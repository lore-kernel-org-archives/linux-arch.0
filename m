From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patches] [PATCH 1/9] RISC-V: Init and Halt Code
Date: Thu, 06 Jul 2017 15:34:39 -0700 (PDT)
Message-ID: <mhng-c095ae8f-4e14-4984-b4d8-10f3b27a2135@palmer-si-x1c4>
References: <20170704215401.whmxuedbu3jd7uf5@latitude>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36124 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbdGFWem (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 18:34:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so1743107pgn.3
        for <linux-arch@vger.kernel.org>; Thu, 06 Jul 2017 15:34:41 -0700 (PDT)
In-Reply-To: <20170704215401.whmxuedbu3jd7uf5@latitude>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: j.neuschaefer@gmx.net
Cc: patches@groups.riscv.org, peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Tue, 04 Jul 2017 14:54:01 PDT (-0700), j.neuschaefer@gmx.net wrote:
> Hi, below are some small comments.
>
> On Tue, Jul 04, 2017 at 12:50:54PM -0700, Palmer Dabbelt wrote:
>> This contains the various __init C functions, the initial assembly
>> kernel entry point, and the code to reset the system.  When a file was
>> init-related, it contains
>
> It contains what?
>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [...]
>
>> +#ifdef CONFIG_GENERIC_BUG
>> +#define __BUG_INSN	_AC(0x00100073, UL) /* sbreak */
>
> This should be ebreak, not sbreak, in Priv Spec 1.10, AFAICT.
> I guess binutils still understands sbreak, but it's nicer to stick to
> the spec, IMHO.

I agree.  IIRC they're the same instruction, we just alias sbreak->ebreak in
binutils (like scall->ecall).

>> +#define BUG()							\
>> +do {								\
>> +	__asm__ __volatile__ (					\
>> +		"1:\n\t"					\
>> +			"sbreak\n"				\
>
> ebreak
>
>> +			".pushsection __bug_table,\"a\"\n\t"	\
>> +		"2:\n\t"					\
>> +			__BUG_ENTRY "\n\t"			\
>> +			".org 2b + %2\n\t"			\
>> +			".popsection"				\
>> +		:						\
>> +		: "i" (__FILE__), "i" (__LINE__),		\
>> +		  "i" (sizeof(struct bug_entry)));		\
>> +	unreachable();						\
>> +} while (0)
>> +#endif /* !__ASSEMBLY__ */
>> +#else /* CONFIG_GENERIC_BUG */
>> +#ifndef __ASSEMBLY__
>> +#define BUG()							\
>> +do {								\
>> +	__asm__ __volatile__ ("sbreak\n");			\
>
> ebreak
>
>> +	unreachable();						\
>> +} while (0)
>> +#endif /* !__ASSEMBLY__ */
>> +#endif /* CONFIG_GENERIC_BUG */
> [...]
>
>> +#define DO_ERROR_INFO(name, signo, code, str)				\
>> +asmlinkage void name(struct pt_regs *regs)				\
>> +{									\
>> +	do_trap_error(regs, signo, code, regs->sepc, "Oops - " str);	\
>> +}
>> +
>> +DO_ERROR_INFO(do_trap_unknown,
>> +	SIGILL, ILL_ILLTRP, "unknown exception");
>> +DO_ERROR_INFO(do_trap_insn_misaligned,
>> +	SIGBUS, BUS_ADRALN, "instruction address misaligned");
>> +DO_ERROR_INFO(do_trap_insn_fault,
>> +	SIGBUS, BUS_ADRALN, "instruction access fault");
>
> For a general instruction access fault, BUS_ADRALN seems wrong. A
> variant of SIGSEGV seems more appropriate, IMHO.

How does this look?

  diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
  index 4c693b5b9980..3ce9ac6e736e 100644
  --- a/arch/riscv/kernel/traps.c
  +++ b/arch/riscv/kernel/traps.c
  @@ -112,7 +112,7 @@ DO_ERROR_INFO(do_trap_unknown,
   DO_ERROR_INFO(do_trap_insn_misaligned,
          SIGBUS, BUS_ADRALN, "instruction address misaligned");
   DO_ERROR_INFO(do_trap_insn_fault,
  -       SIGBUS, BUS_ADRALN, "instruction access fault");
  +       SIGBUS, SEGV_ACCERR, "instruction access fault");
   DO_ERROR_INFO(do_trap_insn_illegal,
          SIGILL, ILL_ILLOPC, "illegal instruction");
   DO_ERROR_INFO(do_trap_load_misaligned,
