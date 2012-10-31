From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Wed, 31 Oct 2012 20:35:03 +0100
Message-ID: <20121031193503.GA4640@merkur.ravnborg.org>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-13-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:52608 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759678Ab2JaTfG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 31 Oct 2012 15:35:06 -0400
Content-Disposition: inline
In-Reply-To: <1351700061-7203-13-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

Hi James.

Some random comments below.
Two general comments.
1) This patch should be the last one - as this enables build of this architecture.
2) this patch should not contain changes to files outside metag
3) there seems to be confusion if the shorthand is meta or metag.
   Please fix it up so metag is used everywhere.

	Sam

> 
> diff --git a/arch/metag/Kconfig b/arch/metag/Kconfig
> new file mode 100644
> index 0000000..3a19cb6
> --- /dev/null
> +++ b/arch/metag/Kconfig
> @@ -0,0 +1,292 @@
> +config SYMBOL_PREFIX
> +	string
> +	default "_"
> +
> +config METAG
> +	def_bool y
> +	select EMBEDDED
> +	select HAVE_64BIT_ALIGNED_STRUCT
> +	select HAVE_MEMBLOCK
> +	select HAVE_MEMBLOCK_NODE_MAP
> +	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_IRQ_WORK
> +	select HAVE_KERNEL_GZIP
> +	select HAVE_KERNEL_BZIP2
> +	select HAVE_KERNEL_LZMA
> +	select HAVE_KERNEL_XZ
> +	select HAVE_KERNEL_LZO
> +	select HAVE_SYSCALL_TRACEPOINTS
> +	select HAVE_GENERIC_HARDIRQS
> +	select GENERIC_ATOMIC64
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_IRQ_SHOW
> +	select GENERIC_SMP_IDLE_THREAD
> +	select IRQ_DOMAIN
> +	select OF
> +	select OF_EARLY_FLATTREE
Sorting these in alphabetic order avoid merge issues later.

> +	help
> +	  Imagination Technologies Meta processors are a family of multi-
> +	  threaded DSPs designed for embedded systems.
This help entry is not visible in KConfig - just add it as a comment above the config symbol.


> +config IRQ_PER_CPU
> +	def_bool y
This looks obsolete / unused in mainline kernel.

> +config MMU
> +	def_bool y
> +
> +config STACK_GROWSUP
> +	def_bool y
> +
> +config HOTPLUG_CPU
> +	bool "Enable CPU hotplug support"
> +	depends on SMP && HOTPLUG
Today HOTPLUG is always y so the HOTPLUG dependency is not needed.

> +
> +config HIGHMEM
> +	bool "High Memory Support"
> +	depends on MMU

MMU is always y as per above - so the MMU dependeny is not neeeded.

> +	help
> +	  The address space of Meta processors is only 4 Gigabytes large
> +	  and it has to accommodate user address space, kernel address
> +	  space as well as some memory mapped IO. That means that, if you
> +	  have a large amount of physical memory and/or IO, not all of the
> +	  memory can be "permanently mapped" by the kernel. The physical
> +	  memory that is not permanently mapped is called "high memory".
> +
> +	  Depending on the selected kernel/user memory split, minimum
> +	  vmalloc space and actual amount of RAM, you may not need this
> +	  option which should result in a slightly faster kernel.
> +
> +	  If unsure, say n.
> +
> +source "arch/metag/mm/Kconfig"
> +
> +source "arch/metag/Kconfig.soc"
> +
> +config META12
> +	bool
> +	---help---
> +	  Select this from the SoC config symbol to indicate that it contains a
> +	  Meta 1.2 core.
It would be good to have all METAG (or is it META) symbol perfixed with
the same text. Such as METAG_META12 etc.
General comment!



> +
> +config META21
> +	bool
> +	---help---
> +	  Select this from the SoC config symbol to indicate that it contains a
> +	  Meta 2.1 core.
Today we have larely moved away from ---help--- and uses the shorter help
---help--- has 2290 hits
help       has 7841 hits


