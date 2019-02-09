Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:48310 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbfBIMYL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 9 Feb 2019 07:24:11 -0500
Date: Sat, 9 Feb 2019 13:24:05 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 06/28] x86/asm: annotate local pseudo-functions
Message-ID: <20190209122405.GB5089@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-7-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-7-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190209122405.3rUKReNZ0rD-UxEuUMB20Ii5XwPULN0UsVahnGVS55o@z>

On Wed, Jan 30, 2019 at 01:46:49PM +0100, Jiri Slaby wrote:
> Use the newly added SYM_CODE_START_LOCAL* to annotate starts of all
> pseudo-functions (those ending END until now) which do not have ".globl"
> annotation. This is needed to balance END for tools that generate
> debuginfo. Note that we switch from END to SYM_CODE_END too so that
> everybody can see the pairing.
> 
> We are not annotating C-like functions (which handle frame ptr etc.)
> here, hence we use SYM_CODE_* macros here, not SYM_FUNC_*.  Note that
> early_idt_handler_common already had ENDPROC -- switch that to
> SYM_CODE_END for the same reason as above.
> 
> bogus_64_magic, bad_address, bad_get_user*, and bad_put_user are now
> aligned, as they are separate functions. They do not mind to be aligned
> -- no need to be compact there.
> 
> early_idt_handler_common is aligned now too, as it is after
> early_idt_handler_array, so as well no need to be compact there.
> 
> verify_cpu is self-standing and included in other .S files, so align it
> too.
> 
> The others have alignment preserved to what it used to be (using the
> _NOALIGN variant of macros).
> 
> [v3] annotate more functions
> [v4] describe the alignments changes
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: <x86@kernel.org>
> ---
>  arch/x86/entry/entry_32.S        | 5 ++---
>  arch/x86/entry/entry_64.S        | 3 ++-
>  arch/x86/kernel/acpi/wakeup_64.S | 3 ++-
>  arch/x86/kernel/head_32.S        | 4 ++--
>  arch/x86/kernel/head_64.S        | 4 ++--
>  arch/x86/kernel/verify_cpu.S     | 4 ++--
>  arch/x86/lib/getuser.S           | 8 ++++----
>  arch/x86/lib/putuser.S           | 4 ++--
>  8 files changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index d309f30cf7af..306ae3e9a24c 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -737,8 +737,7 @@ END(ret_from_fork)
>   */
>  
>  	# userspace resumption stub bypassing syscall exit tracing
> -	ALIGN
> -ret_from_exception:
> +SYM_CODE_START_LOCAL(ret_from_exception)

This wants to be a local label instead, no?

.Lret_from_exception:

...

>  	preempt_stop(CLBR_ANY)
>  ret_from_intr:
>  #ifdef CONFIG_VM86
> @@ -761,7 +760,7 @@ ENTRY(resume_userspace)
>  	movl	%esp, %eax
>  	call	prepare_exit_to_usermode
>  	jmp	restore_all
> -END(ret_from_exception)
> +SYM_CODE_END(ret_from_exception)
>  
>  #ifdef CONFIG_PREEMPT
>  ENTRY(resume_kernel)
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 1f0efdb7b629..463f9edd78a4 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1006,7 +1006,7 @@ EXPORT_SYMBOL(native_load_gs_index)
>  	_ASM_EXTABLE(.Lgs_change, bad_gs)
>  	.section .fixup, "ax"
>  	/* running with kernelgs */
> -bad_gs:
> +SYM_CODE_START_LOCAL_NOALIGN(bad_gs)

Ditto.

>  	SWAPGS					/* switch back to user gs */
>  .macro ZAP_GS
>  	/* This can't be a string because the preprocessor needs to see it. */
> @@ -1017,6 +1017,7 @@ bad_gs:
>  	xorl	%eax, %eax
>  	movl	%eax, %gs
>  	jmp	2b
> +SYM_CODE_END(bad_gs)
>  	.previous
>  
>  /* Call softirq on interrupt stack. Interrupts are off. */
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 551758f48eb7..6c60fe346583 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -36,8 +36,9 @@ ENTRY(wakeup_long64)
>  	jmp	*%rax
>  ENDPROC(wakeup_long64)
>  
> -bogus_64_magic:
> +SYM_CODE_START_LOCAL(bogus_64_magic)

Ditto.

>  	jmp	bogus_64_magic
> +SYM_CODE_END(bogus_64_magic)
>  
>  ENTRY(do_suspend_lowlevel)
>  	FRAME_BEGIN
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index d1e213da4782..0bae769b7b59 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -409,7 +409,7 @@ ENTRY(early_idt_handler_array)
>  	.endr
>  ENDPROC(early_idt_handler_array)
>  	
> -early_idt_handler_common:
> +SYM_CODE_START_LOCAL(early_idt_handler_common)

This one too - all those are used only in this compilation unit so not
having them as symbols at all is fine AFAICT.

Same for the rest of the local symbols in this patch, except verify_cpu.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
