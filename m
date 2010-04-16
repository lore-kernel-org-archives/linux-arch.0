From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/13] powerpc: Add rcu_read_lock() to gup_fast()
 implementation
Date: Fri, 16 Apr 2010 16:54:51 +1000
Message-ID: <1271400891.13059.186.camel@pasglop>
References: <20100408191737.296180458@chello.nl>
	 <20100408192722.643778654@chello.nl> <1271120731.13059.6.camel@pasglop>
	 <20100413034311.GB2772@linux.vnet.ibm.com>
	 <1271253110.32749.47.camel@laptop>
	 <20100415142852.GA2471@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:36899 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab0DPHZp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 16 Apr 2010 03:25:45 -0400
In-Reply-To: <20100415142852.GA2471@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>

On Thu, 2010-04-15 at 07:28 -0700, Paul E. McKenney wrote:
> 
> Of course, with call_rcu_sched(), the corresponding RCU read-side
> critical
> sections are non-preemptible.  Therefore, in CONFIG_PREEMPT_RT, these
> read-side critical sections must use raw spinlocks.
> 
> Can the code in question accommodate these restrictions? 

What we protect against is always code that hard-disable IRQs (though
there seem to be a bug in the hugepages code there...). Would that
work ?

Cheers,
Ben.
