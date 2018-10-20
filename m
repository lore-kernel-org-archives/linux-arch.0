From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Date: Sat, 20 Oct 2018 22:22:29 +0200
Message-ID: <20181020202229.GA10526@andrea>
References: <20181020161049.GA13756@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181020161049.GA13756@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davidtgoldblatt@gmail.com, stern@rowland.harvard.edu, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
List-Id: linux-arch.vger.kernel.org

[...]

> The second (informal) litmus test has a more interesting Linux-kernel
> counterpart:
> 
> 	void t1_interrupt(void)
> 	{
> 		r0 = READ_ONCE(y);
> 		smp_store_release(&x, 1);
> 	}
> 
> 	void t1(void)
> 	{
> 		smp_store_release(&y, 1);
> 	}
> 
> 	void t2(void)
> 	{
> 		r1 = smp_load_acquire(&x);
> 		r2 = smp_load_acquire(&y);
> 	}
> 
> On store-reordering architectures that implement smp_store_release()
> as a memory-barrier instruction followed by a store, the interrupt could
> arrive betweentimes in t1(), so that there would be no ordering between
> t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.

FWIW, I'd rather call "paranoid" the act of excluding such outcome ;-)
but I admit that I've only run this test in *my mind*: in an SC world,

  CPU1				CPU2

  t1()
    t1_interrupt()
      r0 = READ_ONCE(y); // =0
				t2()
				  r1 = smp_load_acquire(&x); // =0
      smp_store_release(&x, 1);
    smp_store_release(&y, 1);
				  r2 = smp_load_acquire(&y); // =1


> So how paranoid should we be with respect to interrupt handlers for
> smp_store_release(), smp_load_acquire(), and the various RMW atomic
> operations that are sometimes implemented with separate memory-barrier
> instructions?  ;-)

Good question! ;-)

  Andrea


> 
> 							Thanx, Paul
> 
