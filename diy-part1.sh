#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# 通过修改diy-part1.sh文件修改feeds.conf.default配置。

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#sed -i '$a src-git Whitecolor https://github.com/Whitestorys/openwrt-extra-packages.git' feeds.conf.default
#sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
#sed -i '$a src-git small https://github.com/kenzok8/small-package' feeds.conf.default
sed -i '$a src-git 281677160 https://github.com/281677160/openwrt-package' feeds.conf.default
sed -i '$a src-git haiibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
#sed -i '$a src-git ytalm https://github.com/ytalm/my-packages' feeds.conf.default
#sed -i '$a src-git Aibx https://github.com/Aibx/OpenWRT-Packages' feeds.conf.default
#sed -i '$a src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2' feeds.conf.default

#内核版本是会随着源码更新而改变的，在coolsnowwolf/lede的源码查看最好，以X86机型为例，源码的target/linux/x86文件夹可以看到有几个内核版本，x86文件夹里Makefile可以查看源码正在使用内核版本
#修改版本内核（下面两行代码前面有#为源码默认最新5.4内核,没#为4.19内核,默认修改X86的，其他机型L大源码那里target/linux查看，对应修改下面的路径就好）
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本
#sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=4.19/g' ./target/linux/x86/Makefile  #修改内核版本

#添加自定义插件链接（自己想要什么就github里面搜索然后添加）
# git clone -b 18.06 https://github.com/garypang13/luci-theme-edge.git package/lean/luci-theme-edge  #主题-edge-动态登陆界面
# git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git package/lean/luci-theme-infinityfreedom  #透明主题
# git clone https://github.com/jerrykuku/lua-maxminddb     #git lua-maxminddb 依赖
# git clone https://github.com/jerrykuku/luci-app-vssr
# git clone https://github.com/xiaorouji/openwrt-passwall2  #passwall出国软件

# rm -rf ./package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  #新的argon主题
# 全新的[argon-主题]此主题玩法很多,这里看说明【https://github.com/jerrykuku/luci-theme-argon/blob/18.06/README_ZH.md】
# 用WinSCP连接openwrt，在/www/luci-static/argon里面创建background文件夹（如果本身就有background就不需要创建）来存放jpg png gif格式图片可以自定义登陆界面，gif图片为动态登陆界面

