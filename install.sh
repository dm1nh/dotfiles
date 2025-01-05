#!/usr/bin/env bash

# Install basic packages
sudo pacman -S --noconfirm --needed base-devel git

if ! which paru >/dev/null; then
	sudo pacman -S --noconfirm --needed rustup

	# Install rustup toolchain
	rustup install stable
	rustup default stable

	sleep 1

	# Install Paru
	git clone https://aur.archlinux.org/paru.git
	pushd paru
	makepkg -si --noconfirm
	popd
	rm -rf paru
fi

paru -Syy --noconfirm
paru -Sy --noconfirm archlinux-keyring
paru -S --noconfirm - <./pkgs.txt

# Enable services
sudo systemctl enable sddm.service
sudo systemctl enable rfkill-block@bluetooth.service # turn off bluetooth on startup

# Create user directories
xdg-user-dirs-update

# Copy fonts

sudo cp -R ./fonts/{JetBrainsMonoNerdFont,MaterialSymbols,NotoColorEmoji-Regular.ttf} /usr/share/fonts/
fc-cache -r

# Install sddm astronaut theme
sudo rm -rf /usr/share/sddm/themes/astronaut
sudo git clone https://github.com/dm1nh/sddm-astronaut.git /usr/share/sddm/themes/astronaut
sudo cp -r ./misc/sddm.conf.d /etc/
sudo cp ./config/sddm-astronaut-theme/theme.conf /usr/share/sddm/themes/astronaut/
sudo cp ./config/hypr/wallpapers/greet.png /usr/share/sddm/themes/astronaut/

# Fix function keys on apple keyboards or other machenical keyboards
sudo cp -r ./misc/modprobe.d /etc/

# Install GTK themes
rm -rf ~/.local/share/themes
mkdir -p ~/.local/share/themes
cp -r ./themes/Trop-Green-Dark-Medium ~/.local/share/themes/

# Backup old configs
mv ~/.config ~/.config.backup
ln -s ~/.dots/config ~/.config
# Copy common system configs
sudo cp -R ./misc/sddm.conf.d /etc/
cp ./misc/.gitconfig ~/
cp -R ./misc/.icons ~/

# Remove default cursor theme
sudo rm -rf /usr/share/icons/default

# pnpm
if ! which pnpm >/dev/null; then
	curl -fsSL https://get.pnpm.io/install.sh | sh -
fi

# Run Docker without sudo
sudo usermod -aG docker $USER

paru -Rns $(paru -Qdtq)
paru -Scc --noconfirm

echo "Reboot to your system and Happy working!"
