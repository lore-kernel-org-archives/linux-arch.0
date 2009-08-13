From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 0/3] Allow inlined spinlocks again V3
Date: Thu, 13 Aug 2009 11:11:22 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908131100000.28882@localhost.localdomain>
References: <20090812183934.777715527@de.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49803 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751967AbZHMSLv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Aug 2009 14:11:51 -0400
In-Reply-To: <20090812183934.777715527@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>



On Wed, 12 Aug 2009, Heiko Carstens wrote:
> 
> This patch set allows to have inlined spinlocks again.

I'm not convinced this is the right approach.

The thing is, CONFIG_SPINLOCK_INLINE doesn't look like the right thing to 
do. On x86, for example, functions calls are usually quite cheap, and it 
may well make sense to keep 'spin_lock()' out-of-line, especially once you 
start doing things like playing with the softirq counts or interrupts.

At the same time, the special case of spin *unlock* is generally just a 
single (small) instruction on x86, so that one almost certainly is worth 
inlining - at least as long as it's not one of the softirq ones.

In other words, I think your hammer is too large. If you want to inline 
the lock functions, you should _not_ make this a single "everything or 
nothing" thing.

> If one considers that server kernels are usually compiled with
> !CONFIG_PREEMPT a simple spin_lock is just a compare and swap loop.
> The extra overhead for a function call is significant.
> With inlined spinlocks overall cpu usage gets reduced by 1%-5% on s390.
> These numbers were taken with some network benchmarks. However I expect
> any workload that calls frequently into the kernel and which grabs a few
> locks to perform better.

Have you tried to determine which kinds of spinlocks you care most about? 
With networking, I guess the softirq-safe ones (and perhaps the irq ones) 
are pretty common, but maybe even there it's really just a couple of 
cases. 

Now, there is one advantage to inlining that I really like - and that I 
personally have missed from the days when we used to always do it: 
profiling. Inlining the spinlocks tends to do _wonders_ for showing 
exactly which spinlock ends up being the contention cases for certain 
loads.

So there are advantages outside of the "size vs speed" kind of things, but 
at the same time I do suspect that the disadvantages mean that we really 
should make this be something where an architecture can specify things at 
a finer granularity. Perhaps by using per-symbol defines (ie have the 
<asm/spinlock.h> file do things like

	#define __spin_lock_is_small
	#define __spin_unlock_is_small

kind of things for the particular sequences that are worth inlining.

		Linus
