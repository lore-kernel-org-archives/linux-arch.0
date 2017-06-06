From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 17/17] RISC-V: Makefile and Kconfig
Date: Tue,  6 Jun 2017 16:00:07 -0700
Message-ID: <20170606230007.19101-18-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34009 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdFFXBn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id v14so10530422pgn.1
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:42 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>

This patch adds RISC-V support to the build infastructure.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 Makefile                                  |   3 +-
 arch/riscv/Kconfig                        | 318 ++++++++++++++++++++++++++++++
 arch/riscv/Makefile                       |  64 ++++++
 arch/riscv/configs/freedom-u500_defconfig |  53 +++++
 arch/riscv/configs/spike32_defconfig      |  50 +++++
 arch/riscv/configs/spike64_defconfig      |  46 +++++
 6 files changed, 533 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/Kconfig
 create mode 100644 arch/riscv/Makefile
 create mode 100644 arch/riscv/configs/freedom-u500_defconfig
 create mode 100644 arch/riscv/configs/spike32_defconfig
 create mode 100644 arch/riscv/configs/spike64_defconfig

diff --git a/Makefile b/Makefile
index 853ae9179af9..88711cbcc3ca 100644
--- a/Makefile
+++ b/Makefile
@@ -232,7 +232,8 @@ SUBARCH := $(shell uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/ \
 				  -e s/arm.*/arm/ -e s/sa110/arm/ \
 				  -e s/s390x/s390/ -e s/parisc64/parisc/ \
 				  -e s/ppc.*/powerpc/ -e s/mips.*/mips/ \
-				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ )
+				  -e s/sh[234].*/sh/ -e s/aarch64.*/arm64/ \
+				  -e s/riscv.*/riscv/)
 
 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
