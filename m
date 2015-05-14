From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 1/4] ARC: [axs101] Add support for AXS101 SDP (software development platform)
Date: Thu, 14 May 2015 15:48:41 +0300
Message-ID: <1431607724-9142-2-git-send-email-abrodkin@synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, devicetree@vger.kernel.org, Vineet.Gupta1@synopsys.com, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Mischa Jonker <mjonker@synopsys.com>
List-Id: linux-arch.vger.kernel.org

The AXS10x platforms consist of a mainboard with peripherals,
on which several daughter cards can be placed. The daughter cards
typically contain a CPU and memory.

Signed-off-by: Mischa Jonker <mjonker@synopsys.com>
Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 Documentation/devicetree/bindings/arc/axs10x.txt |   7 +
 MAINTAINERS                                      |   7 +
 arch/arc/Kconfig                                 |   1 +
 arch/arc/Makefile                                |   1 +
 arch/arc/boot/dts/axc001.dtsi                    |  79 ++++++
 arch/arc/boot/dts/axs101.dts                     |  21 ++
 arch/arc/boot/dts/axs10x_mb.dtsi                 | 223 +++++++++++++++++
 arch/arc/configs/axs101_defconfig                | 112 +++++++++
 arch/arc/plat-axs10x/Kconfig                     |  35 +++
 arch/arc/plat-axs10x/Makefile                    |   9 +
 arch/arc/plat-axs10x/axs10x.c                    | 298 +++++++++++++++++++++++
 11 files changed, 793 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arc/axs10x.txt
 create mode 100644 arch/arc/boot/dts/axc001.dtsi
 create mode 100644 arch/arc/boot/dts/axs101.dts
 create mode 100644 arch/arc/boot/dts/axs10x_mb.dtsi
 create mode 100644 arch/arc/configs/axs101_defconfig
 create mode 100644 arch/arc/plat-axs10x/Kconfig
 create mode 100644 arch/arc/plat-axs10x/Makefile
 create mode 100644 arch/arc/plat-axs10x/axs10x.c

diff --git a/Documentation/devicetree/bindings/arc/axs10x.txt b/Documentation/devicetree/bindings/arc/axs10x.txt
new file mode 100644
index 0000000..dcbb834
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/axs10x.txt
@@ -0,0 +1,7 @@
+Synopsys DesignWare ARC Software Development Platforms Device Tree Bindings
+---------------------------------------------------------------------------
+
+SDP boards with Synopsys ARC700 core shall have the following properties.
+
+Required root node properties:
+    - compatible = "snps,axs101";
diff --git a/MAINTAINERS b/MAINTAINERS
index 2e5bbc0..ed73eee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9543,6 +9543,13 @@ F:	arch/arc/
 F:	Documentation/devicetree/bindings/arc/
 F:	drivers/tty/serial/arc_uart.c
 
+SYNOPSYS ARC SDP platform support
+M:	Alexey Brodkin <abrodkin@synopsys.com>
+S:	Supported
+F:	arch/arc/plat-axs10x
+F:	arch/arc/boot/dts/ax*
+F:	Documentation/devicetree/bindings/arc/axs10x.txt
+
 SYSV FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index df94ac1..13d4c26 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -83,6 +83,7 @@ menu "ARC Platform/SoC/Board"
 
 source "arch/arc/plat-arcfpga/Kconfig"
 source "arch/arc/plat-tb10x/Kconfig"
+source "arch/arc/plat-axs10x/Kconfig"
 #New platform adds here
 
 endmenu
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index db72fec..562ac7d 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -83,6 +83,7 @@ core-y		+= arch/arc/boot/dts/
 
 core-$(CONFIG_ARC_PLAT_FPGA_LEGACY)	+= arch/arc/plat-arcfpga/
 core-$(CONFIG_ARC_PLAT_TB10X)		+= arch/arc/plat-tb10x/
+core-$(CONFIG_ARC_PLAT_AXS10X)		+= arch/arc/plat-axs10x/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/arc/oprofile/
 