> +config SMP
> +	bool "Symmetric multi-processing support"
> +	depends on META21
> +	select USE_GENERIC_SMP_HELPERS
> +	---help---
> +	  This enables support for systems with more than one thread running
> +	  Linux. If you have a system with only one thread running Linux,
> +	  say N. Otherwise, say Y.
> +
> +config NR_CPUS
> +	int "Maximum number of CPUs (2-4)" if SMP
> +	range 2 4 if SMP
> +	default "1" if !SMP
> +	default "4" if SMP
> +
> +config SMP_WRITE_REORDERING
> +	bool
> +	---help---
> +	  This attempts to prevent cache-memory incoherence due to external
> +	  reordering of writes from different hardware threads when SMP is
> +	  enabled. It adds fences (system event 0) to smp_mb and smp_rmb in an
> +	  attempt to catch some of the cases, and also before writes to shared
> +	  memory in LOCK1 protected atomics and spinlocks.
> +	  This will not completely prevent cache incoherency on affected cores.
> +
> +config LNKGET_AROUND_CACHE
> +	bool
> +	depends on META21
> +	---help---
> +	  This indicates that the LNKGET/LNKSET instructions go around the
> +	  cache, which requires some extra cache flushes when the memory needs
> +	  to be accessed by normal GET/SET instructions too.
> +
> +choice
> +	prompt "Atomicity primitive"
> +	default ATOMICITY_LNKGET
> +	---help---
> +	  This option selects the mechanism for performing atomic operations.
> +
> +config ATOMICITY_IRQSOFF
> +	depends on !SMP
> +	bool "irqsoff"
> +	---help---
> +	  This option disables interrupts to achieve atomicity. This mechanism
> +	  is not SMP-safe.
> +
> +config ATOMICITY_LNKGET
> +	depends on META21
> +	bool "lnkget/lnkset"
> +	---help---
> +	  This option uses the LNKGET and LNKSET instructions to achieve
> +	  atomicity. LNKGET/LNKSET are load-link/store-conditional instructions.
> +	  Choose this option if your system requires low latency.
> +
> +config ATOMICITY_LOCK1
> +	depends on SMP
> +	bool "lock1"
> +	---help---
> +	  This option uses the LOCK1 instruction for atomicity. This is mainly
> +	  provided as a debugging aid if the lnkget/lnkset atomicity primitive
> +	  isn't working properly.
> +
> +endchoice
> +
> +config META_FPU
> +	bool "FPU Support"
> +	depends on META21
> +	default y
> +	help
> +	  This option allows processes to use FPU hardware available with this
> +	  CPU. If this option is not enabled FPU registers will not be saved
> +	  and restored on context-switch.
> +
> +	  If you plan on running programs which are compiled to use hard floats
> +	  say Y here.
> +
> +config META_DSP
> +	bool "DSP Support"
> +	help
> +	  This option allows processes to use DSP hardware available
> +	  with this CPU. If this option is not enabled DSP registers
> +	  will not be saved and restored on context-switch.
> +
> +	  If you plan on running DSP programs say Y here.
> +
> +config META_PERFCOUNTER_IRQS
> +	bool "PerfCounters interrupt support"
> +	depends on META21
> +	help
> +	  This option enables using interrupts to collect information from
> +	  Performance Counters. This option is supported in new META21
> +	  (starting from HTP265).
> +
> +	  When disabled, Performance Counters information will be collected
> +	  based on Timer Interrupt.
> +
> +menu "Boot options"


Can we use the common config symbols here?
CMDLINE, CMDLINE_OVERWRITE, CMDLINE_BOOL etc.

> +
> +config METAG_CMDLINE_BOOL
> +	bool "Built-in kernel command line"
> +	---help---
> +	  Allow for specifying boot arguments to the kernel at
> +	  build time.  On some systems (e.g. embedded ones), it is
> +	  necessary or convenient to provide some or all of the
> +	  kernel boot arguments with the kernel itself (that is,
> +	  to not rely on the boot loader to provide them.)
> +
> +	  To compile command line arguments into the kernel,
> +	  set this option to 'Y', then fill in the
> +	  the boot arguments in CONFIG_METAG_CMDLINE.
> +
> +	  Systems with fully functional boot loaders (i.e. non-embedded)
> +	  should leave this option set to 'N'.
> +
> +config METAG_CMDLINE
> +	string "Built-in kernel command string"
> +	depends on METAG_CMDLINE_BOOL
> +	default ""
> +	---help---
> +	  Enter arguments here that should be compiled into the kernel
> +	  image and used at boot time.  If the boot loader provides a
> +	  command line at boot time, it is appended to this string to
> +	  form the full kernel command line, when the system boots.
> +
> +	  However, you can use the CONFIG_METAG_CMDLINE_OVERRIDE option to
> +	  change this behavior.
> +
> +	  In most cases, the command line (whether built-in or provided
> +	  by the boot loader) should specify the device for the root
> +	  file system.
> +
> +config METAG_CMDLINE_OVERRIDE
> +	bool "Built-in command line overrides boot loader arguments"
> +	depends on METAG_CMDLINE_BOOL
> +	---help---
> +	  Set this option to 'Y' to have the kernel ignore the boot loader
> +	  command line, and use ONLY the built-in command line.
> +
> +	  This is used to work around broken boot loaders.  This should
> +	  be set to 'N' under normal conditions.
> +
> +endmenu
> +
> +menu "Board support"
> +
> +endmenu
No point having an empty menu!?

