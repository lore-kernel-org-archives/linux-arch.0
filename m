From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -resend 00/27] New macros for assembler symbols
Date: Mon, 14 May 2018 10:10:09 +0200
Message-ID: <20180514081009.GC6607@gmail.com>
References: <20180510080644.19752-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-arch.vger.kernel.org


* Jiri Slaby <jslaby@suse.cz> wrote:

> This series introduces new macros for assembly as was discussed [1].
> The macros are introduced in the first patch of the series. The rest
> of patches start using these new macros in x86, converting *all* uses
> of the old macros to the new ones throughout the last patch. With
> every last user of some old macro, the macro is immediatelly made
> forbidden for x86.
> 
> When this settles down, conversion of other architectures can be done
> too.
> 
> For introduction, documentation, use and examples, please see
> Documentation/asm-annotations.rst from the first patch of the series.
> 
> [1] https://lkml.org/lkml/2017/3/1/742
> 
> Jiri Slaby (27):
>   linkage: new macros for assembler symbols
>   x86: assembly, use SYM_DATA for data
>   x86: assembly, annotate relocate_kernel
>   x86: entry, annotate THUNKs
>   x86: assembly, annotate local pseudo-functions
>   x86: crypto, annotate local functions
>   x86: boot, annotate local functions
>   x86: assembly, annotate aliases
>   x86: entry, annotate interrupt symbols properly
>   x86: head, annotate data appropriatelly
>   x86: boot, annotate data appropriatelly
>   x86: um, annotate data appropriatelly
>   x86: xen-pvh, annotate data appropriatelly
>   x86: purgatory, start using annotations
>   x86: assembly, do not annotate functions by GLOBAL
>   x86: assembly, use SYM_CODE_INNER_LABEL instead of GLOBAL
>   x86: realmode, use SYM_DATA_* instead of GLOBAL
>   x86: assembly, remove GLOBAL macro
>   x86: assembly, make some functions local
>   x86: ftrace, mark function_hook as function
>   x86_64: assembly, add ENDs to some functions and relabel with SYM_CODE_*
>   x86_64: assembly, change all ENTRY+END to SYM_CODE_*
>   x86_64: assembly, change all ENTRY+ENDPROC to SYM_FUNC_*
>   x86_32: assembly, add ENDs to some functions and relabel with SYM_CODE_*
>   x86_32: assembly, change all ENTRY+END to SYM_CODE_*
>   x86_32: assembly, change all ENTRY+ENDPROC to SYM_FUNC_*
>   x86: assembly, replace WEAK uses

So since this is going to be a lot of commits I'd rather not edit every title, but 
every single patch you sent has a non-standard title that looks totally out of 
place if you look at existing commits to those same files.

For example:

>   x86: boot, annotate local functions

Modifies files whose existing commit title format to be:

974f221c84b0: x86/boot: Move compressed kernel to the end of the decompression buffer
c04028813221: x86/boot: Clarify purpose of functions in misc.c

So could you please use the proper x86 titles?

In fact I'd suggest using the same subsystem identifier for most patches, i.e.:

   x86/asm: Annotate xen-pvh symbols ....

because these are really mostly assembly code annotations.

Thanks,

	Ingo