diff --git a/arch/arc/boot/dts/axc001.dtsi b/arch/arc/boot/dts/axc001.dtsi
new file mode 100644
index 0000000..6990ca4
--- /dev/null
+++ b/arch/arc/boot/dts/axc001.dtsi
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device tree for AXC001 770D/EM6/AS221 CPU card
+ * Note that this file only supports the 770D CPU
+ */
+
+/ {
+	compatible = "snps,arc";
+	clock-frequency = <750000000>;	/* 750 MHZ */
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpu_card {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ranges = <0x00000000 0xf0000000 0x10000000>;
+
+		cpu_intc: arc700-intc@cpu {
+			compatible = "snps,arc700-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		/*
+		 * this GPIO block ORs all interrupts on CPU card (creg,..)
+		 * to uplink only 1 IRQ to ARC core intc
+		 */
+		dw-apb-gpio@0x2000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = < 0x2000 0x80 >;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ictl_intc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <30>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupt-parent = <&cpu_intc>;
+				interrupts = <15>;
+			};
+		};
+
+		debug_uart: dw-apb-uart@0x5000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x5000 0x100>;
+			clock-frequency = <33333000>;
+			interrupt-parent = <&ictl_intc>;
+			interrupts = <19 4>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		arcpmu0: pmu {
+			compatible = "snps,arc700-pct";
+		};
+	};
+
+	memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0x80000000 0x40000000>;
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;	/* 512MiB */
+	};
+};
diff --git a/arch/arc/boot/dts/axs101.dts b/arch/arc/boot/dts/axs101.dts
new file mode 100644
index 0000000..6c3391d
--- /dev/null
+++ b/arch/arc/boot/dts/axs101.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * ARC AXS101 S/W development platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "axc001.dtsi"
+/include/ "axs10x_mb.dtsi"
+
+/ {
+	compatible = "snps,axs101";
+
+	chosen {
+		bootargs = "console=tty0 console=ttyS3,115200n8 consoleblank=0";
+	};
+};
diff --git a/arch/arc/boot/dts/axs10x_mb.dtsi b/arch/arc/boot/dts/axs10x_mb.dtsi
new file mode 100644
index 0000000..255c712
--- /dev/null
+++ b/arch/arc/boot/dts/axs10x_mb.dtsi
@@ -0,0 +1,223 @@
+/*
+ * Support for peripherals on the AXS10x mainboard
+ *
+ * Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	axs10x_mb {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0xe0000000 0x10000000>;
+		interrupt-parent = <&mb_intc>;
+
+		clocks {
+			i2cclk: i2cclk {
+				compatible = "fixed-clock";
+				clock-frequency = <50000000>;
+				#clock-cells = <0>;
+			};
+
+			apbclk: apbclk {
+				compatible = "fixed-clock";
+				clock-frequency = <50000000>;
+				#clock-cells = <0>;
+			};
+
+			mmcclk: mmcclk {
+				compatible = "fixed-clock";
+				clock-frequency = <50000000>;
+				#clock-cells = <0>;
+			};
+		};
+
+		/*
+		 * This INTC is actually connected to DW APB GPIO
+		 * which acts as a wire between MB INTC and CPU INTC.
+		 * GPIO INTC is configured in platform init code
+		 * and here we mimic direct connection from MB INTC to
+		 * CPU INTC, thus we set "interrupts = <7>" instead of
+		 * "interrupts = <12>"
+		 */
+		mb_intc: dw-apb-ictl@0x12000 {
+			#interrupt-cells = <1>;
+			compatible = "snps,dw-apb-ictl";
+			reg = < 0x12000 0x200 >;
+			interrupt-controller;
+			interrupt-parent = <&cpu_intc>;
+			interrupts = < 7 >;
+		};
+
+		ethernet@0x18000 {
+			#interrupt-cells = <1>;
+			compatible = "snps,dwmac";
+			reg = < 0x18000 0x2000 >;
+			interrupts = < 4 >;
+			interrupt-names = "macirq";
+			phy-mode = "rgmii";
+			snps,pbl = < 32 >;
+			clocks = <&apbclk>;
+			clock-names = "stmmaceth";
+		};
+
+		ehci@0x40000 {
+			compatible = "generic-ehci";
+			reg = < 0x40000 0x100 >;
+			interrupts = < 8 >;
+		};
+
+		ohci@0x60000 {
+			compatible = "generic-ohci";
+			reg = < 0x60000 0x100 >;
+			interrupts = < 8 >;
+		};
+
+		mmc@0x15000 {
+			compatible = "snps,dw-mshc";
+			reg = < 0x15000 0x400 >;
+			num-slots = < 1 >;
+			fifo-depth = < 16 >;
+			card-detect-delay = < 200 >;
+			clocks = <&apbclk>, <&mmcclk>;
+			clock-names = "biu", "ciu";
+			interrupts = < 7 >;
+			bus-width = < 4 >;
+		};
+
+		uart@0x20000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x20000 0x100>;
+			clock-frequency = <33333333>;
+			interrupts = <17>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart@0x21000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x21000 0x100>;
+			clock-frequency = <33333333>;
+			interrupts = <18>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		/* UART muxed with USB data port (ttyS3) */
+		uart@0x22000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x22000 0x100>;
+			clock-frequency = <33333333>;
+			interrupts = <19>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		i2c@0x1d000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x1d000 0x100>;
+			clock-frequency = <400000>;
+			clocks = <&i2cclk>;
+			interrupts = <14>;
+		};
+
+		i2c@0x1e000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x1e000 0x100>;
+			clock-frequency = <400000>;
+			clocks = <&i2cclk>;
+			interrupts = <15>;
+		};
+
+		i2c@0x1f000 {
+			compatible = "snps,designware-i2c";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x1f000 0x100>;
+			clock-frequency = <400000>;
+			clocks = <&i2cclk>;
+			interrupts = <16>;
+
+			eeprom@0x54{
+				compatible = "24c01";
+				reg = <0x54>;
+				pagesize = <0x8>;
+			};
+
+			eeprom@0x57{
+				compatible = "24c04";
+				reg = <0x57>;
+				pagesize = <0x8>;
+			};
+		};
+
+		gpio0:gpio@13000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x13000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio0_banka: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <32>;
+				reg = <0>;
+			};
+
+			gpio0_bankb: gpio-controller@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <8>;
+				reg = <1>;
+			};
+
+			gpio0_bankc: gpio-controller@2 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <8>;
+				reg = <2>;
+			};
+		};
+
+		gpio1:gpio@14000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0x14000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			gpio1_banka: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <30>;
+				reg = <0>;
+			};
+
+			gpio1_bankb: gpio-controller@1 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <10>;
+				reg = <1>;
+			};
+
+			gpio1_bankc: gpio-controller@2 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				snps,nr-gpios = <8>;
+				reg = <2>;
+			};
+		};
+	};
+};
diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
new file mode 100644
index 0000000..27dc4d5
--- /dev/null
+++ b/arch/arc/configs/axs101_defconfig
@@ -0,0 +1,112 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="../arc_initramfs/"
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARC_PLAT_AXS10X=y
+CONFIG_AXS101=y
+CONFIG_ARC_CACHE_LINE_SHIFT=5
+# CONFIG_ARC_HAS_RTSC is not set
+CONFIG_ARC_BUILTIN_DTB_NAME="axs101"
+CONFIG_PREEMPT=y
+# CONFIG_COMPACTION is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_IPV6 is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_STMMAC_ETH=y
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_NATIONAL_PHY=y
+# CONFIG_USB_NET_DRIVERS is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_MOUSE_PS2_TOUCHKIT=y
+CONFIG_MOUSE_SERIAL=y
+CONFIG_MOUSE_SYNAPTICS_USB=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_DESIGNWARE_PLATFORM=y
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_LOGO_LINUX_CLUT224 is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_IDMAC=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT4_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_NFS_FS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
new file mode 100644
index 0000000..45641ca
--- /dev/null
+++ b/arch/arc/plat-axs10x/Kconfig
@@ -0,0 +1,35 @@
+#
+# Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+
+config ARC_PLAT_AXS10X
+	bool "Synopsys ARC AXS10x Software Development Platforms"
+	select DW_APB_ICTL
+	select GPIO_DWAPB
+	select OF_GPIO
+	select GENERIC_IRQ_CHIP
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Support for the ARC AXS10x Software Development Platforms.
+
+	  The AXS10x Platforms consist of a mainboard with peripherals,
+	  on which several daughter cards can be placed. The daughter cards
+	  typically contain a CPU and memory.
+
+if ARC_PLAT_AXS10X
+
+config AXS101
+	bool "AXS101 with AXC001 CPU Card (ARC 770D/EM6/AS221)"
+	help
+	  This adds support for the 770D/EM6/AS221 CPU Card. Only the ARC
+	  770D is supported in Linux.
+
+	  The AXS101 Platform consists of an AXS10x mainboard with
+	  this daughtercard. Please use the axs101.dts device tree
+	  with this configuration.
+
+endif
diff --git a/arch/arc/plat-axs10x/Makefile b/arch/arc/plat-axs10x/Makefile
new file mode 100644
index 0000000..d4748f2
--- /dev/null
+++ b/arch/arc/plat-axs10x/Makefile
@@ -0,0 +1,9 @@
+#
+# Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+
+obj-$(CONFIG_ARC_PLAT_AXS10X) += axs10x.o
diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
new file mode 100644
index 0000000..2e7686d
--- /dev/null
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -0,0 +1,298 @@
+/*
+ * AXS101 Software Development Platform
+ *
+ * Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/of_platform.h>
+#include <asm/mach_desc.h>
+#include <asm/io.h>
+
+#define AXS_MB_CGU		0xE0010000
+#define AXS_MB_CREG		0xE0011000
+
+#define CREG_MB_IRQ_MUX		(AXS_MB_CREG + 0x214)
+#define CREG_MB_SW_RESET	(AXS_MB_CREG + 0x220)
+#define CREG_MB_VER		(AXS_MB_CREG + 0x230)
+#define CREG_MB_CONFIG		(AXS_MB_CREG + 0x234)
+
+#define AXC001_CREG		0xF0001000
+#define AXC001_GPIO_INTC	0xF0003000
+
+#define CREG_CPU_ADDR_770	(AXC001_CREG + 0x20)
+#define CREG_CPU_ADDR_TUNN	(AXC001_CREG + 0x60)
+#define CREG_CPU_ADDR_770_UPD	(AXC001_CREG + 0x34)
+#define CREG_CPU_ADDR_TUNN_UPD	(AXC001_CREG + 0x74)
+
+#define CREG_CPU_ARC770_IRQ_MUX	(AXC001_CREG + 0x114)
+#define CREG_CPU_GPIO_UART_MUX	(AXC001_CREG + 0x120)
+
+static void enable_gpio_intc_wire(void)
+{
+	/*
+	 * Peripherals on CPU Card and Mother Board are wired to cpu intc via
+	 * intermediate DW APB GPIO blocks (mainly for debouncing)
+	 *
+	 *         ---------------------
+	 *        |  snps,arc700-intc |
+	 *        ---------------------
+	 *          | #7          | #15
+	 * -------------------   -------------------
+	 * | snps,dw-apb-gpio |  | snps,dw-apb-gpio |
+	 * -------------------   -------------------
+	 *        |                         |
+	 *        |                 [ Debug UART on cpu card ]
+	 *        |
+	 * ------------------------
+	 * | snps,dw-apb-intc (MB)|
+	 * ------------------------
+	 *  |      |       |      |
+	 * [eth] [uart]        [... other perip on Main Board]
+	 *
+	 * Current implementation of "irq-dw-apb-ictl" driver doesn't work well
+	 * with stacked INTCs. In particular problem happens if its master INTC
+	 * not yet instantiated. See discussion here -
+	 * https://lkml.org/lkml/2015/3/4/755
+	 *
+	 * So setup the first gpio block as a passive pass thru and hide it from
+	 * DT hardware topology - connect MB intc directly to cpu intc
+	 * The GPIO "wire" needs to be init nevertheless (here)
+	 *
+	 * One side adv is that peripheral interrupt handling avoids one nested
+	 * intc ISR hop
+	 */
+#define GPIO_INTEN		(AXC001_GPIO_INTC + 0x30)
+#define GPIO_INTMASK		(AXC001_GPIO_INTC + 0x34)
+#define GPIO_INTTYPE_LEVEL	(AXC001_GPIO_INTC + 0x38)
+#define GPIO_INT_POLARITY	(AXC001_GPIO_INTC + 0x3c)
+#define MB_TO_GPIO_IRQ		12
+
+	iowrite32(~(1 << MB_TO_GPIO_IRQ), (void __iomem *) GPIO_INTMASK);
+	iowrite32(0, (void __iomem *) GPIO_INTTYPE_LEVEL);
+	iowrite32(~0, (void __iomem *) GPIO_INT_POLARITY);
+	iowrite32(1 << MB_TO_GPIO_IRQ, (void __iomem *) GPIO_INTEN);
+}
+
+static void axs10x_print_board_ver(unsigned int creg, const char *str)
+{
+	union ver {
+		struct {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+			unsigned int pad:11, y:12, m:4, d:5;
+#else
+			unsigned int d:5, m:4, y:12, pad:11;
+#endif
+		};
+		unsigned int val;
+	} board;
+
+	board.val = ioread32((void __iomem *)creg);
+	pr_info("AXS: %s FPGA Date: %u-%u-%u\n", str, board.d, board.m,
+		board.y);
+}
+
+static void axs10x_early_init(void)
+{
+	int mb_rev;
+	char mb[32];
+
+	/* Determine motherboard version */
+	if (ioread32((void __iomem *) CREG_MB_CONFIG) & (1 << 28))
+		mb_rev = 3;	/* HT-3 (rev3.0) */
+	else
+		mb_rev = 2;	/* HT-2 (rev2.0) */
+
+	enable_gpio_intc_wire();
+
+	scnprintf(mb, 32, "MainBoard v%d", mb_rev);
+	axs10x_print_board_ver(CREG_MB_VER, mb);
+}
+
+/*
+ * Set up System Memory Map for ARC cpu / peripherals controllers
+ *
+ * Each AXI master has a 4GB memory map specified as 16 apertures of 256MB, each
+ * of which maps to a corresponding 256MB aperture in Target slave memory map.
+ *
+ * e.g. ARC cpu AXI Master's aperture 8 (0x8000_0000) is mapped to aperture 0
+ * (0x0000_0000) of DDR Port 0 (slave #1)
+ *
+ * Access from cpu to MB controllers such as GMAC is setup using AXI Tunnel:
+ * which has master/slaves on both ends.
+ * e.g. aperture 14 (0xE000_0000) of ARC cpu is mapped to aperture 14
+ * (0xE000_0000) of CPU Card AXI Tunnel slave (slave #3) which is mapped to
+ * MB AXI Tunnel Master, which also has a mem map setup
+ *
+ * In the reverse direction, MB AXI Masters (e.g. GMAC) mem map is setup
+ * to map to MB AXI Tunnel slave which connects to CPU Card AXI Tunnel Master
+ */
+struct aperture {
+	unsigned int slave_sel:4, slave_off:4, pad:24;
+};
+
+/* CPU Card target slaves */
+#define AXC001_SLV_NONE			0
+#define AXC001_SLV_DDR_PORT0		1
+#define AXC001_SLV_SRAM			2
+#define AXC001_SLV_AXI_TUNNEL		3
+#define AXC001_SLV_AXI2APB		6
+#define AXC001_SLV_DDR_PORT1		7
+
+/* MB AXI Target slaves */
+#define AXS_MB_SLV_NONE			0
+#define AXS_MB_SLV_AXI_TUNNEL_CPU	1
+#define AXS_MB_SLV_AXI_TUNNEL_HAPS	2
+#define AXS_MB_SLV_SRAM			3
+#define AXS_MB_SLV_CONTROL		4
+
+/* MB AXI masters */
+#define AXS_MB_MST_TUNNEL_CPU		0
+#define AXS_MB_MST_USB_OHCI		10
+
+/*
+ * memmap for ARC core on CPU Card
+ */
+static const struct aperture axc001_memmap[16] = {
+	{AXC001_SLV_AXI_TUNNEL,		0x0},
+	{AXC001_SLV_AXI_TUNNEL,		0x1},
+	{AXC001_SLV_SRAM,		0x0}, /* 0x2000_0000: Local SRAM */
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_DDR_PORT0,		0x0}, /* 0x8000_0000: DDR   0..256M */
+	{AXC001_SLV_DDR_PORT0,		0x1}, /* 0x9000_0000: DDR 256..512M */
+	{AXC001_SLV_DDR_PORT1,		0x0},
+	{AXC001_SLV_DDR_PORT1,		0x1},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_AXI_TUNNEL,		0xD},
+	{AXC001_SLV_AXI_TUNNEL,		0xE}, /* MB: CREG, CGU... */
+	{AXC001_SLV_AXI2APB,		0x0}, /* CPU Card local CREG, CGU... */
+};
+
+/*
+ * memmap for CPU Card AXI Tunnel Master (for access by MB controllers)
+ * GMAC (MB) -> MB AXI Tunnel slave -> CPU Card AXI Tunnel Master -> DDR
+ */
+static const struct aperture axc001_axi_tunnel_memmap[16] = {
+	{AXC001_SLV_AXI_TUNNEL,		0x0},
+	{AXC001_SLV_AXI_TUNNEL,		0x1},
+	{AXC001_SLV_SRAM,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_DDR_PORT0,		0x0},
+	{AXC001_SLV_DDR_PORT0,		0x1},
+	{AXC001_SLV_DDR_PORT1,		0x0},
+	{AXC001_SLV_DDR_PORT1,		0x1},
+	{AXC001_SLV_NONE,		0x0},
+	{AXC001_SLV_AXI_TUNNEL,		0xD},
+	{AXC001_SLV_AXI_TUNNEL,		0xE},
+	{AXC001_SLV_AXI2APB,		0x0},
+};
+
+/*
+ * memmap for MB AXI Masters
+ * Same mem map for all perip controllers as well as MB AXI Tunnel Master
+ */
+static const struct aperture axs_mb_memmap[16] = {
+	{AXS_MB_SLV_SRAM,		0x0},
+	{AXS_MB_SLV_SRAM,		0x0},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_AXI_TUNNEL_CPU,	0x8},	/* DDR on CPU Card */
+	{AXS_MB_SLV_AXI_TUNNEL_CPU,	0x9},	/* DDR on CPU Card */
+	{AXS_MB_SLV_AXI_TUNNEL_CPU,	0xA},
+	{AXS_MB_SLV_AXI_TUNNEL_CPU,	0xB},
+	{AXS_MB_SLV_NONE,		0x0},
+	{AXS_MB_SLV_AXI_TUNNEL_HAPS,	0xD},
+	{AXS_MB_SLV_CONTROL,		0x0},	/* MB Local CREG, CGU... */
+	{AXS_MB_SLV_AXI_TUNNEL_CPU,	0xF},
+};
+
+static noinline void
+axs101_set_memmap(void __iomem *base, const struct aperture map[16])
+{
+	unsigned int slave_select, slave_offset;
+	int i;
+
+	slave_select = slave_offset = 0;
+	for (i = 0; i < 8; i++) {
+		slave_select |= map[i].slave_sel << (i << 2);
+		slave_offset |= map[i].slave_off << (i << 2);
+	}
+
+	iowrite32(slave_select, base + 0x0);	/* SLV0 */
+	iowrite32(slave_offset, base + 0x8);	/* OFFSET0 */
+
+	slave_select = slave_offset = 0;
+	for (i = 0; i < 8; i++) {
+		slave_select |= map[i+8].slave_sel << (i << 2);
+		slave_offset |= map[i+8].slave_off << (i << 2);
+	}
+
+	iowrite32(slave_select, base + 0x4);	/* SLV1 */
+	iowrite32(slave_offset, base + 0xC);	/* OFFSET1 */
+}
+
+static void axs101_early_init(void)
+{
+	int i;
+
+	/* ARC 770D memory view */
+	axs101_set_memmap((void __iomem *) CREG_CPU_ADDR_770, axc001_memmap);
+	iowrite32(1, (void __iomem *) CREG_CPU_ADDR_770_UPD);
+
+	/* AXI tunnel memory map (incoming traffic from MB into CPU Card */
+	axs101_set_memmap((void __iomem *) CREG_CPU_ADDR_TUNN,
+			      axc001_axi_tunnel_memmap);
+	iowrite32(1, (void __iomem *) CREG_CPU_ADDR_TUNN_UPD);
+
+	/* MB peripherals memory map */
+	for (i = AXS_MB_MST_TUNNEL_CPU; i <= AXS_MB_MST_USB_OHCI; i++)
+		axs101_set_memmap((void __iomem *) AXS_MB_CREG + (i << 4),
+				      axs_mb_memmap);
+
+	iowrite32(0x3ff, (void __iomem *) AXS_MB_CREG + 0x100); /* Update */
+
+	/* GPIO pins 18 and 19 are used as UART rx and tx, respectively. */
+	iowrite32(0x01, (void __iomem *) CREG_CPU_GPIO_UART_MUX);
+
+	/* Set up the MB interrupt system: mux interrupts to GPIO7) */
+	iowrite32(0x01, (void __iomem *) CREG_MB_IRQ_MUX);
+
+	/* reset ethernet and ULPI interfaces */
+	iowrite32(0x18, (void __iomem *) CREG_MB_SW_RESET);
+
+	/* map GPIO 14:10 to ARC 9:5 (IRQ mux change for MB v2 onwards) */
+	iowrite32(0x52, (void __iomem *) CREG_CPU_ARC770_IRQ_MUX);
+
+	axs10x_early_init();
+}
+
+static const char *axs101_compat[] __initconst = {
+	"snps,axs101",
+	NULL,
+};
+
+MACHINE_START(AXS101, "axs101")
+	.dt_compat	= axs101_compat,
+	.init_early	= axs101_early_init,
+MACHINE_END
-- 
2.1.0
