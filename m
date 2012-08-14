Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55625 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab2HNRxR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:17 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 30/31] arm64: Build infrastructure
Date: Tue, 14 Aug 2012 18:52:31 +0100
Message-ID: <1344966752-16102-31-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>
Message-ID: <20120814175231.M2VKtCy66HDnMowkKjUY8GNOeaiPnJ9oox6ge4jR1vg@z>

This patch adds Makefile and Kconfig files required for building an
AArch64 kernel.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig                   |  261 ++++++++++++++++++++++++++++++=
++++
 arch/arm64/Kconfig.debug             |   27 ++++
 arch/arm64/Makefile                  |   71 +++++++++
 arch/arm64/boot/.gitignore           |    2 +
 arch/arm64/boot/Makefile             |   38 +++++
 arch/arm64/boot/install.sh           |   52 +++++++
 arch/arm64/configs/generic_defconfig |   85 +++++++++++
 arch/arm64/include/asm/prom.h        |    1 +
 arch/arm64/kernel/.gitignore         |    1 +
 arch/arm64/kernel/Makefile           |   27 ++++
 arch/arm64/kernel/vmlinux.lds.S      |  146 +++++++++++++++++++
 arch/arm64/mm/Kconfig                |    5 +
 arch/arm64/mm/Makefile               |    6 +
 init/Kconfig                         |    3 +-
 lib/Kconfig.debug                    |    6 +-
 15 files changed, 728 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/Kconfig
 create mode 100644 arch/arm64/Kconfig.debug
 create mode 100644 arch/arm64/Makefile
 create mode 100644 arch/arm64/boot/.gitignore
 create mode 100644 arch/arm64/boot/Makefile
 create mode 100644 arch/arm64/boot/install.sh
 create mode 100644 arch/arm64/configs/generic_defconfig
 create mode 100644 arch/arm64/include/asm/prom.h
 create mode 100644 arch/arm64/kernel/.gitignore
 create mode 100644 arch/arm64/kernel/Makefile
 create mode 100644 arch/arm64/kernel/vmlinux.lds.S
 create mode 100644 arch/arm64/mm/Kconfig
 create mode 100644 arch/arm64/mm/Makefile

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
new file mode 100644
index 0000000..1ce3d04
--- /dev/null
+++ b/arch/arm64/Kconfig
@@ -0,0 +1,261 @@
+config ARM64
+=09def_bool y
+=09select OF
+=09select OF_EARLY_FLATTREE
+=09select IRQ_DOMAIN
+=09select HAVE_AOUT
+=09select HAVE_DMA_ATTRS
+=09select HAVE_DMA_API_DEBUG
+=09select HAVE_IDE
+=09select HAVE_MEMBLOCK
+=09select RTC_LIB
+=09select SYS_SUPPORTS_APM_EMULATION
+=09select HAVE_GENERIC_DMA_COHERENT
+=09select GENERIC_IOMAP
+=09select HAVE_IRQ_WORK
+=09select HAVE_PERF_EVENTS
+=09select HAVE_ARCH_TRACEHOOK
+=09select PERF_USE_VMALLOC
+=09select HAVE_HW_BREAKPOINT if PERF_EVENTS
+=09select HAVE_GENERIC_HARDIRQS
+=09select GENERIC_HARDIRQS_NO_DEPRECATED
+=09select HAVE_SPARSE_IRQ
+=09select SPARSE_IRQ
+=09select GENERIC_IRQ_SHOW
+=09select GENERIC_SMP_IDLE_THREAD
+=09select NO_BOOTMEM
+=09help
+=09  ARM 64-bit (AArch64) Linux support.
+
+config 64BIT
+=09def_bool y
+
+config ARCH_PHYS_ADDR_T_64BIT
+=09def_bool y
+
+config HAVE_PWM
+=09bool
+
+config SYS_SUPPORTS_APM_EMULATION
+=09bool
+
+config NO_IOPORT
+=09def_bool y
+
+config GENERIC_GPIO
+=09bool
+
+config GENERIC_TIME_VSYSCALL
+=09def_bool y
+
+config GENERIC_CLOCKEVENTS
+=09def_bool y
+
+config STACKTRACE_SUPPORT
+=09def_bool y
+
+config LOCKDEP_SUPPORT
+=09def_bool y
+
+config TRACE_IRQFLAGS_SUPPORT
+=09def_bool y
+
+config HARDIRQS_SW_RESEND
+=09def_bool y
+
+config GENERIC_IRQ_PROBE
+=09def_bool y
+
+config GENERIC_LOCKBREAK
+=09def_bool y
+=09depends on SMP && PREEMPT
+
+config RWSEM_GENERIC_SPINLOCK
+=09def_bool y
+
+config RWSEM_XCHGADD_ALGORITHM
+=09bool
+
+config ARCH_HAS_ILOG2_U32
+=09bool
+
+config ARCH_HAS_ILOG2_U64
+=09bool
+
+config ARCH_HAS_CPUFREQ
+=09bool
+=09help
+=09  Internal node to signify that the ARCH has CPUFREQ support
+=09  and that the relevant menu configurations are displayed for
+=09  it.
+
+config GENERIC_HWEIGHT
+=09def_bool y
+
+config GENERIC_CSUM
+        def_bool y
+
+config GENERIC_CALIBRATE_DELAY
+=09def_bool y
+
+config ZONE_DMA32
+=09def_bool y
+
+config ARCH_DMA_ADDR_T_64BIT
+=09def_bool y
+
+config NEED_DMA_MAP_STATE
+=09def_bool y
+
+config NEED_SG_DMA_LENGTH
+=09def_bool y
+
+config SWIOTLB
+=09def_bool y
+
+config IOMMU_HELPER
+=09def_bool SWIOTLB
+
+source "init/Kconfig"
+
+source "kernel/Kconfig.freezer"
+
+menu "System Type"
+
+source "arch/arm64/mm/Kconfig"
+
+endmenu
+
+menu "Bus support"
+
+config ARM_AMBA
+=09bool
+
+endmenu
+
+menu "Kernel Features"
+
+source "kernel/time/Kconfig"
+
+config ARM64_64K_PAGES
+=09bool "Enable 64KB pages support"
+=09help
+=09  This feature enables 64KB pages support (4KB by default)
+=09  allowing only two levels of page tables and faster TLB
+=09  look-up. AArch32 emulation is not available when this feature
+=09  is enabled.
+
+config SMP
+=09bool "Symmetric Multi-Processing"
+=09depends on GENERIC_CLOCKEVENTS
+=09select USE_GENERIC_SMP_HELPERS
+=09help
+=09  This enables support for systems with more than one CPU.  If
+=09  you say N here, the kernel will run on single and
+=09  multiprocessor machines, but will use only one CPU of a
+=09  multiprocessor machine. If you say Y here, the kernel will run
+=09  on many, but not all, single processor machines. On a single
+=09  processor machine, the kernel will run faster if you say N
+=09  here.
+
+=09  If you don't know what to do here, say N.
+
+config NR_CPUS
+=09int "Maximum number of CPUs (2-32)"
+=09range 2 32
+=09depends on SMP
+=09default "4"
+
+source kernel/Kconfig.preempt
+
+config HZ
+=09int
+=09default 100
+
+config ARCH_HAS_HOLES_MEMORYMODEL
+=09def_bool y if SPARSEMEM
+
+config ARCH_SPARSEMEM_ENABLE
+=09def_bool y
+=09select SPARSEMEM_VMEMMAP_ENABLE
+
+config ARCH_SPARSEMEM_DEFAULT
+=09def_bool ARCH_SPARSEMEM_ENABLE
+
+config ARCH_SELECT_MEMORY_MODEL
+=09def_bool ARCH_SPARSEMEM_ENABLE
+
+config HAVE_ARCH_PFN_VALID
+=09def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
+
+config HW_PERF_EVENTS
+=09bool "Enable hardware performance counter support for perf events"
+=09depends on PERF_EVENTS
+=09default y
+=09help
+=09  Enable hardware performance counter support for perf events. If
+=09  disabled, perf events will use software events only.
+
+source "mm/Kconfig"
+
+endmenu
+
+menu "Boot options"
+
+config CMDLINE
+=09string "Default kernel command string"
+=09default ""
+=09help
+=09  Provide a set of default command-line options at build time by
+=09  entering them here. As a minimum, you should specify the the
+=09  root device (e.g. root=3D/dev/nfs).
+
+config CMDLINE_FORCE
+=09bool "Always use the default kernel command string"
+=09help
+=09  Always use the default kernel command string, even if the boot
+=09  loader passes other arguments to the kernel.
+=09  This is useful if you cannot or don't want to change the
+=09  command-line options your boot loader passes to the kernel.
+
+endmenu
+
+menu "Userspace binary formats"
+
+source "fs/Kconfig.binfmt"
+
+config AARCH32_EMULATION
+=09bool "Kernel support for 32-bit EL0"
+=09depends on !ARM64_64K_PAGES
+=09select COMPAT_BINFMT_ELF
+=09help
+=09  This option enables support for a 32-bit EL0 running under a 64-bit
+=09  kernel at EL1. AArch32-specific components such as system calls,
+=09  the user helper functions, VFP support and the ptrace interface are
+=09  handled appropriately by the kernel.
+
+=09  If you want to execute 32-bit userspace applications, say Y.
+
+config COMPAT
+=09def_bool y
+=09depends on AARCH32_EMULATION
+
+config SYSVIPC_COMPAT
+=09def_bool y
+=09depends on COMPAT && SYSVIPC
+
+endmenu
+
+source "net/Kconfig"
+
+source "drivers/Kconfig"
+
+source "fs/Kconfig"
+
+source "arch/arm64/Kconfig.debug"
+
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
new file mode 100644
index 0000000..d7553f2
--- /dev/null
+++ b/arch/arm64/Kconfig.debug
@@ -0,0 +1,27 @@
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
+
+config FRAME_POINTER
+=09bool
+=09default y
+
+config DEBUG_ERRORS
+=09bool "Verbose kernel error messages"
+=09depends on DEBUG_KERNEL
+=09help
+=09  This option controls verbose debugging information which can be
+=09  printed when the kernel detects an internal error. This debugging
+=09  information is useful to kernel hackers when tracking down problems,
+=09  but mostly meaningless to other people. It's safe to say Y unless
+=09  you are concerned with the code size or don't want to see these
+=09  messages.
+
+config DEBUG_STACK_USAGE
+=09bool "Enable stack utilization instrumentation"
+=09depends on DEBUG_KERNEL
+=09help
+=09  Enables the display of the minimum amount of free stack which each
+=09  task has ever had available in the sysrq-T output.
+
+endmenu
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
new file mode 100644
index 0000000..831bd41
--- /dev/null
+++ b/arch/arm64/Makefile
@@ -0,0 +1,71 @@
+#
+# arch/arm64/Makefile
+#
+# This file is included by the global makefile so that you can add your ow=
n
+# architecture-specific flags and dependencies.
+#
+# This file is subject to the terms and conditions of the GNU General Publ=
ic
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995-2001 by Russell King
+
+LDFLAGS_vmlinux=09:=3D-p --no-undefined -X
+CPPFLAGS_vmlinux.lds =3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
+OBJCOPYFLAGS=09:=3D-O binary -R .note -R .note.gnu.build-id -R .comment -S
+GZFLAGS=09=09:=3D-9
+
+LIBGCC =09=09:=3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+
+KBUILD_DEFCONFIG :=3D generic_defconfig
+
+KBUILD_CFLAGS=09+=3D -mgeneral-regs-only
+KBUILD_CPPFLAGS=09+=3D -mlittle-endian
+AS=09=09+=3D -EL
+LD=09=09+=3D -EL
+
+comma =3D ,
+
+CHECKFLAGS=09+=3D -D__aarch64__
+
+# Default value
+head-y=09=09:=3D arch/arm64/kernel/head.o
+
+# The byte offset of the kernel image in RAM from the start of RAM.
+TEXT_OFFSET :=3D 0x00080000
+
+export=09TEXT_OFFSET GZFLAGS
+
+core-y=09=09+=3D arch/arm64/kernel/ arch/arm64/mm/
+libs-y=09=09:=3D arch/arm64/lib/ $(libs-y)
+libs-y=09=09+=3D $(LIBGCC)
+
+# Default target when executing plain make
+KBUILD_IMAGE :=3D Image.gz
+
+all:=09$(KBUILD_IMAGE)
+
+boot :=3D arch/arm64/boot
+
+Image Image.gz: vmlinux
+=09$(Q)$(MAKE) $(build)=3D$(boot) MACHINE=3D$(MACHINE) $(boot)/$@
+
+zinstall install: vmlinux
+=09$(Q)$(MAKE) $(build)=3D$(boot) MACHINE=3D$(MACHINE) $@
+
+%.dtb:
+=09$(Q)$(MAKE) $(build)=3D$(boot) MACHINE=3D$(MACHINE) $(boot)/$@
+
+# We use MRPROPER_FILES and CLEAN_FILES now
+archclean:
+=09$(Q)$(MAKE) $(clean)=3D$(boot)
+
+define archhelp
+  echo  '* Image.gz      - Compressed kernel image (arch/$(ARCH)/boot/Imag=
e.gz)'
+  echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Im=
age)'
+  echo  '  install       - Install uncompressed kernel'
+  echo  '  zinstall      - Install compressed kernel'
+  echo  '                  Install using (your) ~/bin/installkernel or'
+  echo  '                  (distribution) /sbin/installkernel or'
+  echo  '                  install to $$(INSTALL_PATH) and run lilo'
+endef
diff --git a/arch/arm64/boot/.gitignore b/arch/arm64/boot/.gitignore
new file mode 100644
index 0000000..8dab0bb
--- /dev/null
+++ b/arch/arm64/boot/.gitignore
@@ -0,0 +1,2 @@
+Image
+Image.gz
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
new file mode 100644
index 0000000..15a58a8
--- /dev/null
+++ b/arch/arm64/boot/Makefile
@@ -0,0 +1,38 @@
+#
+# arch/arm64/boot/Makefile
+#
+# This file is included by the global makefile so that you can add your ow=
n
+# architecture-specific flags and dependencies.
+#
+# This file is subject to the terms and conditions of the GNU General Publ=
ic
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 2012, ARM Ltd.
+# Author: Will Deacon <will.deacon@arm.com>
+#
+# Based on the ia64 boot/Makefile.
+#
+
+targets :=3D Image Image.gz
+
+$(obj)/Image: vmlinux FORCE
+=09$(call if_changed,objcopy)
+=09@echo '  Kernel: $@ is ready'
+
+$(obj)/Image.gz: $(obj)/Image FORCE
+=09$(call if_changed,gzip)
+=09@echo '  Kernel: $@ is ready'
+
+$(obj)/%.dtb: $(src)/dts/%.dts
+=09$(call cmd,dtc)
+
+install: $(obj)/Image
+=09$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+=09$(obj)/Image System.map "$(INSTALL_PATH)"
+
+zinstall: $(obj)/Image.gz
+=09$(CONFIG_SHELL) $(srctree)/$(src)/install.sh $(KERNELRELEASE) \
+=09$(obj)/Image.gz System.map "$(INSTALL_PATH)"
+
+clean-files +=3D *.dtb
diff --git a/arch/arm64/boot/install.sh b/arch/arm64/boot/install.sh
new file mode 100644
index 0000000..9151e21
--- /dev/null
+++ b/arch/arm64/boot/install.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# arch/arm64/boot/install.sh
+#
+# This file is subject to the terms and conditions of the GNU General Publ=
ic
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1995 by Linus Torvalds
+#
+# Adapted from code in arch/i386/boot/Makefile by H. Peter Anvin
+# Adapted from code in arch/i386/boot/install.sh by Russell King
+#
+# "make install" script for the AArch64 Linux port
+#
+# Arguments:
+#   $1 - kernel version
+#   $2 - kernel image file
+#   $3 - kernel map file
+#   $4 - default install path (blank if root directory)
+#
+
+# User may have a custom install script
+if [ -x ~/bin/${INSTALLKERNEL} ]; then exec ~/bin/${INSTALLKERNEL} "$@"; f=
i
+if [ -x /sbin/${INSTALLKERNEL} ]; then exec /sbin/${INSTALLKERNEL} "$@"; f=
i
+
+if [ "$(basename $2)" =3D "Image.gz" ]; then
+# Compressed install
+  echo "Installing compressed kernel"
+  base=3Dvmlinuz
+else
+# Normal install
+  echo "Installing normal kernel"
+  base=3Dvmlinux
+fi
+
+if [ -f $4/$base-$1 ]; then
+  mv $4/$base-$1 $4/$base-$1.old
+fi
+cat $2 > $4/$base-$1
+
+# Install system map file
+if [ -f $4/System.map-$1 ]; then
+  mv $4/System.map-$1 $4/System.map-$1.old
+fi
+cp $3 $4/System.map-$1
+
+if [ -x /sbin/loadmap ]; then
+  /sbin/loadmap
+else
+  echo "You have to install it yourself"
+fi
diff --git a/arch/arm64/configs/generic_defconfig b/arch/arm64/configs/gene=
ric_defconfig
new file mode 100644
index 0000000..d9aac95
--- /dev/null
+++ b/arch/arm64/configs/generic_defconfig
@@ -0,0 +1,85 @@
+CONFIG_EXPERIMENTAL=3Dy
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
+CONFIG_BSD_PROCESS_ACCT=3Dy
+CONFIG_BSD_PROCESS_ACCT_V3=3Dy
+CONFIG_NO_HZ=3Dy
+CONFIG_HIGH_RES_TIMERS=3Dy
+CONFIG_IKCONFIG=3Dy
+CONFIG_IKCONFIG_PROC=3Dy
+CONFIG_LOG_BUF_SHIFT=3D14
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+CONFIG_SCHED_AUTOGROUP=3Dy
+CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_KALLSYMS_ALL=3Dy
+# CONFIG_COMPAT_BRK is not set
+CONFIG_PROFILING=3Dy
+CONFIG_MODULES=3Dy
+CONFIG_MODULE_UNLOAD=3Dy
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_SMP=3Dy
+CONFIG_PREEMPT_VOLUNTARY=3Dy
+CONFIG_CMDLINE=3D"console=3DttyAMA0"
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_AARCH32_EMULATION=3Dy
+CONFIG_NET=3Dy
+CONFIG_PACKET=3Dy
+CONFIG_UNIX=3Dy
+CONFIG_INET=3Dy
+CONFIG_IP_PNP=3Dy
+CONFIG_IP_PNP_DHCP=3Dy
+CONFIG_IP_PNP_BOOTP=3Dy
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
+CONFIG_DEVTMPFS=3Dy
+# CONFIG_BLK_DEV is not set
+CONFIG_SCSI=3Dy
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=3Dy
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_NETDEVICES=3Dy
+CONFIG_MII=3Dy
+# CONFIG_WLAN is not set
+CONFIG_INPUT_EVDEV=3Dy
+# CONFIG_SERIO_I8042 is not set
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_LEGACY_PTY_COUNT=3D16
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+CONFIG_FB=3Dy
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=3Dy
+CONFIG_LOGO=3Dy
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_EXT2_FS=3Dy
+CONFIG_EXT3_FS=3Dy
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+# CONFIG_EXT3_FS_XATTR is not set
+CONFIG_FUSE_FS=3Dy
+CONFIG_CUSE=3Dy
+CONFIG_VFAT_FS=3Dy
+CONFIG_TMPFS=3Dy
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=3Dy
+CONFIG_ROOT_NFS=3Dy
+CONFIG_NLS_CODEPAGE_437=3Dy
+CONFIG_NLS_ISO8859_1=3Dy
+CONFIG_MAGIC_SYSRQ=3Dy
+CONFIG_DEBUG_FS=3Dy
+CONFIG_DEBUG_KERNEL=3Dy
+# CONFIG_SCHED_DEBUG is not set
+CONFIG_DEBUG_INFO=3Dy
+# CONFIG_FTRACE is not set
+CONFIG_ATOMIC64_SELFTEST=3Dy
+CONFIG_DEBUG_ERRORS=3Dy
diff --git a/arch/arm64/include/asm/prom.h b/arch/arm64/include/asm/prom.h
new file mode 100644
index 0000000..68b90e6
--- /dev/null
+++ b/arch/arm64/include/asm/prom.h
@@ -0,0 +1 @@
+/* Empty for now */
diff --git a/arch/arm64/kernel/.gitignore b/arch/arm64/kernel/.gitignore
new file mode 100644
index 0000000..c5f676c
--- /dev/null
+++ b/arch/arm64/kernel/.gitignore
@@ -0,0 +1 @@
+vmlinux.lds
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
new file mode 100644
index 0000000..59fbdef
--- /dev/null
+++ b/arch/arm64/kernel/Makefile
@@ -0,0 +1,27 @@
+#
+# Makefile for the linux kernel.
+#
+
+CPPFLAGS_vmlinux.lds=09:=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
+AFLAGS_head.o=09=09:=3D -DTEXT_OFFSET=3D$(TEXT_OFFSET)
+
+# Object file lists.
+arm64-obj-y=09=09:=3D debug-monitors.o elf.o entry.o irq.o=09fpsimd.o=09\
+=09=09=09   entry-fpsimd.o process.o ptrace.o setup.o signal.o=09\
+=09=09=09   sys.o stacktrace.o time.o traps.o io.o vdso.o
+
+arm64-obj-$(CONFIG_AARCH32_EMULATION)=09+=3D sys32.o kuser32.o signal32.o =
=09\
+=09=09=09=09=09   sys_compat.o
+arm64-obj-$(CONFIG_MODULES)=09=09+=3D arm64ksyms.o module.o
+arm64-obj-$(CONFIG_SMP)=09=09=09+=3D smp.o
+arm64-obj-$(CONFIG_HW_PERF_EVENTS)=09+=3D perf_event.o
+arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+=3D hw_breakpoint.o
+
+obj-y=09=09=09=09=09+=3D $(arm64-obj-y) vdso/
+obj-m=09=09=09=09=09+=3D $(arm64-obj-m)
+head-y=09=09=09=09=09:=3D head.o
+extra-y=09=09=09=09=09:=3D $(head-y) vmlinux.lds
+
+# vDSO - this must be built first to generate the symbol offsets
+$(call objectify,$(arm64-obj-y)): $(obj)/vdso/vdso-offsets.h
+$(obj)/vdso/vdso-offsets.h: $(obj)/vdso
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.ld=
s.S
new file mode 100644
index 0000000..5eab87b
--- /dev/null
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -0,0 +1,146 @@
+/*
+ * ld script to make ARM Linux kernel
+ * taken from the i386 version by Russell King
+ * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
+ */
+
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/thread_info.h>
+#include <asm/memory.h>
+#include <asm/page.h>
+
+#define PROC_INFO=09=09=09=09=09=09=09\
+=09VMLINUX_SYMBOL(__proc_info_begin) =3D .;=09=09=09=09\
+=09*(.proc.info.init)=09=09=09=09=09=09\
+=09VMLINUX_SYMBOL(__proc_info_end) =3D .;
+
+#define ARM_CPU_DISCARD(x)=09x
+#define ARM_CPU_KEEP(x)
+
+#define ARM_EXIT_KEEP(x)
+#define ARM_EXIT_DISCARD(x)=09x
+
+OUTPUT_ARCH(aarch64)
+ENTRY(stext)
+
+jiffies =3D jiffies_64;
+
+SECTIONS
+{
+=09/*
+=09 * XXX: The linker does not define how output sections are
+=09 * assigned to input sections when there are multiple statements
+=09 * matching the same input section name.  There is no documented
+=09 * order of matching.
+=09 */
+=09/DISCARD/ : {
+=09=09ARM_EXIT_DISCARD(EXIT_TEXT)
+=09=09ARM_EXIT_DISCARD(EXIT_DATA)
+=09=09EXIT_CALL
+=09=09*(.discard)
+=09=09*(.discard.*)
+=09}
+
+=09. =3D PAGE_OFFSET + TEXT_OFFSET;
+
+=09.head.text : {
+=09=09_text =3D .;
+=09=09HEAD_TEXT
+=09}
+=09.text : {=09=09=09/* Real text segment=09=09*/
+=09=09_stext =3D .;=09=09/* Text and read-only data=09*/
+=09=09=09*(.smp.pen.text)
+=09=09=09__exception_text_start =3D .;
+=09=09=09*(.exception.text)
+=09=09=09__exception_text_end =3D .;
+=09=09=09IRQENTRY_TEXT
+=09=09=09TEXT_TEXT
+=09=09=09SCHED_TEXT
+=09=09=09LOCK_TEXT
+=09=09=09*(.fixup)
+=09=09=09*(.gnu.warning)
+=09=09. =3D ALIGN(16);
+=09=09*(.got)=09=09=09/* Global offset table=09=09*/
+=09=09=09ARM_CPU_KEEP(PROC_INFO)
+=09}
+
+=09RO_DATA(PAGE_SIZE)
+
+=09_etext =3D .;=09=09=09/* End of text and rodata section */
+
+=09. =3D ALIGN(PAGE_SIZE);
+=09__init_begin =3D .;
+
+=09INIT_TEXT_SECTION(8)
+=09.exit.text : {
+=09=09ARM_EXIT_KEEP(EXIT_TEXT)
+=09}
+=09. =3D ALIGN(16);
+=09.init.proc.info : {
+=09=09ARM_CPU_DISCARD(PROC_INFO)
+=09}
+=09. =3D ALIGN(16);
+=09.init.data : {
+=09=09INIT_DATA
+=09=09INIT_SETUP(16)
+=09=09INIT_CALLS
+=09=09CON_INITCALL
+=09=09SECURITY_INITCALL
+=09=09INIT_RAM_FS
+=09}
+=09.exit.data : {
+=09=09ARM_EXIT_KEEP(EXIT_DATA)
+=09}
+
+=09PERCPU_SECTION(64)
+
+=09__init_end =3D .;
+=09. =3D ALIGN(THREAD_SIZE);
+=09__data_loc =3D .;
+
+=09.data : AT(__data_loc) {
+=09=09_data =3D .;=09=09/* address in memory */
+=09=09_sdata =3D .;
+
+=09=09/*
+=09=09 * first, the init task union, aligned
+=09=09 * to an 8192 byte boundary.
+=09=09 */
+=09=09INIT_TASK_DATA(THREAD_SIZE)
+=09=09NOSAVE_DATA
+=09=09CACHELINE_ALIGNED_DATA(64)
+=09=09READ_MOSTLY_DATA(64)
+
+=09=09/*
+=09=09 * The exception fixup table (might need resorting at runtime)
+=09=09 */
+=09=09. =3D ALIGN(32);
+=09=09__start___ex_table =3D .;
+=09=09*(__ex_table)
+=09=09__stop___ex_table =3D .;
+
+=09=09/*
+=09=09 * and the usual data section
+=09=09 */
+=09=09DATA_DATA
+=09=09CONSTRUCTORS
+
+=09=09_edata =3D .;
+=09}
+=09_edata_loc =3D __data_loc + SIZEOF(.data);
+
+=09NOTES
+
+=09BSS_SECTION(0, 0, 0)
+=09_end =3D .;
+
+=09STABS_DEBUG
+=09.comment 0 : { *(.comment) }
+}
+
+/*
+ * These must never be empty
+ * If you have to comment these two assert statements out, your
+ * binutils is too old (for other reasons as well)
+ */
+ASSERT((__proc_info_end - __proc_info_begin), "missing CPU support")
diff --git a/arch/arm64/mm/Kconfig b/arch/arm64/mm/Kconfig
new file mode 100644
index 0000000..8e94e52
--- /dev/null
+++ b/arch/arm64/mm/Kconfig
@@ -0,0 +1,5 @@
+config MMU
+=09def_bool y
+
+config CPU_64
+=09def_bool y
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
new file mode 100644
index 0000000..81a9d8b
--- /dev/null
+++ b/arch/arm64/mm/Makefile
@@ -0,0 +1,6 @@
+obj-y=09=09=09=09:=3D dma-mapping.o extable.o fault.o init.o \
+=09=09=09=09   cache.o copypage.o flush.o \
+=09=09=09=09   ioremap.o mmap.o pgd.o mmu.o \
+=09=09=09=09   context.o tlb.o proc.o
+
+obj-$(CONFIG_MODULES)=09=09+=3D proc-syms.o
diff --git a/init/Kconfig b/init/Kconfig
index af6c7f8..8bfda46 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1153,7 +1153,8 @@ menuconfig EXPERT
=20
 config UID16
 =09bool "Enable 16-bit UID system calls" if EXPERT
