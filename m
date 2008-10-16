From: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 2/4] idle cputime accounting
Date: Thu, 16 Oct 2008 15:59:09 +1100
Message-ID: <18678.51741.878923.169870@cargo.ozlabs.ibm.com>
References: <20081008161958.767142939@de.ibm.com>
	<20081008162144.500130264@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:57271 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986AbYJPE7Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Oct 2008 00:59:25 -0400
In-Reply-To: <20081008162144.500130264@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

Martin Schwidefsky writes:

> The cpu time spent by the idle process actually doing something is
> currently accounted as idle time. This is plain wrong, the architectures
> that support VIRT_CPU_ACCOUNTING=y can do better: distinguish between the
> time spent doing nothing and the time spent by idle doing work. The first
> is accounted with account_steal_time and the second with account_idle_time.

I don't think what you said in that last sentence is correct.  If the
hypervisor takes cpu time away from us while we're doing nothing,
that's still idle time, not stolen time.  Otherwise, imagine the
situation where we have one process running periodically and using say
2% of the cpu, and nothing else (except the idle tasks) running.  At
the moment the kernel will report 98% idle and 0% stolen, which makes
sense.  If we do what you say above, then the kernel will report close
to 0% idle and 98% stolen time.  That looks like this partition is
fully loaded and the machine as a whole is quite overloaded, which is
incorrect.

However, that doesn't seem to be what your patch does, at least as far
as powerpc is concerned.  What you seem to have done in the patch is
to move the logic that says "stolen time is idle time if stolen from
the idle task" from generic code into arch-specific code.  Which is
fine, but it isn't mentioned in your patch description.

> This patch contains the necessary common code changes to be able to
> distinguish idle system time and true idle time. The architectures with
> support for VIRT_CPU_ACCOUNTING need some changes to exploit this.

I can't see how you can make that distinction without adding hooks
into the idle task code so it can say "now we're really idle" and "now
we're executing idle task stuff".  I don't see that this patch does
that for any architecture.  Is that what your last sentence above is
saying?

Finally, with this patch I get the following compilation error on
powerpc:

arch/powerpc/kernel/process.c: In function '__switch_to':
arch/powerpc/kernel/process.c:400: error: implicit declaration of function 'account_process_tick'
make[2]: *** [arch/powerpc/kernel/process.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2

Overall, most of the patch looks OK, but the patch description needs
to explain things more clearly.

Paul.
