From: Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 27/28] ARCv2: [axs103] Support ARC SDP FPGA platform for HS38x cores
Date: Tue, 9 Jun 2015 17:18:27 +0530
Message-ID: <1433850508-26317-28-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: arnd-r2nGTMty4D4@public.gmane.org, arc-linux-dev-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, Vineet Gupta <Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
---
 Documentation/devicetree/bindings/arc/axs103.txt |   8 +
 arch/arc/boot/dts/axc003.dtsi                    | 102 ++++++++++++
 arch/arc/boot/dts/axc003_idu.dtsi                | 126 +++++++++++++++
 arch/arc/boot/dts/axs103.dts                     |  24 +++
 arch/arc/boot/dts/axs103_idu.dts                 |  24 +++
 arch/arc/configs/axs103_defconfig                | 117 ++++++++++++++
 arch/arc/configs/axs103_smp_defconfig            | 118 ++++++++++++++
 arch/arc/kernel/devtree.c                        |   2 +-
 arch/arc/plat-axs10x/Kconfig                     |  13 +-
 arch/arc/plat-axs10x/axs10x.c                    | 198 +++++++++++++++++++++--
 10 files changed, 720 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arc/axs103.txt
 create mode 100644 arch/arc/boot/dts/axc003.dtsi
 create mode 100644 arch/arc/boot/dts/axc003_idu.dtsi
 create mode 100644 arch/arc/boot/dts/axs103.dts
 create mode 100644 arch/arc/boot/dts/axs103_idu.dts
 create mode 100644 arch/arc/configs/axs103_defconfig
 create mode 100644 arch/arc/configs/axs103_smp_defconfig

