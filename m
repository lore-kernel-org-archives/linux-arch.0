From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Date: Sat, 20 Oct 2018 16:18:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
References: <20181020161049.GA13756@linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181020161049.GA13756@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davidtgoldblatt@gmail.com, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
List-Id: linux-arch.vger.kernel.org

On Sat, 20 Oct 2018, Paul E. McKenney wrote:

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

This is disconcerting only if we assume that t1_interrupt() has to be
executed by the same CPU as t1().  If the interrupt could be fielded by
a different CPU then the paranoid outcome is perfectly understandable,
even in an SC context.

So the question really should be limited to situations where a handler 
is forced to execute in the context of a particular thread.  While 
POSIX does allow such restrictions for user programs, I'm not aware of 
any similar mechanism in the kernel.

Alan
