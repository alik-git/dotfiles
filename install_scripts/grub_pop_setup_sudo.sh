set -x

apt install grub-efi grub2-common grub-customizer -y

grub-install

# cp /boot/grub/x86_64-efi/grub.efi /boot/efi/EFI/pop/grubx64.efi