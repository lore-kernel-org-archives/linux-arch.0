Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:51893 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933187AbbFILwy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2015 07:52:54 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 25/28] ARCv2: [nsim*hs*] Support simulation platforms for HS38x cores
Date: Tue, 9 Jun 2015 17:18:25 +0530
Message-ID: <1433850508-26317-26-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Message-ID: <20150609114825.UpsanTKq2WQCdSJM0RCigFrjCITU4Di-ZsN1M5f14iI@z>

Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/boot/dts/nsim_hs.dts              |  53 +++++++++++++++
 arch/arc/boot/dts/nsim_hs_idu.dts          |  72 ++++++++++++++++++++
 arch/arc/boot/dts/nsimosci_hs.dts          |  80 +++++++++++++++++++++++
 arch/arc/boot/dts/nsimosci_hs_idu.dts      | 101 +++++++++++++++++++++++++++++
 arch/arc/configs/nsim_hs_defconfig         |  64 ++++++++++++++++++
 arch/arc/configs/nsim_hs_smp_defconfig     |  63 ++++++++++++++++++
 arch/arc/configs/nsimosci_hs_defconfig     |  73 +++++++++++++++++++++
 arch/arc/configs/nsimosci_hs_smp_defconfig |  93 ++++++++++++++++++++++++++
 arch/arc/plat-sim/platform.c               |   2 +
 9 files changed, 601 insertions(+)
 create mode 100644 arch/arc/boot/dts/nsim_hs.dts
 create mode 100644 arch/arc/boot/dts/nsim_hs_idu.dts
 create mode 100644 arch/arc/boot/dts/nsimosci_hs.dts
 create mode 100644 arch/arc/boot/dts/nsimosci_hs_idu.dts
 create mode 100644 arch/arc/configs/nsim_hs_defconfig
 create mode 100644 arch/arc/configs/nsim_hs_smp_defconfig
 create mode 100644 arch/arc/configs/nsimosci_hs_defconfig
 create mode 100644 arch/arc/configs/nsimosci_hs_smp_defconfig

