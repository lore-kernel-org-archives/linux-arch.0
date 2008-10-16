From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/4] idle cputime accounting
Date: Thu, 16 Oct 2008 08:42:49 +0200
Message-ID: <1224139369.6228.8.camel@localhost>
References: <20081008161958.767142939@de.ibm.com>
	 <20081008162144.500130264@de.ibm.com>
	 <18678.51741.878923.169870@cargo.ozlabs.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:38167 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbYJPGrV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Oct 2008 02:47:21 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9G6lEBF214884
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2008 06:47:14 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m9G6lE7r4046938
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2008 08:47:14 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m9G6lCLa013406
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2008 08:47:14 +0200
In-Reply-To: <18678.51741.878923.169870@cargo.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

On Thu, 2008-10-16 at 15:59 +1100, Paul Mackerras wrote:
> Martin Schwidefsky writes:
> 
> > The cpu time spent by the idle process actually doing something is
> > currently accounted as idle time. This is plain wrong, the architectures
> > that support VIRT_CPU_ACCOUNTING=y can do better: distinguish between the
> > time spent doing nothing and the time spent by idle doing work. The first
> > is accounted with account_steal_time and the second with account_idle_time.
> 
> I don't think what you said in that last sentence is correct.  If the
> hypervisor takes cpu time away from us while we're doing nothing,
> that's still idle time, not stolen time.  Otherwise, imagine the
> situation where we have one process running periodically and using say
> 2% of the cpu, and nothing else (except the idle tasks) running.  At
> the moment the kernel will report 98% idle and 0% stolen, which makes
> sense.  If we do what you say above, then the kernel will report close
> to 0% idle and 98% stolen time.  That looks like this partition is
> fully loaded and the machine as a whole is quite overloaded, which is
> incorrect.

True, that is nonsense. It should be "The first is accounted with
account_idle_time and the second with account_system_time." I'll fix the
description, good catch. The point I'm trying to make is that it is a
difference if idle is actively using the cpu vs it is truly idle. If it
is using the cpu and the hypervisor steals cpu then this has to be added
as steal time.

> However, that doesn't seem to be what your patch does, at least as far
> as powerpc is concerned.  What you seem to have done in the patch is
> to move the logic that says "stolen time is idle time if stolen from
> the idle task" from generic code into arch-specific code.  Which is
> fine, but it isn't mentioned in your patch description.

That is what is done for powerpc until you can come up with an improved
method to measure true idle time.

> > This patch contains the necessary common code changes to be able to
> > distinguish idle system time and true idle time. The architectures with
> > support for VIRT_CPU_ACCOUNTING need some changes to exploit this.
> 
> I can't see how you can make that distinction without adding hooks
> into the idle task code so it can say "now we're really idle" and "now
> we're executing idle task stuff".  I don't see that this patch does
> that for any architecture.  Is that what your last sentence above is
> saying?

You need to look at patch #3 and patch #4. They are s390 specific and
what they do is to add the required hooks. We already have code that
measures the true idle time which is the time the cpu has an enabled
wait psw loaded. With the two s390 patches the code does a store-clock
right before loading the enabled wait psw and another store-clock as the
first instruction on the asynchronous interrupt paths in entry[64].S.
The difference between these two time stamps is the true idle time.
Is is possible to pull of this scheme on powerpc as well ?

> Finally, with this patch I get the following compilation error on
> powerpc:
> 
> arch/powerpc/kernel/process.c: In function '__switch_to':
> arch/powerpc/kernel/process.c:400: error: implicit declaration of function 'account_process_tick'
> make[2]: *** [arch/powerpc/kernel/process.o] Error 1
> make[1]: *** [arch/powerpc/kernel] Error 2

This is with CONFIG_VIRT_CPU_ACCOUNTING=y?

> Overall, most of the patch looks OK, but the patch description needs
> to explain things more clearly.

Yes, I'll fix it.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
