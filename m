From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH] doc: Replace smp_cond_acquire() with
 smp_cond_load_acquire()
Date: Wed, 11 Jul 2018 17:53:55 +0200
Message-ID: <20180711154830.GA14348@andrea>
References: <1531216943-6382-1-git-send-email-andrea.parri@amarulasolutions.com>
 <1531314530-11624-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180711153840.GS3593@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180711153840.GS3593@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 11, 2018 at 08:38:40AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 11, 2018 at 03:08:50PM +0200, Andrea Parri wrote:
> > Amend commit 1f03e8d2919270 ("locking/barriers: Replace smp_cond_acquire()
> > with smp_cond_load_acquire()") by updating the documentation accordingly.
> > Also remove some obsolete information related to the implementation.
> > 
> > Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> > Cc: Luc Maranget <luc.maranget@inria.fr>
> > Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> > Cc: Daniel Lustig <dlustig@nvidia.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > ---
> >  Documentation/memory-barriers.txt | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> I have queued this for further review, thank you!  Just to confirm,
> the reason that the old passage was obsolete is because ARMv8 implements
> smp_cond_load_acquire() as a straight acquire load, correct?

Thanks.  Yes; the generic code builds on a control dependency and an
smp_acquire__after_ctrl_dep() (which defaults to smp_rmb()); but the
required ordering on arm64 is given by (its) smp_load_acquire().

I thought that entering this level of details (and keeping it up-to-
date ;) wasn't really worth/needed for this high-level doc.

  Andrea


> 
> 							Thanx, Paul
> 
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index 0d8d7ef131e9a..c1d913944ad8b 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -471,8 +471,7 @@ And a couple of implicit varieties:
> >       operations after the ACQUIRE operation will appear to happen after the
> >       ACQUIRE operation with respect to the other components of the system.
> >       ACQUIRE operations include LOCK operations and both smp_load_acquire()
> > -     and smp_cond_acquire() operations. The later builds the necessary ACQUIRE
> > -     semantics from relying on a control dependency and smp_rmb().
> > +     and smp_cond_load_acquire() operations.
> > 
> >       Memory operations that occur before an ACQUIRE operation may appear to
> >       happen after it completes.
> > -- 
> > 2.7.4
> > 
> 
