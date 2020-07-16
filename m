From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V3 08/13] x86/entry: Use generic syscall entry function
Date: Thu, 16 Jul 2020 14:13:58 -0700
Message-ID: <202007161359.AB211685@keescook>
References: <20200716182208.180916541@linutronix.de>
 <20200716185424.765294277@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgGPVOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jul 2020 17:14:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A9CC061755
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 14:14:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cm21so5422302pjb.3
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2020 14:14:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200716185424.765294277@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

On Thu, Jul 16, 2020 at 08:22:16PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace the syscall entry work handling with the generic version. Provide
> the necessary helper inlines to handle the real architecture specific
> parts, e.g. audit and seccomp invocations.
> 
> Use a temporary define for idtentry_enter_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [...]
> --- /dev/null
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_X86_ENTRY_COMMON_H
> +#define _ASM_X86_ENTRY_COMMON_H
> +
> +#include <linux/seccomp.h>
> +#include <linux/audit.h>
> +
> +/* Check that the stack and regs on entry from user mode are sane. */
> +static __always_inline void arch_check_user_regs(struct pt_regs *regs)
> +{
> +	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
> +		/*
> +		 * Make sure that the entry code gave us a sensible EFLAGS
> +		 * register.  Native because we want to check the actual CPU
> +		 * state, not the interrupt state as imagined by Xen.
> +		 */
> +		unsigned long flags = native_save_fl();
> +		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> +				      X86_EFLAGS_NT));
> +
> +		/* We think we came from user mode. Make sure pt_regs agrees. */
> +		WARN_ON_ONCE(!user_mode(regs));
> +
> +		/*
> +		 * All entries from user mode (except #DF) should be on the
> +		 * normal thread stack and should have user pt_regs in the
> +		 * correct location.
> +		 */
> +		WARN_ON_ONCE(!on_thread_stack());
> +		WARN_ON_ONCE(regs != task_pt_regs(current));
> +	}
> +}
> +#define arch_check_user_regs arch_check_user_regs

Will architectures implement subsets of these functions? (i.e. instead
of each of the defines, is CONFIG_ENTRY_GENERIC sufficient for the
no-op inlines?)

> +
> +static inline long arch_syscall_enter_seccomp(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_SECCOMP
> +	u32 arch = in_ia32_syscall() ? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
> +	struct seccomp_data sd;
> +
> +	sd.arch = arch;
> +	sd.nr = regs->orig_ax;
> +	sd.instruction_pointer = regs->ip;
> +
> +#ifdef CONFIG_X86_64
> +	if (arch == AUDIT_ARCH_X86_64) {
> +		sd.args[0] = regs->di;
> +		sd.args[1] = regs->si;
> +		sd.args[2] = regs->dx;
> +		sd.args[3] = regs->r10;
> +		sd.args[4] = regs->r8;
> +		sd.args[5] = regs->r9;
> +	} else
> +#endif
> +	{
> +		sd.args[0] = regs->bx;
> +		sd.args[1] = regs->cx;
> +		sd.args[2] = regs->dx;
> +		sd.args[3] = regs->si;
> +		sd.args[4] = regs->di;
> +		sd.args[5] = regs->bp;
> +	}
> +
> +	return __secure_computing(&sd);
> +#else
> +	return 0;
> +#endif
> +}
> +#define arch_syscall_enter_seccomp arch_syscall_enter_seccomp

Actually, I've been meaning to clean this up. It's not needed at all.
This was left over from the seccomp fast-path code that got ripped out a
while ago. seccomp already has everything it needs to do this work, so
just:

	__secure_computing(NULL);

is sufficient for every architecture that supports seccomp. (See kernel/seccomp.c
populate_seccomp_data().)

And if you want more generalization work, note that the secure_computing()
macro performs a TIF test before calling __secure_computing(NULL). But
my point is, I think arch_syscall_enter_seccomp() is not needed.

> +static inline void arch_syscall_enter_audit(struct pt_regs *regs)
> +{
> +#ifdef CONFIG_X86_64
> +	if (in_ia32_syscall()) {
> +		audit_syscall_entry(regs->orig_ax, regs->di,
> +				    regs->si, regs->dx, regs->r10);
> +	} else
> +#endif
> +	{
> +		audit_syscall_entry(regs->orig_ax, regs->bx,
> +				    regs->cx, regs->dx, regs->si);
> +	}
> +}
> +#define arch_syscall_enter_audit arch_syscall_enter_audit

Similarly, I think these can be redefined in the generic case
using the existing accessors for syscall arguments, etc. e.g.
arch_syscall_enter_audit() is not needed for any architecture, and the
generic is:

	unsigned long args[6];

        syscall_get_arguments(task, regs, args);
	audit_syscall_entry(syscall_get_nr(current, regs),
			    args[0], args[1], args[2], args[3]);



-- 
Kees Cook