diff --git a/Documentation/devicetree/bindings/arc/axs103.txt b/Documentation/devicetree/bindings/arc/axs103.txt
new file mode 100644
index 000000000000..6eea862e72b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arc/axs103.txt
@@ -0,0 +1,8 @@
+Synopsys DesignWare ARC Software Development Platforms Device Tree Bindings
+---------------------------------------------------------------------------
+
+SDP Main Board with an AXC003 FPGA Card which can contain various flavours of
+HS38x cores.
+
+Required root node properties:
+    - compatible = "snps,axs103", "snps,arc-sdp";
diff --git a/arch/arc/boot/dts/axc003.dtsi b/arch/arc/boot/dts/axc003.dtsi
new file mode 100644
index 000000000000..15c8d6226c9d
--- /dev/null
+++ b/arch/arc/boot/dts/axc003.dtsi
@@ -0,0 +1,102 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device tree for AXC003 CPU card: HS38x UP configuration
+ */
+
+/ {
+	compatible = "snps,arc";
+	clock-frequency = <75000000>;
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
+		cpu_intc: archs-intc@cpu {
+			compatible = "snps,archs-intc";
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
+				interrupts = <25>;
+			};
+		};
+
+		debug_uart: dw-apb-uart@0x5000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x5000 0x100>;
+			clock-frequency = <33333000>;
+			interrupt-parent = <&ictl_intc>;
+			interrupts = <2 4>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		arcpct0: pct {
+			compatible = "snps,archs-pct";
+			#interrupt-cells = <1>;
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <20>;
+		};
+	};
+
+	/*
+	 * This INTC is actually connected to DW APB GPIO
+	 * which acts as a wire between MB INTC and CPU INTC.
+	 * GPIO INTC is configured in platform init code
+	 * and here we mimic direct connection from MB INTC to
+	 * CPU INTC, thus we set "interrupts = <7>" instead of
+	 * "interrupts = <12>"
+	 *
+	 * This intc actually resides on MB, but we move it here to
+	 * avoid duplicating the MB dtsi file given that IRQ from
+	 * this intc to cpu intc are different for axs101 and axs103
+	 */
+	mb_intc: dw-apb-ictl@0xe0012000 {
+		#interrupt-cells = <1>;
+		compatible = "snps,dw-apb-ictl";
+		reg = < 0xe0012000 0x200 >;
+		interrupt-controller;
+		interrupt-parent = <&cpu_intc>;
+		interrupts = < 24 >;
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
diff --git a/arch/arc/boot/dts/axc003_idu.dtsi b/arch/arc/boot/dts/axc003_idu.dtsi
new file mode 100644
index 000000000000..199d42820eca
--- /dev/null
+++ b/arch/arc/boot/dts/axc003_idu.dtsi
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2014, 2015 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device tree for AXC003 CPU card: HS38x2 (Dual Core) with IDU intc
+ */
+
+/ {
+	compatible = "snps,arc";
+	clock-frequency = <75000000>;
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
+		cpu_intc: archs-intc@cpu {
+			compatible = "snps,archs-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		idu_intc: idu-interrupt-controller {
+			compatible = "snps,archs-idu-intc";
+			interrupt-controller;
+			interrupt-parent = <&cpu_intc>;
+
+			/*
+			 * <hwirq  distribution>
+			 * distribution: 0=RR; 1=cpu0, 2=cpu1, 4=cpu2, 8=cpu3
+			 */
+			#interrupt-cells = <2>;
+
+			/*
+			 * upstream irqs to core intc - downstream these are
+			 * "COMMON" irq 0,1..
+			 */
+			interrupts = <24 25>;
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
+				interrupt-parent = <&idu_intc>;
+
+				/*
+				 * cmn irq 1 -> cpu irq 25
+				 * Distribute to cpu0 only
+				 */
+				interrupts = <1 1>;
+			};
+		};
+
+		debug_uart: dw-apb-uart@0x5000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x5000 0x100>;
+			clock-frequency = <33333000>;
+			interrupt-parent = <&ictl_intc>;
+			interrupts = <2 4>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		arcpct0: pct {
+			compatible = "snps,archs-pct";
+			#interrupt-cells = <1>;
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <20>;
+		};
+	};
+
+	/*
+	 * This INTC is actually connected to DW APB GPIO
+	 * which acts as a wire between MB INTC and CPU INTC.
+	 * GPIO INTC is configured in platform init code
+	 * and here we mimic direct connection from MB INTC to
+	 * CPU INTC, thus we set "interrupts = <0 1>" instead of
+	 * "interrupts = <12>"
+	 *
+	 * This intc actually resides on MB, but we move it here to
+	 * avoid duplicating the MB dtsi file given that IRQ from
+	 * this intc to cpu intc are different for axs101 and axs103
+	 */
+	mb_intc: dw-apb-ictl@0xe0012000 {
+		#interrupt-cells = <1>;
+		compatible = "snps,dw-apb-ictl";
+		reg = < 0xe0012000 0x200 >;
+		interrupt-controller;
+		interrupt-parent = <&idu_intc>;
+		interrupts = <0 1>;	/* cmn irq 0 -> cpu irq 24
+					   distribute to cpu0 only */
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
diff --git a/arch/arc/boot/dts/axs103.dts b/arch/arc/boot/dts/axs103.dts
new file mode 100644
index 000000000000..e6d0e31ea299
--- /dev/null
+++ b/arch/arc/boot/dts/axs103.dts
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device Tree for AXS103 SDP with AXS10X Main Board and
+ * AXC003 FPGA Card (with UP bitfile)
+ */
+/dts-v1/;
+
+/include/ "axc003.dtsi"
+/include/ "axs10x_mb.dtsi"
+
+/ {
+	compatible = "snps,axs103", "snps,arc-sdp";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=ttyS3,115200n8 debug print-fatal-signals=1";
+	};
+};
diff --git a/arch/arc/boot/dts/axs103_idu.dts b/arch/arc/boot/dts/axs103_idu.dts
new file mode 100644
index 000000000000..f999fef5a60a
--- /dev/null
+++ b/arch/arc/boot/dts/axs103_idu.dts
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device Tree for AXS103 SDP with AXS10X Main Board and
+ * AXC003 FPGA Card (with SMP bitfile)
+ */
+/dts-v1/;
+
+/include/ "axc003_idu.dtsi"
+/include/ "axs10x_mb.dtsi"
+
+/ {
+	compatible = "snps,axs103", "snps,arc-sdp";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=ttyS3,115200n8 debug print-fatal-signals=1";
+	};
+};
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
new file mode 100644
index 000000000000..83a6d8d5cc58
--- /dev/null
+++ b/arch/arc/configs/axs103_defconfig
@@ -0,0 +1,117 @@
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
+CONFIG_INITRAMFS_SOURCE="../../arc_initramfs_hs/"
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARC_PLAT_AXS10X=y
+CONFIG_AXS103=y
+CONFIG_ISA_ARCV2=y
+CONFIG_ARC_BUILTIN_DTB_NAME="axs103"
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
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_AXS=y
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
+CONFIG_USB=y
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
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
new file mode 100644
index 000000000000..f1e1c84e0dda
--- /dev/null
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -0,0 +1,118 @@
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
+CONFIG_INITRAMFS_SOURCE="../../arc_initramfs_hs/"
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB=y
+CONFIG_MODULES=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARC_PLAT_AXS10X=y
+CONFIG_AXS103=y
+CONFIG_ISA_ARCV2=y
+CONFIG_SMP=y
+CONFIG_ARC_BUILTIN_DTB_NAME="axs103_idu"
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
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_AXS=y
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
+CONFIG_USB=y
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
diff --git a/arch/arc/kernel/devtree.c b/arch/arc/kernel/devtree.c
index f801d46dc087..7e844fd8213f 100644
--- a/arch/arc/kernel/devtree.c
+++ b/arch/arc/kernel/devtree.c
@@ -33,7 +33,7 @@ static void __init arc_set_early_base_baud(unsigned long dt_root)
 	if (of_flat_dt_is_compatible(dt_root, "abilis,arc-tb10x"))
 		arc_base_baud = core_clk/3;
 	else if (of_flat_dt_is_compatible(dt_root, "snps,arc-sdp"))
