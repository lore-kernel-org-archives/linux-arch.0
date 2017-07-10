Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34004 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754609AbdGJUjv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2017 16:39:51 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so14010668pge.1
        for <linux-arch@vger.kernel.org>; Mon, 10 Jul 2017 13:39:51 -0700 (PDT)
Date: Mon, 10 Jul 2017 13:39:49 -0700 (PDT)
Subject: Re: [patches] [PATCH 1/9] RISC-V: Init and Halt Code
In-Reply-To: <20170707125855.rgqp432a62kmskhr@latitude>
From: Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <mhng-0e729a6d-ca23-471e-85d5-93286e735b53@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: j.neuschaefer@gmx.net, patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
Message-ID: <20170710203949.ps2YLzJuWbpPBtjA9FPW7CqsaNPt7R6dRBLEMafoL5U@z>

On Fri, 07 Jul 2017 05:58:55 PDT (-0700), j.neuschaefer@gmx.net wrote:
> On Thu, Jul 06, 2017 at 03:34:39PM -0700, Palmer Dabbelt wrote:
>> On Tue, 04 Jul 2017 14:54:01 PDT (-0700), j.neuschaefer@gmx.net wrote:
> [...]
>> >> +#define DO_ERROR_INFO(name, signo, code, str)				\
>> >> +asmlinkage void name(struct pt_regs *regs)				\
>> >> +{									\
>> >> +	do_trap_error(regs, signo, code, regs->sepc, "Oops - " str);	\
>> >> +}
>> >> +
>> >> +DO_ERROR_INFO(do_trap_unknown,
>> >> +	SIGILL, ILL_ILLTRP, "unknown exception");
>> >> +DO_ERROR_INFO(do_trap_insn_misaligned,
>> >> +	SIGBUS, BUS_ADRALN, "instruction address misaligned");
>> >> +DO_ERROR_INFO(do_trap_insn_fault,
>> >> +	SIGBUS, BUS_ADRALN, "instruction access fault");
>> >
>> > For a general instruction access fault, BUS_ADRALN seems wrong. A
>> > variant of SIGSEGV seems more appropriate, IMHO.
>>
>> How does this look?
>>
>>   diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>   index 4c693b5b9980..3ce9ac6e736e 100644
>>   --- a/arch/riscv/kernel/traps.c
>>   +++ b/arch/riscv/kernel/traps.c
>>   @@ -112,7 +112,7 @@ DO_ERROR_INFO(do_trap_unknown,
>>    DO_ERROR_INFO(do_trap_insn_misaligned,
>>           SIGBUS, BUS_ADRALN, "instruction address misaligned");
>>    DO_ERROR_INFO(do_trap_insn_fault,
>>   -       SIGBUS, BUS_ADRALN, "instruction access fault");
>>   +       SIGBUS, SEGV_ACCERR, "instruction access fault");
>>    DO_ERROR_INFO(do_trap_insn_illegal,
>>           SIGILL, ILL_ILLOPC, "illegal instruction");
>>    DO_ERROR_INFO(do_trap_load_misaligned,
>
> I'm not familiar with the trap handling infrastructure, but looking at
> include/uapi/asm-generic/siginfo.h, SEGV_ACCERR would alias to
> BUS_ADRERR (both are defined as (__SI_FAULT|2)). So if you use SEGV_*,
> you need to use SIGSEGV, too.
>
> With DO_ERROR_INFO(..., SIGSEGV, SEGV_ACCERR, ...); it looks good to me.

Oh, sorry, I wasn't paying attention.  It should be fixed now.

Thanks!
