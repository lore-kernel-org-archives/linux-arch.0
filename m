From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Date: Mon, 22 Oct 2018 12:30:20 -0500
Message-ID: <87ftwx3n4j.fsf@xmission.com>
References: <20181020161049.GA13756@linux.ibm.com>
        <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
        <20181020210413.GB2674@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181020210413.GB2674@linux.ibm.com> (Paul E. McKenney's message
        of "Sat, 20 Oct 2018 14:04:13 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davidtgoldblatt@gmail.com, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
List-Id: linux-arch.vger.kernel.org

"Paul E. McKenney" <paulmck@linux.ibm.com> writes:

> On Sat, Oct 20, 2018 at 04:18:37PM -0400, Alan Stern wrote:
>> On Sat, 20 Oct 2018, Paul E. McKenney wrote:
>> 
>> > The second (informal) litmus test has a more interesting Linux-kernel
>> > counterpart:
>> > 
>> > 	void t1_interrupt(void)
>> > 	{
>> > 		r0 = READ_ONCE(y);
>> > 		smp_store_release(&x, 1);
>> > 	}
>> > 
>> > 	void t1(void)
>> > 	{
>> > 		smp_store_release(&y, 1);
>> > 	}
>> > 
>> > 	void t2(void)
>> > 	{
>> > 		r1 = smp_load_acquire(&x);
>> > 		r2 = smp_load_acquire(&y);
>> > 	}
>> > 
>> > On store-reordering architectures that implement smp_store_release()
>> > as a memory-barrier instruction followed by a store, the interrupt could
>> > arrive betweentimes in t1(), so that there would be no ordering between
>> > t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
>> > in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.
>> 
>> This is disconcerting only if we assume that t1_interrupt() has to be
>> executed by the same CPU as t1().  If the interrupt could be fielded by
>> a different CPU then the paranoid outcome is perfectly understandable,
>> even in an SC context.
>> 
>> So the question really should be limited to situations where a handler 
>> is forced to execute in the context of a particular thread.  While 
>> POSIX does allow such restrictions for user programs, I'm not aware of 
>> any similar mechanism in the kernel.

> Good point, and I was in fact assuming that t1() and t1_interrupt()
> were executing on the same CPU.
>
> This sort of thing happens naturally in the kernel when both t1()
> and t1_interrupt() are accessing per-CPU variables.

Interrupts have a cpumask of the cpus they may be dlievered on.

I believe networking does in fact have places where percpu actions
happen as well as interrupts pinned to a single cpu.  And yes I agree
percpu variables mean that you do not need to pin an interrupt to a
single cpu to cause this to happen.

Eric
