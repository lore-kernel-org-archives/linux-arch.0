From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Wed, 28 Jun 2017 23:49:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706282336270.1890@nanos>
References: <20170606230007.19101-1-palmer@dabbelt.com> <20170628185538.1804-1-palmer@dabbelt.com> <20170628185538.1804-9-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:53804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbdF1Vv0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jun 2017 17:51:26 -0400
In-Reply-To: <20170628185538.1804-9-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017, Palmer Dabbelt wrote:
> +
> +SYSCALL_DEFINE3(sysriscv_cmpxchg32, unsigned long, arg1, unsigned long, arg2,
> +		unsigned long, arg3)
> +{
> +	unsigned long flags;
> +	unsigned long prev;
> +	unsigned int *ptr;
> +	unsigned int err;
> +
> +	ptr = (unsigned int *)arg1;

Errm. Why isn't arg1 a proper pointer type and the arguments arg2/3 u32?

And please give the arguments a proper name, so it's obvious what is what.

SYSCALL_DEFINE3(sysriscv_cmpxchg32, u32 __user *, ptr, u32 new, u32 old)

Hmm?

> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned int)))
> +		return -EFAULT;
> +
> +	preempt_disable();
> +	raw_local_irq_save(flags);

Why do you want to disable interrupts here? This is thread context and
accessing user space memory, so the only protection this needs is against
preemption.

> +	err = __get_user(prev, ptr);
> +	if (likely(!err && prev == arg2))
> +		err = __put_user(arg3, ptr);
> +	raw_local_irq_restore(flags);
> +	preempt_enable();
> +
> +	return unlikely(err) ? err : prev;
> +}
> +
> +SYSCALL_DEFINE3(sysriscv_cmpxchg64, unsigned long, arg1, unsigned long, arg2,
> +		unsigned long, arg3)

This one is even worse. How does this implement cmpxchg64 on a 32bit machine?

Answer: Not at all, because arg2 and 3 are 32bit ....

> +{
> +	unsigned long flags;
> +	unsigned long prev;
> +	unsigned int *ptr;
> +	unsigned int err;
> +
> +	ptr = (unsigned int *)arg1;

Type casting to random pointer types makes the code more obvious
and safe, right? What the heck has a int pointer to do with u64?

> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned long)))
> +		return -EFAULT;
> +
> +	preempt_disable();
> +	raw_local_irq_save(flags);

Same as above.

> +	err = __get_user(prev, ptr);

Sigh. Type safety is overrated, right?

Thanks,

	tglx
