#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#
# 说明：
#
# 除了第一行的#!/bin/bash不要动，其他的设置，前面带#表示不起作用，不带的表示起作用了（根据你自己需要打开或者关闭）
#
# 通过修改diy-part2.sh文件可以自定义默认IP，登陆密码等。按我的需要现在的默认IP为172.16.1.1
# 修改openwrt登陆地址,把下面的172.16.1.1修改成你想要的就可以了
sed -i 's/192.168.1.1/172.16.10.1/g' ./package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-123修改你喜欢的就行（不能纯数字或者使用中文）
sed -i 's/OpenWrt/immortalwrt/g' ./package/base-files/files/bin/config_generate

# Enable wifi
# sed -i 's/.disabled=1/.disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# echo "修改wifi名称"
# sed -i "s/OpenWrt/$wifi_name/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Set Wifi SSID and Password
# sed -i 's/.ssid=OpenWrt/.ssid=Tomato24/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i 's/.encryption=none/.encryption=psk-mixed/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
# sed -i '/set\ wireless.default_radio${devidx}.encryption=psk-mixed/a set\ wireless.default_radio${devidx}.key=Psn@2416' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置密码为空（安装固件时无需密码登陆，然后自己修改想要的密码）
# sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

# Set default root password
# sed -i 's/root::0:0:99999:7:::/root:$1$kWRCl0Y2$7JL\/jLAF1xoVIiIMdTO5f.:16788:0:99999:7:::/g' package/base-files/files/etc/shadow

# 修改默认主题Modify default THEME
# sed -i 's/luci-theme-bootstrap/luci-theme-atmaterial_new/g' ./feeds/luci/collections/luci/Makefile

