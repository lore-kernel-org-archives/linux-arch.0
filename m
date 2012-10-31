From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Wed, 31 Oct 2012 21:34:34 +0000
Message-ID: <5091996A.2030401@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-13-git-send-email-james.hogan@imgtec.com> <20121031193503.GA4640@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:14224 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760368Ab2JaVei (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Oct 2012 17:34:38 -0400
In-Reply-To: <20121031193503.GA4640@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org

Hi Sam,

Thanks for taking a look.

On 31/10/12 19:35, Sam Ravnborg wrote:
> 1) This patch should be the last one - as this enables build of this architecture.

Okay, makes sense

> 2) this patch should not contain changes to files outside metag

Okay, I'll split those changes into a separate patch

> 3) there seems to be confusion if the shorthand is meta or metag.
>    Please fix it up so metag is used everywhere.
> 
> 	Sam
> 
>> +config METAG
>> +	def_bool y
>> +	select EMBEDDED
>> +	select HAVE_64BIT_ALIGNED_STRUCT
>> +	select HAVE_MEMBLOCK
>> +	select HAVE_MEMBLOCK_NODE_MAP
>> +	select HAVE_ARCH_TRACEHOOK
>> +	select HAVE_IRQ_WORK
>> +	select HAVE_KERNEL_GZIP
>> +	select HAVE_KERNEL_BZIP2
>> +	select HAVE_KERNEL_LZMA
>> +	select HAVE_KERNEL_XZ
>> +	select HAVE_KERNEL_LZO
>> +	select HAVE_SYSCALL_TRACEPOINTS
>> +	select HAVE_GENERIC_HARDIRQS
>> +	select GENERIC_ATOMIC64
>> +	select GENERIC_CLOCKEVENTS
>> +	select GENERIC_IRQ_SHOW
>> +	select GENERIC_SMP_IDLE_THREAD
>> +	select IRQ_DOMAIN
>> +	select OF
>> +	select OF_EARLY_FLATTREE
> Sorting these in alphabetic order avoid merge issues later.

Good idea

> 
>> +	help
>> +	  Imagination Technologies Meta processors are a family of multi-
>> +	  threaded DSPs designed for embedded systems.
> This help entry is not visible in KConfig - just add it as a comment above the config symbol.

Okay

> 
>> +config IRQ_PER_CPU
>> +	def_bool y
> This looks obsolete / unused in mainline kernel.

True. It appears to have been removed by
6a58fb3bad099076f36f0f30f44507bc3275cdb6 but not from any of the
architectures that selected it. I'll add that to the list.

>> +config HOTPLUG_CPU
>> +	bool "Enable CPU hotplug support"
>> +	depends on SMP && HOTPLUG
> Today HOTPLUG is always y so the HOTPLUG dependency is not needed.

Okay

>> +config HIGHMEM
>> +	bool "High Memory Support"
>> +	depends on MMU
> 
> MMU is always y as per above - so the MMU dependeny is not neeeded.

Okay

>> +config META12
>> +	bool
>> +	---help---
>> +	  Select this from the SoC config symbol to indicate that it contains a
>> +	  Meta 1.2 core.
> It would be good to have all METAG (or is it META) symbol perfixed with
> the same text. Such as METAG_META12 etc.
> General comment!

Yep, makes sense.

>> +config META21
>> +	bool
>> +	---help---
>> +	  Select this from the SoC config symbol to indicate that it contains a
>> +	  Meta 2.1 core.
> Today we have larely moved away from ---help--- and uses the shorter help
> ---help--- has 2290 hits
> help       has 7841 hits

Okay, I think I remember doing the same grep and not really being sure
which to unify towards.

>> +menu "Boot options"
> 
> 
> Can we use the common config symbols here?
> CMDLINE, CMDLINE_OVERWRITE, CMDLINE_BOOL etc.

This was intentional, as they're used in drivers/of/fdt.c, which
interferes a bit with allowing appending of a builtin command line. I'm
happy to make it more uniform with other arches though.

>> +menu "Board support"
>> +
>> +endmenu
> No point having an empty menu!?

Oops, I'll remove until we submit something to put in it.

