From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Mon, 20 Jul 2020 12:07:31 +1000
Message-ID: <20200720020731.GQ5369@dread.disaster.area>
References: <20200717044427.68747-1-ebiggers@kernel.org>
 <20200717174750.GQ12769@casper.infradead.org>
 <20200718013839.GD2183@sol.localdomain>
 <20200718021304.GS12769@casper.infradead.org>
 <20200718052818.GF2183@sol.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:42707 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgGTCHi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 19 Jul 2020 22:07:38 -0400
Content-Disposition: inline
In-Reply-To: <20200718052818.GF2183@sol.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, Jul 17, 2020 at 10:28:18PM -0700, Eric Biggers wrote:
> What do people think about the following instead?  (Not proofread / tested yet,
> so please comment on the high-level approach, not minor mistakes :-) )

No huge long macros, please.

We don't accept people writing long complex static inline functions,
so for the same reasons it is not acceptable to write long complex
macros.  Especially ones that use variable arguments and embed
invisible locking within them.

The whole serialisation/atomic/ordering APIs have fallen badly off
the macro cliff, to the point where finding out something as simple
as the order of parameters passed to cmpxchg and what semantics it
provides requires macro-spelunking 5 layers deep to find the generic
implementation function that contains a comment describing what it
does....

That's yet another barrier to understanding what all the different
synchronisation primitives do.

....

> In the fs/direct-io.c case we'd use:
> 
> int sb_init_dio_done_wq(struct super_block *sb)
> {
> 	static DEFINE_MUTEX(sb_init_dio_done_mutex);
> 
> 	return INIT_ONCE_PTR(&sb->s_dio_done_wq, &sb_init_dio_done_mutex,
> 			     alloc_workqueue,
> 			     "dio/%s", WQ_MEM_RECLAIM, 0, sb->s_id);
> }

Yeah, that's pretty horrible...

I *much* prefer an API like Willy's suggested to somethign like
this. Just because you can hide all sorts of stuff in macros doesn't
mean you should.

> The only part I really don't like is the way arguments are passed to the
> alloc_func.  We could also make it work like the following, though it would
> break the usual rules since it looks like the function call is always executed,
> but it's not:
> 
> 	return INIT_ONCE_PTR(&sb->s_dio_done_wq, &sb_init_dio_done_mutex,
> 			     alloc_workqueue("dio/%s", WQ_MEM_RECLAIM, 0,
> 					     sb->s_id));

Yeah, that's even worse. Code that does not do what it looks like it
should needs to be nuked from orbit.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
