From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v4 27/36] nds32: Build infrastructure
Date: Mon, 18 Dec 2017 14:46:39 +0800
Message-ID: <9e46d1370f0fcf8147de2a9362844a315fe6e0df.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45441 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbdLRHNx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Dec 2017 02:13:53 -0500
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
In-Reply-To: <cover.1513577007.git.green.hu@gmail.com>
References: <cover.1513577007.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, pombredanne@nexb.com
Cc: green.hu@gmail.com, Vincent Chen <vincentc@andestech.com>

From: Greentime Hu <greentime@andestech.com>

This patch adds Makefile, Kconfig and vmlinux.lds.S files required for building
an nds32 kernel.

Signed-off-by: Vincent Chen <vincentc@andestech.com>
Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/Kconfig                 |  108 ++++++++++++++++++++++++
 arch/nds32/Kconfig.cpu             |  161 ++++++++++++++++++++++++++++++++++++
 arch/nds32/Makefile                |   66 +++++++++++++++
 arch/nds32/boot/Makefile           |   15 ++++
 arch/nds32/include/asm/Kbuild      |   53 ++++++++++++
 arch/nds32/include/uapi/asm/Kbuild |   28 +++++++
 arch/nds32/kernel/Makefile         |   23 ++++++
 arch/nds32/kernel/vmlinux.lds.S    |   57 +++++++++++++
 arch/nds32/mm/Makefile             |    7 ++
 9 files changed, 518 insertions(+)
 create mode 100644 arch/nds32/Kconfig
 create mode 100644 arch/nds32/Kconfig.cpu
 create mode 100644 arch/nds32/Makefile
 create mode 100644 arch/nds32/boot/Makefile
 create mode 100644 arch/nds32/include/asm/Kbuild
 create mode 100644 arch/nds32/include/uapi/asm/Kbuild
 create mode 100644 arch/nds32/kernel/Makefile
 create mode 100644 arch/nds32/kernel/vmlinux.lds.S
 create mode 100644 arch/nds32/mm/Makefile

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
new file mode 100644
index 0000000..c83506e
--- /dev/null
+++ b/arch/nds32/Kconfig
@@ -0,0 +1,108 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+config NDS32
+        def_bool y
+	select ARCH_HAS_RAW_COPY_USER
+	select ARCH_WANT_FRAME_POINTERS if FTRACE
+	select ARCH_WANT_IPC_PARSE_VERSION
+	select CLKSRC_MMIO
+	select CLONE_BACKWARDS
+	select COMMON_CLK
+	select TIMER_OF
+	select FRAME_POINTER
+	select GENERIC_ATOMIC64
+	select GENERIC_CPU_DEVICES
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_SHOW
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select GENERIC_TIME_VSYSCALL
+	select HANDLE_DOMAIN_IRQ
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_DEBUG_KMEMLEAK
+	select HAVE_MEMBLOCK
+	select HAVE_REGS_AND_STACK_ACCESS_API
+	select IRQ_DOMAIN
+	select LOCKDEP_SUPPORT
+	select MODULES_USE_ELF_RELA
+	select OF
+	select OF_EARLY_FLATTREE
+	select NO_BOOTMEM
+	select NO_IOPORT_MAP
+	select RTC_LIB
+	select THREAD_INFO_IN_TASK
+	help
+	  Andes(nds32) Linux support.
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool n
+
+config GENERIC_CSUM
+        def_bool y
+
+config GENERIC_HWEIGHT
+        def_bool y
+
+config GENERIC_LOCKBREAK
+        def_bool y
+	depends on PREEMPT
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config TRACE_IRQFLAGS_SUPPORT
+	def_bool y
+
+config STACKTRACE_SUPPORT
+        def_bool y
+
+config FIX_EARLYCON_MEM
+	def_bool y
+
+config PGTABLE_LEVELS
+	default 2
+
+source "init/Kconfig"
+
+menu "System Type"
+source "arch/nds32/Kconfig.cpu"
+config NR_CPUS
+	int
+	default 1
+
+config MMU
+        def_bool y
+
+config NDS32_BUILTIN_DTB
+        string "Builtin DTB"
+        default ""
+	help
+	  User can use it to specify the dts of the SoC
+endmenu
+
+menu "Kernel Features"
+source "kernel/Kconfig.preempt"
+source "mm/Kconfig"
+source "kernel/Kconfig.hz"
+endmenu
+
+menu "Executable file formats"
+source "fs/Kconfig.binfmt"
+endmenu
+
+source "net/Kconfig"
+source "drivers/Kconfig"
+source "fs/Kconfig"
+
+menu "Kernel hacking"
+source "lib/Kconfig.debug"
+endmenu
+
+source "security/Kconfig"
+source "crypto/Kconfig"
+source "lib/Kconfig"
diff --git a/arch/nds32/Kconfig.cpu b/arch/nds32/Kconfig.cpu
new file mode 100644
index 0000000..6c9fbdc
--- /dev/null
+++ b/arch/nds32/Kconfig.cpu
@@ -0,0 +1,161 @@
+comment "Processor Features"
+
+config CPU_BIG_ENDIAN
+	bool "Big endian"
+
+config CPU_LITTLE_ENDIAN
+        def_bool !CPU_BIG_ENDIAN
+
+config HWZOL
+	bool "hardware zero overhead loop support"
+	depends on CPU_D10 || CPU_D15
+	default n
+	help
+	  A set of Zero-Overhead Loop mechanism is provided to reduce the
+	  instruction fetch and execution overhead of loop-control instructions.
+	  It will save 3 registers($LB, $LC, $LE) for context saving if say Y.
+	  You don't need to save these registers if you can make sure your user
+	  program doesn't use these registers.
+
+	  If unsure, say N.
+
+config CPU_CACHE_ALIASING
+	bool "Aliasing cache"
+	depends on CPU_N10 || CPU_D10 || CPU_N13 || CPU_V3
+	default y
+	help
+	  If this CPU is using VIPT data cache and its cache way size is larger
+	  than page size, say Y. If it is using PIPT data cache, say N.
+
+	  If unsure, say Y.
+
+choice
+	prompt "CPU type"
+	default CPU_V3
+config CPU_N15
+	bool "AndesCore N15"
+config CPU_N13
+	bool "AndesCore N13"
+	select CPU_CACHE_ALIASING if ANDES_PAGE_SIZE_4KB
+config CPU_N10
+	bool "AndesCore N10"
+	select CPU_CACHE_ALIASING
+config CPU_D15
+	bool "AndesCore D15"
+config CPU_D10
+	bool "AndesCore D10"
+	select CPU_CACHE_ALIASING
+config CPU_V3
+	bool "AndesCore v3 compatible"
+	select ANDES_PAGE_SIZE_8KB
+endchoice
+choice
+	prompt "Paging -- page size "
+	default ANDES_PAGE_SIZE_4KB
+config  ANDES_PAGE_SIZE_4KB
+	bool "use 4KB page size"
+config  ANDES_PAGE_SIZE_8KB
+	bool "use 8KB page size"
+endchoice
+
+config CPU_ICACHE_DISABLE
+	bool "Disable I-Cache"
+	help
+	  Say Y here to disable the processor instruction cache. Unless
+	  you have a reason not to or are unsure, say N.
+
+config CPU_DCACHE_DISABLE
+	bool "Disable D-Cache"
+	help
+	  Say Y here to disable the processor data cache. Unless
+	  you have a reason not to or are unsure, say N.
+
+config CPU_DCACHE_WRITETHROUGH
+	bool "Force write through D-cache"
+	depends on !CPU_DCACHE_DISABLE
+	help
+	  Say Y here to use the data cache in writethrough mode. Unless you
+	  specifically require this or are unsure, say N.
+
+config WBNA
+	bool "WBNA"
+	default n
+	help
+	  Say Y here to enable write-back memory with no-write-allocation policy.
+
+config ALIGNMENT_TRAP
+	bool "Kernel support unaligned access handling by sw"
+	depends on PROC_FS
+	default n
+	help
+	  Andes processors cannot fetch/store information which is not
+	  naturally aligned on the bus, i.e., a 4 byte fetch must start at an
+	  address divisible by 4. On 32-bit Andes processors, these non-aligned
+	  fetch/store instructions will be emulated in software if you say
+	  here, which has a severe performance impact. With an IP-only
+	  configuration it is safe to say N, otherwise say Y.
+
+config HW_SUPPORT_UNALIGNMENT_ACCESS
+	bool "Kernel support unaligned access handling by hw"
+	depends on !ALIGNMENT_TRAP
+	default n
+	help
+	  Andes processors load/store world/half-word instructions can access
+	  unaligned memory locations without generating the Data Alignment
+	  Check exceptions. With an IP-only configuration it is safe to say N,
+	  otherwise say Y.
+
+config HIGHMEM
+	bool "High Memory Support"
+	depends on MMU && CPU_CACHE_NONALIASING
+	help
+	  The address space of Andes processors is only 4 Gigabytes large
+	  and it has to accommodate user address space, kernel address
+	  space as well as some memory mapped IO. That means that, if you
+	  have a large amount of physical memory and/or IO, not all of the
+	  memory can be "permanently mapped" by the kernel. The physical
+	  memory that is not permanently mapped is called "high memory".
+
+	  Depending on the selected kernel/user memory split, minimum
+	  vmalloc space and actual amount of RAM, you may not need this
+	  option which should result in a slightly faster kernel.
+
+	  If unsure, say N.
+
+config CACHE_L2
+	bool "Support L2 cache"
+        default y
+	help
+	  Say Y here to enable L2 cache if your SoC are integrated with L2CC.
+	  If unsure, say N.
+
+menu "Memory configuration"
+
+choice
+	prompt "Memory split"
+	depends on MMU
+	default VMSPLIT_3G
+	help
+	  Select the desired split between kernel and user memory.
+
+	  If you are not absolutely sure what you are doing, leave this
+	  option alone!
+
+	config VMSPLIT_3G
+		bool "3G/1G user/kernel split"
+	config VMSPLIT_3G_OPT
+		bool "3G/1G user/kernel split (for full 1G low memory)"
+	config VMSPLIT_2G
+		bool "2G/2G user/kernel split"
+	config VMSPLIT_1G
+		bool "1G/3G user/kernel split"
+endchoice
+
+config PAGE_OFFSET
+	hex
+	default 0x40000000 if VMSPLIT_1G
+	default 0x80000000 if VMSPLIT_2G
+	default 0xB0000000 if VMSPLIT_3G_OPT
+	default 0xC0000000
+
+endmenu
diff --git a/arch/nds32/Makefile b/arch/nds32/Makefile
new file mode 100644
index 0000000..54b4de9
--- /dev/null
+++ b/arch/nds32/Makefile
@@ -0,0 +1,66 @@
+LDFLAGS_vmlinux	:= --no-undefined -X
+OBJCOPYFLAGS	:= -O binary -R .note -R .note.gnu.build-id -R .comment -S
+
+KBUILD_DEFCONFIG := defconfig
+
+comma = ,
+
+KBUILD_CFLAGS	+=-mno-sched-prolog-epilog -mcmodel=large
+
+KBUILD_CFLAGS	+=$(arch-y) $(tune-y)
+KBUILD_AFLAGS	+=$(arch-y) $(tune-y)
+
+#Default value
+head-y		 := arch/nds32/kernel/head.o
+textaddr-y	 := $(CONFIG_PAGE_OFFSET)+0xc000
+
+TEXTADDR := $(textaddr-y)
+
+export	TEXTADDR
+
+
+# If we have a machine-specific directory, then include it in the build.
+core-y				+= arch/nds32/kernel/ arch/nds32/mm/
+libs-y				+= arch/nds32/lib/
+LIBGCC_PATH     		:= \
+  $(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
+libs-y				+= $(LIBGCC_PATH)
+
+ifneq '$(CONFIG_NDS32_BUILTIN_DTB)' '""'
+BUILTIN_DTB := y
+else
+BUILTIN_DTB := n
+endif
+
+ifdef CONFIG_CPU_LITTLE_ENDIAN
+KBUILD_CFLAGS   += -EL
+else
+KBUILD_CFLAGS   += -EB
+endif
+
+boot := arch/nds32/boot
+core-$(BUILTIN_DTB) += $(boot)/dts/
+
+.PHONY: FORCE
+
+Image: vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+
+PHONY += vdso_install
+vdso_install:
+	$(Q)$(MAKE) $(build)=arch/nds32/kernel/vdso $@
+
+prepare: vdso_prepare
+vdso_prepare: prepare0
+	$(Q)$(MAKE) $(build)=arch/nds32/kernel/vdso include/generated/vdso-offsets.h
+
+CLEAN_FILES += include/asm-nds32/constants.h*
+
+# We use MRPROPER_FILES and CLEAN_FILES now
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+define archhelp
+  echo  '  Image         - kernel image (arch/$(ARCH)/boot/Image)'
+endef
diff --git a/arch/nds32/boot/Makefile b/arch/nds32/boot/Makefile
new file mode 100644
index 0000000..3f9b86f
--- /dev/null
+++ b/arch/nds32/boot/Makefile
@@ -0,0 +1,15 @@
+targets := Image Image.gz
+
+$(obj)/Image: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/Image.gz: $(obj)/Image FORCE
+	$(call if_changed,gzip)
+
+install: $(obj)/Image
+	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(obj)/Image System.map "$(INSTALL_PATH)"
+
+zinstall: $(obj)/Image.gz
+	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+	$(obj)/Image.gz System.map "$(INSTALL_PATH)"
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
new file mode 100644
index 0000000..8046ca5
--- /dev/null
+++ b/arch/nds32/include/asm/Kbuild
@@ -0,0 +1,53 @@
+generic-y += asm-offsets.h
+generic-y += atomic.h
+generic-y += bitops.h
+generic-y += bitsperlong.h
+generic-y += bug.h
+generic-y += bugs.h
+generic-y += checksum.h
+generic-y += clkdev.h
+generic-y += cmpxchg.h
+generic-y += cmpxchg-local.h
+generic-y += cputime.h
+generic-y += device.h
+generic-y += div64.h
+generic-y += dma.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += exec.h
+generic-y += fb.h
+generic-y += fcntl.h
+generic-y += ftrace.h
+generic-y += gpio.h
+generic-y += hardirq.h
+generic-y += hw_irq.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += irq.h
+generic-y += irq_regs.h
+generic-y += irq_work.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += kprobes.h
+generic-y += kvm_para.h
+generic-y += limits.h
+generic-y += local.h
+generic-y += mm-arch-hooks.h
+generic-y += mman.h
+generic-y += parport.h
+generic-y += pci.h
+generic-y += percpu.h
+generic-y += preempt.h
+generic-y += sections.h
+generic-y += segment.h
+generic-y += serial.h
+generic-y += shmbuf.h
+generic-y += sizes.h
+generic-y += stat.h
+generic-y += switch_to.h
+generic-y += timex.h
+generic-y += topology.h
+generic-y += trace_clock.h
+generic-y += unaligned.h
+generic-y += user.h
+generic-y += word-at-a-time.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
new file mode 100644
index 0000000..c4dc909
--- /dev/null
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -0,0 +1,28 @@
+# UAPI Header export list
+include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += errno.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += shmbuf.h
+generic-y += bitsperlong.h
+generic-y += fcntl.h
+generic-y += stat.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += setup.h
+generic-y += siginfo.h
+generic-y += signal.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += swab.h
+generic-y += statfs.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += types.h
+generic-y += ucontext.h
diff --git a/arch/nds32/kernel/Makefile b/arch/nds32/kernel/Makefile
new file mode 100644
index 0000000..4279274
--- /dev/null
+++ b/arch/nds32/kernel/Makefile
@@ -0,0 +1,23 @@
+#
+# Makefile for the linux kernel.
+#
+
+CPPFLAGS_vmlinux.lds	:= -DTEXTADDR=$(TEXTADDR)
+AFLAGS_head.o		:= -DTEXTADDR=$(TEXTADDR)
+
+# Object file lists.
+
+obj-y			:= ex-entry.o ex-exit.o ex-scall.o irq.o \
+			process.o ptrace.o setup.o signal.o \
+			sys_nds32.o time.o traps.o cacheinfo.o \
+			dma.o syscall_table.o vdso.o
+
+obj-$(CONFIG_MODULES)		+= nds32_ksyms.o module.o
+obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
+obj-$(CONFIG_OF)		+= devtree.o
+obj-$(CONFIG_CACHE_L2)		+= atl2c.o
+
+extra-y := head.o vmlinux.lds
+
+
+obj-y				+= vdso/
diff --git a/arch/nds32/kernel/vmlinux.lds.S b/arch/nds32/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..288313b
--- /dev/null
+++ b/arch/nds32/kernel/vmlinux.lds.S
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2005-2017 Andes Technology Corporation
+
+#include <asm/page.h>
+#include <asm/thread_info.h>
+#include <asm/cache.h>
+#include <asm/memory.h>
+
+#define LOAD_OFFSET	(PAGE_OFFSET - PHYS_OFFSET)
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_ARCH(nds32)
+ENTRY(_stext_lma)
+jiffies = jiffies_64;
+
+SECTIONS
+{
+	_stext_lma = TEXTADDR - LOAD_OFFSET;
+	. = TEXTADDR;
+	__init_begin = .;
+	HEAD_TEXT_SECTION
+	INIT_TEXT_SECTION(PAGE_SIZE)
+	INIT_DATA_SECTION(16)
+	PERCPU_SECTION(L1_CACHE_BYTES)
+	__init_end = .;
+
+	. = ALIGN(PAGE_SIZE);
+	_stext = .;
+	/* Real text segment */
+	.text : AT(ADDR(.text) - LOAD_OFFSET) {
+		_text = .;		/* Text and read-only data	*/
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		IRQENTRY_TEXT
+		*(.fixup)
+	}
+
+	_etext = .;			/* End of text and rodata section */
+
+	_sdata = .;
+	RO_DATA_SECTION(PAGE_SIZE)
+	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+	_edata  =  .;
+
+	EXCEPTION_TABLE(16)
+	NOTES
+	BSS_SECTION(4, 4, 4)
+	_end = .;
+
+	STABS_DEBUG
+	DWARF_DEBUG
+
+	DISCARDS
+}
diff --git a/arch/nds32/mm/Makefile b/arch/nds32/mm/Makefile
new file mode 100644
index 0000000..6b68558
--- /dev/null
+++ b/arch/nds32/mm/Makefile
@@ -0,0 +1,7 @@
+obj-y				:= extable.o tlb.o \
+				   fault.o init.o ioremap.o mmap.o \
+                                   mm-nds32.o cacheflush.o proc.o
+
+obj-$(CONFIG_ALIGNMENT_TRAP)	+= alignment.o
+obj-$(CONFIG_HIGHMEM)           += highmem.o
+CFLAGS_proc-n13.o		+= -fomit-frame-pointer
-- 
1.7.9.5
