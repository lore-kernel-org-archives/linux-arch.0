Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.asahi-net.or.jp ([202.224.39.198]:18155 "EHLO
	mail2.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbbBOHt6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 15 Feb 2015 02:49:58 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v3 10/15] h8300: Build scripts
Date: Sun, 15 Feb 2015 16:49:28 +0900
Message-ID: <1423986573-2329-11-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150215074928.5KIrS_8phZYhnsbpCucAegv4vEB-TyPWcGvBHe-DZK4@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/Kconfig              | 119 +++++++++++++++++++++++++++++++++++
 arch/h8300/Kconfig.cpu          | 136 ++++++++++++++++++++++++++++++++++++++++
 arch/h8300/Kconfig.debug        |  23 +++++++
 arch/h8300/Makefile             |  45 +++++++++++++
 arch/h8300/kernel/Makefile      |  16 +++++
 arch/h8300/kernel/vmlinux.lds.S |  85 +++++++++++++++++++++++++
 6 files changed, 424 insertions(+)
 create mode 100644 arch/h8300/Kconfig
 create mode 100644 arch/h8300/Kconfig.cpu
 create mode 100644 arch/h8300/Kconfig.debug
 create mode 100644 arch/h8300/Makefile
 create mode 100644 arch/h8300/kernel/Makefile
 create mode 100644 arch/h8300/kernel/vmlinux.lds.S

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
new file mode 100644
index 0000000..828c356
--- /dev/null
+++ b/arch/h8300/Kconfig
@@ -0,0 +1,119 @@
+config H8300
+	bool
+	default y
+	select HAVE_IDE
+	select GENERIC_ATOMIC64
+	select HAVE_UID16
+	select VIRT_TO_BUS
+	select ARCH_WANT_IPC_PARSE_VERSION
+	select GENERIC_IRQ_SHOW
+	select FRAME_POINTER
+	select GENERIC_CPU_DEVICES
+	select MODULES_USE_ELF_RELA
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select HAVE_ARCH_TRACEHOOK
+	select ARCH_WANT_FRAME_POINTERS
+
+config MMU
+	bool
+	default n
+
+config SWAP
+	bool
+	default n
+
+config ZONE_DMA
+	bool
+	default y
+
+config FPU
+	bool
+	default n
+
+config RWSEM_GENERIC_SPINLOCK
+	bool
+	default y
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U32
+	bool
+	default n
+
+config ARCH_HAS_ILOG2_U64
+	bool
+	default n
+
+config GENERIC_HWEIGHT
+	bool
+	default y
+
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
+config GENERIC_BUG
+        bool
+        depends on BUG
+
+config TIME_LOW_RES
+	bool
+	default y
+
+config NO_IOPORT_MAP
+	def_bool y
+
+config NO_DMA
+	def_bool n
+
+config ISA
+        def_bool n
+
+config PCI
+	def_bool n
+
+config HZ
+	int
+	default 100
+
+config NR_CPUS
+        int
+	default 1
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+source "arch/h8300/Kconfig.cpu"
+
+menu "Kernel Features"
+
+source "kernel/Kconfig.preempt"
+
+source "mm/Kconfig"
+
+endmenu
+
+menu "Executable file formats"
+
+source "fs/Kconfig.binfmt"
+
+endmenu
+
+source "net/Kconfig"
+
+source "drivers/Kconfig"
+
+source "fs/Kconfig"
+
+source "arch/h8300/Kconfig.debug"
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff --git a/arch/h8300/Kconfig.cpu b/arch/h8300/Kconfig.cpu
new file mode 100644
index 0000000..2eaa797
--- /dev/null
+++ b/arch/h8300/Kconfig.cpu
@@ -0,0 +1,136 @@
+menu "Processor type and features"
+
+choice
+	prompt "H8/300 platform"
+
+config H8300_AE3068
+	bool "AE-3068/69"
+	select H83069
+	select RAMKERNEL
+	help
+	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Support
+	  More Information. (Japanese Only)
+	  <http://akizukidenshi.com/catalog/default.aspx>
+	  AE-3068/69 Evaluation Board Support
+	  More Information.
+	  <http://www.microtronique.com/ae3069lan.htm>
+
+config H8300_H8MAX
+	bool "H8MAX"
+	select H83069
+	select RAMKERNEL
+	help
+	  H8MAX Evaluation Board Support
+	  More Information. (Japanese Only)
+	  <http://strawberry-linux.com/h8/index.html>
+
+config H8300_KANEBEBE
+	bool "KaneBebe"
+	select H83069
+	select RAMKERNEL
+	help
+	  KaneBebe Evalition Board Support
+
+config H8300H_SIM
+	bool "H8/300H GDB Simulator"
+	select H83069
+	select ROMKERNEL
+	help
+	  GDB Simulator Support
+	  More Information.
+	  <http://sourceware.org/sid/>
+
+config H8S_EDOSK2674
+	bool "EDOSK-2674"
+	select H8S2678
+	select RAMKERNEL
+	help
+	  Renesas EDOSK-2674 Evaluation Board Support
+	  More Information.
+	  <http://www.azpower.com/H8-uClinux/index.html>
+ 	  <http://www.renesas.eu/products/tools/introductory_evaluation_tools/evaluation_development_os_kits/edosk2674r/edosk2674r_software_tools_root.jsp>
+
+config H8S_SIM
+	bool "H8S GDB Simulator"
+	select H8S2678
+	select ROMKERNEL
+	help
+	  GDB Simulator Support
+	  More Information.
+	  <http://sourceware.org/sid/>
+
+endchoice
+
+choice
+	prompt "CPU Selection"
+
+config H83069
+	bool "H8/3065,3066,3067,3068,3069"
+	select CPU_H8300H
+	select H8300_TMR8
+	select H8300_TMR16
+
+config H8S2678
+	bool "H8S/2670,2673,2674R,2675,2676"
+	select CPU_H8S
+	select H8300_TMR8
+	select H8300_TPU
+
+endchoice
+
+config CPU_CLOCK
+	int "CPU Clock Frequency"
+	depends on ROMKERNEL
+	default "200000000" if H8300H_AKI3068NET || H8300H_SIM
+	default "250000000" if H8300H_H8MAX || H8300H_KANEBEBE
+	default "333333333" if H8S_EDOSK2674 || H8S_SIM
+	help
+	  CPU Clock Frequency
+
+choice
+	prompt "Kernel executes from"
+	---help---
+	  Choose the memory type that the kernel will be running in.
+
+config RAMKERNEL
+	bool "RAM"
+	help
+	  The kernel will be resident in RAM when running.
+
+config ROMKERNEL
+	bool "ROM"
+	help
+	  The kernel will be resident in FLASH/ROM when running.
+endchoice
+
+config CPU_H8300H
+	bool
+	depends on H83069
+	default y
+
+config CPU_H8S
+	bool
+	depends on H8S2678
+	default y
+
+config ROMSIZE
+	hex "ROM size"
+	depends on ROMKERNEL
+	default 0x200000
+
+config RAMBASE
+	hex "RAM base address"
+	default 0x400000
+
+config RAMSIZE
+	hex "RAM size"
+	depends on ROMKERNEL
+	default 0x200000 if H8300_AE3068 || H8300_H8MAX || H8300H_SIM
+	default 0x400000 if H8300_KANEBEBE
+	default 0x800000 if H8S_EDOSK2674 || H8S_SIM
+
+config OFFSET
+        hex "Load offset"
+	default 0
+
+endmenu
diff --git a/arch/h8300/Kconfig.debug b/arch/h8300/Kconfig.debug
new file mode 100644
index 0000000..eb72b01
--- /dev/null
+++ b/arch/h8300/Kconfig.debug
@@ -0,0 +1,23 @@
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
+
+config FULLDEBUG
+	bool "Full Symbolic/Source Debugging support"
+	help
+	  Enable debugging symbols on kernel build.
+
+config HIGHPROFILE
+	bool "Use fast second timer for profiling"
+	help
+	  Use a fast secondary clock to produce profiling information.
+
+config NO_KERNEL_MSG
+	bool "Suppress Kernel BUG Messages"
+	help
+	  Do not output any debug BUG messages within the kernel.
+
+config SH_STANDARD_BIOS
+       def_bool n
+
+endmenu
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
new file mode 100644
index 0000000..44e915c
--- /dev/null
+++ b/arch/h8300/Makefile
@@ -0,0 +1,45 @@
+#
+# arch/h8300/Makefile
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# (C) Copyright 2002-2015 Yoshinori Sato <ysato@users.sourceforge.jp>
+#
+
+cflags-$(CONFIG_CPU_H8300H)	:= -mh
+aflags-$(CONFIG_CPU_H8300H)	:= -mh -Wa,--mach=h8300h
+ldflags-$(CONFIG_CPU_H8300H)	:= -mh8300helf_linux
+cflags-$(CONFIG_CPU_H8S)	:= -ms
+aflags-$(CONFIG_CPU_H8S)	:= -ms -Wa,--mach=h8300s
+ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self_linux
+
+KBUILD_CFLAGS += $(cflags-y)
+KBUILD_CFLAGS += -mint32 -fno-builtin
+KBUILD_CFLAGS += -D__linux__
+KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinux\"
+KBUILD_AFLAGS += $(aflags-y)
+LDFLAGS += $(ldflags-y)
+
+CROSS_COMPILE := h8300-unknown-linux-
+
+core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
+
+libs-y	+= arch/$(ARCH)/lib/
+
+boot := arch/h8300/boot
+
+archmrproper:
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+vmlinux.srec vmlinux.bin zImage uImage.bin: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+define archhelp
+  @echo  'vmlinux.bin  - Create raw binary'
+  @echo  'vmlinux.srec - Create srec binary'
+  @echo  'zImage       - Compressed kernel image'
+endef
diff --git a/arch/h8300/kernel/Makefile b/arch/h8300/kernel/Makefile
new file mode 100644
index 0000000..0b5fe00
--- /dev/null
+++ b/arch/h8300/kernel/Makefile
@@ -0,0 +1,16 @@
+#
+# Makefile for the linux kernel.
+#
+
+extra-y := vmlinux.lds
+
+obj-y := process.o traps.o ptrace.o \
+	 signal.o setup.o syscalls.o \
+	 irq.o entry.o dma.o cpu/
+
+obj-$(CONFIG_ROMKERNEL) += head_rom.o
+obj-$(CONFIG_RAMKERNEL) += head_ram.o
+
+obj-$(CONFIG_MODULES) += module.o h8300_ksyms.o
+obj-$(CONFIG_H8300H_SIM) += sim-console.o
+obj-$(CONFIG_H8S_SIM) += sim-console.o
diff --git a/arch/h8300/kernel/vmlinux.lds.S b/arch/h8300/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..e1b49aa
--- /dev/null
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -0,0 +1,85 @@
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
+
+#define ROMTOP 0x000000
+#define RAMTOP CONFIG_RAMBASE
+
+jiffies = jiffies_64 + 4;
+
+ENTRY(_start)
+
+SECTIONS
+{
+#if defined(CONFIG_ROMKERNEL)
+	. = ROMTOP;
+	.vectors :
+	{
+	_vector = . ;
+		*(.vector*)
+	}
+#else
+	. = RAMTOP;
+	_ramstart = .;
+	. = . + CONFIG_OFFSET;
+#endif
+	_text = .;
+	HEAD_TEXT_SECTION
+	.text : {
+	_stext = . ;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+#if defined(CONFIG_ROMKERNEL)
+		*(.int_redirect)
+#endif
+	_etext = . ;
+	}
+	EXCEPTION_TABLE(16)
+	NOTES
+	RO_DATA(4)
+#if defined(CONFIG_ROMKERNEL)
+	.init.text : {
+		_sinittext = .;
+		INIT_TEXT
+		_einittext = .;
+	}
+	SECURITY_INIT
+#endif
+	ROMEND = .;
+#if defined(CONFIG_ROMKERNEL)
+	. = RAMTOP;
+	_ramstart = .;
+	.data :	AT(ROMEND)
+#else
+	.data :
+#endif
+	{
+	_sdata = . ;
+	__data_start = . ;
+		INIT_TASK_DATA(0x2000)
+		NOSAVE_DATA
+		PAGE_ALIGNED_DATA(0x1000)
+		CACHELINE_ALIGNED_DATA(0x0002)
+		READ_MOSTLY_DATA(0x0002)
+		DATA_DATA
+		CONSTRUCTORS
+	}
+	. = ALIGN(0x4) ;
+	__init_begin = .;
+#if defined(CONFIG_RAMKERNEL)
+	INIT_TEXT_SECTION(4)
+#endif
+	INIT_DATA_SECTION(4)
+#if defined(CONFIG_RAMKERNEL)
+	SECURITY_INIT
+#endif
+	__init_end = .;
+	_edata = . ;
+	_begin_data = LOADADDR(.data);
+	_sbss =.;
+	BSS_SECTION(4,4,4)
+	_ebss =.;
+	_ramend = .;
+	_end = .;
+	DISCARDS
+}
-- 
2.1.4

