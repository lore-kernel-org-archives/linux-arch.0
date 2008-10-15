From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch 0/4] [RFC] true vs. system idle cputime
Date: Thu, 16 Oct 2008 07:56:30 +1100
Message-ID: <1224104190.8157.473.camel@pasglop>
References: <20081008161958.767142939@de.ibm.com>
	 <1224079316.16990.28.camel@localhost>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:33902 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbYJOU54 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Oct 2008 16:57:56 -0400
In-Reply-To: <1224079316.16990.28.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

On Wed, 2008-10-15 at 16:01 +0200, Martin Schwidefsky wrote:
> > There is one change in patch #2 that might require a change on powerpc
> > and/or ia64. The generic TICK_ONESHOT/NO_HZ code calculates the number
> > of ticks spent with a disabled HZ timer and accounts this as idle time.
> > For a configuration for VIRT_CPU_ACCOUNTING=y this is horribly wrong.
> > Either you have precise accounting or you don't. Patch #2 just removes
> > the calculation for VIRT_CPU_ACCOUNTING=y. The architectures which support
> > precise accounting have to deal with it on their own. This is where the
> > powerpc and ia64 maintainer come into play. Would you look at patch #2
> > please ?
> > 
> > To make it clearer what happens in tick_nohz_restart_sched_tick I've added
> > a new function account_idle_ticks(). And for good measure another one named
> > account_steal_ticks() for xen where "interesting" things have been done
> > with the account_steal_time interface.
> 
> Any news about powerpc? Do these patches break anything or does it work?

I didn't have a chance to look at it yet. I'll try to get that looked at
today.

Cheers,
Ben.
