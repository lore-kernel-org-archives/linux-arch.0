From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Date: Sun, 4 May 2008 11:00:25 +0200
Message-ID: <20080504090024.GA29318@elte.hu>
References: <1209832169.6929.42.camel@lappy> <20080503170130.GB21967@elte.hu> <20080503.212607.157994166.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:41250 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262AbYEDJAn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 4 May 2008 05:00:43 -0400
Content-Disposition: inline
In-Reply-To: <20080503.212607.157994166.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: a.p.zijlstra@chello.nl, tglx@linutronix.de, guichaz@gmail.com, andi@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, efault@gmx.de, dhaval@linux.vnet.ibm.com


* David Miller <davem@davemloft.net> wrote:

> > that wont work very well when sched_clock() is called from within 
> > CONFIG_LOCK_STAT instrumentation. Does the patch below solve the 
> > boot problems for you?
> 
> Also, no platform can set HAVE_STABLE_CLOCK until we instantiate it in 
> a Kconfig somewhere.  I've choosen to do it in kernel/Kconfig.hz and 
> here are the sparc/sparc64 bits as well, I've booted this up with 
> Peter's patch on my 64-cpu niagara2 box and done some basic testing.

applied, thanks David.

right now this topic looks good in review and in testing but it is 
stalled on a bug: in overnight testing it triggered an ftrace self-test 
hang that i bisected down to that patch. While that doesnt affect 
mainline it's something that shows that the new sched_clock() code is 
not as widely usable as the old code - have to investigate that some 
more.

> It would be nice if a powerpc person could test the trivial powerpc 
> Kconfig patch.
> 
> Possibly this should be HAVE_UNSTABLE_CLOCK, then only one platform 
> needs to set it :-)

heh, indeed :)

Initially i thought that it's better to first be safe, but this really 
will only affect x86 in practice, so ... i think we'll switch around the 
flag, turning this into a no-effort thing for everything but x86.

	Ingo
