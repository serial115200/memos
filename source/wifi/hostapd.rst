

https://w1.fi/cgit/hostap/
https://w1.fi/cgit/hostap/snapshot/hostap_2_11.tar.gz


sudo modprobe mac80211_hwsim

cd hostap/wpa_supplicant
cp defconfig .config
sed -i '/DBUS/ s/^/# /' .config
make

cd hostap/hostapd
cp defconfig .config
make


sudo rfkill unblock wlan
