Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33691 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfH1Lr3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 07:47:29 -0400
Subject: Asm & local labels for functions [was: [PATCH v8 05/28] x86/asm:
 annotate local pseudo-functions]
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-6-jslaby@suse.cz> <20190815160719.GI15313@zn.tnic>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <c5e0f683-796c-f552-0c3b-8a1105446200@suse.cz>
Date: Wed, 28 Aug 2019 13:47:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190815160719.GI15313@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190828114723.j7rP14lh-mPkvAMD9DHH_c9XjB8ezM3oYuT4VxLTkH4@z>

On 15. 08. 19, 18:07, Borislav Petkov wrote:
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -283,7 +283,7 @@ ENTRY(early_idt_handler_array)
>  		UNWIND_HINT_IRET_REGS offset=8
>  	.endif
>  	pushq $i		# 72(%rsp) Vector number
> -	jmp early_idt_handler_common
> +	jmp .Learly_idt_handler_common
>  	UNWIND_HINT_IRET_REGS
>  	i = i + 1
>  	.fill early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
> @@ -291,7 +291,7 @@ ENTRY(early_idt_handler_array)
>  	UNWIND_HINT_IRET_REGS offset=16
>  END(early_idt_handler_array)
>  
> -SYM_CODE_START_LOCAL(early_idt_handler_common)
> +SYM_CODE_START_LOCAL(.Learly_idt_handler_common)
>  	/*
>  	 * The stack is the hardware frame, an error code or zero, and the
>  	 * vector number.
> @@ -333,7 +333,7 @@ SYM_CODE_START_LOCAL(early_idt_handler_common)
>  20:
>  	decl early_recursion_flag(%rip)
>  	jmp restore_regs_and_return_to_kernel
> -SYM_CODE_END(early_idt_handler_common)
> +SYM_CODE_END(.Learly_idt_handler_common)

...

> All except this one can be local labels and be removed from vmlinux'
> symtable:
> 
> $ readelf -a vmlinux | grep -E "(bad_(gs|(get|put)_user)|bogus_64_magic|early_idt_handler_common|verify_cpu)"
>     45: ffffffff810000e0   241 FUNC    LOCAL  DEFAULT    1 verify_cpu
> $

Thanks for all the review hints.

Let's start with this one: do you really want me to get rid of (local)
symbols like this? It would make backtraces completely misleading as the
unwinder would put a name of the previous function (or some garbage,
depending on unwinder) into the backtrace...

thanks,
-- 
js
suse labs