-		arc_base_baud = 33333333;	/* Fixed 33MHz clk */
+		arc_base_baud = 33333333;	/* Fixed 33MHz clk (AXS10x) */
 	else
 		arc_base_baud = core_clk;
 }
diff --git a/arch/arc/plat-axs10x/Kconfig b/arch/arc/plat-axs10x/Kconfig
index 45641ca8aba8..d475f9d4847c 100644
--- a/arch/arc/plat-axs10x/Kconfig
+++ b/arch/arc/plat-axs10x/Kconfig
@@ -6,7 +6,7 @@
 # published by the Free Software Foundation.
 #
 
-config ARC_PLAT_AXS10X
+menuconfig ARC_PLAT_AXS10X
 	bool "Synopsys ARC AXS10x Software Development Platforms"
 	select DW_APB_ICTL
 	select GPIO_DWAPB
@@ -23,6 +23,7 @@ config ARC_PLAT_AXS10X
 if ARC_PLAT_AXS10X
 
 config AXS101
+	depends on ISA_ARCOMPACT
 	bool "AXS101 with AXC001 CPU Card (ARC 770D/EM6/AS221)"
 	help
 	  This adds support for the 770D/EM6/AS221 CPU Card. Only the ARC
@@ -32,4 +33,14 @@ config AXS101
 	  this daughtercard. Please use the axs101.dts device tree
 	  with this configuration.
 
+config AXS103
+	bool "AXS103 with AXC003 CPU Card (ARC HS38x)"
+	depends on ISA_ARCV2
+	help
+	  This adds support for the HS38x CPU Card.
+
+	  The AXS103 Platform consists of an AXS10x mainboard with
+	  this daughtercard. Please use the axs103.dts device tree
+	  with this configuration.
+
 endif
diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
index a1cecdaf9dca..ad0a7ef84660 100644
--- a/arch/arc/plat-axs10x/axs10x.c
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -1,5 +1,5 @@
 /*
- * AXS101 Software Development Platform
+ * AXS101/AXS103 Software Development Platform
  *
  * Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
  *
@@ -15,8 +15,10 @@
  */
 
 #include <linux/of_platform.h>
-#include <asm/mach_desc.h>
+#include <asm/clk.h>
 #include <asm/io.h>
+#include <asm/mach_desc.h>
+#include <asm/mcip.h>
 
 #define AXS_MB_CGU		0xE0010000
 #define AXS_MB_CREG		0xE0011000
@@ -29,14 +31,6 @@
 #define AXC001_CREG		0xF0001000
 #define AXC001_GPIO_INTC	0xF0003000
 