>> +LDFLAGS		:=
>> +OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
>> +
>> +CHECKFLAGS-$(CONFIG_META12) += -DMETAC_1_2
>> +CHECKFLAGS-$(CONFIG_META21) += -DMETAC_2_1
> 
> As a rule of thumb UPPERCASE is for exported stuff.
> lower-case for local variables.
> 
> I would do it like this:
> checkflags-$(CONFIG_META12) := -DMETAC_1_2
> checkflags-$(CONFIG_META21) := -DMETAC_2_1
> CHECKFLAGS   += -D__metag__ $(checkflags-y)

Okay, thanks. I'll give all our stuff a scan over to check for this kind
of thing.

>> +core-y					+= arch/metag/kernel/ \
>> +					   arch/metag/mm/
> 
> The abuse of \ in makefile in bad practice IMO.
> The following is much more readable:
> 
> core-y += arch/metag/kernel/
> core-y += arch/metag/mm/
> 
> Please fix this in all Makefile - if I can convince you.

Agreed (it definitely makes merges etc easier)

> 
>> +
>> +ifneq ($(score-y),)
>> +core-y                                  += arch/metag/$(score-y)/
>> +endif
> 
> How can score-y ever be non-empty?

Individual SoCs would set that. I'll remove it until SoC support is
submitted.

> 
>> +
>> +ifneq ($(machdir-y),)
>> +core-y  += $(addprefix arch/metag/boards/, \
>> +             $(filter-out ., $(patsubst %,%/,$(machdir-y))))
>> +endif
> 
> 
> Or like this:
> machdirs := $(filter-out ., $(patsubst %,%/,$(machdir-y)))
> core-y += $(addprefix arch/metag/boards/, $(machdirs))
> 
> I see no need to test if machdir-y is non-empty.

Agreed.


>> +$(obj)/vmlinux.bin: $(VMLINUX)
>> +	$(Q)$(OBJCOPY) -O binary $(strip-flags) $(VMLINUX) $(obj)/vmlinux.bin
> 
> Can you use:
> OBJCOPYFLAGS_vmlinux.bin := $(strip-flags)
> $(obj)/vmlinux.bin: $(VMLINUX)
> 	$(call if_changed,objcopy)
> 
> It will use the definition of OBJCOPYFLAGS from arch/metag/Makefile

Neat, thanks

> where does strip-flags come from?

Nowhere apparently. I suspect it was copied from mips. I'll remove it.

>> +export suffix-y
> lower-case is not exported.
> And why this export anyway?

I think this was derived from sh, but that seems to use it in
arch/sh/boot/compressed/Makefile which we don't have, so I'll remove the
export.

>> diff --git a/arch/metag/kernel/Makefile b/arch/metag/kernel/Makefile
>> new file mode 100644
>> index 0000000..0391546
>> --- /dev/null
>> +++ b/arch/metag/kernel/Makefile
>> @@ -0,0 +1,37 @@

> No use of "\" - good!

:-) the "\"'s were bugging me here when splitting up the patches

>> +/* ld script to make Meta Linux kernel */

>> +  _text = .;
> I doubt this symbol is used anywhere - as meta adds '_'.

It appears to be used by .tmp_kallsyms1.o

>> +  __text = .;
>> +  __stext = .;
>> +  HEAD_TEXT_SECTION
>> +  .text : {
>> +	TEXT_TEXT
>> +	SCHED_TEXT
>> +	LOCK_TEXT
>> +	KPROBES_TEXT
>> +	IRQENTRY_TEXT
>> +	*(.text.*)
>> +	*(.gnu.warning)
>> +	}
>> +
>> +  __etext = .;			/* End of text section */
>> +
>> +  __sdata = .;
>> +  RO_DATA_SECTION(PAGE_SIZE)
>> +  RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
>> +  __edata = .;			/* End of data section */
>> +
>> +  EXCEPTION_TABLE(16)
> Do you have a more descriptive constant than 16?
> What does 16 imply here?

A bunch of other architectures also set this alignment. A couple though
use a cache line size definition, suggesting it's for cache efficiency.
If so we should probably set it to 64 (metag's cache line size).

> 
> 
>> +  NOTES
>> +
>> +  . = ALIGN(PAGE_SIZE);		/* Init code and data */
>> +  ___init_begin = .;
>> +  INIT_TEXT_SECTION(PAGE_SIZE)
>> +  INIT_DATA_SECTION(16)
> 
> Same here - what does 16 imply here?

Almost every other architecture also sets this alignment to 16 (except
frv=8, hexagon=pagesize).

Thanks for all the comments,

Cheers
James