> --- /dev/null
> +++ b/arch/metag/Makefile
> @@ -0,0 +1,90 @@
> +#
> +# metag/Makefile
> +#
> +# This file is included by the global makefile so that you can add your own
> +# architecture-specific flags and dependencies. Remember to do have actions
> +# for "archclean" cleaning up for this architecture.
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 1994 by Linus Torvalds
> +#               2007,2008,2012 by Imagination Technologies Ltd.
> +#
> +
> +LDFLAGS		:=
> +OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
> +
> +CHECKFLAGS-$(CONFIG_META12) += -DMETAC_1_2
> +CHECKFLAGS-$(CONFIG_META21) += -DMETAC_2_1

As a rule of thumb UPPERCASE is for exported stuff.
lower-case for local variables.

I would do it like this:
checkflags-$(CONFIG_META12) := -DMETAC_1_2
checkflags-$(CONFIG_META21) := -DMETAC_2_1
CHECKFLAGS   += -D__metag__ $(checkflags-y)

> +CHECKFLAGS	+= -D__metag__ $(CHECKFLAGS-y)
> +
> +KBUILD_DEFCONFIG := meta2_defconfig
> +
> +sflags-$(CONFIG_META12) += -mmetac=1.2
> +
> +ifeq ($(CONFIG_META12),y)
> +# Only use TBI API 1.4 if DSP is enabled for META12 cores
> +sflags-$(CONFIG_META_DSP) += -DTBI_1_4
> +endif
> +
> +sflags-$(CONFIG_META21) += -mmetac=2.1 -DTBI_1_4
> +
> +# Default SoC .c files
> +score-y  :=
> +
> +head-y := arch/metag/kernel/head.o
> +
> +core-y					+= arch/metag/kernel/ \
> +					   arch/metag/mm/

The abuse of \ in makefile in bad practice IMO.
The following is much more readable:

core-y += arch/metag/kernel/
core-y += arch/metag/mm/

Please fix this in all Makefile - if I can convince you.

> +
> +ifneq ($(score-y),)
> +core-y                                  += arch/metag/$(score-y)/
> +endif

How can score-y ever be non-empty?

> +
> +ifneq ($(machdir-y),)
> +core-y  += $(addprefix arch/metag/boards/, \
> +             $(filter-out ., $(patsubst %,%/,$(machdir-y))))
> +endif


Or like this:
machdirs := $(filter-out ., $(patsubst %,%/,$(machdir-y)))
core-y += $(addprefix arch/metag/boards/, $(machdirs))

I see no need to test if machdir-y is non-empty.


> new file mode 100644
> index 0000000..9f6fb26
> --- /dev/null
> +++ b/arch/metag/boot/Makefile
> @@ -0,0 +1,72 @@
> +#
> +# This file is subject to the terms and conditions of the GNU General Public
> +# License.  See the file "COPYING" in the main directory of this archive
> +# for more details.
> +#
> +# Copyright (C) 2007,2012  Imagination Technologies Ltd.
> +#
> +
> +suffix-y := bin
> +suffix-$(CONFIG_KERNEL_GZIP)	:= gz
> +suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
> +suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
> +suffix-$(CONFIG_KERNEL_XZ)	:= xz
> +suffix-$(CONFIG_KERNEL_LZO)	:= lzo
> +
> +targets := uImage uImage.gz uImage.bz2 uImage.lzma uImage.xz uImage.lzo \
> +	   uImage.bin
> +extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
> +	   vmlinux.bin.xz vmlinux.bin.lzo
> +
> +UIMAGE_LOADADDR = $(CONFIG_PAGE_OFFSET)
> +
> +VMLINUX = vmlinux
> +
> +ifeq ($(CONFIG_FUNCTION_TRACER),y)
> +ORIG_CFLAGS := $(KBUILD_CFLAGS)
> +KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
> +endif
> +
> +$(obj)/vmlinux.bin: $(VMLINUX)
> +	$(Q)$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin

Can you use:
OBJCOPYFLAGS_vmlinux.bin := $(strip-flags)
$(obj)/vmlinux.bin: $(VMLINUX)
	$(call if_changed,objcopy)

