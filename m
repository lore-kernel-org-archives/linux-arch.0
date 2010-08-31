From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 08/20] powerpc: Preemptible mmu_gather
Date: Tue, 31 Aug 2010 11:14:44 +0200
Message-ID: <1283246084.2059.66.camel@laptop>
References: <20100828141637.421594670@chello.nl>
	 <20100828142455.960494507@chello.nl>  <1283236004.2151.33.camel@pasglop>
	 <1283236265.2151.35.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283236265.2151.35.camel@pasglop>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Tue, 2010-08-31 at 16:31 +1000, Benjamin Herrenschmidt wrote:

> Of course, with -rt and the pte lock becoming a mutex, all of your
> changes do become necessary (and I suppose that's where they come from).
>
> Now, those changes won't technically hurt on a non-rt kernel, tho they
> will add a tiny bit of overhead. I'll see if I can measure it.

Indeed, those parts are only strictly needed for -rt, I was hoping the
tiny bit of overhead wouldn't be too bad and we could keep it.

If not I guess we should put those two bits in __switch_to() under
CONFIG_PREEMPT_RT and carry them there for a little while longer.

> > I suppose that's what's causing the similar patch you have in -rt to
> > fail btw. This could be fixed easily by using "current" instead.
> 
> And here's a fix. Using current_thread_info() everywhere is better
> anyways, you are not supposed to touch the local_flags within anything
> but "current" so we may as well make it explicit.
> 
> Feel free to fold that into your -rt patch and this one if you decide
> not to drop that whole part. 

Thanks! And yeah I'd prefer to keep it to reduce Thomas' burden if
possible.
