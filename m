From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 28/28] ARCv2: [vdk] dts files and defconfig for HS38 VDK
Date: Tue, 9 Jun 2015 17:18:28 +0530
Message-ID: <1433850508-26317-29-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:51916 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbFILym (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:54:42 -0400
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Ruud Derwig <Ruud.Derwig@synopsys.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>

From: Ruud Derwig <rderwig@synopsys.com>

 - CONFIG_ARC_UBOOT_SUPPORT to handle arguments passed in r0, r1, r2
 - CONFIG_DEVTMPFS_MOUNT for mouting rootfs since it uses external cpio
   for rootfs

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Ruud Derwig <rderwig@synopsys.com>
[vgupta: folded the Main baord DT files for smp/up into one]
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/boot/dts/vdk_axc003.dtsi       |  61 +++++++++++++++++++
 arch/arc/boot/dts/vdk_axc003_idu.dtsi   |  76 +++++++++++++++++++++++
 arch/arc/boot/dts/vdk_axs10x_mb.dtsi    |  93 ++++++++++++++++++++++++++++
 arch/arc/boot/dts/vdk_hs38.dts          |  21 +++++++
 arch/arc/boot/dts/vdk_hs38_smp.dts      |  21 +++++++
 arch/arc/configs/vdk_hs38_defconfig     | 102 +++++++++++++++++++++++++++++++
 arch/arc/configs/vdk_hs38_smp_defconfig | 104 ++++++++++++++++++++++++++++++++
 arch/arc/kernel/asm-offsets.c           |   2 +
 arch/arc/mm/tlbex.S                     |   2 +
 arch/arc/plat-axs10x/axs10x.c           |   8 +++
 10 files changed, 490 insertions(+)
 create mode 100644 arch/arc/boot/dts/vdk_axc003.dtsi
 create mode 100644 arch/arc/boot/dts/vdk_axc003_idu.dtsi
 create mode 100644 arch/arc/boot/dts/vdk_axs10x_mb.dtsi
 create mode 100644 arch/arc/boot/dts/vdk_hs38.dts
 create mode 100644 arch/arc/boot/dts/vdk_hs38_smp.dts
 create mode 100644 arch/arc/configs/vdk_hs38_defconfig
 create mode 100644 arch/arc/configs/vdk_hs38_smp_defconfig

diff --git a/arch/arc/boot/dts/vdk_axc003.dtsi b/arch/arc/boot/dts/vdk_axc003.dtsi
new file mode 100644
index 000000000000..9393fd902f0d
--- /dev/null
+++ b/arch/arc/boot/dts/vdk_axc003.dtsi
@@ -0,0 +1,61 @@
+/*
+ * Copyright (C) 2013, 2014 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device tree for AXC003 CPU card: HS38x UP configuration (VDK version)
+ */
+
+/ {
+	compatible = "snps,arc";
+	clock-frequency = <50000000>;
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
+		debug_uart: dw-apb-uart@0x5000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x5000 0x100>;
+			clock-frequency = <2403200>;
+			interrupt-parent = <&cpu_intc>;
+			interrupts = <19>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+	};
+
+	mb_intc: dw-apb-ictl@0xe0012000 {
+		#interrupt-cells = <1>;
+		compatible = "snps,dw-apb-ictl";
+		reg = < 0xe0012000 0x200 >;
+		interrupt-controller;
+		interrupt-parent = <&cpu_intc>;
+		interrupts = < 18 >;
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
diff --git a/arch/arc/boot/dts/vdk_axc003_idu.dtsi b/arch/arc/boot/dts/vdk_axc003_idu.dtsi
new file mode 100644
index 000000000000..9bee8ed09eb0
--- /dev/null
+++ b/arch/arc/boot/dts/vdk_axc003_idu.dtsi
@@ -0,0 +1,76 @@
+/*
+ * Copyright (C) 2014, 2015 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * Device tree for AXC003 CPU card:
+ * HS38x2 (Dual Core) with IDU intc (VDK version)
+ */
+
+/ {
+	compatible = "snps,arc";
+	clock-frequency = <50000000>;
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
+			interrupts = <24 25 26 27>;
+		};
+
+		debug_uart: dw-apb-uart@0x5000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x5000 0x100>;
+			clock-frequency = <2403200>;
+			interrupt-parent = <&idu_intc>;
+			interrupts = <2 0>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+	};
+
+	mb_intc: dw-apb-ictl@0xe0012000 {
+		#interrupt-cells = <1>;
+		compatible = "snps,dw-apb-ictl";
+		reg = < 0xe0012000 0x200 >;
+		interrupt-controller;
+		interrupt-parent = <&idu_intc>;
+		interrupts = < 0 0 >;
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
diff --git a/arch/arc/boot/dts/vdk_axs10x_mb.dtsi b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
new file mode 100644
index 000000000000..45cd665fca23
--- /dev/null
+++ b/arch/arc/boot/dts/vdk_axs10x_mb.dtsi
@@ -0,0 +1,93 @@
+/*
+ * Support for peripherals on the AXS10x mainboard (VDK version)
+ *
+ * Copyright (C) 2013-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	axs10x_mb_vdk {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0xe0000000 0x10000000>;
+		interrupt-parent = <&mb_intc>;
+
+		clocks {
+			apbclk: apbclk {
+				compatible = "fixed-clock";
+				clock-frequency = <50000000>;
+				#clock-cells = <0>;
+			};
+
+		};
+
+		ethernet@0x18000 {
+			#interrupt-cells = <1>;
+			compatible = "snps,dwmac";
+			reg = < 0x18000 0x2000 >;
+			interrupts = < 4 >;
+			interrupt-names = "macirq";
+			phy-mode = "rgmii";
+			snps,phy-addr = < 0 >;  // VDK model phy address is 0
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
+		uart@0x20000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x20000 0x100>;
+			clock-frequency = <2403200>;
+			interrupts = <17>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart@0x21000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x21000 0x100>;
+			clock-frequency = <2403200>;
+			interrupts = <18>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+		uart@0x22000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x22000 0x100>;
+			clock-frequency = <2403200>;
+			interrupts = <19>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+		};
+
+/* PGU output directly sent to virtual LCD screen; hdmi controller not modelled */
+		pgu@0x17000 {
+			compatible = "snps,arcpgufb";
+			reg = <0x17000 0x400>;
+			clock-frequency = <51000000>; /* PGU'clock is initated in init function */
+			/* interrupts = <5>;   PGU interrupts not used, this vector is used for ps2 below */
+		};
+
+/* VDK has additional ps2 keyboard/mouse interface integrated in LCD screen model */
+		ps2: ps2@e0017400 {
+			compatible = "snps,arc_ps2";
+			reg = <0x17400 0x14>;
+			interrupts = <5>;
+			interrupt-names = "arc_ps2_irq";
+		};
+	};
+};
diff --git a/arch/arc/boot/dts/vdk_hs38.dts b/arch/arc/boot/dts/vdk_hs38.dts
new file mode 100644
index 000000000000..5d803dd2de59
--- /dev/null
+++ b/arch/arc/boot/dts/vdk_hs38.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2013 Synopsys, Inc. (www.synopsys.com)
+ *
+ * ARC HS38 Virtual Development Kit (VDK)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "vdk_axc003.dtsi"
+/include/ "vdk_axs10x_mb.dtsi"
+
+/ {
+	compatible = "snps,axs103";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0";
+	};
+};
diff --git a/arch/arc/boot/dts/vdk_hs38_smp.dts b/arch/arc/boot/dts/vdk_hs38_smp.dts
new file mode 100644
index 000000000000..031a5bc79b3e
--- /dev/null
+++ b/arch/arc/boot/dts/vdk_hs38_smp.dts
@@ -0,0 +1,21 @@
+/*
+ * Copyright (C) 2013 Synopsys, Inc. (www.synopsys.com)
+ *
+ * ARC HS38 Virtual Development Kit, SMP version (VDK)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "vdk_axc003_idu.dtsi"
+/include/ "vdk_axs10x_mb.dtsi"
+
+/ {
+	compatible = "snps,axs103";
+
+	chosen {
+		bootargs = "earlycon=uart8250,mmio32,0xe0022000,115200n8 console=tty0 console=ttyS3,115200n8 consoleblank=0";
+	};
+};
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
new file mode 100644
index 000000000000..ef35ef3923dd
--- /dev/null
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -0,0 +1,102 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARC_PLAT_AXS10X=y
+CONFIG_AXS103=y
+CONFIG_ISA_ARCV2=y
+CONFIG_ARC_UBOOT_SUPPORT=y
+CONFIG_ARC_BUILTIN_DTB_NAME="vdk_hs38"
+CONFIG_PREEMPT=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_IPV6 is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_SLRAM=y
+CONFIG_BLK_DEV_RAM=y
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
+CONFIG_MOUSE_PS2_TOUCHKIT=y
+CONFIG_SERIO_ARC_PS2=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_ARCPGU_RGB888=y
+CONFIG_ARCPGU_DISPTYPE=0
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_LOGO_LINUX_CLUT224 is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_SERIAL=y
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
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
new file mode 100644
index 000000000000..634509e5e572
--- /dev/null
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -0,0 +1,104 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARC_PLAT_AXS10X=y
+CONFIG_AXS103=y
+CONFIG_ISA_ARCV2=y
+CONFIG_SMP=y
+# CONFIG_ARC_HAS_GRTC is not set
+CONFIG_ARC_UBOOT_SUPPORT=y
+CONFIG_ARC_BUILTIN_DTB_NAME="vdk_hs38_smp"
+CONFIG_PREEMPT=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_IPV6 is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_SLRAM=y
+CONFIG_BLK_DEV_RAM=y
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
+CONFIG_MOUSE_PS2_TOUCHKIT=y
+CONFIG_SERIO_ARC_PS2=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_ARCPGU_RGB888=y
+CONFIG_ARCPGU_DISPTYPE=0
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_LOGO_LINUX_CLUT224 is not set
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_SERIAL=y
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
+CONFIG_DEBUG_SHIRQ=y
+CONFIG_LOCKUP_DETECTOR=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=10
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_FTRACE is not set
diff --git a/arch/arc/kernel/asm-offsets.c b/arch/arc/kernel/asm-offsets.c
index 605281f5b301..ecaf34e9235c 100644
--- a/arch/arc/kernel/asm-offsets.c
+++ b/arch/arc/kernel/asm-offsets.c
@@ -37,6 +37,8 @@ int main(void)
 
 	DEFINE(TASK_ACT_MM, offsetof(struct task_struct, active_mm));
 	DEFINE(TASK_TGID, offsetof(struct task_struct, tgid));
+	DEFINE(TASK_PID, offsetof(struct task_struct, pid));
+	DEFINE(TASK_COMM, offsetof(struct task_struct, comm));
 
 	DEFINE(MM_CTXT, offsetof(struct mm_struct, context));
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 8624ebd7114e..f6f4c3cb505d 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -313,6 +313,7 @@ ENTRY(EV_TLBMissI)
 	CONV_PTE_TO_TLB
 	COMMIT_ENTRY_TO_MMU
 	TLBMISS_RESTORE_REGS
+EV_TLBMissI_fast_ret:	; additional label for VDK OS-kit instrumentation
 	rtie
 
 END(EV_TLBMissI)
@@ -378,6 +379,7 @@ ENTRY(EV_TLBMissD)
 
 	COMMIT_ENTRY_TO_MMU
 	TLBMISS_RESTORE_REGS
+EV_TLBMissD_fast_ret:	; additional label for VDK OS-kit instrumentation
 	rtie
 
 ;-------- Common routine to call Linux Page Fault Handler -----------
diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
index ad0a7ef84660..99f7da513a48 100644
--- a/arch/arc/plat-axs10x/axs10x.c
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -15,6 +15,8 @@
  */
 
 #include <linux/of_platform.h>
+
+#include <asm/asm-offsets.h>
 #include <asm/clk.h>
 #include <asm/io.h>
 #include <asm/mach_desc.h>
@@ -473,4 +475,10 @@ MACHINE_START(AXS103, "axs103")
 #endif
 MACHINE_END
 
+/*
+ * For the VDK OS-kit, to get the offset to pid and command fields
+ */
+char coware_swa_pid_offset[TASK_PID];
+char coware_swa_comm_offset[TASK_COMM];
+
 #endif	/* CONFIG_AXS103 */
-- 
1.9.1
