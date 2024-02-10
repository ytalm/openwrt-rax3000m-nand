**English** | [中文](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

# Actions-OpenWrt借助 GitHub Actions 的 OpenWrt 在线自动编译.

[![LICENSE](https://img.shields.io/github/license/mashape/apistatus.svg?style=flat-square&label=LICENSE)](https://github.com/P3TERX/Actions-OpenWrt/blob/master/LICENSE)
![GitHub Stars](https://img.shields.io/github/stars/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Stars&logo=github)
![GitHub Forks](https://img.shields.io/github/forks/P3TERX/Actions-OpenWrt.svg?style=flat-square&label=Forks&logo=github)

OpenWrt官方有过三种分区固件：OpenWrt stock layout、OpenWrt layout和OpenWrt U-Boot layout。

OpenWrt stock layout对应保留官方分区刷OpenWrt，我称为stock固件。

OpenWrt layout对应的就是hanwckf大佬的不死uboot(ubi 110MB)，我称为uboot固件。

OpenWrt U-Boot layout对应的是HZFrodo大佬的不死ubootmod(ubi 122.5MB)，我称为ubootmod固件。


目前OpenWrt官方、X-Wrt只保留了stock固件和ubootmod固件。

padavanonly和hanwckf大佬闭源驱动固件只支持stock固件和uboot固件。

Lean源码只支持uboot固件。

## CMCC_RAX3000M 闭源驱动固件 源码来源
- padavanonly-[padavanonly/immortalwrtARM](https://github.com/padavanonly/immortalwrtARM/tree/mt7986).
```bash
git clone -b mt7986 --single-branch https://github.com/padavanonly/immortalwrtARM
```
- hanwckf-[hanwckf/immortalwrt-mt798x](https://github.com/hanwckf/immortalwrt-mt798x).
```bash
git clone -b openwrt-21.02 --single-branch https://github.com/hanwckf/immortalwrt-mt798x
```

## CMCC_RAX3000M 开源驱动固件 源码来源
- OpenWrt官方-[openwrt/openwrt](https://github.com/openwrt/openwrt).
```bash
git clone https://github.com/openwrt/openwrt
```
- Lean-[coolsnowwolf/lede](https://github.com/coolsnowwolf/lede).
```bash
git clone https://github.com/coolsnowwolf/lede
```
- ptpt52-[x-wrt/x-wrt](https://github.com/x-wrt/x-wrt).
```bash
git clone https://github.com/x-wrt/x-wrt
```

## CMCC_RAX3000M 不死uboot
- hanwckf-[hanwckf/bl-mt798x](https://github.com/hanwckf/bl-mt798x).

## CMCC_RAX3000M 不死ubootmod
- HZFrodo-[HZFrodo/uboot-mediatek: add support for Xiaomi Redmi Router AX6000](https://github.com/openwrt/openwrt/commit/1613e3340b829ea9aa6da954bf0ff98214b71751).

# CMCC_RAX3000M
RAX3000M是中国移动于2023年推出的一款高性价比路由器。

不仅美观( https://www.red-dot.org/project/rax3000m-wifi6-65030 )，
硬件配置更是家用百元级产品中的佼佼者：
```text
SoC: MediaTek Filogic 820 MT7981B 双核1.3GHz
RAM: 512MB
Flash: NAND版本128MB；EMMC版本64GB
WiFi: WiFi6-AX3000M规格
四个千兆网口
一个USB3.0插口
```

更不可思议的是这款路由器支持**免拆刷机**！[滑稽+狗头]

### 刷入uBoot
这里推荐使用hanwckf制作的bootloader。
- https://github.com/hanwckf/bl-mt798x
- https://github.com/hanwckf/bl-mt798x/releases/tag/20231124

也可以自行编译，可参考本项目的`.github/workflows`。

```bash
# 1. ssh登录到路由器操作系统
# 2. 上传适用于cmcc_rax3000m的文件到/tmp目录下
# 3. 使用mtd命令写入
mtd write /tmp/mt7981_cmcc_rax3000m-fip-fixed-parts.bin FIP
```
重启路由器，并按住背面的reset直至指示灯变绿，此时路由器使用的就是我们上传uboot了。

### 获取固件
这款路由器对市面上主流的OpenWRT系统都兼容良好。
推荐根据自身需求自行编译系统固件。

编译过程可参考本项目的`.github/workflows`。

### 刷入OpenWRT
刷入uboot后，可以轻松的借助其web页面(192.168.1.1)刷入系统固件。
详见：
[hanwckf's blog](https://cmi.hanwckf.top/p/mt798x-uboot-usage/#failsafe-webui%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E)


### immortalwrt-mt798x项目介绍
- https://cmi.hanwckf.top/p/immortalwrt-mt798x/

ImmortalWrt 是OpenWrt的一个分支，移植了更多的软件包，支持更多的设备，性能更好，并且针对中国大陆用户进行了特别优化。
immortalwrt-mt798x基于immortalwrt项目，特点如下
基于immortalwrt 21.02分支，内核版本5.4，目前仅支持mt7981/mt7986
使用mtk-openwrt-feeds提供的有线驱动、hnat驱动、内核补丁及配置工具，支持所有硬件加速特性
mt7981/mt7986均支持两个ppe，每个ppe有32k Entry（当有线驱动使用ADMAv1时，每个PPE最大支持16k Entry）
使用mtwifi原厂无线驱动（目前默认使用7.6.6.1版本），默认开启802.11k，支持warp在内的所有加速特性
新开发的mtwifi-cfg无线配置工具支持openwrt的原生luci界面以及netifd-wireless标准接口。除此以外，还支持mtk原厂提供的luci-app-mtk和wifi-profile

### 固件源码
- https://github.com/hanwckf/immortalwrt-mt798x

### 编译说明
1 拉取固件源码，参考immortalwrt的README搭建openwrt编译环境，并更新feeds

2 使用defconfig目录内预置的配置文件作为配置模板，

```bash
#defconfig/luci-app-mtk-deprecated目录里的配置文件使用旧版luci-app-mtk作为无线配置工具

# 对于mt7981，使用mt7981-ax3000.config
cp -f defconfig/mt7981-ax3000.config .config
# 对于mt7986，使用mt7986-ax6000.config
cp -f defconfig/mt7986-ax6000.config .config
# 对于256M内存的mt7986（如磊科N60），使用mt7986-ax6000-256m.config
cp -f defconfig/mt7986-ax6000-256m.config .config
# 对于AX4200方案的mt7986（如BPI-R3 MINI），使用mt7986-ax4200.config
cp -f defconfig/mt7986-ax4200.config .config
```
3 运行make menuconfig定制固件

4 运行make V=s开始编译固件，为了加快编译速度，可以使用make V=s -j$(nproc)

### 注意事项

- **GL.iNet MT3000/MT2500的WAN/LAN口对应的GMAC不符合参考设计，为了保证HNAT加速功能正常，immortalwrt-mt798x最新源码中已按照mtk公版方案进行修正，上述两款路由器均使用2.5G口作为LAN口**

- **不要在开启hwnat时使用主线的flow-offload，即不要启用turbo-acc的flow-offload加速方式**

- **推荐选择WPA2-PSK/WPA3-PSK无线认证方式以获得最好的兼容性**

- **由于mt798x无线驱动中继扫描所需时间较长，对应频段关联的无线设备可能会在扫描期间断开。因此在触发中继扫描时，要使用有线或者非扫描频段连接路由器操作**

- **因未经测试，不推荐同时开启shortcut-fe**

- **当前无线驱动的IGMP Snooping功能可能存在问题，新版源码已默认关闭此功能，较旧版本的固件可以手动在无线设置中禁用IGMP Snooping以避免出现问题**

### 硬件加速功能说明
immortalwrt-mt798x支持mt798x的所有原厂有线、无线硬件加速特性，除此以外还支持以下功能

- 可通过luci直接设置hwnat PPE的启用数量、PPE加速阈值（当NAT连接速率大于阈值时会被硬件加速，默认是30pps，设置更小的值会使NAT连接更容易被加速）、macvlan支持（支持macvlan作为WAN的加速功能）、IPv6开关等
- 每个NAT连接需要占用2个Entry（进站和出站方向），当使用2个PPE时，由GMAC2进入的包将使用PPE1加速，其它情况下均使用PPE0加速。当路由器仅使用GMAC1时（如JCG Q30，CT3003等路由器），PPE1将不会起任何作用
- mt7981/mt7986均支持2个PPE，每个PPE有32768个Entry，当有线驱动使用ADMAv1时，每个PPE最多支持16384个Entry。按照mtk-sdk和最新openwrt主线的有线驱动，mt7981的ADMAv2存在不可修复的问题，immortalwrt-mt798x已参照上述源码将mt7981 ADMAv2回退至ADMAv1，mt7986不受影响
- immortalwrt-mt798x最新源码已支持外部网络设备（如USB3.0 5G模块、USB-RNDIS/ECM网卡等）到有线和无线的双向hwnat PPE加速，mtk-sdk原厂驱动不支持此功能。此功能可降低使用外部网络设备时的CPU占用率，实测mt7981在外接USB-RNDIS/ECM网卡时可跑满千兆速率（原厂只能达到300-500Mbps）。目前仅在RAX3000M中开启，MT7986机型暂未测试
- immortalwrt-mt798x支持硬件QoS的所有特性，该功能已集成到luci-app-eqos-mtk，具体用法参考luci里面的说明。为确保PPE尽可能接管所有的NAT连接，当开启硬件QoS时，PPE加速阈值将会被设置为5pps
- 同一个MBSSID内的无线客户端之间互传数据不支持硬件加速，不同MBSSID之间的无线客户端之间互传数据支持完全硬件加速

### mtwifi无线配置工具说明
immortalwrt-mt798x早期采用的是mtk-sdk提供的luci-app-mtk和wifi-profile作为无线配置工具，并且在mtk-sdk基础上进行了大幅度的精简、修复、适配和汉化以尽可能满足日常使用需求。2023年12月，我开发了新的mtwifi-cfg配置工具，并配套做好了iwinfo和netifd相关支持，至此immortalwrt-mt798x可以选择两种完全不同的无线配置工具，特点分别如下：

- mtwifi-cfg：为mtwifi设计的无线配置工具，兼容openwrt原生luci和netifd，可调整无线驱动的参数较少，配置界面美观友好，由于是新开发的工具，可能存在一些问题
- luci-app-mtk：源自mtk-sdk提供的配置工具，需要配合wifi-profile脚本使用，可调整无线驱动的几乎所有参数，配置界面较为简陋

mtwifi-cfg与luci-app-mtk不能在固件里共存，编译时必须选择其中之一，目前最新源码已默认使用mtwifi-cfg作为无线配置工具，如需使用旧版luci-app-mtk，请选择defconfig/luci-app-mtk-deprecated目录里的配置模板文件进行编译
### mtwifi-cfg无线配置说明
mtwifi-cfg是我为mt798x无线平台新开发的配置工具，支持openwrt的luci和netifd-wireless无线控制界面，具有以下特点：
```text
使用openwrt原版luci无线配置界面，配置方法非常接近原版openwrt
支持apcli中继功能
支持已连接站点信息显示（含apcli连接信息）
支持读取无线芯片实际发射功率
支持mtk原厂无线驱动可配置的大部分选项（含弱信号剔除等）
支持WPA-PSK/WPA2-PSK/WPA3-PSK/OWE无线认证方式，支持AP/APCLI工作模式，支持最多开启16个MBSSID
部分老旧的2.4G智能家居设备可能无法连接，请尝试以下无线设置：
使用WPA-PSK+AES/WPA2-PSK+AES认证加密方式
将2.4G无线设置为N模式
关闭2.4G的MU-MIMO功能（在较新的源码里，无线设置为N模式时自动关闭MU-MIMO）
设置频宽为20MHz，并关闭强制40MHz开关
```
### mtwifi-cfg配套源码
mtwifi-cfg及配套的补丁完全开源，具体参考immortalwrt-mt798x源码内下列目录

- package/mtk/applications/mtwifi-cfg
- package/mtk/applications/luci-app-mtwifi-cfg
- package/mtk/drivers/mt_wifi/patches
- package/network/utils/iwinfo
- package/network/config/netifd/patches
### luci-app-mtk无线配置说明
luci-app-mtk来源于mtk-sdk，采用wifi-profile作为无线控制脚本，不支持openwrt的原版luci界面和netifd-wireless

luci-app-mtk配置界面已基本汉化，可显示驱动版本、芯片温度、已连接客户端信息等，下面以MT7981为例
- 第一级MT7981右侧的配置按钮为chip_cfg，配置无线驱动基础参数，一般无需修改
- 第二级MT7981.1.1右侧的配置按钮为dev_cfg，可配置信道、国家代码等频段相关参数
- 第三级接口右侧的配置按钮为vif_cfg，可配置SSID、加密方式、无线中继扫描等

**默认登录地址：http://172.16.10.1或http://immortalwrt.lan，用户名：root，密码：none**

### 感谢名单（向他们学习才有这个项目）
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt)
[Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)
