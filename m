From: James Hogan <james.hogan@imgtec.com>
Subject: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Wed, 31 Oct 2012 16:13:53 +0000
Message-ID: <1351700061-7203-13-git-send-email-james.hogan@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:49628 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423120Ab2JaQOz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 12:14:55 -0400
In-Reply-To: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>

Add metag build infrastructure.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/metag/Kconfig                     |  292 ++++++++++++++++++++++++++++++++
 arch/metag/Kconfig.debug               |   40 +++++
 arch/metag/Kconfig.soc                 |   58 +++++++
 arch/metag/Makefile                    |   90 ++++++++++
 arch/metag/boot/Makefile               |   72 ++++++++
 arch/metag/configs/meta1_defconfig     |   42 +++++
 arch/metag/configs/meta2_defconfig     |   42 +++++
 arch/metag/configs/meta2_smp_defconfig |   43 +++++
 arch/metag/include/asm/Kbuild          |   59 +++++++
 arch/metag/include/asm/tbx/Kbuild      |    8 +
 arch/metag/kernel/.gitignore           |    1 +
 arch/metag/kernel/Makefile             |   37 ++++
 arch/metag/kernel/asm-offsets.c        |   14 ++
 arch/metag/kernel/metag_ksyms.c        |   77 +++++++++
 arch/metag/kernel/vmlinux.lds.S        |   71 ++++++++
 arch/metag/lib/Makefile                |    7 +
 arch/metag/mm/Kconfig                  |  153 +++++++++++++++++
 arch/metag/mm/Makefile                 |   17 ++
 arch/metag/tbx/Makefile                |   17 ++
 lib/Kconfig.debug                      |    6 +-
 20 files changed, 1143 insertions(+), 3 deletions(-)
 create mode 100644 arch/metag/Kconfig
 create mode 100644 arch/metag/Kconfig.debug
 create mode 100644 arch/metag/Kconfig.soc
 create mode 100644 arch/metag/Makefile
 create mode 100644 arch/metag/boot/Makefile
 create mode 100644 arch/metag/configs/meta1_defconfig
 create mode 100644 arch/metag/configs/meta2_defconfig
 create mode 100644 arch/metag/configs/meta2_smp_defconfig
 create mode 100644 arch/metag/include/asm/Kbuild
 create mode 100644 arch/metag/include/asm/tbx/Kbuild
 create mode 100644 arch/metag/kernel/.gitignore
 create mode 100644 arch/metag/kernel/Makefile
 create mode 100644 arch/metag/kernel/asm-offsets.c
 create mode 100644 arch/metag/kernel/metag_ksyms.c
 create mode 100644 arch/metag/kernel/vmlinux.lds.S
 create mode 100644 arch/metag/lib/Makefile
 create mode 100644 arch/metag/mm/Kconfig
 create mode 100644 arch/metag/mm/Makefile
 create mode 100644 arch/metag/tbx/Makefile

diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
new file mode 100644
index 0000000..3a19cb6
--- /dev/null
+++ b/arch/metag/Kconfig
@@ -0,0 +1,292 @@
+config SYMBOL_PREFIX
+	string
+	default "_"
+
+config METAG
+	def_bool y
+	select EMBEDDED
+	select HAVE_64BIT_ALIGNED_STRUCT
+	select HAVE_MEMBLOCK
+	select HAVE_MEMBLOCK_NODE_MAP
+	select HAVE_ARCH_TRACEHOOK
+	select HAVE_IRQ_WORK
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_LZMA
+	select HAVE_KERNEL_XZ
+	select HAVE_KERNEL_LZO
+	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_ATOMIC64
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_SHOW
+	select GENERIC_SMP_IDLE_THREAD
+	select IRQ_DOMAIN
+	select OF
+	select OF_EARLY_FLATTREE
+	help
+	  Imagination Technologies Meta processors are a family of multi-
+	  threaded DSPs designed for embedded systems.
+
+config STACKTRACE_SUPPORT
+	def_bool y
+
+config LOCKDEP_SUPPORT
+	def_bool y
+
+config HAVE_LATENCYTOP_SUPPORT
+	def_bool y
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config RWSEM_XCHGADD_ALGORITHM
+	bool
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config IRQ_PER_CPU
+	def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config GENERIC_GPIO
+	def_bool n
+
+config NO_IOPORT
+	def_bool y
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+menu "Processor type and features"
+
+config MMU
+	def_bool y
+
+config STACK_GROWSUP
+	def_bool y
+
+config HOTPLUG_CPU
+	bool "Enable CPU hotplug support"
+	depends on SMP && HOTPLUG
+	help
+	  Say Y here to allow turning CPUs off and on. CPUs can be
+	  controlled through /sys/devices/system/cpu.
+
+	  Say N if you want to disable CPU hotplug.
+
+config HIGHMEM
+	bool "High Memory Support"
+	depends on MMU
+	help
+	  The address space of Meta processors is only 4 Gigabytes large
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
+	  If unsure, say n.
+
+source "arch/metag/mm/Kconfig"
+
+source "arch/metag/Kconfig.soc"
+
+config META12
+	bool
+	---help---
+	  Select this from the SoC config symbol to indicate that it contains a
+	  Meta 1.2 core.
+
+config META21
+	bool
+	---help---
+	  Select this from the SoC config symbol to indicate that it contains a
+	  Meta 2.1 core.
+
+config SMP
+	bool "Symmetric multi-processing support"
+	depends on META21
+	select USE_GENERIC_SMP_HELPERS
+	---help---
+	  This enables support for systems with more than one thread running
+	  Linux. If you have a system with only one thread running Linux,
+	  say N. Otherwise, say Y.
+
+config NR_CPUS
+	int "Maximum number of CPUs (2-4)" if SMP
+	range 2 4 if SMP
+	default "1" if !SMP
+	default "4" if SMP
+
+config SMP_WRITE_REORDERING
+	bool
+	---help---
+	  This attempts to prevent cache-memory incoherence due to external
+	  reordering of writes from different hardware threads when SMP is
+	  enabled. It adds fences (system event 0) to smp_mb and smp_rmb in an
+	  attempt to catch some of the cases, and also before writes to shared
+	  memory in LOCK1 protected atomics and spinlocks.
+	  This will not completely prevent cache incoherency on affected cores.
+
+config LNKGET_AROUND_CACHE
+	bool
+	depends on META21
+	---help---
+	  This indicates that the LNKGET/LNKSET instructions go around the
+	  cache, which requires some extra cache flushes when the memory needs
+	  to be accessed by normal GET/SET instructions too.
+
+choice
+	prompt "Atomicity primitive"
+	default ATOMICITY_LNKGET
+	---help---
+	  This option selects the mechanism for performing atomic operations.
+
+config ATOMICITY_IRQSOFF
+	depends on !SMP
+	bool "irqsoff"
+	---help---
+	  This option disables interrupts to achieve atomicity. This mechanism
+	  is not SMP-safe.
+
+config ATOMICITY_LNKGET
+	depends on META21
+	bool "lnkget/lnkset"
+	---help---
+	  This option uses the LNKGET and LNKSET instructions to achieve
+	  atomicity. LNKGET/LNKSET are load-link/store-conditional instructions.
+	  Choose this option if your system requires low latency.
+
+config ATOMICITY_LOCK1
+	depends on SMP
+	bool "lock1"
+	---help---
+	  This option uses the LOCK1 instruction for atomicity. This is mainly
+	  provided as a debugging aid if the lnkget/lnkset atomicity primitive
+	  isn't working properly.
+
+endchoice
+
+config META_FPU
+	bool "FPU Support"
+	depends on META21
+	default y
+	help
+	  This option allows processes to use FPU hardware available with this
+	  CPU. If this option is not enabled FPU registers will not be saved
+	  and restored on context-switch.
+
+	  If you plan on running programs which are compiled to use hard floats
+	  say Y here.
+
+config META_DSP
+	bool "DSP Support"
+	help
+	  This option allows processes to use DSP hardware available
+	  with this CPU. If this option is not enabled DSP registers
+	  will not be saved and restored on context-switch.
+
+	  If you plan on running DSP programs say Y here.
+
+config META_PERFCOUNTER_IRQS
+	bool "PerfCounters interrupt support"
+	depends on META21
+	help
+	  This option enables using interrupts to collect information from
+	  Performance Counters. This option is supported in new META21
+	  (starting from HTP265).
+
+	  When disabled, Performance Counters information will be collected
+	  based on Timer Interrupt.
+
+menu "Boot options"
+
+config METAG_CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	---help---
+	  Allow for specifying boot arguments to the kernel at
+	  build time.  On some systems (e.g. embedded ones), it is
+	  necessary or convenient to provide some or all of the
+	  kernel boot arguments with the kernel itself (that is,
+	  to not rely on the boot loader to provide them.)
+
+	  To compile command line arguments into the kernel,
+	  set this option to 'Y', then fill in the
+	  the boot arguments in CONFIG_METAG_CMDLINE.
+
+	  Systems with fully functional boot loaders (i.e. non-embedded)
+	  should leave this option set to 'N'.
+
+config METAG_CMDLINE
+	string "Built-in kernel command string"
+	depends on METAG_CMDLINE_BOOL
+	default ""
+	---help---
+	  Enter arguments here that should be compiled into the kernel
+	  image and used at boot time.  If the boot loader provides a
+	  command line at boot time, it is appended to this string to
+	  form the full kernel command line, when the system boots.
+
+	  However, you can use the CONFIG_METAG_CMDLINE_OVERRIDE option to
+	  change this behavior.
+
+	  In most cases, the command line (whether built-in or provided
+	  by the boot loader) should specify the device for the root
+	  file system.
+
+config METAG_CMDLINE_OVERRIDE
+	bool "Built-in command line overrides boot loader arguments"
+	depends on METAG_CMDLINE_BOOL
+	---help---
+	  Set this option to 'Y' to have the kernel ignore the boot loader
+	  command line, and use ONLY the built-in command line.
+
+	  This is used to work around broken boot loaders.  This should
+	  be set to 'N' under normal conditions.
+
+endmenu
+
+menu "Board support"
+
+endmenu
+
+source "kernel/Kconfig.preempt"
+
+source kernel/Kconfig.hz
+
+endmenu
+
+menu "Power management options"
+
+source kernel/power/Kconfig
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
+source "arch/metag/Kconfig.debug"
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff --git a/arch/metag/Kconfig.debug b/arch/metag/Kconfig.debug
new file mode 100644
index 0000000..d2f4e18
--- /dev/null
+++ b/arch/metag/Kconfig.debug
@@ -0,0 +1,40 @@
+menu "Kernel hacking"
+
+config TRACE_IRQFLAGS_SUPPORT
+	bool
+	default y
+
+source "lib/Kconfig.debug"
+
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+	help
+	  This option will cause messages to be printed if free stack space
+	  drops below a certain limit.
+
+config 4KSTACKS
+	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	depends on DEBUG_KERNEL
+	help
+	  If you say Y here the kernel will use a 4Kb stacksize for the
+	  kernel stack attached to each process/thread. This facilitates
+	  running more threads on a system and also reduces the pressure
+	  on the VM subsystem for higher order allocations. This option
+	  will also use IRQ stacks to compensate for the reduced stackspace.
+
+config META_FUNCTION_TRACE
+	bool "Output Meta real-time trace data for function entry/exit"
+	help
+	  If you say Y here the kernel will use the Meta hardware trace
+	  unit to output information about function entry and exit that
+	  can be used by a debugger for profiling and call-graphs.
+
+config POISON_CATCH_BUFFERS
+	bool "Poison catch buffer contents on kernel entry"
+	help
+	  If you say Y here the kernel will write poison data to the
+	  catch buffer registers on kernel entry. This will make any
+	  problem with catch buffer handling much more apparent.
+
+endmenu
diff --git a/arch/metag/Kconfig.soc b/arch/metag/Kconfig.soc
new file mode 100644
index 0000000..698653e
--- /dev/null
+++ b/arch/metag/Kconfig.soc
@@ -0,0 +1,58 @@
+choice
+	prompt "SoC Type"
+	default META21_FPGA
+
+config META12_FPGA
+	bool "Meta 1.2 FPGA"
+	select META12
+	---help---
+	  This is a Meta 1.2 FPGA bitstream, just a bare CPU.
+
+config META21_FPGA
+	bool "Meta 2.1 FPGA"
+	select META21
+	---help---
+	  This is a Meta 2.1 FPGA bitstream, just a bare CPU.
+
+endchoice
+
+menu "SoC configuration"
+
+if META21
+
+# Meta 2.x specific options
+
+config META21_MMU
+	bool "Meta 2.x MMU mode"
+	depends on META21
+	default y
+	help
+	  Use the Meta 2.x MMU in extended mode.
+
+config META21_UNALIGNED
+	bool "Meta 2.x unaligned access checking"
+	depends on META21
+	default y
+	help
+	  All memory accesses will be checked for alignment and an exception
+	  raised on unaligned accesses. This feature does cost performance
+	  but without it there will be no notification of this type of error.
+
+config META_USER_TCM
+	bool "Meta on-chip memory support for userland"
+	depends on META21
+	select GENERIC_ALLOCATOR
+	default y
+	help
+	  Allow the on-chip memories of Meta SoCs to be used by user
+	  applications.
+
+endif
+
+config META_HALT_ON_PANIC
+	bool "Halt the core on panic"
+	help
+	  Halt the core when a panic occurs. This is useful when running
+	  pre-production silicon or in an FPGA environment.
+
+endmenu
diff --git a/arch/metag/Makefile b/arch/metag/Makefile
new file mode 100644
index 0000000..7fd59be
--- /dev/null
+++ b/arch/metag/Makefile
@@ -0,0 +1,90 @@
+#
+# metag/Makefile
+#
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies. Remember to do have actions
+# for "archclean" cleaning up for this architecture.
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1994 by Linus Torvalds
+#               2007,2008,2012 by Imagination Technologies Ltd.
+#
+
+LDFLAGS		:=
+OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
+
+CHECKFLAGS-$(CONFIG_META12) += -DMETAC_1_2
+CHECKFLAGS-$(CONFIG_META21) += -DMETAC_2_1
+CHECKFLAGS	+= -D__metag__ $(CHECKFLAGS-y)
+
+KBUILD_DEFCONFIG := meta2_defconfig
+
+sflags-$(CONFIG_META12) += -mmetac=1.2
+
+ifeq ($(CONFIG_META12),y)
+# Only use TBI API 1.4 if DSP is enabled for META12 cores
+sflags-$(CONFIG_META_DSP) += -DTBI_1_4
+endif
+
+sflags-$(CONFIG_META21) += -mmetac=2.1 -DTBI_1_4
+
+# Default SoC .c files
+score-y  :=
+
+head-y := arch/metag/kernel/head.o
+
+core-y					+= arch/metag/kernel/ \
+					   arch/metag/mm/
+
+ifneq ($(score-y),)
+core-y                                  += arch/metag/$(score-y)/
+endif
+
+ifneq ($(machdir-y),)
+core-y  += $(addprefix arch/metag/boards/, \
+             $(filter-out ., $(patsubst %,%/,$(machdir-y))))
+endif
+
+libs-y 					+= arch/metag/lib/ \
+					   arch/metag/tbx/
+
+cflags-$(CONFIG_META_FUNCTION_TRACE) +=  -mhwtrace-leaf -mhwtrace-retpc
+
+cflags-$(CONFIG_META21) += -mextensions=bex
+
+KBUILD_CFLAGS += -pipe
+
+KBUILD_CFLAGS += -ffunction-sections
+
+KBUILD_CFLAGS += $(sflags-y) $(cflags-y)
+KBUILD_AFLAGS += $(sflags-y)
+
+LDFLAGS_vmlinux := $(ldflags-y)
+
+boot := arch/metag/boot
+
+BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.xz uImage.lzo \
+	       uImage.bin vmlinux.bin
+PHONY += $(BOOT_TARGETS)
+
+all: vmlinux.bin
+
+$(BOOT_TARGETS): vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+define archhelp
+  echo  '* vmlinux.bin	- Binary kernel image (arch/$(ARCH)/boot/vmlinux.bin)'
+  @echo '  uImage  	- Alias to bootable U-Boot image'
+  @echo '  uImage.bin	- Kernel-only image for U-Boot (bin)'
+  @echo '  uImage.gz	- Kernel-only image for U-Boot (gzip)'
+  @echo '  uImage.bz2	- Kernel-only image for U-Boot (bzip2)'
+  @echo '  uImage.lzma	- Kernel-only image for U-Boot (lzma)'
+  @echo '  uImage.xz	- Kernel-only image for U-Boot (xz)'
+  @echo '  uImage.lzo	- Kernel-only image for U-Boot (lzo)'
+endef
diff --git a/arch/metag/boot/Makefile b/arch/metag/boot/Makefile
new file mode 100644
index 0000000..9f6fb26
--- /dev/null
+++ b/arch/metag/boot/Makefile
@@ -0,0 +1,72 @@
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2007,2012  Imagination Technologies Ltd.
+#
+
+suffix-y := bin
+suffix-$(CONFIG_KERNEL_GZIP)	:= gz
+suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
+suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
+suffix-$(CONFIG_KERNEL_XZ)	:= xz
+suffix-$(CONFIG_KERNEL_LZO)	:= lzo
+
+targets := uImage uImage.gz uImage.bz2 uImage.lzma uImage.xz uImage.lzo \
+	   uImage.bin
+extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
+	   vmlinux.bin.xz vmlinux.bin.lzo
+
+UIMAGE_LOADADDR = $(CONFIG_PAGE_OFFSET)
+
+VMLINUX = vmlinux
+
+ifeq ($(CONFIG_FUNCTION_TRACER),y)
+ORIG_CFLAGS := $(KBUILD_CFLAGS)
+KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
+endif
+
+$(obj)/vmlinux.bin: $(VMLINUX)
+	$(Q)$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
+
+$(obj)/vmlinux.bin.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+$(obj)/vmlinux.bin.bz2: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,bzip2)
+
+$(obj)/vmlinux.bin.lzma: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,lzma)
+
+$(obj)/vmlinux.bin.xz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,xzkern)
+
+$(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,lzo)
+
+$(obj)/uImage.bz2: $(obj)/vmlinux.bin.bz2
+	$(call if_changed,uimage,bzip2)
+
+$(obj)/uImage.gz: $(obj)/vmlinux.bin.gz
+	$(call if_changed,uimage,gzip)
+
+$(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma
+	$(call if_changed,uimage,lzma)
+
+$(obj)/uImage.xz: $(obj)/vmlinux.bin.xz
+	$(call if_changed,uimage,xz)
+
+$(obj)/uImage.lzo: $(obj)/vmlinux.bin.lzo
+	$(call if_changed,uimage,lzo)
+
+$(obj)/uImage.bin: $(obj)/vmlinux.bin
+	$(call if_changed,uimage,none)
+
+$(obj)/uImage: $(obj)/uImage.$(suffix-y)
+	@ln -sf $(notdir $<) $@
+	@echo '  Image $@ is ready'
+
+clean-files += vmlinux.bin
+
+export suffix-y
diff --git a/arch/metag/configs/meta1_defconfig b/arch/metag/configs/meta1_defconfig
new file mode 100644
index 0000000..eb01dde
--- /dev/null
+++ b/arch/metag/configs/meta1_defconfig
@@ -0,0 +1,42 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_LOG_BUF_SHIFT=13
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="arch/metag/boot/ramdisk.cpio"
+CONFIG_INITRAMFS_COMPRESSION_GZIP=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_ELF_CORE is not set
+CONFIG_SLAB=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_META12_FPGA=y
+CONFIG_HZ_100=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=16384
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_CRC32 is not set
diff --git a/arch/metag/configs/meta2_defconfig b/arch/metag/configs/meta2_defconfig
new file mode 100644
index 0000000..1d28258
--- /dev/null
+++ b/arch/metag/configs/meta2_defconfig
@@ -0,0 +1,42 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_LOG_BUF_SHIFT=13
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="arch/metag/boot/ramdisk.cpio"
+CONFIG_INITRAMFS_COMPRESSION_GZIP=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_ELF_CORE is not set
+CONFIG_SLAB=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_META_L2C=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_META_HALT_ON_PANIC=y
+CONFIG_HZ_100=y
+CONFIG_DEVTMPFS=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=16384
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_CRC32 is not set
diff --git a/arch/metag/configs/meta2_smp_defconfig b/arch/metag/configs/meta2_smp_defconfig
new file mode 100644
index 0000000..979107b
--- /dev/null
+++ b/arch/metag/configs/meta2_smp_defconfig
@@ -0,0 +1,43 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_LOG_BUF_SHIFT=13
+CONFIG_SYSFS_DEPRECATED=y
+CONFIG_SYSFS_DEPRECATED_V2=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="arch/metag/boot/ramdisk.cpio"
+CONFIG_INITRAMFS_COMPRESSION_GZIP=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_ELF_CORE is not set
+CONFIG_SLAB=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+CONFIG_META_L2C=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_META_HALT_ON_PANIC=y
+CONFIG_SMP=y
+CONFIG_HZ_100=y
+CONFIG_DEVTMPFS=y
+# CONFIG_STANDALONE is not set
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+# CONFIG_FW_LOADER is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=1
+CONFIG_BLK_DEV_RAM_SIZE=16384
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_DEVKMEM is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_DNOTIFY is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_CRC32 is not set
diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
new file mode 100644
index 0000000..1678d85
--- /dev/null
+++ b/arch/metag/include/asm/Kbuild
@@ -0,0 +1,59 @@
+include include/asm-generic/Kbuild.asm
+
+header-y += tbx/
+
+header-y += hw_breakpoints.h
+
+generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += bugs.h
+generic-y += cputime.h
+generic-y += current.h
+generic-y += device.h
+generic-y += dma.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += exec.h
+generic-y += fb.h
+generic-y += fcntl.h
+generic-y += ftrace.h
+generic-y += futex.h
+generic-y += hardirq.h
+generic-y += hw_irq.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += irq_regs.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += kvm_para.h
+generic-y += local.h
+generic-y += local64.h
+generic-y += msgbuf.h
+generic-y += mutex.h
+generic-y += param.h
+generic-y += pci.h
+generic-y += percpu.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += scatterlist.h
+generic-y += sections.h
+generic-y += sembuf.h
+generic-y += serial.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += signal.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += switch_to.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += timex.h
+generic-y += types.h
+generic-y += ucontext.h
+generic-y += unaligned.h
+generic-y += user.h
+generic-y += vga.h
+generic-y += xor.h
diff --git a/arch/metag/include/asm/tbx/Kbuild b/arch/metag/include/asm/tbx/Kbuild
new file mode 100644
index 0000000..41791e6
--- /dev/null
+++ b/arch/metag/include/asm/tbx/Kbuild
@@ -0,0 +1,8 @@
+header-y += compasm.inc
+header-y += machine.inc
+header-y += metac_1_2.inc
+header-y += metac_2_1.inc
+header-y += metac_all.inc
+header-y += metag.inc
+header-y += metagtbx.h
+
diff --git a/arch/metag/kernel/.gitignore b/arch/metag/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/metag/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
diff --git a/arch/metag/kernel/Makefile b/arch/metag/kernel/Makefile
new file mode 100644
index 0000000..0391546
--- /dev/null
+++ b/arch/metag/kernel/Makefile
@@ -0,0 +1,37 @@
+#
+# Makefile for the Linux/Meta kernel.
+#
+
+extra-y	+= head.o
+extra-y	+= vmlinux.lds
+
+obj-y	+= cachepart.o
+obj-y	+= clock.o
+obj-y	+= core_reg.o
+obj-y	+= dma.o
+obj-y	+= hw_breakpoints.o
+obj-y	+= irq.o
+obj-y	+= irq_external.o
+obj-y	+= kick.o
+obj-y	+= process.o
+obj-y	+= ptrace.o
+obj-y	+= setup.o
+obj-y	+= signal.o
+obj-y	+= stacktrace.o
+obj-y	+= sys_metag.o
+obj-y	+= tbiunexp.o
+obj-y	+= time.o
+obj-y	+= topology.o
+obj-y	+= traps.o
+obj-y	+= user_gateway.o
+
+obj-$(CONFIG_METAG_COREMEM)		+= coremem.o
+obj-$(CONFIG_DYNAMIC_FTRACE)		+= ftrace.o
+obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace_stub.o
+obj-$(CONFIG_META_PERFCOUNTER_IRQS)	+= irq_internal.o
+obj-$(CONFIG_MODULES)			+= metag_ksyms.o
+obj-$(CONFIG_MODULES)			+= module.o
+obj-$(CONFIG_PERF_EVENTS)		+= perf_callchain.o
+obj-$(CONFIG_SMP)			+= smp.o
+obj-$(CONFIG_METAG_SUSPEND_MEM)		+= suspend.o
+obj-$(CONFIG_META_USER_TCM)		+= tcm.o
diff --git a/arch/metag/kernel/asm-offsets.c b/arch/metag/kernel/asm-offsets.c
new file mode 100644
index 0000000..bfc9205
--- /dev/null
+++ b/arch/metag/kernel/asm-offsets.c
@@ -0,0 +1,14 @@
+/*
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ *
+ */
+
+#include <linux/kbuild.h>
+#include <linux/thread_info.h>
+
+int main(void)
+{
+	DEFINE(THREAD_INFO_SIZE, sizeof(struct thread_info));
+	return 0;
+}
diff --git a/arch/metag/kernel/metag_ksyms.c b/arch/metag/kernel/metag_ksyms.c
new file mode 100644
index 0000000..0ea1332
--- /dev/null
+++ b/arch/metag/kernel/metag_ksyms.c
@@ -0,0 +1,77 @@
+#include <linux/export.h>
+#include <linux/linkage.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/user.h>
+#include <linux/interrupt.h>
+#include <linux/hardirq.h>
+
+#include <asm/setup.h>
+#include <asm/checksum.h>
+#include <asm/uaccess.h>
+#include <asm/traps.h>
+#include <asm/ftrace.h>
+
+#define METAG_ALL_VALUES
+#define METAC_ALL_VALUES
+#include <asm/tbx/metagtbx.h>
+
+/* uaccess symbols */
+EXPORT_SYMBOL(__copy_user_zeroing);
+EXPORT_SYMBOL(__copy_user);
+EXPORT_SYMBOL(__get_user_asm_b);
+EXPORT_SYMBOL(__get_user_asm_w);
+EXPORT_SYMBOL(__get_user_asm_d);
+EXPORT_SYMBOL(__put_user_asm_b);
+EXPORT_SYMBOL(__put_user_asm_w);
+EXPORT_SYMBOL(__put_user_asm_d);
+EXPORT_SYMBOL(__put_user_asm_l);
+EXPORT_SYMBOL(__strncpy_from_user);
+EXPORT_SYMBOL(strnlen_user);
+EXPORT_SYMBOL(__do_clear_user);
+
+EXPORT_SYMBOL(pTBI_get);
+EXPORT_SYMBOL(meta_memoffset);
+EXPORT_SYMBOL(kick_register_func);
+EXPORT_SYMBOL(kick_unregister_func);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL(get_trigger_mask);
+#else
+EXPORT_SYMBOL(global_trigger_mask);
+#endif
+
+EXPORT_SYMBOL(empty_zero_page);
+EXPORT_SYMBOL(kernel_thread);
+
+EXPORT_SYMBOL(pfn_base);
+
+/* TBI symbols */
+EXPORT_SYMBOL(__TBI);
+EXPORT_SYMBOL(__TBIFindSeg);
+EXPORT_SYMBOL(__TBIPoll);
+EXPORT_SYMBOL(__TBITimeStamp);
+EXPORT_SYMBOL(__TBITransStr);
+EXPORT_SYMBOL(__TBICodeCacheFlush);
+EXPORT_SYMBOL(__TBIDataCacheFlush);
+
+#define DECLARE_EXPORT(name) extern void name(void); EXPORT_SYMBOL(name)
+
+/* libgcc functions */
+DECLARE_EXPORT(__ashldi3);
+DECLARE_EXPORT(__ashrdi3);
+DECLARE_EXPORT(__lshrdi3);
+DECLARE_EXPORT(__udivsi3);
+DECLARE_EXPORT(__divsi3);
+DECLARE_EXPORT(__umodsi3);
+DECLARE_EXPORT(__modsi3);
+DECLARE_EXPORT(__muldi3);
+
+/* String functions */
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memmove);
+
+#ifdef CONFIG_FUNCTION_TRACER
+EXPORT_SYMBOL(mcount);
+EXPORT_SYMBOL(mcount_wrapper);
+#endif
diff --git a/arch/metag/kernel/vmlinux.lds.S b/arch/metag/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..d1ad7cf
--- /dev/null
+++ b/arch/metag/kernel/vmlinux.lds.S
@@ -0,0 +1,71 @@
+/* ld script to make Meta Linux kernel */
+
+#include <asm/thread_info.h>
+#include <asm/page.h>
+#include <asm/cache.h>
+
+#include <asm-generic/vmlinux.lds.h>
+
+OUTPUT_FORMAT("elf32-metag", "elf32-metag", "elf32-metag")
+OUTPUT_ARCH(metag)
+ENTRY(__start)
+
+_jiffies = _jiffies_64;
+SECTIONS
+{
+  . = CONFIG_PAGE_OFFSET;
+  _text = .;
+  __text = .;
+  __stext = .;
+  HEAD_TEXT_SECTION
+  .text : {
+	TEXT_TEXT
+	SCHED_TEXT
+	LOCK_TEXT
+	KPROBES_TEXT
+	IRQENTRY_TEXT
+	*(.text.*)
+	*(.gnu.warning)
+	}
+
+  __etext = .;			/* End of text section */
+
+  __sdata = .;
+  RO_DATA_SECTION(PAGE_SIZE)
+  RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
+  __edata = .;			/* End of data section */
+
+  EXCEPTION_TABLE(16)
+  NOTES
+
+  . = ALIGN(PAGE_SIZE);		/* Init code and data */
+  ___init_begin = .;
+  INIT_TEXT_SECTION(PAGE_SIZE)
+  INIT_DATA_SECTION(16)
+
+  .init.arch.info : {
+	  ___arch_info_begin = .;
+	  *(.arch.info.init)
+	  ___arch_info_end = .;
+  }
+
+  PERCPU_SECTION(L1_CACHE_BYTES)
+
+  ___init_end = .;
+
+  BSS_SECTION(0, PAGE_SIZE, 0)
+
+  __end = .;
+	
+  . = ALIGN(PAGE_SIZE);
+  __heap_start = .;
+
+  DWARF_DEBUG
+
+  /* When something in the kernel is NOT compiled as a module, the
+   * module cleanup code and data are put into these segments.  Both
+   * can then be thrown away, as cleanup code is never called unless
+   * it's a module.
+   */
+  DISCARDS
+}
diff --git a/arch/metag/lib/Makefile b/arch/metag/lib/Makefile
new file mode 100644
index 0000000..d2f9439
--- /dev/null
+++ b/arch/metag/lib/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for Meta-specific library files.
+#
+
+lib-y = usercopy.o copy_page.o clear_page.o memcpy.o memmove.o \
+	memset.o delay.o div64.o muldi3.o ashrdi3.o ashldi3.o lshrdi3.o \
+	divsi3.o modsi3.o ip_fast_csum.o checksum.o
diff --git a/arch/metag/mm/Kconfig b/arch/metag/mm/Kconfig
new file mode 100644
index 0000000..e5055b8
--- /dev/null
+++ b/arch/metag/mm/Kconfig
@@ -0,0 +1,153 @@
+menu "Memory management options"
+
+config PAGE_OFFSET
+	hex "Kernel page offset address"
+	default "0x40000000"
+	help
+	  This option allows you to set the virtual address at which the
+	  kernel will be mapped to.
+endmenu
+
+config KERNEL_4M_PAGES
+	bool "Map kernel with 4MB pages"
+	depends on META21_MMU
+	default y
+	help
+	  Map the kernel with large pages to reduce TLB pressure.
+
+choice
+	prompt "User page size"
+	default PAGE_SIZE_4K
+
+config PAGE_SIZE_4K
+	bool "4kB"
+	help
+	  This is the default page size used by all Meta cores.
+
+config PAGE_SIZE_8K
+	bool "8kB"
+	depends on META21_MMU
+	help
+	  This enables 8kB pages as supported by Meta 2.x and later MMUs.
+
+config PAGE_SIZE_16K
+	bool "16kB"
+	depends on META21_MMU
+	help
+	  This enables 16kB pages as supported by Meta 2.x and later MMUs.
+
+endchoice
+
+config NUMA
+	bool "Non Uniform Memory Access (NUMA) Support"
+	help
+	  Some Meta systems have MMU-mappable on-chip memories with
+	  lower latencies than main memory. This enables support for
+	  these blocks by binding them to nodes and allowing
+	  memory policies to be used for prioritizing and controlling
+	  allocation behaviour.
+
+config FORCE_MAX_ZONEORDER
+	int "Maximum zone order"
+	range 10 32
+	default "10"
+	help
+	  The kernel memory allocator divides physically contiguous memory
+	  blocks into "zones", where each zone is a power of two number of
+	  pages.  This option selects the largest power of two that the kernel
+	  keeps in the memory allocator.  If you need to allocate very large
+	  blocks of physically contiguous memory, then you may need to
+	  increase this value.
+
+	  This config option is actually maximum order plus one. For example,
+	  a value of 11 means that the largest free memory block is 2^10 pages.
+
+	  The page size is not necessarily 4KB.  Keep this in mind
+	  when choosing a value for this option.
+
+config META_L2C
+	bool "Level 2 Cache Support"
+	depends on META21
+	help
+	  Press y here to enable support for the Meta Level 2 (L2) cache. This
+	  will enable the cache at start up if it hasn't already been enabled
+	  by the bootloader.
+
+	  If the bootloader enables the L2 you must press y here to ensure the
+	  kernel takes the appropriate actions to keep the cache coherent.
+
+config NODES_SHIFT
+	int
+	default "1"
+	depends on NEED_MULTIPLE_NODES
+
+config ARCH_FLATMEM_ENABLE
+	def_bool y
+	depends on !NUMA
+
+config ARCH_SPARSEMEM_ENABLE
+	def_bool y
+	select SPARSEMEM_STATIC
+
+config ARCH_SPARSEMEM_DEFAULT
+	def_bool y
+
+config MAX_ACTIVE_REGIONS
+	int
+	default "2" if SPARSEMEM
+	default "1"
+
+config ARCH_POPULATES_NODE_MAP
+	def_bool y
+
+config ARCH_SELECT_MEMORY_MODEL
+	def_bool y
+
+config SYS_SUPPORTS_HUGETLBFS
+	def_bool y
+	depends on META21_MMU
+
+choice
+	prompt "HugeTLB page size"
+	depends on META21_MMU && HUGETLB_PAGE
+	default HUGETLB_PAGE_SIZE_1M
+
+config HUGETLB_PAGE_SIZE_8K
+	bool "8kB"
+	depends on PAGE_SIZE_4K
+
+config HUGETLB_PAGE_SIZE_16K
+	bool "16kB"
+	depends on PAGE_SIZE_4K || PAGE_SIZE_8K
+
+config HUGETLB_PAGE_SIZE_32K
+	bool "32kB"
+
+config HUGETLB_PAGE_SIZE_64K
+	bool "64kB"
+
+config HUGETLB_PAGE_SIZE_128K
+	bool "128kB"
+
+config HUGETLB_PAGE_SIZE_256K
+	bool "256kB"
+
+config HUGETLB_PAGE_SIZE_512K
+	bool "512kB"
+
+config HUGETLB_PAGE_SIZE_1M
+	bool "1MB"
+
+config HUGETLB_PAGE_SIZE_2M
+	bool "2MB"
+
+config HUGETLB_PAGE_SIZE_4M
+	bool "4MB"
+
+endchoice
+
+config METAG_COREMEM
+	bool
+	default y if SUSPEND
+
+source "mm/Kconfig"
diff --git a/arch/metag/mm/Makefile b/arch/metag/mm/Makefile
new file mode 100644
index 0000000..097f104
--- /dev/null
+++ b/arch/metag/mm/Makefile
@@ -0,0 +1,17 @@
+#
+# Makefile for the linux Meta-specific parts of the memory manager.
+#
+
+obj-y	:= init.o fault.o ioremap.o extable.o maccess.o
+
+obj-$(CONFIG_NUMA)	+= numa.o
+obj-$(CONFIG_HIGHMEM)	+= highmem.o
+obj-$(CONFIG_META_L2C)	+= l2cache.o
+
+ifdef CONFIG_META21_MMU
+obj-y 	+= mmu-meta2.o
+else
+obj-y 	+= mmu-meta1.o
+endif
+
+obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
diff --git a/arch/metag/tbx/Makefile b/arch/metag/tbx/Makefile
new file mode 100644
index 0000000..478e193
--- /dev/null
+++ b/arch/metag/tbx/Makefile
@@ -0,0 +1,17 @@
+#
+# Makefile for TBX library files..
+#
+
+asflags-y += -I$(srctree)/arch/metag/include/asm/tbx -mmetac=2.1 \
+		-Wa,-mfpu=metac21 -mdsp
+ccflags-y += -I$(srctree)/arch/metag/include/asm/tbx -mmetac=2.1
+
+ifeq ($(CONFIG_SMP),y)
+asflags-y += -DTBX_PERCPU_SP_SAVE
+endif
+
+lib-y = tbicache.o tbicore.o tbictx.o tbilogf.o \
+	tbipcx.o tbiroot.o tbisoft.o tbistring.o tbitimer.o tbidefr.o
+
+lib-$(CONFIG_META_DSP) += tbidspram.o
+lib-$(CONFIG_META_FPU) += tbictxfpu.o
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2403a63..6a73b08 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -452,7 +452,7 @@ config SLUB_STATS
 config DEBUG_KMEMLEAK
 	bool "Kernel memory leak detector"
 	depends on DEBUG_KERNEL && EXPERIMENTAL && \
-		(X86 || ARM || PPC || MIPS || S390 || SPARC64 || SUPERH || MICROBLAZE || TILE)
+		(X86 || ARM || PPC || MIPS || S390 || SPARC64 || SUPERH || MICROBLAZE || TILE || METAG)
 
 	select DEBUG_FS
 	select STACKTRACE if STACKTRACE_SUPPORT
@@ -714,7 +714,7 @@ config STACKTRACE
 
 config DEBUG_STACK_USAGE
 	bool "Stack utilization instrumentation"
-	depends on DEBUG_KERNEL && !IA64 && !PARISC
+	depends on DEBUG_KERNEL && !IA64 && !PARISC && !METAG
 	help
 	  Enables the display of the minimum amount of free stack which each
 	  task has ever had available in the sysrq-T and sysrq-P debug output.
@@ -885,7 +885,7 @@ config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && \
 		(CRIS || M68K || FRV || UML || \
-		 AVR32 || SUPERH || BLACKFIN || MN10300) || \
+		 AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || \
 		ARCH_WANT_FRAME_POINTERS
 	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
 	help
-- 
1.7.7.6
