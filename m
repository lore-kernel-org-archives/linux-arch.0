From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Tue, 14 Jul 2015 08:37:30 +1000
Message-ID: <1436827050.3948.236.camel@kernel.crashing.org>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
	 <20150713131143.GY19282@twins.programming.kicks-ass.net>
	 <20150713140915.GD2632@arm.com> <20150713142109.GE2632@arm.com>
	 <20150713155447.GB19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48076 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbbGMWiF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 13 Jul 2015 18:38:05 -0400
In-Reply-To: <20150713155447.GB19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, 2015-07-13 at 17:54 +0200, Peter Zijlstra wrote:

> That said, I don't think this could even happen on PPC because we have
> load_acquire and store_release, this means that:
> 
> 	*A = a
> 	lwsync
> 	store_release M
> 	load_acquire N
> 	lwsync
> 	*B = b
> 
> And since the store to M is wrapped inside two lwsync there must be
> strong store order, and because the load from N is equally wrapped in
> two lwsyncs there must also be strong load order.
> 
> In fact, no store/load can cross from before the first lwsync to after
> the latter and the other way around.
> 
> So in that respect it does provide full load-store ordering. What it
> does not provide is order for M and N, nor does it provide transitivity,
> but looking at our documentation I'm not at all sure we guarantee that
> in any case.

The problem is if you have a load after the second lwsync, that load can
go up pass the store release. This has caused issues when N or M is what
you are trying to order against. That's why we had to add a sync to
spin_is_locked or similar.

Ben.

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
