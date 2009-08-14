From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Fri, 14 Aug 2009 19:13:08 +0200
Message-ID: <20090814171308.GA4906@osiris.boeblingen.de.ibm.com>
References: <20090812183934.777715527@de.ibm.com>
 <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain>
 <20090814123439.GB4959@osiris.boeblingen.de.ibm.com>
 <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate5.uk.ibm.com ([195.212.29.138]:49652 "EHLO
	mtagate5.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755235AbZHNROH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Aug 2009 13:14:07 -0400
Received: from d06nrmr1707.portsmouth.uk.ibm.com (d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate5.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n7EHD9pL373302
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 17:13:09 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com [9.149.37.228])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id n7EHD9jW1724550
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 18:13:09 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id n7EHD8VH019265
	for <linux-arch@vger.kernel.org>; Fri, 14 Aug 2009 18:13:09 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908140840540.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, "David S. Miller" <davem@davemloft.net>

On Fri, Aug 14, 2009 at 09:04:49AM -0700, Linus Torvalds wrote:
> On Fri, 14 Aug 2009, Heiko Carstens wrote:
> > 
> > All of this started when we compared a 2.6.27 based distro kernel
> > to a 2.6.16 based one. It turned out that 2.6.27 burns a lot more cpu
> > cycles than 2.6.16 does for the same workloads.
> > 
> > As an example: we took a simple one connection ping pong network load.
> > (client sends packet to server and waits until packet from server
> >  returns and game starts again). It uses more cpu cycles on 2.6.27.
> > 
> > Using ftrace we figured out that on 2.6.27 it takes more than 500 function
> > calls on the client for a single roundtrip while on 2.6.16 it took only
> > ~230 calls.
> 
> Hmm. But the spinlock part of this seems to not really have changed.
> 
> Removing everything but the actual callchain info, and then doing a "diff" 
> between your two roundtrips, and they look very different, and basically 
> none of the difference seems to be due to spinlocks.
> 
> It seems to be due to a number of different things, but the bulk of the 
> new costs seem to be in networking (and to some degree scheduling). There 
> are smaller differences elsewhere, but the networking code _really_ blows 
> up.
> 
> I don't know how much of some of these are "real" kernel changes, and how 
> much of it is less inlining, but spinlocks don't seem to be the issue. 
> Here's a quick walk-through (some of these get repeated a couple of times 
> in your traces)

That's true. I just wanted to give some background how all of this started.
Spinlocks are equally good or bad for s390 on both kernel versions.

However quite a few of the additional function calls in networking code
come from uninlining:

c2aa270a [NET]: uninline skb_push, de-bloats a lot
6be8ac2f [NET]: uninline skb_pull, de-bloats a lot
419ae74e [NET]: uninline skb_trim, de-bloats

Christian Ehrhardt identified these and more, but hasn't posted patches
yet. Reverting these patches does increase performance.

That's when I started wondering what we would gain when we would inline
spinlock code again.

>  * the timer code doing more:
> 
> 	__timer_stats_timer_set_start_info <-mod_timer
> 	__mod_timer <-mod_timer
> 	__timer_stats_timer_set_start_info <-__mod_timer
> 	lock_timer_base <-__mod_timer
> 	_spin_lock_irqsave <-lock_timer_base
> 	internal_add_timer <-__mod_timer
> 	_spin_unlock_irqrestore <-__mod_timer
> 	qdio_perf_stat_inc <-qdio_outbound_processing
> 	account_system_vtime <-__do_softirq

This should be better now:

507e1231 timer stats: Optimize by adding quick check to avoid function calls

We did also address our device driver with several patches.
