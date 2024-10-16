#!/bin/bash

# Cihazları listele ve sadece isimlerini al
echo "Listing available devices..."
device_list=$(djtgcfg enum | grep "Device:")

# Eğer hiç cihaz yoksa, hata mesajı ver ve çık
if [ -z "$device_list" ]; then
    echo "No devices found."
    exit 1
fi

# Cihaz isimlerini indeksleyip yazdır
device_array=()
index=0
while IFS= read -r line; do
    device_name=$(echo "$line" | awk '{print $2}')
    device_array+=("$device_name")
    echo "[$index] $device_name"
    ((index++))
done <<< "$device_list"

# Kullanıcıdan cihaz seçmesini iste
read -p "Enter the index of the device you want to use: " device_index

# Geçerli bir indeks girilip girilmediğini kontrol et
if [[ $device_index -lt 0 || $device_index -ge ${#device_array[@]} ]]; then
    echo "Invalid device index."
    exit 1
fi

selected_device="${device_array[$device_index]}"
echo "You selected device: $selected_device"

# Seçilen cihazı başlat
echo "Initializing device scan chain for $selected_device..."
device_init_output=$(djtgcfg init -d $selected_device)

# Cihazları yazdır ve indeksle, ID: olan satırları atla
echo "Listing devices found on $selected_device..."
device_list=$(echo "$device_init_output" | grep "Device" | grep -v "ID:")
device_init_array=()
index=0
while IFS= read -r line; do
    device_type=$(echo "$line" | awk '{print $3}')
    device_init_array+=("$device_type")
    echo "[$index] $device_type"
    ((index++))
done <<< "$device_list"

# Eğer geçerli bir cihaz bulunmadıysa hata ver
if [ ${#device_init_array[@]} -eq 0 ]; then
    echo "No programmable devices found."
    exit 1
fi

# Kullanıcıdan programlanacak cihazı seçmesini iste
read -p "Enter the index of the device you want to program: " programming_index

# Geçerli bir indeks girilip girilmediğini kontrol et
if [[ $programming_index -lt 0 || $programming_index -ge ${#device_init_array[@]} ]]; then
    echo "Invalid programming device index."
    exit 1
fi

selected_programming_device="${device_init_array[$programming_index]}"
echo "You selected to program: $selected_programming_device"

# Bulunan .bit dosyalarını listele ve indeksle
echo "Searching for .bit files in the current directory..."
bit_files=($(find . -maxdepth 1 -name "*.bit"))

# Eğer .bit dosyası yoksa, kullanıcıya bir dosya yolu belirtmesini zorunlu tut
if [ ${#bit_files[@]} -eq 0 ]; then
    echo "No .bit files found in the current directory."
    read -e -p "Enter the full path to the bitstream file: " bitfile
else
    # .bit dosyalarını indeksleyip yazdır
    index=0
    for bitfile in "${bit_files[@]}"; do
        echo "[$index] $bitfile"
        ((index++))
    done

    # Ekstra bir seçenek: Başka bir dosya yolu belirtme
    echo "[$index] Enter another file path manually"

    # Kullanıcıdan seçim yapmasını iste
    read -p "Enter the index of the bitstream file you want to use: " bitfile_index

    # Eğer son indeks seçildiyse, manuel dosya yolu belirtmesini iste
    if [[ $bitfile_index -eq $index ]]; then
        read -e -p "Enter the full path to the bitstream file: " bitfile
    elif [[ $bitfile_index -lt 0 || $bitfile_index -ge ${#bit_files[@]} ]]; then
        echo "Invalid bitstream file index."
        exit 1
    else
        bitfile="${bit_files[$bitfile_index]}"
    fi
fi

# FPGA'yi programla
echo "Programming the FPGA with $bitfile. Please wait..."
djtgcfg prog -d $selected_device -i $programming_index -f "$bitfile"


