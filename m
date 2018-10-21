From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Date: Sun, 21 Oct 2018 10:52:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1810211043160.23485-100000@netrider.rowland.org>
References: <20181020210646.GC2674@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181020210646.GC2674@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davidtgoldblatt@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
List-Id: linux-arch.vger.kernel.org

On Sat, 20 Oct 2018, Paul E. McKenney wrote:

> On Sat, Oct 20, 2018 at 10:22:29PM +0200, Andrea Parri wrote:
> > [...]
> > 
> > > The second (informal) litmus test has a more interesting Linux-kernel
> > > counterpart:
> > > 
> > > 	void t1_interrupt(void)
> > > 	{
> > > 		r0 = READ_ONCE(y);
> > > 		smp_store_release(&x, 1);
> > > 	}
> > > 
> > > 	void t1(void)
> > > 	{
> > > 		smp_store_release(&y, 1);
> > > 	}
> > > 
> > > 	void t2(void)
> > > 	{
> > > 		r1 = smp_load_acquire(&x);
> > > 		r2 = smp_load_acquire(&y);
> > > 	}
> > > 
> > > On store-reordering architectures that implement smp_store_release()
> > > as a memory-barrier instruction followed by a store, the interrupt could
> > > arrive betweentimes in t1(), so that there would be no ordering between
> > > t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> > > in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.
> > 
> > FWIW, I'd rather call "paranoid" the act of excluding such outcome ;-)
> > but I admit that I've only run this test in *my mind*: in an SC world,
> > 
> >   CPU1				CPU2
> > 
> >   t1()
> >     t1_interrupt()
> >       r0 = READ_ONCE(y); // =0
> > 				t2()
> > 				  r1 = smp_load_acquire(&x); // =0
> >       smp_store_release(&x, 1);
> >     smp_store_release(&y, 1);
> > 				  r2 = smp_load_acquire(&y); // =1
> 
> OK, so did I get the outcome messed up again?  :-/

Did you mean to say r0==1?  If so, the litmus test would be a little
clearer if you wrote t1() above t1_interrupt().  That would help to
cement the WRC pattern in the reader's mind.

In any case, perhaps this indicates the kernel should ensure that a
full memory barrier is executed when an interrupt occurs.  (Of course, 
the hardware may already do this for us, depending on the 
architecture.)

Alan
