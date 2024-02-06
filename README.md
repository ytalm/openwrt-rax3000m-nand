**默认登录地址：http://172.16.10.1或http://immortalwrt.lan，用户名：root，密码：none**
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
