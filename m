From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Fri, 17 Jul 2020 18:47:50 +0100
Message-ID: <20200717174750.GQ12769@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> +If that doesn't apply, you'll have to implement one-time init yourself.
> +
> +The simplest implementation just uses a mutex and an 'inited' flag.
> +This implementation should be used where feasible:

I think some syntactic sugar should make it feasible for normal people
to implement the most efficient version of this just like they use locks.

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

Why do we have cmpxchg_release() anyway?  Under what circumstances is
cmpxchg() useful _without_ having release semantics?

> +			free_foo(p);
> +			/* pairs with successful cmpxchg_release() above */
> +			smp_load_acquire(&foo);
> +		}
> +		return 0;
> +	}

How about something like this ...

once.h:

static struct init_once_pointer {
	void *p;
};

static inline void *once_get(struct init_once_pointer *oncep)
{ ... }

static inline bool once_store(struct init_once_pointer *oncep, void *p)
{ ... }

--- foo.c ---

struct foo *get_foo(gfp_t gfp)
{
	static struct init_once_pointer my_foo;
	struct foo *foop;

	foop = once_get(&my_foo);
	if (foop)
		return foop;

	foop = alloc_foo(gfp);
	if (!once_store(&my_foo, foop)) {
		free_foo(foop);
		foop = once_get(&my_foo);
	}

	return foop;
}

Any kernel programmer should be able to handle that pattern.  And no mutex!
