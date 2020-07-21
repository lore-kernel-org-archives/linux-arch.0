Return-Path: <SRS0=7mXE=BA=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgGUVrU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 17:47:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F165C0619DC
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:47:19 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cv18so1934700pjb.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 14:47:19 -0700 (PDT)
Date: Tue, 21 Jul 2020 14:47:17 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [patch V4 10/15] x86/entry: Use generic syscall entry function
Message-ID: <202007211440.BEF76E2@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.325060396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.325060396@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Keno Fischer <keno@juliacomputing.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <20200721214717.d0E_yDZ0nJrD-0Yp--oSVE3s-k5h8F6r_GbKN0v7kQw@z>

On Tue, Jul 21, 2020 at 12:57:16PM +0200, Thomas Gleixner wrote:
> Replace the syscall entry work handling with the generic version. Provide
> the necessary helper inlines to handle the real architecture specific
> parts, e.g. ptrace.
> 
> Use a temporary define for idtentry_enter_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

Though, notes and a comment below...

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

push, pop, bit test

> +
> +		/* We think we came from user mode. Make sure pt_regs agrees. */
> +		WARN_ON_ONCE(!user_mode(regs));

memory deref, bit test

> +
> +		/*
> +		 * All entries from user mode (except #DF) should be on the
> +		 * normal thread stack and should have user pt_regs in the
> +		 * correct location.
> +		 */
> +		WARN_ON_ONCE(!on_thread_stack());

per-cpu deref, subtract, test

> +		WARN_ON_ONCE(regs != task_pt_regs(current));

memory deref, test

> +	}
> +}

This doesn't look very expensive, and they certain indicate really bad
conditions. Does this need to be behind a CONFIG? (Whatever the answer,
we can probably make those changes in a later series -- some of these
also look not arch-specific...)

-- 
Kees Cook