It will use the definition of OBJCOPYFLAGS from arch/metag/Makefile
where does strip-flags come from?


> +export suffix-y
lower-case is not exported.
And why this export anyway?

> diff --git a/arch/metag/kernel/Makefile b/arch/metag/kernel/Makefile
> new file mode 100644
> index 0000000..0391546
> --- /dev/null
> +++ b/arch/metag/kernel/Makefile
> @@ -0,0 +1,37 @@
> +#
> +# Makefile for the Linux/Meta kernel.
> +#
> +
> +extra-y	+= head.o
> +extra-y	+= vmlinux.lds
> +
> +obj-y	+= cachepart.o
> +obj-y	+= clock.o
> +obj-y	+= core_reg.o
> +obj-y	+= dma.o
> +obj-y	+= hw_breakpoints.o
> +obj-y	+= irq.o
> +obj-y	+= irq_external.o
> +obj-y	+= kick.o
> +obj-y	+= process.o
> +obj-y	+= ptrace.o
> +obj-y	+= setup.o
> +obj-y	+= signal.o
> +obj-y	+= stacktrace.o
> +obj-y	+= sys_metag.o
> +obj-y	+= tbiunexp.o
> +obj-y	+= time.o
> +obj-y	+= topology.o
> +obj-y	+= traps.o
> +obj-y	+= user_gateway.o

No use of "\" - good!

> +/* ld script to make Meta Linux kernel */
> +
> +#include <asm/thread_info.h>
> +#include <asm/page.h>
> +#include <asm/cache.h>
> +
> +#include <asm-generic/vmlinux.lds.h>
> +
> +OUTPUT_FORMAT("elf32-metag", "elf32-metag", "elf32-metag")
> +OUTPUT_ARCH(metag)
> +ENTRY(__start)
> +
> +_jiffies = _jiffies_64;
> +SECTIONS
> +{
> +  . = CONFIG_PAGE_OFFSET;
> +  _text = .;
I doubt this symbol is used anywhere - as meta adds '_'.

> +  __text = .;
> +  __stext = .;
> +  HEAD_TEXT_SECTION
> +  .text : {
> +	TEXT_TEXT
> +	SCHED_TEXT
> +	LOCK_TEXT
> +	KPROBES_TEXT
> +	IRQENTRY_TEXT
> +	*(.text.*)
> +	*(.gnu.warning)
> +	}
> +
> +  __etext = .;			/* End of text section */
> +
> +  __sdata = .;
> +  RO_DATA_SECTION(PAGE_SIZE)
> +  RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +  __edata = .;			/* End of data section */
> +
> +  EXCEPTION_TABLE(16)
Do you have a more descriptive constant than 16?
What does 16 imply here?


> +  NOTES
> +
> +  . = ALIGN(PAGE_SIZE);		/* Init code and data */
> +  ___init_begin = .;
> +  INIT_TEXT_SECTION(PAGE_SIZE)
> +  INIT_DATA_SECTION(16)

Same here - what does 16 imply here?

> +
> +  .init.arch.info : {
> +	  ___arch_info_begin = .;
> +	  *(.arch.info.init)
> +	  ___arch_info_end = .;
> +  }
> +
> +  PERCPU_SECTION(L1_CACHE_BYTES)
> +
> +  ___init_end = .;
> +
> +  BSS_SECTION(0, PAGE_SIZE, 0)
> +
> +  __end = .;
> +	
> +  . = ALIGN(PAGE_SIZE);
> +  __heap_start = .;
> +
> +  DWARF_DEBUG
> +
> +  /* When something in the kernel is NOT compiled as a module, the
> +   * module cleanup code and data are put into these segments.  Both
> +   * can then be thrown away, as cleanup code is never called unless
> +   * it's a module.
> +   */
> +  DISCARDS
> +}

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2403a63..6a73b08 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -452,7 +452,7 @@ config SLUB_STATS
>  config DEBUG_KMEMLEAK
>  	bool "Kernel memory leak detector"
>  	depends on DEBUG_KERNEL && EXPERIMENTAL && \
> -		(X86 || ARM || PPC || MIPS || S390 || SPARC64 || SUPERH || MICROBLAZE || TILE)
> +		(X86 || ARM || PPC || MIPS || S390 || SPARC64 || SUPERH || MICROBLAZE || TILE || METAG)
>  
>  	select DEBUG_FS
>  	select STACKTRACE if STACKTRACE_SUPPORT

This is outside arch/ so it belongs in another patch.
