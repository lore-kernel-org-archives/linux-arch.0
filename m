From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v10 15/19] h8300: Build scripts
Date: Mon,  4 May 2015 19:41:58 +0900
Message-ID: <1430736122-20929-17-git-send-email-ysato@users.sourceforge.jp>
References: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.asahi-net.or.jp ([202.224.39.197]:59225 "EHLO
	mail1.asahi-net.or.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbbEDKnJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 06:43:09 -0400
In-Reply-To: <1430736122-20929-2-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

h8300's Makefile, Kconfig and memory layout.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/h8300/Kconfig              | 75 +++++++++++++++++++++++++++++++
 arch/h8300/Kconfig.cpu          | 97 +++++++++++++++++++++++++++++++++++++++++
 arch/h8300/Makefile             | 55 +++++++++++++++++++++++
 arch/h8300/kernel/Makefile      | 16 +++++++
 arch/h8300/kernel/vmlinux.lds.S | 67 ++++++++++++++++++++++++++++
 5 files changed, 310 insertions(+)
 create mode 100644 arch/h8300/Kconfig
 create mode 100644 arch/h8300/Kconfig.cpu
 create mode 100644 arch/h8300/Makefile
 create mode 100644 arch/h8300/kernel/Makefile
 create mode 100644 arch/h8300/kernel/vmlinux.lds.S

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
new file mode 100644
index 0000000..f2ea4e1
--- /dev/null
+++ b/arch/h8300/Kconfig
@@ -0,0 +1,75 @@
+config H8300
+        def_bool y
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
+	select OF
+	select OF_EARLY_FLATTREE
+	select HAVE_MEMBLOCK
+	select IRQ_DOMAIN
+	select HANDLE_DOMAIN_IRQ
+	select HAVE_DMA_ATTRS
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config GENERIC_HWEIGHT
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
index 0000000..5f25d6d
--- /dev/null
+++ b/arch/h8300/Kconfig.cpu
@@ -0,0 +1,97 @@
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
+config H8300_BUILTIN_DTB
+        string "Builtin DTB"
+	default ""
+
+config OFFSET
+        hex "Load offset"
+	default 0
+
+endmenu
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
new file mode 100644
index 0000000..c2b24c9
--- /dev/null
+++ b/arch/h8300/Makefile
@@ -0,0 +1,55 @@
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
+core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/ arch/h8300/boot/dts/
+ifneq '$(CONFIG_H8300_BUILTIN_DTB)' '""'
+core-y += arch/h8300/boot/dtb/
+endif
+
+libs-y	+= arch/$(ARCH)/lib/
+
+boot := arch/h8300/boot
+
+%.dtb %.dtb.S %.dtb.o: | scripts
+	$(Q)$(MAKE) $(build)=arch/h8300/boot/dts arch/h8300/boot/dts/$@
+
+PHONY += dtbs
+dtbs: scripts
+	$(Q)$(MAKE) $(build)=arch/h8300/boot/dts
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
index 0000000..7c302dc
--- /dev/null
+++ b/arch/h8300/kernel/vmlinux.lds.S
@@ -0,0 +1,67 @@
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
+
+#define ROMTOP 0x000000
+#define RAMTOP 0x400000
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
