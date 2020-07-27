From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 27 Jul 2020 13:51:37 +0100
Message-ID: <20200727125137.GK23808@casper.infradead.org>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200717175138.GB1156312@rowland.harvard.edu>
 <20200718010247.GC2183@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgG0Mvn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 08:51:43 -0400
Content-Disposition: inline
In-Reply-To: <20200718010247.GC2183@sol.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, Jul 17, 2020 at 06:02:47PM -0700, Eric Biggers wrote:
> On Fri, Jul 17, 2020 at 01:51:38PM -0400, Alan Stern wrote:
> > On Fri, Jul 17, 2020 at 06:47:50PM +0100, Matthew Wilcox wrote:
> > > On Thu, Jul 16, 2020 at 09:44:27PM -0700, Eric Biggers wrote:
> > ...
> > > > +		/* on success, pairs with smp_load_acquire() above and below */
> > > > +		if (cmpxchg_release(&foo, NULL, p) != NULL) {
> > > 
> > > Why do we have cmpxchg_release() anyway?  Under what circumstances is
> > > cmpxchg() useful _without_ having release semantics?
> > 
> > To answer just the last question: cmpxchg() is useful for lock 
> > acquisition, in which case it needs to have acquire semantics rather 
> > than release semantics.
> > 
> 
> To clarify, there are 4 versions of cmpxchg:
> 
> 	cmpxchg(): does ACQUIRE and RELEASE (on success)
> 	cmpxchg_acquire(): does ACQUIRE only (on success)
> 	cmpxchg_release(): does RELEASE only (on success)
> 	cmpxchg_relaxed(): no barriers
> 
> The problem here is that here we need RELEASE on success and ACQUIRE on failure.
> But no version guarantees any barrier on failure.

Why not?  Do CPU designers not do load-linked-with-acquire-semantics?
Or is it our fault for not using the appropriate instruction?

> So as far as I can tell, the best we can do is use cmpxchg_release() (or
> cmpxchg() which would be stronger but unnecessary), followed by a separate
> ACQUIRE on failure.

OK, but that detail needs to be hidden behind a higher level primitive,
not exposed to device driver writers.
