From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 01/13] powerpc: Add rcu_read_lock() to gup_fast()
 implementation
Date: Fri, 16 Apr 2010 21:37:02 +0200
Message-ID: <1271446622.1674.433.camel@laptop>
References: <20100413034311.GB2772@linux.vnet.ibm.com>
	 <1271253110.32749.47.camel@laptop>
	 <20100415142852.GA2471@linux.vnet.ibm.com>
	 <1271425881.4807.2319.camel@twins>
	 <20100416141745.GC2615@linux.vnet.ibm.com>
	 <1271427819.4807.2353.camel@twins>
	 <20100416143202.GE2615@linux.vnet.ibm.com>
	 <1271429810.4807.2390.camel@twins>
	 <20100416150909.GF2615@linux.vnet.ibm.com>
	 <1271430855.4807.2411.camel@twins>
	 <20100416164503.GH2615@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:49897 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757978Ab0DPTh6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Apr 2010 15:37:58 -0400
Received: from e35131.upc-e.chello.nl ([213.93.35.131] helo=dyad.programming.kicks-ass.net)
	by bombadil.infradead.org with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1O2rMT-0000zp-RI
	for linux-arch@vger.kernel.org; Fri, 16 Apr 2010 19:37:57 +0000
In-Reply-To: <20100416164503.GH2615@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On Fri, 2010-04-16 at 09:45 -0700, Paul E. McKenney wrote:
> o       mutex_lock(): Critical sections need not guarantee
>         forward progress, as general blocking is permitted.
> 
Right, I would argue that they should guarantee fwd progress, but due to
being able to schedule while holding them, its harder to enforce.

Anything that is waiting for uncertainty should do so without any locks
held and simply re-acquire them once such an event does occur.

> So the easy response is "just use SRCU."  Of course, SRCU has some
> disadvantages at the moment:
> 
> o       The return value from srcu_read_lock() must be passed to
>         srcu_read_unlock().  I believe that I can fix this.
> 
> o       There is no call_srcu().  I believe that I can fix this.
> 
> o       SRCU uses a flat per-CPU counter scheme that is not particularly
>         scalable.  I believe that I can fix this.
> 
> o       SRCU's current implementation makes it almost impossible to
>         implement priority boosting.  I believe that I can fix this.
> 
> o       SRCU requires explicit initialization of the underlying
>         srcu_struct.  Unfortunately, I don't see a reasonable way
>         around this.  Not yet, anyway.
> 
> So, is there anything else that you don't like about SRCU?

No, I quite like SRCU when implemented as preemptible tree RCU, and I
don't at all mind that last point, all dynamic things need some sort of
init. All locks certainly have.
