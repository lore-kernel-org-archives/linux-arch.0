From: Mark Salter <msalter@redhat.com>
Subject: [PATCH 04/24] C6X: build infrastructure
Date: Mon,  8 Aug 2011 17:44:19 -0400
Message-ID: <1312839879-13592-5-git-send-email-msalter@redhat.com>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:65223 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab1HHVor (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 8 Aug 2011 17:44:47 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p78Lil1k009805
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:47 -0400
Received: from deneb.redhat.com (ovpn-113-62.phx2.redhat.com [10.3.113.62])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p78LiinN010873
	for <linux-arch@vger.kernel.org>; Mon, 8 Aug 2011 17:44:46 -0400
In-Reply-To: <1312839879-13592-1-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/Kconfig                    |  180 +++++++++++++++++++++++++++++++++++
 arch/c6x/Kconfig.debug              |   14 +++
 arch/c6x/Makefile                   |   56 +++++++++++
 arch/c6x/boot/Makefile              |   22 ++++
 arch/c6x/configs/dsk6455_defconfig  |   39 ++++++++
 arch/c6x/configs/evmc6457_defconfig |   40 ++++++++
 arch/c6x/configs/evmc6472_defconfig |   41 ++++++++
 arch/c6x/configs/evmc6474_defconfig |   41 ++++++++
 arch/c6x/include/asm/Kbuild         |   54 +++++++++++
 arch/c6x/kernel/Makefile            |   12 +++
 arch/c6x/kernel/vmlinux.lds.S       |  165 ++++++++++++++++++++++++++++++++
 arch/c6x/lib/Makefile               |    8 ++
 arch/c6x/mm/Makefile                |   10 ++
 arch/c6x/platforms/Kconfig          |   45 +++++++++
 arch/c6x/platforms/Makefile         |   19 ++++
 15 files changed, 746 insertions(+), 0 deletions(-)
 create mode 100644 arch/c6x/Kconfig
 create mode 100644 arch/c6x/Kconfig.debug
 create mode 100644 arch/c6x/Makefile
 create mode 100644 arch/c6x/boot/Makefile
 create mode 100644 arch/c6x/configs/dsk6455_defconfig
 create mode 100644 arch/c6x/configs/evmc6457_defconfig
 create mode 100644 arch/c6x/configs/evmc6472_defconfig
 create mode 100644 arch/c6x/configs/evmc6474_defconfig
 create mode 100644 arch/c6x/include/asm/Kbuild
 create mode 100644 arch/c6x/kernel/Makefile
 create mode 100644 arch/c6x/kernel/vmlinux.lds.S
 create mode 100644 arch/c6x/lib/Makefile
 create mode 100644 arch/c6x/mm/Makefile
 create mode 100644 arch/c6x/platforms/Kconfig
 create mode 100644 arch/c6x/platforms/Makefile

diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
new file mode 100644
index 0000000..9205d5c
--- /dev/null
+++ b/arch/c6x/Kconfig
@@ -0,0 +1,180 @@
+#
+# For a description of the syntax of this configuration file,
+# see Documentation/kbuild/kconfig-language.txt.
+#
+
+config TMS320C6X
+	def_bool y
+	select CLKDEV_LOOKUP
+	select HAVE_MEMBLOCK
+	select HAVE_SPARSE_IRQ
+	select GENERIC_IRQ_SHOW
+	select HAVE_GENERIC_HARDIRQS
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_HARDIRQS_NO__DO_IRQ
+	select GENERIC_HARDIRQS_NO_DEPRECATED
+	select GENERIC_FIND_FIRST_BIT
+	select GENERIC_FIND_NEXT_BIT
+	select GENERIC_FIND_LAST_BIT
+	select GENERIC_FIND_BIT_LE
+	select OF
+	select OF_EARLY_FLATTREE
+
+config MMU
+	def_bool n
+
+config ZONE_DMA
+	def_bool y
+
+config FPU
+	def_bool n
+
+config HIGHMEM
+	def_bool n
+
+config NUMA
+	def_bool n
+
+config RWSEM_GENERIC_SPINLOCK
+	def_bool y
+
+config RWSEM_XCHGADD_ALGORITHM
+	def_bool n
+
+config GENERIC_CALIBRATE_DELAY
+	def_bool y
+
+config GENERIC_FIND_NEXT_BIT
+	def_bool y
+
+config GENERIC_HWEIGHT
+	def_bool y
+
+config GENERIC_CLOCKEVENTS
+	def_bool y
+
+config GENERIC_CLOCKEVENTS_BROADCAST
+	bool
+
+config GENERIC_BUG
+	def_bool y
+
+config COMMON_CLKDEV
+	def_bool y
+
+config BIG_KERNEL
+	bool "Build a big kernel"
+	help
+	  The C6X function call instruction has a limited range of +/- 2MiB.
+	  This is sufficient for most kernels, but some kernel configurations
+	  with lots of compiled-in functionality may require a larger range
+	  for function calls. Use this option to have the compiler generate
+	  function calls with 32-bit range. This will make the kernel both
+	  larger and slower.
+
+	  If unsure, say N.
+
+config NR_IRQS
+	int "Number of virtual interrupt numbers"
+	range 32 32768
+	default "256"
+	help
+	  This defines the number of virtual interrupt numbers the kernel
+	  can manage. Virtual interrupt numbers are what you see in
+	  /proc/interrupts. If you configure your system to have too few,
+	  drivers will fail to load or worse - handle with care.
+
+source "init/Kconfig"
+
+# Use the generic interrupt handling code in kernel/irq/
+
+source "kernel/Kconfig.freezer"
+
+config CMDLINE_BOOL
+	bool "Default bootloader kernel arguments"
+
+config CMDLINE
+	string "Kernel command line"
+	depends on CMDLINE_BOOL
+	default "console=ttyS0,57600"
+	help
+	  On some architectures there is currently no way for the boot loader
+	  to pass arguments to the kernel. For these architectures, you should
+	  supply some command-line options at build time by entering them
+	  here.
+
+config CMDLINE_FORCE
+	bool "Force default kernel command string"
+	depends on CMDLINE_BOOL
+	default n
+	help
+	  Set this to have arguments from the default kernel command string
+	  override those passed by the boot loader.
+
+config CPU_BIG_ENDIAN
+	bool "Build big-endian kernel"
+	default n
+	help
+	  Say Y if you plan on running a kernel in big-endian mode.
+	  Note that your board must be properly built and your board
+	  port must properly enable any big-endian related features
+	  of your chipset/board/processor.
+
+config FORCE_MAX_ZONEORDER
+	int
+	default "13"
+
+menu "Processor type and features"
+
+config TMS320C64XPLUS
+	bool "TMS320C64X+"
+
+source "arch/c6x/platforms/Kconfig"
+
+config TMS320C6X_CACHES_ON
+	bool "L2 cache support"
+	default y
+
+config KERNEL_RAM_BASE_ADDRESS
+	hex "Virtual address of memory base"
+	default 0xe0000000 if SOC_TMS320C6455
+	default 0xe0000000 if SOC_TMS320C6457
+	default 0xe0000000 if SOC_TMS320C6472
+	default 0x80000000
+
+source "mm/Kconfig"
+
+source "kernel/Kconfig.preempt"
+
+source "kernel/Kconfig.hz"
+source "kernel/time/Kconfig"
+
+endmenu
+
+menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
+
+config PCI
+	bool "PCI support"
+	help
+	  Support for PCI bus.
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
+source "security/Kconfig"
+
+source "crypto/Kconfig"
+
+source "lib/Kconfig"
+
+source "arch/c6x/Kconfig.debug"
diff --git a/arch/c6x/Kconfig.debug b/arch/c6x/Kconfig.debug
new file mode 100644
index 0000000..2a07d84
--- /dev/null
+++ b/arch/c6x/Kconfig.debug
@@ -0,0 +1,14 @@
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
+
+config ACCESS_CHECK
+	bool "Check the user pointer address"
+	default y
+	help
+	  Usually the pointer transfer from user space is checked to see if its
+	  address is in the kernel space.
+
+	  Say N here to disable that check to improve the performance.
+
+endmenu
diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
new file mode 100644
index 0000000..00fd050
--- /dev/null
+++ b/arch/c6x/Makefile
@@ -0,0 +1,56 @@
+#
+# linux/arch/c6x/Makefile
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+
+cflags-y := -D__linux__ -D__TMS320C6X__
+
+cflags-$(CONFIG_TMS320C64XPLUS) += -D__TMS320C6XPLUS__ -march=c64x+
+
+cflags-y += -mno-dsbt -msdata=none
+
+cflags-$(CONFIG_BIG_KERNEL) += -mlong-calls
+
+CFLAGS_MODULE   += -mlong-calls -mno-dsbt -msdata=none
+
+KBUILD_CFLAGS   += $(cflags-y)
+KBUILD_AFLAGS   += $(cflags-y)
+
+ifdef CONFIG_CPU_BIG_ENDIAN
+KBUILD_CFLAGS   += -mbig-endian
+KBUILD_AFLAGS	+= -mbig-endian
+LINKFLAGS	+= -mbig-endian
+KBUILD_LDFLAGS	+= -mbig-endian
+LDFLAGS	+= -EB
+endif
+
+head-y		:= arch/c6x/kernel/head.o
+core-y		+= arch/c6x/kernel/ arch/c6x/mm/ arch/c6x/platforms/
+libs-y		+= arch/c6x/lib/
+
+# Default to vmlinux.bin, override when needed
+all: vmlinux.bin
+
+boot := arch/$(ARCH)/boot
+
+# With make 3.82 we cannot mix normal and wildcard targets
+BOOT_TARGETS1 = vmlinux.bin
+BOOT_TARGETS2 = dtbImage.%
+
+$(BOOT_TARGETS1): vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+$(BOOT_TARGETS2): vmlinux
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+define archhelp
+  @echo '  *_defconfig     - Select default config from arch/$(ARCH)/configs'
+  @echo '  vmlinux.bin     - Binary kernel image (arch/$(ARCH)/boot/vmlinux.bin)'
+  @echo '  dtbImage.<dt>   - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
+  @echo '                  - stripped elf with fdt blob'
+endef
diff --git a/arch/c6x/boot/Makefile b/arch/c6x/boot/Makefile
new file mode 100644
index 0000000..0ea47f6
--- /dev/null
+++ b/arch/c6x/boot/Makefile
@@ -0,0 +1,22 @@
+#
+# Makefile for bootable kernel images
+#
+
+all: $(obj)/vmlinux.bin
+
+hostprogs-y := install-dtb
+
+$(obj)/vmlinux.bin: vmlinux
+	$(OBJCOPY) -O binary $< $@
+
+
+$(obj)/dtbImage.%: vmlinux $(obj)/install-dtb $(obj)/%.dtb
+	cp vmlinux $@
+	$(obj)/install-dtb $(obj)/$*.dtb $@
+
+clean-files := $(obj)/*.dtb
+
+DTC_FLAGS ?= -p 1024
+
+$(obj)/%.dtb: $(src)/dts/%.dts FORCE
+	$(call cmd,dtc)
diff --git a/arch/c6x/configs/dsk6455_defconfig b/arch/c6x/configs/dsk6455_defconfig
new file mode 100644
index 0000000..2113395
--- /dev/null
+++ b/arch/c6x/configs/dsk6455_defconfig
@@ -0,0 +1,39 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_FUTEX is not set
+# CONFIG_SLUB_DEBUG is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=17000
+CONFIG_MISC_DEVICES=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_CRC16=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/c6x/configs/evmc6457_defconfig b/arch/c6x/configs/evmc6457_defconfig
new file mode 100644
index 0000000..d2eff63
--- /dev/null
+++ b/arch/c6x/configs/evmc6457_defconfig
@@ -0,0 +1,40 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_FUTEX is not set
+# CONFIG_SLUB_DEBUG is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+CONFIG_BOARD_EVM6457=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=17000
+CONFIG_MISC_DEVICES=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_CRC16=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/c6x/configs/evmc6472_defconfig b/arch/c6x/configs/evmc6472_defconfig
new file mode 100644
index 0000000..aa81c58
--- /dev/null
+++ b/arch/c6x/configs/evmc6472_defconfig
@@ -0,0 +1,41 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_FUTEX is not set
+# CONFIG_SLUB_DEBUG is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+# CONFIG_CMDLINE_FORCE is not set
+CONFIG_BOARD_EVM6472=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=17000
+CONFIG_MISC_DEVICES=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_CRC16=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/c6x/configs/evmc6474_defconfig b/arch/c6x/configs/evmc6474_defconfig
new file mode 100644
index 0000000..ceee6fc
--- /dev/null
+++ b/arch/c6x/configs/evmc6474_defconfig
@@ -0,0 +1,41 @@
+CONFIG_EXPERIMENTAL=y
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_SYSVIPC=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_NAMESPACES=y
+# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_FUTEX is not set
+# CONFIG_SLUB_DEBUG is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+# CONFIG_CMDLINE_FORCE is not set
+CONFIG_BOARD_EVM6474=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=17000
+CONFIG_MISC_DEVICES=y
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_CRC16=y
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
new file mode 100644
index 0000000..b2d4a05
--- /dev/null
+++ b/arch/c6x/include/asm/Kbuild
@@ -0,0 +1,54 @@
+include include/asm-generic/Kbuild.asm
+
+generic-y += atomic.h
+generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += bug.h
+generic-y += bugs.h
+generic-y += cputime.h
+generic-y += current.h
+generic-y += device.h
+generic-y += div64.h
+generic-y += emergency-restart.h
+generic-y += errno.h
+generic-y += fb.h
+generic-y += fcntl.h
+generic-y += futex.h
+generic-y += hw_irq.h
+generic-y += io.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += irq_regs.h
+generic-y += kdebug.h
+generic-y += kmap_types.h
+generic-y += local.h
+generic-y += mman.h
+generic-y += mmu_context.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += pci.h
+generic-y += percpu.h
+generic-y += pgalloc.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += scatterlist.h
+generic-y += segment.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += siginfo.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += tlbflush.h
+generic-y += topology.h
+generic-y += types.h
+generic-y += ucontext.h
+generic-y += user.h
+generic-y += vga.h
diff --git a/arch/c6x/kernel/Makefile b/arch/c6x/kernel/Makefile
new file mode 100644
index 0000000..794ac08
--- /dev/null
+++ b/arch/c6x/kernel/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for arch/c6x/kernel/
+#
+
+extra-y	 := head.o vmlinux.lds
+
+obj-y 	 := process.o traps.o irq.o signal.o ptrace.o \
+	    setup.o sys_c6x.o time.o devicetree.o \
+            switch_to.o entry.o vectors.o c6x_ksyms.o\
+	    soc.o
+
+obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
new file mode 100644
index 0000000..6c5686d
--- /dev/null
+++ b/arch/c6x/kernel/vmlinux.lds.S
@@ -0,0 +1,165 @@
+/*
+ * ld script for the c6x kernel
+ *
+ *  Copyright (C) 2010, 2011 Texas Instruments Incorporated
+ *  Mark Salter <msalter@redhat.com>
+ */
+#define __VMLINUX_LDS__
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/thread_info.h>
+#include <asm/page.h>
+
+ENTRY(_c_int00)
+
+#if defined(CONFIG_CPU_BIG_ENDIAN)
+jiffies = jiffies_64 + 4;
+#else
+jiffies = jiffies_64;
+#endif
+
+#define	READONLY_SEGMENT_START	\
+	. = PAGE_OFFSET;
+#define	READWRITE_SEGMENT_START	\
+	. = ALIGN(128);		\
+	_data_lma = .;
+
+SECTIONS
+{
+	/*
+	 * Start kernel read only segment
+	 */
+	READONLY_SEGMENT_START
+
+	.vectors :
+	{
+		VMLINUX_SYMBOL(_vectors_start) = .;
+		*(.vectors)
+		. = ALIGN(0x400);
+		VMLINUX_SYMBOL(_vectors_end) = .;
+	}
+
+	. = ALIGN(0x1000);
+	.cmdline : { *(.cmdline) }
+
+	/*
+	 * This section contains data which may be shared with other
+	 * cores. It needs to be a fixed offset from PAGE_OFFSET
+	 * regardless of kernel configuration.
+	 */
+	.virtio_ipc_dev : { *(.virtio_ipc_dev) }
+
+	. = ALIGN(PAGE_SIZE);
+	.init :
+	{
+		VMLINUX_SYMBOL(_stext) = .;
+		VMLINUX_SYMBOL(_sinittext) = .;
+		HEAD_TEXT
+		INIT_TEXT
+		VMLINUX_SYMBOL(_einittext) = .;
+	}
+
+	VMLINUX_SYMBOL(__init_begin) = VMLINUX_SYMBOL(_stext);
+	INIT_DATA_SECTION(16)
+
+	PERCPU_SECTION(128)
+
+	. = ALIGN(8);
+	.machine.desc : AT(ADDR(.machine.desc) - LOAD_OFFSET) {
+		__machine_desc_start = . ;
+		*(.machine.desc)
+		__machine_desc_end = . ;
+	}
+
+	. = ALIGN(PAGE_SIZE);
+	VMLINUX_SYMBOL(__init_end) = .;
+
+	.text :
+	{
+		VMLINUX_SYMBOL(_text) = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		LOCK_TEXT
+		IRQENTRY_TEXT
+		KPROBES_TEXT
+		*(.fixup)
+		*(.gnu.warning)
+	}
+
+	EXCEPTION_TABLE(16)
+	NOTES
+
+	RO_DATA_SECTION(PAGE_SIZE)
+	.const :
+	{
+		*(.const .const.* .gnu.linkonce.r.*)
+		*(.switch)
+	}
+
+	. = ALIGN (8) ;
+	__fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
+		_fdt_start = . ;	/* place for fdt blob */
+		*(__fdt_blob) ;		/* Any link-placed DTB */
+		BYTE(0);		/* section always has contents */
+	        . = _fdt_start + 0x4000;	/* Pad up to 16kbyte */
+		_fdt_end = . ;
+	}
+
+	VMLINUX_SYMBOL(_etext) = .;
+
+	/*
+	 * Start kernel read-write segment.
+	 */
+	READWRITE_SEGMENT_START
+	VMLINUX_SYMBOL(_sdata) = .;
+
+	.fardata : AT(ADDR(.fardata) - LOAD_OFFSET)
+	{
+		INIT_TASK_DATA(THREAD_SIZE)
+		NOSAVE_DATA
+		PAGE_ALIGNED_DATA(PAGE_SIZE)
+		CACHELINE_ALIGNED_DATA(128)
+		READ_MOSTLY_DATA(128)
+		DATA_DATA
+		CONSTRUCTORS
+		*(.data1)
+		*(.fardata .fardata.*)
+		*(.data.debug_bpt)
+	}
+
+	.neardata ALIGN(8) : AT(ADDR(.neardata) - LOAD_OFFSET)
+	{
+		*(.neardata2 .neardata2.* .gnu.linkonce.s2.*)
+		*(.neardata .neardata.* .gnu.linkonce.s.*)
+		. = ALIGN(8);
+	}
+
+	VMLINUX_SYMBOL(_edata) = .;
+
+	VMLINUX_SYMBOL(__bss_start) = .;
+	SBSS(8)
+	BSS(8)
+	.far :
+	{
+		. = ALIGN(8);
+		*(.dynfar)
+		*(.far .far.* .gnu.linkonce.b.*)
+		. = ALIGN(8);
+	}
+	VMLINUX_SYMBOL(__bss_stop) = .;
+	VMLINUX_SYMBOL(__bss_stop) = .;
+
+	VMLINUX_SYMBOL(_end) = .;
+
+	STABS_DEBUG
+
+	DWARF_DEBUG
+
+	/DISCARD/ : {
+		  EXIT_TEXT
+		  EXIT_DATA
+		  EXIT_CALL
+		  *(.discard)
+		  *(.discard.*)
+		  *(.interp)
+	}
+}
diff --git a/arch/c6x/lib/Makefile b/arch/c6x/lib/Makefile
new file mode 100644
index 0000000..c240add
--- /dev/null
+++ b/arch/c6x/lib/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for arch/c6x/lib/
+#
+
+lib-y  := divu.o divi.o pop_rts.o push_rts.o remi.o remu.o strasgi.o llshru.o \
+	  llshr.o llshl.o negll.o mpyll.o divull.o divremi.o divremu.o
+
+lib-$(CONFIG_TMS320C64XPLUS) += csum_64plus.o memcpy_64plus.o strasgi_64plus.o
diff --git a/arch/c6x/mm/Makefile b/arch/c6x/mm/Makefile
new file mode 100644
index 0000000..75bf2af
--- /dev/null
+++ b/arch/c6x/mm/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for the linux c6x-specific parts of the memory manager.
+#
+# Note! Dependencies are done automagically by 'make dep', which also
+# removes any old dependencies. DON'T put your own dependencies here
+# unless it's something special (ie not a .c file).
+#
+# Note 2! The CFLAGS definition is now in the main makefile...
+
+obj-y	 := init.o dma-coherent.o
diff --git a/arch/c6x/platforms/Kconfig b/arch/c6x/platforms/Kconfig
new file mode 100644
index 0000000..a6ae90a
--- /dev/null
+++ b/arch/c6x/platforms/Kconfig
@@ -0,0 +1,45 @@
+
+config SOC_TMS320C6455
+	bool "TMS320C6455"
+	default n
+	select TMS320C64XPLUS
+
+config SOC_TMS320C6457
+	bool "TMS320C6457"
+	default n
+	select TMS320C64XPLUS
+
+config SOC_TMS320C6472
+	bool "TMS320C6472"
+	default n
+	select TMS320C64XPLUS
+
+config SOC_TMS320C6474
+	bool "TMS320C6474"
+	default n
+	select TMS320C64XPLUS
+
+comment "Board Selection"
+choice
+	prompt "Board"
+	help
+	  This option specifies the specific board for which the kernel will be
+	  compiled.
+
+config BOARD_DSK6455
+	bool "DSK6455"
+	select SOC_TMS320C6455
+
+config BOARD_EVM6457
+	bool "EVM6472"
+	select SOC_TMS320C6457
+
+config BOARD_EVM6472
+	bool "EVM6472"
+	select SOC_TMS320C6472
+
+config BOARD_EVM6474
+	bool "EVM6474"
+	select SOC_TMS320C6474
+
+endchoice
diff --git a/arch/c6x/platforms/Makefile b/arch/c6x/platforms/Makefile
new file mode 100644
index 0000000..8703570
--- /dev/null
+++ b/arch/c6x/platforms/Makefile
@@ -0,0 +1,19 @@
+#
+# Makefile for arch/c6x/platforms
+#
+# Copyright 2010, 2011 Texas Instruments Incorporated
+#
+
+obj-y = cache.o megamod-pic.o pll.o plldata.o timer64.o
+
+# SoC objects
+obj-$(CONFIG_SOC_TMS320C6455)	+= soc-6455.o emif.o
+obj-$(CONFIG_SOC_TMS320C6457)	+= soc-6457.o emif.o psc.o
+obj-$(CONFIG_SOC_TMS320C6472)	+= soc-6472.o psc.o
+obj-$(CONFIG_SOC_TMS320C6474)	+= soc-6474.o psc.o
+
+# Board objects
+obj-$(CONFIG_BOARD_DSK6455)  += board-dsk6455.o
+obj-$(CONFIG_BOARD_EVM6457)  += board-evm6457.o
+obj-$(CONFIG_BOARD_EVM6472)  += board-evm6472.o
+obj-$(CONFIG_BOARD_EVM6474)  += board-evm6474.o
-- 
1.7.6
