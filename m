From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC LKMM 7/7] tools/memory-model: Dynamically check SRCU
 lock-to-unlock matching
Date: Fri, 11 Jan 2019 16:57:17 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1901111654200.1501-100000@iolanthe.rowland.org>
References: <20190111214446.GL1215@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111214446.GL1215@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, willy@infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, 11 Jan 2019, Paul E. McKenney wrote:

> On Fri, Jan 11, 2019 at 12:20:45AM +0100, Andrea Parri wrote:
> > > > I'm not all that exited about spreading version requirements in the
> > > > source: we report this requirement in our README, and apparently we
> > > > already struggle to keep this information up-to-date.  So what about
> > > > squashing something like the below (assume that 7.52 will be released
> > > > by the time this patch hit mainline; if this won't be the case, we
> > > > may consider using the development version 7.51+6)? notice that this
> > > > also removes an (obsolete, at this point) comment from lock.cat.
> > > 
> > > Sounds like a very good point to me!
> > > 
> > > Should have pointers in the various files to the README file?  Or maybe
> > > get people used to using scripting that checks versions?  Or maybe
> > > after answering questions for some time, people will get used to
> > > checking versions?
> > 
> > As discussed off-list: I have no strong opinion on this regard, well,
> > except that I think we ought to fix the README, somehow (consider my
> > diff below as a first proposal).  Akira actually preceded me on this
> > and suggested another solution [1].
> > 
> >   Andrea
> > 
> > [1] http://lkml.kernel.org/r/04d15c18-d210-e3da-01e2-483eff135cb7@gmail.com
> 
> My concern with this approach is that it seems to me to implicitly promise
> that herd will provide backwards compatibility, which is a real pain to
> test, let alone to provide.  Yes, the latest version of herd probably
> supports latest mainline, but will five-years-from-now herd work correctly
> on the .bell, .cat, and .def files from current mainline?

The README file can say something along the lines of:

	Herd version 7.52 (later versions may or may not be 
	compatible).  Herd can be downloaded from...

Alan
