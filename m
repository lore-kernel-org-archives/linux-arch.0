From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH -resend 02/27] x86: assembly, use SYM_DATA for data
Date: Mon, 14 May 2018 10:05:49 +0200
Message-ID: <20180514080549.GB6607@gmail.com>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-3-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510080644.19752-3-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Jiri Slaby <jslaby@suse.cz> wrote:

> We make proper use of SYM_DATA on global data instead of marking them as
> ENTRY. ENTRY is intended for functions and shall be paired with ENDPROC.
> ENTRY also aligns symbols which creates unnecessary holes here between
> data.
> 
> ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64 is
> simply dropped, as these symbols are local only.

Yeah, so this commit talks about ENTRY() and ENDPROC(), while the new methods are 
SYM_FUNC_START()/END().

>  arch/x86/kernel/acpi/wakeup_32.S |  4 ++--
>  arch/x86/kernel/acpi/wakeup_64.S | 14 +++++++-------
>  arch/x86/kernel/head_32.S        |  6 ++----
>  arch/x86/kernel/head_64.S        |  5 ++---
>  4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 0c26b1b44e51..feac1e5ecba0 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -89,8 +89,8 @@ ret_point:
>  
>  .data
>  ALIGN
> -ENTRY(saved_magic)	.long	0
> -ENTRY(saved_eip)	.long	0
> +SYM_DATA(saved_magic,	.long 0)
> +saved_eip:		.long 0
>  
>  # saved registers
>  saved_idt:	.long	0,0
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 50b8ed0317a3..551758f48eb7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
>  ENDPROC(do_suspend_lowlevel)
>  
>  .data
> -ENTRY(saved_rbp)	.quad	0
> -ENTRY(saved_rsi)	.quad	0
> -ENTRY(saved_rdi)	.quad	0
> -ENTRY(saved_rbx)	.quad	0
> +saved_rbp:		.quad	0
> +saved_rsi:		.quad	0
> +saved_rdi:		.quad	0
> +saved_rbx:		.quad	0
>  
> -ENTRY(saved_rip)	.quad	0
> -ENTRY(saved_rsp)	.quad	0
> +saved_rip:		.quad	0
> +saved_rsp:		.quad	0
>  
> -ENTRY(saved_magic)	.quad	0
> +SYM_DATA(saved_magic,	.quad	0)
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index b59e4fb40fd9..80965fd75fea 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -507,10 +507,8 @@ GLOBAL(early_recursion_flag)
>  
>  __REFDATA
>  	.align 4
> -ENTRY(initial_code)
> -	.long i386_start_kernel
> -ENTRY(setup_once_ref)
> -	.long setup_once
> +SYM_DATA(initial_code,		.long i386_start_kernel)
> +SYM_DATA(setup_once_ref,	.long setup_once)
>  
>  /*
>   * BSS section
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 8344dd2f310a..17543533642d 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -463,9 +463,8 @@ early_gdt_descr:
>  early_gdt_descr_base:
>  	.quad	INIT_PER_CPU_VAR(gdt_page)
>  
> -ENTRY(phys_base)
> -	/* This must match the first entry in level2_kernel_pgt */
> -	.quad   0x0000000000000000
> +/* This must match the first entry in level2_kernel_pgt */
> +SYM_DATA(phys_base, .quad 0x0000000000000000)
>  EXPORT_SYMBOL(phys_base)
>  
>  #include "../../x86/xen/xen-head.S"

I'd also suggest splitting this patch into two:

  - one for the renaming of the existing ENTRY() uses

  - and another one for the dropping of ENTRY() annotations

Could you please also do this for other patches if necessary, i.e. there should be 
'pure renaming' patches that are easy to review and verify, separate from patches 
that actually change the symbol table?

Thanks,

	Ingo
