From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/13] powerpc: Add rcu_read_lock() to gup_fast()
 implementation
Date: Sat, 17 Apr 2010 09:25:07 +1000
Message-ID: <1271460307.13059.216.camel@pasglop>
References: <20100408191737.296180458@chello.nl>
	 <20100408192722.643778654@chello.nl> <1271120731.13059.6.camel@pasglop>
	 <20100413034311.GB2772@linux.vnet.ibm.com>
	 <1271253110.32749.47.camel@laptop>
	 <20100415142852.GA2471@linux.vnet.ibm.com>
	 <1271400891.13059.186.camel@pasglop>
	 <20100416134336.GA2615@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100416134336.GA2615@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulmck@linux.vnet.ibm.com
Cc: Peter Zijlstra <peterz@infradead.org>, Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>
List-Id: linux-arch.vger.kernel.org

On Fri, 2010-04-16 at 06:43 -0700, Paul E. McKenney wrote:
> So I believe that in this case call_rcu_sched() is your friend.  ;-)

Looks like it :-)

I'll cook up a patch changing my current call_rcu() to call_rcu_sched().

Cheers,
Ben.
