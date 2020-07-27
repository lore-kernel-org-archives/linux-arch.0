From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 27 Jul 2020 09:01:11 -0700
Message-ID: <20200727160111.GH9247@paulmck-ThinkPad-P72>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
 <20200727151746.GC1468275@rowland.harvard.edu>
 <20200727152827.GM23808@casper.infradead.org>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200727152827.GM23808@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 27, 2020 at 04:28:27PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 27, 2020 at 11:17:46AM -0400, Alan Stern wrote:
> > Given a type "T", an object x of type pointer-to-T, and a function
> > "func" that takes various arguments and returns a pointer-to-T, the
> > accepted API for calling func once would be to create once_func() as
> > follows:
> > 
> > T *once_func(T **ppt, args...)
> > {
> > 	static DEFINE_MUTEX(mut);
> > 	T *p;
> > 
> > 	p = smp_load_acquire(ppt);	/* Mild optimization */
> > 	if (p)
> > 		return p;
> > 
> > 	mutex_lock(mut);
> > 	p = smp_load_acquire(ppt);
> > 	if (!p) {
> > 		p = func(args...);
> > 		if (!IS_ERR_OR_NULL(p))
> > 			smp_store_release(ppt, p);
> > 	}
> > 	mutex_unlock(mut);
> > 	return p;
> > }
> > 
> > Users then would have to call once_func(&x, args...) and check the
> > result.  Different x objects would constitute different "once"
> > domains.
> [...]
> > In fact, the only drawback I can think of is that because this relies
> > on a single mutex for all the different possible x's, it might lead to
> > locking conflicts (if func had to call once_func() recursively, for
> > example).  In most reasonable situations such conflicts would not
> > arise.
> 
> Another drawback for this approach relative to my get_foo() approach
> upthread is that, because we don't have compiler support, there's no
> enforcement that accesses to 'x' go through once_func().  My approach
> wraps accesses in a deliberately-opaque struct so you have to write
> some really ugly code to get at the raw value, and it's just easier to
> call get_foo().

Could ACCESS_PRIVATE() help in this case?  This relies on sparse rather
than the compiler, but some of the testing services do run sparse
regularly.

							Thanx, Paul
