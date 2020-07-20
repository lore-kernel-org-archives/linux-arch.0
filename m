From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 20 Jul 2020 15:06:51 -0700
Message-ID: <20200720220651.GV9247@paulmck-ThinkPad-P72>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200718014204.GN5369@dread.disaster.area>
 <20200718140811.GA1179836@rowland.harvard.edu>
 <20200720013320.GP5369@dread.disaster.area>
 <20200720145211.GC1228057@rowland.harvard.edu>
 <20200720153911.GX12769@casper.infradead.org>
 <20200720160433.GQ9247@paulmck-ThinkPad-P72>
 <20200720164850.GF119549@hirez.programming.kicks-ass.net>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTWGw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Jul 2020 18:06:52 -0400
Content-Disposition: inline
In-Reply-To: <20200720164850.GF119549@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org
Cc: Matthew Wilcox <willy@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Dave Chinner <david@fromorbit.com>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Will Deacon <will@kernel.org>

On Mon, Jul 20, 2020 at 06:48:50PM +0200, peterz@infradead.org wrote:
> On Mon, Jul 20, 2020 at 09:04:34AM -0700, Paul E. McKenney wrote:
> > 2.	If we were to say "unlock" instead of "release", consistency
> > 	would demand that we also say "lock" instead of "acquire".
> > 	But "lock" is subtlely different than "acquire", and there is
> > 	a history of people requesting further divergence.
> 
> This, acquire/release are RCpc, while (with the exception of Power)
> LOCK/UNLOCK are RCsc.
> 
> ( Or did we settle on RCtso for our release/acquire order? I have vague
> memories of a long-ish thread, but seem to have forgotten the outcome,
> if any. )
> 
> Lots of subtlety and head-aches right about there. Anyway, it would be
> awesome if we can get Power into the RCsc locking camp :-)

I will let you take that one up with the Power folks.

But I should give an example of a current difference between lock and
acquire, and just to spread the blame, I will pick on an architecture
other than Power.  ;-)

With lock acquisition, the following orders the access to X and Z:

	WRITE_ONCE(X, 1);
	spin_lock(&my_lock);
	smp_mb__after_lock();
	r1 = READ_ONCE(Z);

But if we replace the lock acquisition with a load acquire, there are
no ordering guarantees for the accesses to X and Z:

	WRITE_ONCE(X, 1);
	r2 = smp_load_acquire(&Y);
	smp_mb__after_lock();  // Yeah, there is no lock.  ;-)
	r3 = READ_ONCE(Z);

There -is- ordering between the accesses to Y and Z, but not to X and Z.
This is not a theoretical issue.  The x86 platform really can reorder
the access to X to follow that of both Y and Z.

So the memory-model divergence between lock acquisition and acquire
loads is very real in the here and now.

							Thanx, Paul