new file mode 100644
index 000000000000..64fcb17886c6
--- /dev/null
+++ b/arch/riscv/Kconfig
@@ -0,0 +1,318 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+config RISCV
+	def_bool y
+	select OF
+	select OF_EARLY_FLATTREE
+	select OF_IRQ
+	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
+	select ARCH_WANT_FRAME_POINTERS
+	select CLONE_BACKWARDS
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_CPU_DEVICES
+	select GENERIC_IRQ_SHOW
+	select GENERIC_PCI_IOMAP
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
+	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_ATOMIC64 if !64BIT || !ISA_A
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select HAVE_MEMBLOCK
+	select HAVE_DMA_API_DEBUG
+	select HAVE_DMA_CONTIGUOUS
+	select HAVE_GENERIC_DMA_COHERENT
+	select IRQ_DOMAIN
+	select NO_BOOTMEM
+	select ISA_A if SMP
+	select SYSRISCV_ATOMIC if !ISA_A
+	select SPARSE_IRQ
+	select SYSCTL_EXCEPTION_TRACE
+	select HAVE_ARCH_TRACEHOOK
+	select MODULES_USE_ELF_RELA if MODULES
+	select THREAD_INFO_IN_TASK
+	select RISCV_IRQ_INTC
+
+config MMU
+	def_bool y
+
+# even on 32-bit, physical (and DMA) addresses are > 32-bits
+config ARCH_PHYS_ADDR_T_64BIT
+	def_bool y
+
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool y
+
+config STACKTRACE_SUPPORT
+	def_bool y
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config GENERIC_BUG
+	def_bool y
+	depends on BUG
+	select GENERIC_BUG_RELATIVE_POINTERS if 64BIT
+
+config GENERIC_BUG_RELATIVE_POINTERS
+	bool
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config GENERIC_CSUM
+	def_bool y
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config PGTABLE_LEVELS
+	int
+	default 3 if 64BIT
+	default 2
+
+config HAVE_KPROBES
+	def_bool n
+
+config DMA_NOOP_OPS
+	def_bool y
+
+menu "Platform type"
+
+config SMP
+	bool "Symmetric Multi-Processing"
+	help
+	  This enables support for systems with more than one CPU.  If
+	  you say N here, the kernel will run on single and
+	  multiprocessor machines, but will use only one CPU of a
+	  multiprocessor machine. If you say Y here, the kernel will run
+	  on many, but not all, single processor machines. On a single
+	  processor machine, the kernel will run faster if you say N
+	  here.
+
+	  If you don't know what to do here, say N.
+
+config NR_CPUS
+	int "Maximum number of CPUs (2-32)"
+	range 2 32
+	depends on SMP
+	default "8"
+
+config CPU_SUPPORTS_32BIT_KERNEL
+	bool
+config CPU_SUPPORTS_64BIT_KERNEL
+	bool
+
+choice
+	prompt "Base ISA"
+	default ARCH_RV64I
+
+config ARCH_RV32I
+	bool "RV32I"
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select 32BIT
+	select GENERIC_ASHLDI3
+	select GENERIC_ASHRDI3
+	select GENERIC_LSHRDI3
+
+config ARCH_RV64I
+	bool "RV64I"
+	select CPU_SUPPORTS_64BIT_KERNEL
+	select 64BIT
+
+endchoice
+
+choice
+	prompt "CPU Tuning"
+	default TUNE_GENERIC
+
+config TUNE_GENERIC
+	bool "generic"
+
+endchoice
+
+config ISA_C
+	bool "Emit compressed instructions when building Linux"
+	default n
+	help
+	   Adds "C" to the ISA subsets that the toolchain is allowed to emit
+	   when building Linux, which results in compressed instructions in the
+	   Linux binary.
+
+	   If you don't know what to do here, say Y.
+
+config ISA_A
+	bool "Emit atomic instructions when building Linux"
+	default y
+	help
+	   Adds "A" to the ISA subsets that the toolchain is allowed to emit
+	   when building Linux, which results in atomic instructions in the
+	   Linux binary.
+
+	   If you don't know what to do here, say Y.
+
+config SYSRISCV_ATOMIC
+	bool "Include support for atomic operation syscalls"
+	default !ISA_A
+	help
+	  If atomic memory instructions are present, i.e.,
+	  CONFIG_ISA_A, this includes support for the syscall that
+	  provides atomic accesses.  This is only useful to run
+	  binaries that require atomic access but were compiled with
+	  -mno-atomic.
+
+	  If CONFIG_ISA_A is unset, this option is mandatory.
+
+	  If you don't know what to do here, say N.
+
+config RV_PUM
+	def_bool y
+	prompt "Protect User Memory" if EXPERT
+	---help---
+	  Protect User Memory (PUM) prevents the kernel from inadvertently
+	  accessing user-space memory.  There is a small performance cost
+	  and kernel size increase if this is enabled.
+
+	  If unsure, say Y.
+
+endmenu
+
+menu "Kernel type"
+
+choice
+	prompt "Kernel code model"
+	default 64BIT
+
+config 32BIT
+	bool "32-bit kernel"
+	depends on CPU_SUPPORTS_32BIT_KERNEL
+	help
+	  Select this option to build a 32-bit kernel.
+
+config 64BIT
+	bool "64-bit kernel"
+	depends on CPU_SUPPORTS_64BIT_KERNEL
+	help
+	  Select this option to build a 64-bit kernel.
+
+endchoice
+
+source "mm/Kconfig"
+
+source "kernel/Kconfig.preempt"
+
+source "kernel/Kconfig.hz"
+
+endmenu
+
+menu "Bus support"
+
+config PCI
+	bool "PCI support"
+	select PCI_MSI
+	help
+	  This feature enables support for PCI bus system. If you say Y
+	  here, the kernel will include drivers and infrastructure code
+	  to support PCI bus devices.
+
+	  If you don't know what to do here, say Y.
+
+config PCI_DOMAINS
+	def_bool PCI
+
+config PCI_DOMAINS_GENERIC
+	def_bool PCI
+
+source "drivers/pci/Kconfig"
+
+endmenu
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+menu "Executable file formats"
+
+source "fs/Kconfig.binfmt"
+
+endmenu
+
+menu "Power management options"
+
+source kernel/power/Kconfig
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
+config CMDLINE_BOOL
+	bool "Built-in kernel command line"
+	default n
+	help
+	  For most platforms, it is firmware or second stage bootloader
+	  that by default specifies the kernel command line options.
+	  However, it might be necessary or advantageous to either override
+	  the default kernel command line or add a few extra options to it.
+	  For such cases, this option allows hardcoding command line options
+	  directly into the kernel.
+
+	  For that, choose 'Y' here and fill in the extra boot parameters
+	  in CONFIG_CMDLINE.
+
+	  The built-in options will be concatenated to the default command
+	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
+	  command line will be ignored and replaced by the built-in string.
+
+config CMDLINE
+	string "Built-in kernel command string"
+	depends on CMDLINE_BOOL
+	default ""
+	help
+	  Supply command-line options at build time by entering them here.
+
+config CMDLINE_OVERRIDE
+	bool "Built-in command line overrides bootloader arguments"
+	default n
+	depends on CMDLINE_BOOL
+	help
+	  Set this option to 'Y' to have the kernel ignore the bootloader
+	  or firmware command line.  Instead, the built-in command line
+	  will be used exclusively.
+
+	  If you don't know what to do here, say N.
+
+config EARLY_PRINTK
+	bool "Early printk"
+	default n
+	help
+	  This option enables special console drivers which allow the kernel
+	  to print messages very early in the bootup process.
+
+	  This is useful for kernel debugging when your machine crashes very
+	  early before the console code is initialized. For normal operation
+	  it is not recommended because it looks ugly and doesn't cooperate
+	  with klogd/syslogd or the X server. You should normally N here,
+	  unless you want to debug such a crash.
+
+
+source "lib/Kconfig.debug"
+
+config CMDLINE_BOOL
+	bool
+endmenu
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
+
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
new file mode 100644
index 000000000000..66c4a5e383f9
--- /dev/null
+++ b/arch/riscv/Makefile
@@ -0,0 +1,64 @@
+# This file is included by the global makefile so that you can add your own
+# architecture-specific flags and dependencies. Remember to do have actions
+# for "archclean" and "archdep" for cleaning up and making dependencies for
+# this architecture
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+
+LDFLAGS         :=
+OBJCOPYFLAGS    := -O binary
+LDFLAGS_vmlinux :=
+KBUILD_AFLAGS_MODULE += -fPIC
+KBUILD_CFLAGS_MODULE += -fPIC
+
+KBUILD_DEFCONFIG = spike64_defconfig
+
+export BITS
+ifeq ($(CONFIG_ARCH_RV64I),y)
+	BITS := 64
+	UTS_MACHINE := riscv64
+
+	KBUILD_CFLAGS += -mabi=lp64
+	KBUILD_AFLAGS += -mabi=lp64
+	KBUILD_MARCH = rv64im
+	LDFLAGS += -melf64lriscv
+else
+	BITS := 32
+	UTS_MACHINE := riscv32
+
+	KBUILD_CFLAGS += -mabi=ilp32
+	KBUILD_AFLAGS += -mabi=ilp32
+	KBUILD_MARCH = rv32im
+	LDFLAGS += -melf32lriscv
+endif
+
+KBUILD_CFLAGS += -Wall
+
+ifeq ($(CONFIG_ISA_A),y)
+	KBUILD_ARCH_A = a
+endif
+ifeq ($(CONFIG_ISA_C),y)
+	KBUILD_ARCH_C = c
+endif
+
+KBUILD_AFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)fd$(KBUILD_ARCH_C)
+
+KBUILD_CFLAGS += -march=$(KBUILD_MARCH)$(KBUILD_ARCH_A)$(KBUILD_ARCH_C)
+KBUILD_CFLAGS += -mno-save-restore
+
+# GCC versions that support the "-mstrict-align" option default to allowing
+# unaligned accesses.  While unaligned accesses are explicitly allowed in the
+# RISC-V ISA, they're emulated by machine mode traps on all extant
+# architectures.  It's faster to have GCC emit only aligned accesses.
+KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+
+head-y := arch/riscv/kernel/head.o
+
+core-y += arch/riscv/kernel/ arch/riscv/mm/
+
+libs-y += arch/riscv/lib/
+
+all: vmlinux
diff --git a/arch/riscv/configs/freedom-u500_defconfig b/arch/riscv/configs/freedom-u500_defconfig
new file mode 100644
index 000000000000..b37908d45067
--- /dev/null
+++ b/arch/riscv/configs/freedom-u500_defconfig
@@ -0,0 +1,53 @@
+CONFIG_CROSS_COMPILE="riscv64-unknown-linux-gnu-"
+CONFIG_DEFAULT_HOSTNAME="ucbvax"
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+# CONFIG_FHANDLE is not set
+CONFIG_NAMESPACES=y
+# CONFIG_SGETMASK_SYSCALL is not set
+CONFIG_EMBEDDED=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_COMPACTION is not set
+CONFIG_HZ_100=y
+CONFIG_PCI_MSI=y
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+CONFIG_OF=y
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_VT is not set
+CONFIG_DEVKMEM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_SYSFS is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_SECTION_MISMATCH=y
+# CONFIG_FRAME_POINTER is not set
+# CONFIG_EARLY_PRINTK is not set
+# CONFIG_CRYPTO_HW is not set
+CONFIG_TTY=y
diff --git a/arch/riscv/configs/spike32_defconfig b/arch/riscv/configs/spike32_defconfig
new file mode 100644
index 000000000000..cf3431e94311
--- /dev/null
+++ b/arch/riscv/configs/spike32_defconfig
@@ -0,0 +1,50 @@
+CONFIG_64BIT=n
+CONFIG_32BIT=y
+CONFIG_ARCH_RV64I=n
+CONFIG_ARCH_RV32I=y
+CONFIG_PCI=y
+CONFIG_DEFAULT_HOSTNAME="ucbvax"
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+# CONFIG_FHANDLE is not set
+CONFIG_NAMESPACES=y
+CONFIG_EMBEDDED=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_VT is not set
+CONFIG_DEVKMEM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_SYSFS is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+# CONFIG_FRAME_POINTER is not set
+# CONFIG_CRYPTO_HW is not set
+CONFIG_TTY=y
diff --git a/arch/riscv/configs/spike64_defconfig b/arch/riscv/configs/spike64_defconfig
new file mode 100644
index 000000000000..5ad6644df541
--- /dev/null
+++ b/arch/riscv/configs/spike64_defconfig
@@ -0,0 +1,46 @@
+CONFIG_PCI=y
+CONFIG_DEFAULT_HOSTNAME="ucbvax"
+# CONFIG_CROSS_MEMORY_ATTACH is not set
+# CONFIG_FHANDLE is not set
+CONFIG_NAMESPACES=y
+CONFIG_EMBEDDED=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FIRMWARE_IN_KERNEL is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_VT is not set
+CONFIG_DEVKMEM=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=y
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=y
+# CONFIG_FILE_LOCKING is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_PROC_PAGE_MONITOR is not set
+# CONFIG_SYSFS is not set
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+# CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_SECTION_MISMATCH=y
+# CONFIG_FRAME_POINTER is not set
+# CONFIG_CRYPTO_HW is not set
+CONFIG_TTY=y
-- 
2.13.0
