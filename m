Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261430AbUKVOaK@vger.kernel.org>
Received: from p508B767E.dip.t-dialin.net ([80.139.118.126]:2353 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S261387AbUKVO32
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Nov 2004 09:29:28 -0500
Date: Mon, 22 Nov 2004 15:29:21 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Unknown traps.
Message-ID: <20041122142921.GB3230@linux-mips.org>
References: <OFE35549E9.20C1C2B2-ON42256F50.00448A0C-42256F50.0049E9FE@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFE35549E9.20C1C2B2-ON42256F50.00448A0C-42256F50.0049E9FE@de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 18, 2004 at 03:27:20PM +0200, Martin Schwidefsky wrote:

> Hi,
> while working on a deficiency in the illegal operation handler for
> s390 (only emits a force_sig instead of a force_sig_info) I stumbled
> over something odd: How are unknown traps handled properly?
> 
> Of the architectures where I have some clue what they are doing:
> 
> i386: doesn't handle unknown traps (idt_table entries with {0,0})
> ia64: does a force_sig with SIGILL.
> parisc: does a force_sig_info with SIGBUS/BUS_OBJERR.
> ppc: doesn't handle unknown traps (?).
> s390: does a force_sig with SIGSEGV.
> sparc: does a force_sig_info with SIGILL/ILL_ILLTRP.
> x86_64: doesn't handle unknown traps (idt_table entries with {0,0})
> 
> What is correct? For s390 I'd like to do a force_sig_info of some
> kind, SIGBUS/BUS_OBJERR is a likely choice.

I'm reacting a bit harsher on MIPS:

asmlinkage void do_reserved(struct pt_regs *regs)
{
        /*
         * Game over - no way to handle this if it ever occurs.  Most probably
         * caused by a new unknown cpu type or after another deadly
         * hard/software error.
         */
        show_regs(regs);
        panic("Caught reserved exception %ld - should not happen.",
              (regs->cp0_cause & 0x7f) >> 2);
}

If this is happening it's a severe kernel or hardware problem and it's not
clear if continuing is safe or how to recover, so game over.

  Ralf
