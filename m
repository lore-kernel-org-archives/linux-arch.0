From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 04/24] C6X: build infrastructure
Date: Tue, 9 Aug 2011 21:17:03 +0200
Message-ID: <20110809191702.GA18124@merkur.ravnborg.org>
References: <1312839879-13592-1-git-send-email-msalter@redhat.com> <1312839879-13592-5-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:61065 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab1HITRF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Aug 2011 15:17:05 -0400
Content-Disposition: inline
In-Reply-To: <1312839879-13592-5-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

Hi Mark.

Some review feedback.

> diff --git a/arch/c6x/Kconfig b/arch/c6x/Kconfig
> new file mode 100644
> index 0000000..9205d5c
> --- /dev/null
> +++ b/arch/c6x/Kconfig
> @@ -0,0 +1,180 @@
> +#
> +# For a description of the syntax of this configuration file,
> +# see Documentation/kbuild/kconfig-language.txt.
> +#
> +
> +config TMS320C6X
> +	def_bool y
> +	select CLKDEV_LOOKUP
> +	select HAVE_MEMBLOCK
> +	select HAVE_SPARSE_IRQ
> +	select GENERIC_IRQ_SHOW
> +	select HAVE_GENERIC_HARDIRQS
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
> +	select GENERIC_HARDIRQS_NO__DO_IRQ
> +	select GENERIC_HARDIRQS_NO_DEPRECATED
> +	select GENERIC_FIND_FIRST_BIT
> +	select GENERIC_FIND_NEXT_BIT
> +	select GENERIC_FIND_LAST_BIT
> +	select GENERIC_FIND_BIT_LE
> +	select OF
> +	select OF_EARLY_FLATTREE

I recommend to keep the above list sorted alphabetically - to minimize merge conflicts.
But alas no-one follows this recommendation - but this should not prevent you from doing so.


> +config GENERIC_FIND_NEXT_BIT
> +	def_bool y

Commit: 63e424c84429903c92a0f1e9654c31ccaf6694d0 removed use of
GENERIC_FIND_*.
They also need to be removed from the select above - all
og GENERIC_FIND_*


> +config BIG_KERNEL
> +	bool "Build a big kernel"
> +	help
> +	  The C6X function call instruction has a limited range of +/- 2MiB.
> +	  This is sufficient for most kernels, but some kernel configurations
> +	  with lots of compiled-in functionality may require a larger range
> +	  for function calls. Use this option to have the compiler generate
> +	  function calls with 32-bit range. This will make the kernel both
> +	  larger and slower.
> +
> +	  If unsure, say N.

To preserve namespace please prefix all C6X specific config symbols with C6X_.
This is true for several symbols.
Btw. I was briefly thinking on BKL when I saw this one :-)

> +config FORCE_MAX_ZONEORDER
> +	int
> +	default "13"
help text is missing. This is the case for several options.

If it is obvious for you what it is - then it should be simple to
write a few lines about it.

> +
> +menu "Bus options (PCI, PCMCIA, EISA, MCA, ISA)"
> +
> +config PCI
> +	bool "PCI support"
> +	help
> +	  Support for PCI bus.
> +endmenu
I expect you to drop this.
But in general do not refer to stuff that is not valid for your arch.
I guess you do not have ISA either.

> +source "arch/c6x/Kconfig.debug"
> diff --git a/arch/c6x/Kconfig.debug b/arch/c6x/Kconfig.debug
> new file mode 100644
> index 0000000..2a07d84
> --- /dev/null
> +++ b/arch/c6x/Kconfig.debug
> @@ -0,0 +1,14 @@
> +menu "Kernel hacking"
> +
> +source "lib/Kconfig.debug"
> +
> +config ACCESS_CHECK
> +	bool "Check the user pointer address"
> +	default y
> +	help
> +	  Usually the pointer transfer from user space is checked to see if its
> +	  address is in the kernel space.
> +
> +	  Say N here to disable that check to improve the performance.
> +
> +endmenu

No need for a dedicated Kconfig.debug file for a single option.


> diff --git a/arch/c6x/Makefile b/arch/c6x/Makefile
> new file mode 100644
> index 0000000..00fd050
> --- /dev/null
> +++ b/arch/c6x/Makefile
> @@ -0,0 +1,56 @@
> +#
> +# linux/arch/c6x/Makefile
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +
> +cflags-y := -D__linux__ -D__TMS320C6X__
> +
> +cflags-$(CONFIG_TMS320C64XPLUS) += -D__TMS320C6XPLUS__ -march=c64x+
> +
> +cflags-y += -mno-dsbt -msdata=none
> +
> +cflags-$(CONFIG_BIG_KERNEL) += -mlong-calls
> +
> +CFLAGS_MODULE   += -mlong-calls -mno-dsbt -msdata=none
> +
> +KBUILD_CFLAGS   += $(cflags-y)
> +KBUILD_AFLAGS   += $(cflags-y)

