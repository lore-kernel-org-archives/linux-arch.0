From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 8/9] RISC-V: User-facing API
Date: Thu, 29 Jun 2017 10:22:00 -0700 (PDT)
Message-ID: <mhng-28dad5a7-ad51-4998-a7a5-6e1dfbc24017@palmer-si-x1c4>
References: <alpine.DEB.2.20.1706282336270.1890@nanos>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32827 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751690AbdF2RWB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 13:22:01 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so13934486pfh.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 10:22:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1706282336270.1890@nanos>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Wed, 28 Jun 2017 14:49:44 PDT (-0700), tglx@linutronix.de wrote:
> On Wed, 28 Jun 2017, Palmer Dabbelt wrote:
>> +
>> +SYSCALL_DEFINE3(sysriscv_cmpxchg32, unsigned long, arg1, unsigned long, arg2,
>> +		unsigned long, arg3)
>> +{
>> +	unsigned long flags;
>> +	unsigned long prev;
>> +	unsigned int *ptr;
>> +	unsigned int err;
>> +
>> +	ptr = (unsigned int *)arg1;
>
> Errm. Why isn't arg1 a proper pointer type and the arguments arg2/3 u32?
>
> And please give the arguments a proper name, so it's obvious what is what.
>
> SYSCALL_DEFINE3(sysriscv_cmpxchg32, u32 __user *, ptr, u32 new, u32 old)
>
> Hmm?

Sorry about that -- this used to be a multiplexed system call, and I guess I
was just being stupid when demultiplexing it.  That's much better, I've
converted these over.

>> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned int)))
>> +		return -EFAULT;
>> +
>> +	preempt_disable();
>> +	raw_local_irq_save(flags);
>
> Why do you want to disable interrupts here? This is thread context and
> accessing user space memory, so the only protection this needs is against
> preemption.

OK, that makes sense.

>> +	err = __get_user(prev, ptr);
>> +	if (likely(!err && prev == arg2))
>> +		err = __put_user(arg3, ptr);
>> +	raw_local_irq_restore(flags);
>> +	preempt_enable();
>> +
>> +	return unlikely(err) ? err : prev;
>> +}
>> +
>> +SYSCALL_DEFINE3(sysriscv_cmpxchg64, unsigned long, arg1, unsigned long, arg2,
>> +		unsigned long, arg3)
>
> This one is even worse. How does this implement cmpxchg64 on a 32bit machine?
>
> Answer: Not at all, because arg2 and 3 are 32bit ....

Thanks for catching that -- this was just a bit of copy-and-paste gone wrong.

>> +{
>> +	unsigned long flags;
>> +	unsigned long prev;
>> +	unsigned int *ptr;
>> +	unsigned int err;
>> +
>> +	ptr = (unsigned int *)arg1;
>
> Type casting to random pointer types makes the code more obvious
> and safe, right? What the heck has a int pointer to do with u64?
>
>> +	if (!access_ok(VERIFY_WRITE, ptr, sizeof(unsigned long)))
>> +		return -EFAULT;
>> +
>> +	preempt_disable();
>> +	raw_local_irq_save(flags);
>
> Same as above.
>
>> +	err = __get_user(prev, ptr);
>
> Sigh. Type safety is overrated, right?

Again, this was due to the multiplexing that has been removed.  I've gone ahead
and cleaned up this system call here

  https://github.com/riscv/riscv-linux/commit/1af46852b968db5af044ec3a0329a73116b3e6ec

We'll include this in our v4 patch set.

Thanks!
