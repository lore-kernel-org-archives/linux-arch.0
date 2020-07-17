From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Fri, 17 Jul 2020 13:35:43 +0100
Message-ID: <20200717123543.GO12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQMfw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 08:35:52 -0400
Content-Disposition: inline
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> +The simplest implementation just uses a mutex and an 'inited' flag.

There's a perfectly good real word "initialised" / initialized.
https://chambers.co.uk/search/?query=inited&title=21st

> +For the single-pointer case, a further optimized implementation
> +eliminates the mutex and instead uses compare-and-exchange:
> +
> +	static struct foo *foo;
> +
> +	int init_foo_if_needed(void)
> +	{
> +		struct foo *p;
> +
> +		/* pairs with successful cmpxchg_release() below */
> +		if (smp_load_acquire(&foo))
> +			return 0;
> +
> +		p = alloc_foo();
> +		if (!p)
> +			return -ENOMEM;
> +
> +		/* on success, pairs with smp_load_acquire() above and below */
> +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> +			free_foo(p);
> +			/* pairs with successful cmpxchg_release() above */
> +			smp_load_acquire(&foo);
> +		}
> +		return 0;
> +	}
> +
> +Note that when the cmpxchg_release() fails due to another task already
> +having done it, a second smp_load_acquire() is required, since we still
> +need to acquire the data that the other task released.  You may be
> +tempted to upgrade cmpxchg_release() to cmpxchg() with the goal of it
> +acting as both ACQUIRE and RELEASE, but that doesn't work here because
> +cmpxchg() only guarantees memory ordering if it succeeds.
> +
> +Because of the above subtlety, the version with the mutex instead of
> +cmpxchg_release() should be preferred, except potentially in cases where
> +it is difficult to provide anything other than a global mutex and where
> +the one-time data is part of a frequently allocated structure.  In that
> +case, a global mutex might present scalability concerns.

There are concerns other than scalability where we might want to eliminate
the mutex.  For example, if (likely) alloc_foo() needs to allocate memory
and we would need foo to perform page writeback, then either we must
allocate foo using GFP_NOFS or do without the mutex, lest we deadlock
on this new mutex.

You might think this would argue for just using GFP_NOFS always, but
GFP_NOFS is a big hammer which forbids reclaiming from any filesystem,
whereas we might only need this foo to reclaim from a particular
filesystem.