I am missing sparse support:

CHECKFLAGS += ...


> +
> +ifdef CONFIG_CPU_BIG_ENDIAN
> +KBUILD_CFLAGS   += -mbig-endian
> +KBUILD_AFLAGS	+= -mbig-endian
> +LINKFLAGS	+= -mbig-endian
> +KBUILD_LDFLAGS	+= -mbig-endian
> +LDFLAGS	+= -EB

Mixed use of tabs and space for indent.
As tabs has special semantic in Makefile avoid using
tabs for indent. I personally restrain from using tabs
in Makefile due to this. But this is a personal thing.
Do what you prefer - but be consistent.


> +endif
> +
> +head-y		:= arch/c6x/kernel/head.o
> +core-y		+= arch/c6x/kernel/ arch/c6x/mm/ arch/c6x/platforms/
> +libs-y		+= arch/c6x/lib/
> +
> +# Default to vmlinux.bin, override when needed
> +all: vmlinux.bin
> +
> +boot := arch/$(ARCH)/boot
> +
> +# With make 3.82 we cannot mix normal and wildcard targets
> +BOOT_TARGETS1 = vmlinux.bin
> +BOOT_TARGETS2 = dtbImage.%
> +
> +$(BOOT_TARGETS1): vmlinux
> +	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
> +$(BOOT_TARGETS2): vmlinux
> +	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)

No need for the two BOOT_TARGETS variables. We try to be explicit when we can.
But you need to add both rules due to make semantics as you also
document.


> +
> +archclean:
> +	$(Q)$(MAKE) $(clean)=$(boot)
> +
> +define archhelp
> +  @echo '  *_defconfig     - Select default config from arch/$(ARCH)/configs'
> +  @echo '  vmlinux.bin     - Binary kernel image (arch/$(ARCH)/boot/vmlinux.bin)'
> +  @echo '  dtbImage.<dt>   - ELF image with $(arch)/boot/dts/<dt>.dts linked in'
> +  @echo '                  - stripped elf with fdt blob'
> +endef

*_defconfig is already covered by the normal "make help" - no need to add them twice.


> diff --git a/arch/c6x/boot/Makefile b/arch/c6x/boot/Makefile
> new file mode 100644
> index 0000000..0ea47f6
> --- /dev/null
> +++ b/arch/c6x/boot/Makefile
> @@ -0,0 +1,22 @@
> +#
> +# Makefile for bootable kernel images
> +#
> +
> +all: $(obj)/vmlinux.bin
You never pass the "all" target to the boot makefile - so this line can be dropped.

> +
> +hostprogs-y := install-dtb
> +
> +$(obj)/vmlinux.bin: vmlinux
> +	$(OBJCOPY) -O binary $< $@

See how x86 handle objcopy.
This is a much nicer output.

> +
> +
> +$(obj)/dtbImage.%: vmlinux $(obj)/install-dtb $(obj)/%.dtb
> +	cp vmlinux $@
> +	$(obj)/install-dtb $(obj)/$*.dtb $@

This can be made nicer to using more kbuild support.


> +
> +clean-files := $(obj)/*.dtb
> +
> +DTC_FLAGS ?= -p 1024
> +
> +$(obj)/%.dtb: $(src)/dts/%.dts FORCE
> +	$(call cmd,dtc)

> diff --git a/arch/c6x/kernel/Makefile b/arch/c6x/kernel/Makefile
> new file mode 100644
> index 0000000..794ac08
> --- /dev/null
> +++ b/arch/c6x/kernel/Makefile
> @@ -0,0 +1,12 @@
> +#
> +# Makefile for arch/c6x/kernel/
> +#
> +
> +extra-y	 := head.o vmlinux.lds
> +
> +obj-y 	 := process.o traps.o irq.o signal.o ptrace.o \
> +	    setup.o sys_c6x.o time.o devicetree.o \
> +            switch_to.o entry.o vectors.o c6x_ksyms.o\
> +	    soc.o

Everyone and their cousins seems to like the style with
continued lines in Makefile.
But using the following is IMO more readable and less errorprone:

obj-y := process.o traps.o irq.o signal.o ptrace.o
obj-y += setup.o sys_c6x.o time.o devicetree.o
obj-y += switch_to.o entry.o vectors.o c6x_ksyms.o
obj-y += soc.o

Or maybe even like this:
obj-y += c6x_ksyms.o
obj-y += devicetree.o
obj-y += entry.o
obj-y += irq.o
obj-y += ptrace.o
obj-y := process.o
obj-y += setup.o
obj-y += signal.o
obj-y += soc.o
obj-y += sys_c6x.o
obj-y += switch_to.o
obj-y += traps.o
obj-y += time.o
obj-y += vectors.o

then there is room for a comment if you have something to say.
We use the "one assignment per line" in many places. the
extra lines does not matter.


> +obj-$(CONFIG_MODULES)		+= module.o
> diff --git a/arch/c6x/kernel/vmlinux.lds.S b/arch/c6x/kernel/vmlinux.lds.S
> new file mode 100644
> index 0000000..6c5686d
> --- /dev/null
> +++ b/arch/c6x/kernel/vmlinux.lds.S
> @@ -0,0 +1,165 @@
> +/*
> + * ld script for the c6x kernel
> + *
> + *  Copyright (C) 2010, 2011 Texas Instruments Incorporated
> + *  Mark Salter <msalter@redhat.com>
> + */
> +#define __VMLINUX_LDS__
I do not see this used - can it be deleted?