diff --git a/arch/arc/boot/dts/nsim_hs.dts b/arch/arc/boot/dts/nsim_hs.dts
new file mode 100644
index 000000000000..911f069e0540
--- /dev/null
+++ b/arch/arc/boot/dts/nsim_hs.dts
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "snps,nsim_hs";
+	interrupt-parent = <&core_intc>;
+
+	chosen {
+		bootargs = "earlycon=arc_uart,mmio32,0xc0fc1000,115200n8 console=ttyARC0,115200n8";
+	};
+
+	aliases {
+		serial0 = &arcuart0;
+	};
+
+	fpga {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* child and parent address space 1:1 mapped */
+		ranges;
+
+		core_intc: core-interrupt-controller {
+			compatible = "snps,archs-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		arcuart0: serial@c0fc1000 {
+			compatible = "snps,arc-uart";
+			reg = <0xc0fc1000 0x100>;
+			interrupts = <24>;
+			clock-frequency = <80000000>;
+			current-speed = <115200>;
+			status = "okay";
+		};
+
+		arcpct0: pct {
+			compatible = "snps,archs-pct";
+			#interrupt-cells = <1>;
+			interrupts = <20>;
+		};
+	};
+};
diff --git a/arch/arc/boot/dts/nsim_hs_idu.dts b/arch/arc/boot/dts/nsim_hs_idu.dts
new file mode 100644
index 000000000000..46ab31975612
--- /dev/null
+++ b/arch/arc/boot/dts/nsim_hs_idu.dts
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "snps,nsim_hs";
+	interrupt-parent = <&core_intc>;
+
+	chosen {
+		bootargs = "earlycon=arc_uart,mmio32,0xc0fc1000,115200n8 console=ttyARC0,115200n8";
+	};
+
+	aliases {
+		serial0 = &arcuart0;
+	};
+
+	fpga {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* child and parent address space 1:1 mapped */
+		ranges;
+
+		core_intc: core-interrupt-controller {
+			compatible = "snps,archs-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		idu_intc: idu-interrupt-controller {
+			compatible = "snps,archs-idu-intc";
+			interrupt-controller;
+			interrupt-parent = <&core_intc>;
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
+			interrupts = <24 25 26 27 28 29 30 31>;
+		};
+
+		arcuart0: serial@c0fc1000 {
+			compatible = "snps,arc-uart";
+			reg = <0xc0fc1000 0x100>;
+			interrupt-parent = <&idu_intc>;
+			interrupts = <0 0>;
+			clock-frequency = <80000000>;
+			current-speed = <115200>;
+			status = "okay";
+		};
+
+		arcpct0: pct {
+			compatible = "snps,archs-pct";
+			#interrupt-cells = <1>;
+			interrupts = <20>;
+		};
+	};
+};
diff --git a/arch/arc/boot/dts/nsimosci_hs.dts b/arch/arc/boot/dts/nsimosci_hs.dts
new file mode 100644
index 000000000000..d64a96f8515a
--- /dev/null
+++ b/arch/arc/boot/dts/nsimosci_hs.dts
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "snps,nsimosci_hs";
+	clock-frequency = <20000000>;	/* 20 MHZ */
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&core_intc>;
+
+	chosen {
+		/* this is for console on PGU */
+		/* bootargs = "console=tty0 consoleblank=0"; */
+		/* this is for console on serial */
+		bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8 console=tty0 console=ttyS0,115200n8 consoleblank=0 debug";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	fpga {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* child and parent address space 1:1 mapped */
+		ranges;
+
+		core_intc: core-interrupt-controller {
+			compatible = "snps,archs-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		uart0: serial@f0000000 {
+			compatible = "ns8250";
+			reg = <0xf0000000 0x2000>;
+			interrupts = <24>;
+			clock-frequency = <3686400>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test = <1>;
+		};
+
+		pgu0: pgu@f9000000 {
+			compatible = "snps,arcpgufb";
+			reg = <0xf9000000 0x400>;
+		};
+
+		ps2: ps2@f9001000 {
+			compatible = "snps,arc_ps2";
+			reg = <0xf9000400 0x14>;
+			interrupts = <27>;
+			interrupt-names = "arc_ps2_irq";
+		};
+
+		eth0: ethernet@f0003000 {
+			compatible = "snps,oscilan";
+			reg = <0xf0003000 0x44>;
+			interrupts = <25>, <26>;
+			interrupt-names = "rx", "tx";
+		};
+
+		arcpct0: pct {
+			compatible = "snps,archs-pct";
+			#interrupt-cells = <1>;
+			interrupts = <20>;
+		};
+	};
+};
diff --git a/arch/arc/boot/dts/nsimosci_hs_idu.dts b/arch/arc/boot/dts/nsimosci_hs_idu.dts
new file mode 100644
index 000000000000..f6bf0ca95a57
--- /dev/null
+++ b/arch/arc/boot/dts/nsimosci_hs_idu.dts
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2014-15 Synopsys, Inc. (www.synopsys.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "snps,nsimosci_hs";
+	clock-frequency = <5000000>;	/* 5 MHZ */
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&core_intc>;
+
+	chosen {
+		/* this is for console on serial */
+		bootargs = "earlycon=uart8250,mmio32,0xf0000000,115200n8 console=tty0 console=ttyS0,115200n8 consoleblan=0 debug";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	fpga {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		/* child and parent address space 1:1 mapped */
+		ranges;
+
+		core_intc: core-interrupt-controller {
+			compatible = "snps,archs-intc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+/*			interrupts = <16 17 18 19 20 21 22 23 24 25>; */
+		};
+
+		idu_intc: idu-interrupt-controller {
+			compatible = "snps,archs-idu-intc";
+			interrupt-controller;
+			interrupt-parent = <&core_intc>;
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
+			interrupts = <24 25 26 27 28 29 30 31>;
+		};
+
+		uart0: serial@f0000000 {
+			compatible = "ns8250";
+			reg = <0xf0000000 0x2000>;
+			interrupt-parent = <&idu_intc>;
+			interrupts = <0 0>; /* cmn irq 0 -> cpu irq 24
+						RR distribute to all cpus */
+			clock-frequency = <3686400>;
+			baud = <115200>;
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			no-loopback-test = <1>;
+		};
+
+		pgu0: pgu@f9000000 {
+			compatible = "snps,arcpgufb";
+			reg = <0xf9000000 0x400>;
+		};
+
+		ps2: ps2@f9001000 {
+			compatible = "snps,arc_ps2";
+			reg = <0xf9000400 0x14>;
+			interrupts = <3 0>;
+			interrupt-parent = <&idu_intc>;
+			interrupt-names = "arc_ps2_irq";
+		};
+
+		eth0: ethernet@f0003000 {
+			compatible = "snps,oscilan";
+			reg = <0xf0003000 0x44>;
+			interrupt-parent = <&idu_intc>;
+			interrupts = <1 2>, <2 2>;
+			interrupt-names = "rx", "tx";
+		};
+
+		arcpct0: pct {
+			compatible = "snps,archs-pct";
+			#interrupt-cells = <1>;
+			interrupts = <20>;
+		};
+	};
+};
diff --git a/arch/arc/configs/nsim_hs_defconfig b/arch/arc/configs/nsim_hs_defconfig
new file mode 100644
index 000000000000..f761a7c70761
--- /dev/null
+++ b/arch/arc/configs/nsim_hs_defconfig
@@ -0,0 +1,64 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="../arc_initramfs_hs/"
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARC_PLAT_SIM=y
+CONFIG_ISA_ARCV2=y
+CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs"
+CONFIG_PREEMPT=y
+# CONFIG_COMPACTION is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+# CONFIG_IPV6 is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_ARC=y
+CONFIG_SERIAL_ARC_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_DEBUG_PREEMPT is not set
+CONFIG_XZ_DEC=y
diff --git a/arch/arc/configs/nsim_hs_smp_defconfig b/arch/arc/configs/nsim_hs_smp_defconfig
new file mode 100644
index 000000000000..dc6f74f41283
--- /dev/null
+++ b/arch/arc/configs/nsim_hs_smp_defconfig
@@ -0,0 +1,63 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_SWAP is not set
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="../arc_initramfs_hs/"
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARC_PLAT_SIM=y
+CONFIG_ARC_BOARD_ML509=y
+CONFIG_ISA_ARCV2=y
+CONFIG_SMP=y
+CONFIG_ARC_BUILTIN_DTB_NAME="nsim_hs_idu"
+CONFIG_PREEMPT=y
+# CONFIG_COMPACTION is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+# CONFIG_IPV6 is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_ARC=y
+CONFIG_SERIAL_ARC_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_XZ_DEC=y
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
new file mode 100644
index 000000000000..3fef0a210c56
--- /dev/null
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -0,0 +1,73 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="../arc_initramfs_hs/"
+CONFIG_KALLSYMS_ALL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARC_PLAT_SIM=y
+CONFIG_ISA_ARCV2=y
+CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci_hs"
+# CONFIG_COMPACTION is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+# CONFIG_IPV6 is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+CONFIG_NET_OSCI_LAN=y
+CONFIG_INPUT_EVDEV=y
+# CONFIG_MOUSE_PS2_ALPS is not set
+# CONFIG_MOUSE_PS2_LOGIPS2PP is not set
+# CONFIG_MOUSE_PS2_SYNAPTICS is not set
+# CONFIG_MOUSE_PS2_TRACKPOINT is not set
+CONFIG_MOUSE_PS2_TOUCHKIT=y
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_SERIO_ARC_PS2=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
new file mode 100644
index 000000000000..51784837daae
--- /dev/null
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -0,0 +1,93 @@
+CONFIG_CROSS_COMPILE="arc-linux-uclibc-"
+CONFIG_DEFAULT_HOSTNAME="ARCLinux"
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_UTS_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="../arc_initramfs_hs/"
+# CONFIG_COMPAT_BRK is not set
+CONFIG_KPROBES=y
+CONFIG_MODULES=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_ARC_PLAT_SIM=y
+CONFIG_ARC_BOARD_ML509=y
+CONFIG_ISA_ARCV2=y
+CONFIG_SMP=y
+CONFIG_ARC_HAS_LL64=y
+# CONFIG_ARC_HAS_RTSC is not set
+CONFIG_ARC_BUILTIN_DTB_NAME="nsimosci_hs_idu"
+CONFIG_PREEMPT=y
+# CONFIG_COMPACTION is not set
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_PACKET_DIAG=y
+CONFIG_UNIX=y
+CONFIG_UNIX_DIAG=y
+CONFIG_NET_KEY=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_BLK_DEV is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_NET_OSCI_LAN=y
+# CONFIG_WLAN is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_MOUSE_PS2_TOUCHKIT=y
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_SERIO_LIBPS2=y
+CONFIG_SERIO_ARC_PS2=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+CONFIG_ARCPGU_RGB888=y
+CONFIG_ARCPGU_DISPTYPE=0
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FTRACE=y
diff --git a/arch/arc/plat-sim/platform.c b/arch/arc/plat-sim/platform.c
index 8795ae2ef48a..d9e35b4a2f08 100644
--- a/arch/arc/plat-sim/platform.c
+++ b/arch/arc/plat-sim/platform.c
@@ -22,7 +22,9 @@
 
 static const char *simulation_compat[] __initconst = {
 	"snps,nsim",
+	"snps,nsim_hs",
 	"snps,nsimosci",
+	"snps,nsimosci_hs",
 	NULL,
 };
 
-- 
1.9.1

