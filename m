From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Fri, 28 Feb 2014 18:56:45 +0100
Message-ID: <20140228175645.GA6835@laptop.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<5310BB81.3090508@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5310BB81.3090508@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org



> After modifying it to do a deterministic cmpxchg, the test run time of 2
> contending tasks jumps up from 600ms (best case) to about 1700ms which was
> worse than the original qspinlock's 1300-1500ms. It is the opportunistic
> nature of the xchg() code that can potentially combine multiple steps in the
> deterministic atomic sequence which can saves time. Without that, I would
> rather prefer going back to the basic qspinlock queuing sequence for 2
> contending tasks.
> 
> Please take a look at the performance data in my patch 3 to see if the
> slowdown at 2 and 3 contending tasks are acceptable or not.

Right; so I've gone back to a simple version (~200 lines) that's fairly
easy to comprehend (to me, since I wrote it). And will now try to see if
I can find the same state transitions in your code.

I find your code somewhat hard to follow; mostly due to those xchg() +
fixup thingies. But I'll get there.

> The reason why I need a whole byte for the lock bit is because of the simple
> unlock code of assigning 0 to the lock byte by the lock holder. Utilizing
> other bits in the low byte for other purpose will complicate the unlock path
> and slow down the no-contention case.

Yeah, I get why you need a whole byte for the lock part, I was asking if
we really need another whole byte for the pending part.

So in my version I think I see an optimization case where this is indeed
useful and I can trade an atomic op for a write barrier, which should be
a big win.

It just wasn't at all clear (to me) from your code.

(I also think the optimization isn't x86 specific)

> >>The code is unfair, but this unfairness help it to run faster than ticket
> >>spinlock in this particular case. And the regular qspinlock slowpath is
> >>fair. A little bit of unfairness in this particular case helps its speed.

> >*groan*, no, unfairness not cool. ticket lock is absolutely fair; we
> >should preserve this.
> 
> We can preserve that by removing patch 3.

I've got a version that does the pending thing and still is entirely
fair.

I don't think the concept of the extra spinner is incompatible with
fairness.

> >BTW; can you share your benchmark thingy?
> 
> I have attached the test program that I used to generate the timing data for
> patch 3.

Thanks, I'll have a play.
