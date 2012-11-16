From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH v1 16/31] ARC: Signal handling
Date: Fri, 16 Nov 2012 05:26:28 +0000
Message-ID: <20121116052628.GC22671@ZenIV.linux.org.uk>
References: <1352281674-2186-1-git-send-email-vgupta@synopsys.com>
 <1352281674-2186-17-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58478 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab2KPF03 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2012 00:26:29 -0500
Content-Disposition: inline
In-Reply-To: <1352281674-2186-17-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, arnd@arndb.de

> +	if (insyscall) {
> +		/* No handler for syscall: restart it */
> +		if (regs->r0 == -ERESTARTNOHAND ||
> +		    regs->r0 == -ERESTARTSYS || regs->r0 == -ERESTARTNOINTR) {
> +			regs->r0 = regs->orig_r0;
> +			regs->ret -= 4;
> +		} else if (regs->r0 == -ERESTART_RESTARTBLOCK) {
> +			regs->r8 = __NR_restart_syscall;
> +			regs->ret -= 4;
> +		}

What's to prevent double decrement on ->ret if two signals arrive?   Note
that e.g. x86 gets away with similar code only because it uses the same
register for syscall number and return value; since none of -ERESTART...
is a valid syscall number, we either won't get into an analog of that code at
all (-ENOSYS is not restart-worthy) or will revert to a value that is
a valid syscall number, so all subsequent do_signal() calls will not hit
that code.  This is subtle and unfortunately not spelled out in the
architectures where it is enough.

You need to make sure that after the first restart in_syscall() will be false.
Same ought to be done in sigreturn(), BTW...
