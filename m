Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:12507
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030283AbWHHWY7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Aug 2006 18:24:59 -0400
Date: Tue, 08 Aug 2006 15:25:04 -0700 (PDT)
Message-Id: <20060808.152504.55835990.davem@davemloft.net>
Subject: Re: Signal restarting happing multiple time in do_signal
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060808110437.GB18770@linux-mips.org>
References: <20060808110437.GB18770@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: ralf@linux-mips.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Ralf Baechle <ralf@linux-mips.org>
Date: Tue, 8 Aug 2006 12:04:37 +0100

> We were able to trigger this when debugging a multithreaded programs.
> At least i386 uses virtually identical algorithms so I think is likely
> to have the same issue.

Other platforms, including x86, clear the state out in one way or
another before the next iteration.

Actually on x86 it occurs as a side effect of setting
regs->eax, it is reset to the system call number requested
at syscall trap time, so it will not match any of the
error return values in this switch statement:

	/* Are we from a system call? */
	if (regs->orig_eax >= 0) {
		/* If so, check system call restarting.. */
		switch (regs->eax) {
		        case -ERESTART_RESTARTBLOCK:
			case -ERESTARTNOHAND:
				regs->eax = -EINTR;
				break;

			case -ERESTARTSYS:
				if (!(ka->sa.sa_flags & SA_RESTART)) {
					regs->eax = -EINTR;
					break;
				}
			/* fallthrough */
			case -ERESTARTNOINTR:
				regs->eax = regs->orig_eax;
				regs->eip -= 2;
		}
	}

So after the first iteration, the next time through here we
won't be "from a system call".
