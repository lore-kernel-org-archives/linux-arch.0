From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patches] [PATCH 1/9] RISC-V: Init and Halt Code
Date: Mon, 10 Jul 2017 13:39:49 -0700 (PDT)
Message-ID: <mhng-0e729a6d-ca23-471e-85d5-93286e735b53@palmer-si-x1c4>
References: <20170707125855.rgqp432a62kmskhr@latitude>
Mime-Version: 1.0 (MHng)
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170707125855.rgqp432a62kmskhr@latitude>
Sender: linux-kernel-owner@vger.kernel.org
Cc: j.neuschaefer@gmx.net, patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com
List-Id: linux-arch.vger.kernel.org

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