> +#include <asm-generic/vmlinux.lds.h>
> +#include <asm/thread_info.h>
> +#include <asm/page.h>
> +
> +ENTRY(_c_int00)
> +
> +#if defined(CONFIG_CPU_BIG_ENDIAN)
> +jiffies = jiffies_64 + 4;
> +#else
> +jiffies = jiffies_64;
> +#endif
> +
> +#define	READONLY_SEGMENT_START	\
> +	. = PAGE_OFFSET;
> +#define	READWRITE_SEGMENT_START	\
> +	. = ALIGN(128);		\
> +	_data_lma = .;
> +
> +SECTIONS
> +{
> +	/*
> +	 * Start kernel read only segment
> +	 */
> +	READONLY_SEGMENT_START
> +
> +	.vectors :
> +	{
> +		VMLINUX_SYMBOL(_vectors_start) = .;
> +		*(.vectors)
> +		. = ALIGN(0x400);
> +		VMLINUX_SYMBOL(_vectors_end) = .;
> +	}
You can drop VMLINUX_SYMBOL in the arch specific part
of vmlinux.lds.h - it is invented for the braindead tool-chains that
add an "_" in front of all symbols.

If you insist on using VMLINUX_SYMBOL then be consistent.
It is not used for __machine_desc_start



> +
> +	. = ALIGN(0x1000);
> +	.cmdline : { *(.cmdline) }

Please follow C syntax - like this:

	.cmdline : {
		*(.cmdline)
	}

This is what we do in (almost) all linker scripts these days.
And consistensy is a good thing here.


> +
> +	/*
> +	 * This section contains data which may be shared with other
> +	 * cores. It needs to be a fixed offset from PAGE_OFFSET
> +	 * regardless of kernel configuration.
> +	 */
> +	.virtio_ipc_dev : { *(.virtio_ipc_dev) }
C style.

> +
> +
> +	STABS_DEBUG
> +
> +	DWARF_DEBUG

Is STABS _and_ DWARF both required?
Not a big deal - but is STABS is not supported by your tool-chain
then drop it.

> +	/DISCARD/ : {
> +		  EXIT_TEXT
> +		  EXIT_DATA
> +		  EXIT_CALL
> +		  *(.discard)
> +		  *(.discard.*)
> +		  *(.interp)
> +	}

I assume you did not use DISCARDS due to "*(.interp)".

> +# Makefile for arch/c6x/lib/
> +#
> +
> +lib-y  := divu.o divi.o pop_rts.o push_rts.o remi.o remu.o strasgi.o llshru.o \
> +	  llshr.o llshl.o negll.o mpyll.o divull.o divremi.o divremu.o
Multi line..
> +
> +lib-$(CONFIG_TMS320C64XPLUS) += csum_64plus.o memcpy_64plus.o strasgi_64plus.o
> diff --git a/arch/c6x/mm/Makefile b/arch/c6x/mm/Makefile
> new file mode 100644
> index 0000000..75bf2af
> --- /dev/null
> +++ b/arch/c6x/mm/Makefile
> @@ -0,0 +1,10 @@
> +#
> +# Makefile for the linux c6x-specific parts of the memory manager.
> +#
> +# Note! Dependencies are done automagically by 'make dep', which also
> +# removes any old dependencies. DON'T put your own dependencies here
> +# unless it's something special (ie not a .c file).
> +#
> +# Note 2! The CFLAGS definition is now in the main makefile...
Kill obsolete comments.


> +
> +obj-y	 := init.o dma-coherent.o


	Sam
