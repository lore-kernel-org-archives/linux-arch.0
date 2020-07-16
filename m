From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V3 08/13] x86/entry: Use generic syscall entry function
Date: Thu, 16 Jul 2020 23:33:21 +0200
Message-ID: <87ft9rtaam.fsf@nanos.tec.linutronix.de>
References: <20200716182208.180916541@linutronix.de> <20200716185424.765294277@linutronix.de> <202007161359.AB211685@keescook>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:36106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgGPVdY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 17:33:24 -0400
In-Reply-To: <202007161359.AB211685@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> On Thu, Jul 16, 2020 at 08:22:16PM +0200, Thomas Gleixner wrote:
>> +}
>> +#define arch_check_user_regs arch_check_user_regs
>
> Will architectures implement subsets of these functions? (i.e. instead
> of each of the defines, is CONFIG_ENTRY_GENERIC sufficient for the
> no-op inlines?)

Yes, some of these are optional as far as my analysis of the
architecture code went.

>> +}
>> +#define arch_syscall_enter_seccomp arch_syscall_enter_seccomp
>
> Actually, I've been meaning to clean this up. It's not needed at all.
> This was left over from the seccomp fast-path code that got ripped out a
> while ago. seccomp already has everything it needs to do this work, so
> just:
>
> 	__secure_computing(NULL);
>
> is sufficient for every architecture that supports seccomp. (See kernel/seccomp.c
> populate_seccomp_data().)

Nice. Was not aware of these details. Trivial enough to fix :)

> And if you want more generalization work, note that the secure_computing()
> macro performs a TIF test before calling __secure_computing(NULL). But
> my point is, I think arch_syscall_enter_seccomp() is not needed.

Cute. One horror gone.

>> +static inline void arch_syscall_enter_audit(struct pt_regs *regs)
>> +{
>> +#ifdef CONFIG_X86_64
>> +	if (in_ia32_syscall()) {
>> +		audit_syscall_entry(regs->orig_ax, regs->di,
>> +				    regs->si, regs->dx, regs->r10);
>> +	} else
>> +#endif
>> +	{
>> +		audit_syscall_entry(regs->orig_ax, regs->bx,
>> +				    regs->cx, regs->dx, regs->si);
>> +	}
>> +}
>> +#define arch_syscall_enter_audit arch_syscall_enter_audit
>
> Similarly, I think these can be redefined in the generic case
> using the existing accessors for syscall arguments, etc. e.g.
> arch_syscall_enter_audit() is not needed for any architecture, and the
> generic is:
>
> 	unsigned long args[6];
>
>         syscall_get_arguments(task, regs, args);
> 	audit_syscall_entry(syscall_get_nr(current, regs),
> 			    args[0], args[1], args[2], args[3]);

Nice. Another arch specific mess gone.

Thanks,

        tglx