-#define CREG_CPU_ADDR_770	(AXC001_CREG + 0x20)
-#define CREG_CPU_ADDR_TUNN	(AXC001_CREG + 0x60)
-#define CREG_CPU_ADDR_770_UPD	(AXC001_CREG + 0x34)
-#define CREG_CPU_ADDR_TUNN_UPD	(AXC001_CREG + 0x74)
-
-#define CREG_CPU_ARC770_IRQ_MUX	(AXC001_CREG + 0x114)
-#define CREG_CPU_GPIO_UART_MUX	(AXC001_CREG + 0x120)
-
 static void __init axs10x_enable_gpio_intc_wire(void)
 {
 	/*
@@ -83,6 +77,22 @@ static void __init axs10x_enable_gpio_intc_wire(void)
 	iowrite32(1 << MB_TO_GPIO_IRQ, (void __iomem *) GPIO_INTEN);
 }
 
+static inline void __init
+write_cgu_reg(uint32_t value, void __iomem *reg, void __iomem *lock_reg)
+{
+	unsigned int loops = 128 * 1024, ctr;
+
+	iowrite32(value, reg);
+
+	ctr = loops;
+	while (((ioread32(lock_reg) & 1) == 1) && ctr--) /* wait for unlock */
+		cpu_relax();
+
+	ctr = loops;
+	while (((ioread32(lock_reg) & 1) == 0) && ctr--) /* wait for re-lock */
+		cpu_relax();
+}
+
 static void __init axs10x_print_board_ver(unsigned int creg, const char *str)
 {
 	union ver {
@@ -118,6 +128,16 @@ static void __init axs10x_early_init(void)
 	axs10x_print_board_ver(CREG_MB_VER, mb);
 }
 
+#ifdef CONFIG_AXS101
+
+#define CREG_CPU_ADDR_770	(AXC001_CREG + 0x20)
+#define CREG_CPU_ADDR_TUNN	(AXC001_CREG + 0x60)
+#define CREG_CPU_ADDR_770_UPD	(AXC001_CREG + 0x34)
+#define CREG_CPU_ADDR_TUNN_UPD	(AXC001_CREG + 0x74)
+
+#define CREG_CPU_ARC770_IRQ_MUX	(AXC001_CREG + 0x114)
+#define CREG_CPU_GPIO_UART_MUX	(AXC001_CREG + 0x120)
+
 /*
  * Set up System Memory Map for ARC cpu / peripherals controllers
  *
@@ -287,6 +307,145 @@ static void __init axs101_early_init(void)
 	axs10x_early_init();
 }
 
+#endif	/* CONFIG_AXS101 */
+
+#ifdef CONFIG_AXS103
+
+#define AXC003_CGU	0xF0000000
+#define AXC003_CREG	0xF0001000
+#define AXC003_MST_AXI_TUNNEL	0
+#define AXC003_MST_HS38		1
+
+#define CREG_CPU_AXI_M0_IRQ_MUX	(AXC003_CREG + 0x440)
+#define CREG_CPU_GPIO_UART_MUX	(AXC003_CREG + 0x480)
+#define CREG_CPU_TUN_IO_CTRL	(AXC003_CREG + 0x494)
+
+
+union pll_reg {
+	struct {
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		unsigned int pad:17, noupd:1, bypass:1, edge:1, high:6, low:6;
+#else
+		unsigned int low:6, high:6, edge:1, bypass:1, noupd:1, pad:17;
+#endif
+	};
+	unsigned int val;
+};
+
+static unsigned int __init axs103_get_freq(void)
+{
+	union pll_reg idiv, fbdiv, odiv;
+	unsigned int f = 33333333;
+
+	idiv.val = ioread32((void __iomem *)AXC003_CGU + 0x80 + 0);
+	fbdiv.val = ioread32((void __iomem *)AXC003_CGU + 0x80 + 4);
+	odiv.val = ioread32((void __iomem *)AXC003_CGU + 0x80 + 8);
+
+	if (idiv.bypass != 1)
+		f = f / (idiv.low + idiv.high);
+
+	if (fbdiv.bypass != 1)
+		f = f * (fbdiv.low + fbdiv.high);
+
+	if (odiv.bypass != 1)
+		f = f / (odiv.low + odiv.high);
+
+	f = (f + 500000) / 1000000; /* Rounding */
+	return f;
+}
+
+static inline unsigned int __init encode_div(unsigned int id, int upd)
+{
+	union pll_reg div;
+
+	div.val = 0;
+
+	div.noupd = !upd;
+	div.bypass = id == 1 ? 1 : 0;
+	div.edge = (id%2 == 0) ? 0 : 1;  /* 0 = rising */
+	div.low = (id%2 == 0) ? id >> 1 : (id >> 1)+1;
+	div.high = id >> 1;
+
+	return div.val;
+}
+
+noinline static void __init
+axs103_set_freq(unsigned int id, unsigned int fd, unsigned int od)
+{
+	write_cgu_reg(encode_div(id, 0),
+		      (void __iomem *)AXC003_CGU + 0x80 + 0,
+		      (void __iomem *)AXC003_CGU + 0x110);
+
+	write_cgu_reg(encode_div(fd, 0),
+		      (void __iomem *)AXC003_CGU + 0x80 + 4,
+		      (void __iomem *)AXC003_CGU + 0x110);
+
+	write_cgu_reg(encode_div(od, 1),
+		      (void __iomem *)AXC003_CGU + 0x80 + 8,
+		      (void __iomem *)AXC003_CGU + 0x110);
+}
+
+static void __init axs103_early_init(void)
+{
+	switch (arc_get_core_freq()/1000000) {
+	case 33:
+		axs103_set_freq(1, 1, 1);
+		break;
+	case 50:
+		axs103_set_freq(1, 30, 20);
+		break;
+	case 75:
+		axs103_set_freq(2, 45, 10);
+		break;
+	case 90:
+		axs103_set_freq(2, 54, 10);
+		break;
+	case 100:
+		axs103_set_freq(1, 30, 10);
+		break;
+	case 125:
+		axs103_set_freq(2, 45,  6);
+		break;
+	default:
+		/*
+		 * In this case, core_frequency derived from
+		 * DT "clock-frequency" might not match with board value.
+		 * Hence update it to match the board value.
+		 */
+		arc_set_core_freq(axs103_get_freq() * 1000000);
+		break;
+	}
+
+	pr_info("Freq is %dMHz\n", axs103_get_freq());
+
+	/* Memory maps already config in pre-bootloader */
+
+	/* set GPIO mux to UART */
+	iowrite32(0x01, (void __iomem *) CREG_CPU_GPIO_UART_MUX);
+
+	iowrite32((0x00100000U | 0x000C0000U | 0x00003322U),
+		  (void __iomem *) CREG_CPU_TUN_IO_CTRL);
+
+	/* Set up the AXS_MB interrupt system.*/
+	iowrite32(12, (void __iomem *) (CREG_CPU_AXI_M0_IRQ_MUX
+					 + (AXC003_MST_HS38 << 2)));
+
+	/* connect ICTL - Main Board with GPIO line */
+	iowrite32(0x01, (void __iomem *) CREG_MB_IRQ_MUX);
+
+	axs10x_print_board_ver(AXC003_CREG + 4088, "AXC003 CPU Card");
+
+	axs10x_early_init();
+
+#ifdef CONFIG_ARC_MCIP
+	/* No Hardware init, but filling the smp ops callbacks */
+	mcip_init_early_smp();
+#endif
+}
+#endif
+
+#ifdef CONFIG_AXS101
+
 static const char *axs101_compat[] __initconst = {
 	"snps,axs101",
 	NULL,
@@ -296,3 +455,22 @@ MACHINE_START(AXS101, "axs101")
 	.dt_compat	= axs101_compat,
 	.init_early	= axs101_early_init,
 MACHINE_END
+
+#endif	/* CONFIG_AXS101 */
+
+#ifdef CONFIG_AXS103
+
+static const char *axs103_compat[] __initconst = {
+	"snps,axs103",
+	NULL,
+};
+
+MACHINE_START(AXS103, "axs103")
+	.dt_compat	= axs103_compat,
+	.init_early	= axs103_early_init,
+#ifdef CONFIG_ARC_MCIP
+	.init_smp	= mcip_init_smp,
+#endif
+MACHINE_END
+
+#endif	/* CONFIG_AXS103 */
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
