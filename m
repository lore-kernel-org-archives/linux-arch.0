Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:37306 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbBVGZ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 22 Feb 2015 01:25:28 -0500
From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v5 10/15] h8300: Build scripts
Date: Sun, 22 Feb 2015 15:25:15 +0900
Message-ID: <1424586320-3144-11-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1424586320-3144-1-git-send-email-ysato@users.sourceforge.jp>
References: <1424586320-3144-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150222062515._tolA3mFqbLvP6zHmPr_K5-WdjmfSdsCqivmJk1ux88@z>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/Kconfig              |  73 ++++++++++++++++++++++++++
 arch/h8300/Kconfig.cpu          | 111 ++++++++++++++++++++++++++++++++++++++++
 arch/h8300/Makefile             |  45 ++++++++++++++++
 arch/h8300/kernel/Makefile      |  16 ++++++
 arch/h8300/kernel/vmlinux.lds.S |  67 ++++++++++++++++++++++++
 5 files changed, 312 insertions(+)
 create mode 100644 arch/h8300/Kconfig
 create mode 100644 arch/h8300/Kconfig.cpu
 create mode 100644 arch/h8300/Makefile
 create mode 100644 arch/h8300/kernel/Makefile
 create mode 100644 arch/h8300/kernel/vmlinux.lds.S

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
new file mode 100644
index 0000000..9e352e6
--- /dev/null
+++ b/arch/h8300/Kconfig
@@ -0,0 +1,73 @@
+config H8300
+	bool
+	default y
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
+	select ARCH_WANT_FRAME_POINTERS
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config NO_IOPORT_MAP
+	def_bool y
+
+config HZ
+	int
+	default 100
+
+config NR_CPUS
+	int
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
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
+
+endmenu
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff --git a/arch/h8300/Kconfig.cpu b/arch/h8300/Kconfig.cpu
new file mode 100644
index 0000000..fdacf92
--- /dev/null
+++ b/arch/h8300/Kconfig.cpu
@@ -0,0 +1,111 @@
+config CPU_H8300H
+	bool
+
+config CPU_H8S
+	bool
+
+config H83069
+	bool
+	select CPU_H8300H
+	select H8300_TMR16
+
+config H8S2678
+	bool
+	select CPU_H8S
+	select H8300_TPU
+
+config RAMKERNEL
+	bool
+
+config ROMKERNEL
+	bool
+
+menu "Processor type and features"
+
+choice
+prompt "H8/300 platform"
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
+	select HAVE_IDE
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
+	  More Information. (Japanese Only)
+	  <http://www.nissin-tech.com/2009/10/uclinuxkane-bebe-h83069f.html>
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
+	  <http://www.renesas.eu/products/tools/introductory_evaluation_tools/evaluation_development_os_kits/edosk2674r/edosk2674r_software_tools_root.jsp>
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
+if ROMKERNEL
+config CPU_CLOCK
+	int "CPU Clock Frequency"
+	help
+	  CPU Clock Frequency
+
+config ROMSIZE
+	hex "ROM size"
+	default 0x200000
+
+config RAMSIZE
+	hex "RAM size"
+endif
+
+config RAMBASE
+	hex "RAM base address"
+	default 0x400000
+
+config OFFSET
+        hex "Load offset"
+	default 0
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
index 0000000..c92c096
--- /dev/null
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -0,0 +1,67 @@
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
+	RO_DATA_SECTION(4)
+	ROMEND = .;
+#if defined(CONFIG_ROMKERNEL)
+	. = RAMTOP;
+	_ramstart = .;
+#define ADDR(x) ROMEND
+#else
+#endif
+	_sdata = . ;
+	__data_start = . ;
+	RW_DATA_SECTION(0,0,0)
+#if defined(CONFIG_ROMKERNEL)
+#undef ADDR
+#endif	
+	. = ALIGN(0x4) ;
+	__init_begin = .;
+	INIT_TEXT_SECTION(4)
+	INIT_DATA_SECTION(4)
+	SECURITY_INIT
+	__init_end = .;
+	_edata = . ;
+	_begin_data = LOADADDR(.data);
+	_sbss =.;
+	BSS_SECTION(0, 0 ,0)
+	_ebss =.;
+	_ramend = .;
+	_end = .;
+	DISCARDS
+}
-- 
2.1.4

