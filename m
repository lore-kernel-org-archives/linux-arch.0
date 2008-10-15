From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/4] [RFC] true vs. system idle cputime
Date: Wed, 15 Oct 2008 16:01:56 +0200
Message-ID: <1224079316.16990.28.camel@localhost>
References: <20081008161958.767142939@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate2.de.ibm.com ([195.212.17.162]:48091 "EHLO
	mtagate2.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbYJOOEu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Oct 2008 10:04:50 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.1/8.13.1) with ESMTP id m9FE4mZC018235
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2008 14:04:48 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m9FE4dvA1814660
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2008 16:04:40 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m9FE4Xwf003517
	for <linux-arch@vger.kernel.org>; Wed, 15 Oct 2008 16:04:34 +0200
In-Reply-To: <20081008161958.767142939@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

On Wed, 2008-10-08 at 18:19 +0200, Martin Schwidefsky wrote:
> Greetings,
> while working on the analysis of a mismatch between the cputime accounting
> numbers of z/VM as the host and Linux as the guest I started to wonder
> about the accounting of idle time. z/VM showed more cpu time for the guest
> as the guest itself. With the current code everything that the idle process
> does is accounted as idle time. If idle is sleeping that is fine, but if
> idle is actually using cpu cycles this is wrong.
> 
> The question is how wrong? To find out I've implemented really precise
> accounting of true idle vs. system idle cputime for s390. A really simple
> test that wakes up 100 times per second to do some minimal work before
> going back to sleep showed 0.35% of system idle time. If you are dealing
> with lots of virtual penguins this quickly becomes significant.
> 
> There are four patches in this series:
> Patch #1: Cleanup scaled / unscaled cputime accounting
> Patch #2: Change the accounting interface to allow the architectures to do
>           precise idle time accounting
> Patch #3: s390 patch to improve the precision of the idle_time_us value
> Patch #4: s390 patch to implement improved idle time accounting
> 
> There is one change in patch #2 that might require a change on powerpc
> and/or ia64. The generic TICK_ONESHOT/NO_HZ code calculates the number
> of ticks spent with a disabled HZ timer and accounts this as idle time.
> For a configuration for VIRT_CPU_ACCOUNTING=y this is horribly wrong.
> Either you have precise accounting or you don't. Patch #2 just removes
> the calculation for VIRT_CPU_ACCOUNTING=y. The architectures which support
> precise accounting have to deal with it on their own. This is where the
> powerpc and ia64 maintainer come into play. Would you look at patch #2
> please ?
> 
> To make it clearer what happens in tick_nohz_restart_sched_tick I've added
> a new function account_idle_ticks(). And for good measure another one named
> account_steal_ticks() for xen where "interesting" things have been done
> with the account_steal_time interface.

Any news about powerpc? Do these patches break anything or does it work?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
