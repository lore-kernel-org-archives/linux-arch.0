From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 5/9] RISC-V: Task implementation
Date: Thu, 29 Jun 2017 15:52:42 -0700 (PDT)
Message-ID: <mhng-edeb5d3c-7b5f-4314-982c-f64e44e55154@palmer-si-x1c4>
References: <20170628233254.GR6973@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33872 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbdF2Wwn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 18:52:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id c24so152037pfe.1
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 15:52:43 -0700 (PDT)
In-Reply-To: <20170628233254.GR6973@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: james.hogan@imgtec.com
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017 16:32:55 PDT (-0700), james.hogan@imgtec.com wrote:
> On Wed, Jun 28, 2017 at 11:55:34AM -0700, Palmer Dabbelt wrote:
>> diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
>> new file mode 100644
>> index 000000000000..1190de7a0f74
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/kprobes.h
>> @@ -0,0 +1,22 @@
> ...
>> +#ifdef CONFIG_KPROBES
>> +#error "RISC-V doesn't skpport CONFIG_KPROBES"
>> +#endif
>
> I'm wondering where your fallback definition of e.g. NOKPROBE_SYMBOL
> comes from then.
>
> Could you just use the asm-generic one?

I believe so.

>> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
>> new file mode 100644
>> index 000000000000..b13d3ea3bf79
>> --- /dev/null

> ...
>> +void show_regs(struct pt_regs *regs)
>> +{
>> +	show_regs_print_info(KERN_DEFAULT);
>> +
>> +	printk(KERN_CONT "sepc: " REG_FMT " ra : " REG_FMT " sp : " REG_FMT "\n",
>> +		regs->sepc, regs->ra, regs->sp);
>
> I've noticed inconsistent use of pr_* and printk(KERN_* in this
> patchset. Maybe now would be the best time to switch everything to pr_*.

I went through and fixed them all.

>> +	/* Reset FPU context
>> +	 *	frm: round to nearest, ties to even (IEEE default)
>> +	 *	fflags: accrued exceptions cleared
>> +	 */
>
> Similarly lots of multiline comments which don't follow the standard
> style in Documentation/process/coding-style.rst. Maybe now is the best
> time to convert if you're going to.

Someone else found one and suggested this, it's on my TODO list.

Thanks!
