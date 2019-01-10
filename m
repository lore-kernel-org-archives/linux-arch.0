From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
Date: Fri, 11 Jan 2019 00:20:45 +0100
Message-ID: <20190110232045.GA3908@andrea>
References: <20190109210706.GA27268@linux.ibm.com>
 <20190109210748.29074-7-paulmck@linux.ibm.com>
 <20190110094131.GA11647@andrea>
 <20190110144049.GK1215@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190110144049.GK1215@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org
List-Id: linux-arch.vger.kernel.org

> > I'm not all that exited about spreading version requirements in the
> > source: we report this requirement in our README, and apparently we
> > already struggle to keep this information up-to-date.  So what about
> > squashing something like the below (assume that 7.52 will be released
> > by the time this patch hit mainline; if this won't be the case, we
> > may consider using the development version 7.51+6)? notice that this
> > also removes an (obsolete, at this point) comment from lock.cat.
> 
> Sounds like a very good point to me!
> 
> Should have pointers in the various files to the README file?  Or maybe
> get people used to using scripting that checks versions?  Or maybe
> after answering questions for some time, people will get used to
> checking versions?

As discussed off-list: I have no strong opinion on this regard, well,
except that I think we ought to fix the README, somehow (consider my
diff below as a first proposal).  Akira actually preceded me on this
and suggested another solution [1].

  Andrea

[1] http://lkml.kernel.org/r/04d15c18-d210-e3da-01e2-483eff135cb7@gmail.com


> 
> 							Thanx, Paul
> 
> >   Andrea
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index 9d7d4f23503fd..b362a41358fa1 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -20,8 +20,8 @@ that litmus test to be exercised within the Linux kernel.
> >  REQUIREMENTS
> >  ============
> >  
> > -Version 7.49 of the "herd7" and "klitmus7" tools must be downloaded
> > -separately:
> > +Version 7.52 or higher of the "herd7" and "klitmus7" tools must be
> > +downloaded separately:
> >  
> >    https://github.com/herd/herdtools7
> >  
> > diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> > index 95bf45f1215fc..8dcb37835b613 100644
> > --- a/tools/memory-model/linux-kernel.cat
> > +++ b/tools/memory-model/linux-kernel.cat
> > @@ -1,7 +1,5 @@
> >  // SPDX-License-Identifier: GPL-2.0+
> >  (*
> > - * Requires herd version 7.51+6 or higher.
> > - *
> >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
> > index 305ded17e7411..a059d1a6d8a29 100644
> > --- a/tools/memory-model/lock.cat
> > +++ b/tools/memory-model/lock.cat
> > @@ -6,9 +6,6 @@
> >  
> >  (*
> >   * Generate coherence orders and handle lock operations
> > - *
> > - * Warning: spin_is_locked() crashes herd7 versions strictly before 7.48.
> > - * spin_is_locked() is functional from herd7 version 7.49.
> >   *)
> >  
> >  include "cross.cat"
> > 
> > 
> > 
> > > + *
> > >   * Copyright (C) 2015 Jade Alglave <j.alglave@ucl.ac.uk>,
> > >   * Copyright (C) 2016 Luc Maranget <luc.maranget@inria.fr> for Inria
> > >   * Copyright (C) 2017 Alan Stern <stern@rowland.harvard.edu>,
> > > diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
> > > index 1d6a120cde14..0c3f0ef486f4 100644
> > > --- a/tools/memory-model/linux-kernel.def
> > > +++ b/tools/memory-model/linux-kernel.def
> > > @@ -49,7 +49,7 @@ synchronize_rcu_expedited() { __fence{sync-rcu}; }
> > >  
> > >  // SRCU
> > >  srcu_read_lock(X)  __srcu{srcu-lock}(X)
> > > -srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X); }
> > > +srcu_read_unlock(X,Y) { __srcu{srcu-unlock}(X,Y); }
> > >  synchronize_srcu(X)  { __srcu{sync-srcu}(X); }
> > >  
> > >  // Atomic
> > > -- 
> > > 2.17.1
> > > 
> > 
> 
