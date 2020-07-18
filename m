From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Sat, 18 Jul 2020 12:00:01 +1000
Message-ID: <20200718020001.GO5369@dread.disaster.area>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717205340.GR7625@magnolia>
 <20200718005857.GB2183@sol.localdomain>
 <20200718012555.GA1168834@rowland.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:55270 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726665AbgGRCAJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 22:00:09 -0400
Content-Disposition: inline
In-Reply-To: <20200718012555.GA1168834@rowland.harvard.edu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Eric Biggers <ebiggers@kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, Jul 17, 2020 at 09:25:55PM -0400, Alan Stern wrote:
> On Fri, Jul 17, 2020 at 05:58:57PM -0700, Eric Biggers wrote:
> > On Fri, Jul 17, 2020 at 01:53:40PM -0700, Darrick J. Wong wrote:
> > > > +There are also cases in which the smp_load_acquire() can be replaced by
> > > > +the more lightweight READ_ONCE().  (smp_store_release() is still
> > > > +required.)  Specifically, if all initialized memory is transitively
> > > > +reachable from the pointer itself, then there is no control dependency
> > > 
> > > I don't quite understand what "transitively reachable from the pointer
> > > itself" means?  Does that describe the situation where all the objects
> > > reachable through the object that the global struct foo pointer points
> > > at are /only/ reachable via that global pointer?
> > > 
> > 
> > The intent is that "transitively reachable" means that all initialized memory
> > can be reached by dereferencing the pointer in some way, e.g. p->a->b[5]->c.
> > 
> > It could also be the case that allocating the object initializes some global or
> > static data, which isn't reachable in that way.  Access to that data would then
> > be a control dependency, which a data dependency barrier wouldn't work for.
> > 
> > It's possible I misunderstood something.  (Note the next paragraph does say that
> > using READ_ONCE() is discouraged, exactly for this reason -- it can be hard to
> > tell whether it's correct.)  Suggestions of what to write here are appreciated.
> 
> Perhaps something like this:
> 
> 	Specifically, if the only way to reach the initialized memory 
> 	involves dereferencing the pointer itself then READ_ONCE() is 
> 	sufficient.  This is because there will be an address dependency 
> 	between reading the pointer and accessing the memory, which will 
> 	ensure proper ordering.  But if some of the initialized memory 
> 	is reachable some other way (for example, if it is global or 
> 	static data) then there need not be an address dependency, 
> 	merely a control dependency (checking whether the pointer is 
> 	non-NULL).  Control dependencies do not always ensure ordering 
> 	-- certainly not for reads, and depending on the compiler, 
> 	possibly not for some writes -- and therefore a load-acquire is 
> 	necessary.

Recipes are aimed at people who simply don't understand any of that
goobledegook. This won't help them -write correct code-.

> Perhaps this is more wordy than you want, but it does get the important 
> ideas across.

You think they are important because you understand what those words
mean.  Large numbers of developers do not understand what they mean,
nor how to put them into practise correctly.

Seriously: if you want people to use this stuff correctly, you need
to -dumb it down-, not make it even more challenging by explaining
words people don't understand with yet more words they don't
understand...

This is the "curse of knowledge" cognative bias in a nutshell.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