-=09depends on ARM || BLACKFIN || CRIS || FRV || H8300 || X86_32 || M68K ||=
 (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && COMPAT) || UML || (X8=
6_64 && IA32_EMULATION)
+=09depends on ARM || BLACKFIN || CRIS || FRV || H8300 || X86_32 || M68K ||=
 (S390 && !64BIT) || SUPERH || SPARC32 || (SPARC64 && COMPAT) || UML || (X8=
6_64 && IA32_EMULATION) \
+=09=09|| AARCH32_EMULATION
 =09default y
 =09help
 =09  This enables the legacy 16-bit UID syscall wrappers.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2403a63..cfb4578 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -452,7 +452,8 @@ config SLUB_STATS
 config DEBUG_KMEMLEAK
 =09bool "Kernel memory leak detector"
 =09depends on DEBUG_KERNEL && EXPERIMENTAL && \
-=09=09(X86 || ARM || PPC || MIPS || S390 || SPARC64 || SUPERH || MICROBLAZ=
E || TILE)
+=09=09(X86 || ARM || PPC || MIPS || S390 || SPARC64 || SUPERH || \
+=09=09 MICROBLAZE || TILE || ARM64)
=20
 =09select DEBUG_FS
 =09select STACKTRACE if STACKTRACE_SUPPORT
@@ -739,7 +740,8 @@ config DEBUG_BUGVERBOSE
 =09bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
 =09depends on BUG
 =09depends on ARM || AVR32 || M32R || M68K || SPARC32 || SPARC64 || \
-=09=09   FRV || SUPERH || GENERIC_BUG || BLACKFIN || MN10300 || TILE
+=09=09   FRV || SUPERH || GENERIC_BUG || BLACKFIN || MN10300 || \
+=09=09   TILE || ARM64
 =09default y
 =09help
 =09  Say Y here to make BUG() panics output the file name and line number

