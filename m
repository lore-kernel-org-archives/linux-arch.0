From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Fri, 28 Feb 2014 10:29:45 +0100
Message-ID: <20140228092945.GG27965@twins.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <530FA32B.8010202@hp.com>
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

On Thu, Feb 27, 2014 at 03:42:19PM -0500, Waiman Long wrote:
> >>+	old = xchg(&qlock->lock_wait, _QSPINLOCK_WAITING|_QSPINLOCK_LOCKED);
> >>+
> >>+	if (old == 0) {
> >>+		/*
> >>+		 * Got the lock, can clear the waiting bit now
> >>+		 */
> >>+		smp_u8_store_release(&qlock->wait, 0);
> >
> >So we just did an atomic op, and now you're trying to optimize this
> >write. Why do you need a whole byte for that?
> >
> >Surely a cmpxchg loop with the right atomic op can't be _that_ much
> >slower? Its far more readable and likely avoids that steal fail below as
> >well.
> 
> At low contention level, atomic operations that requires a lock prefix are
> the major contributor to the total execution times. I saw estimate online
> that the time to execute a lock prefix instruction can easily be 50X longer
> than a regular instruction that can be pipelined. That is why I try to do it
> with as few lock prefix instructions as possible. If I have to do an atomic
> cmpxchg, it probably won't be faster than the regular qspinlock slowpath.

At low contention the cmpxchg won't have to be retried (much) so using
it won't be a problem and you get to have arbitrary atomic ops.

> Given that speed at low contention level which is the common case is
> important to get this patch accepted, I have to do what I can to make it run
> as far as possible for this 2 contending task case.

What I'm saying is that you can do the whole thing with a single
cmpxchg. No extra ops needed. And at that point you don't need a whole
byte, you can use a single bit.

that removes the whole NR_CPUS dependent logic.

> >>+		/*
> >>+		 * Someone has steal the lock, so wait again
> >>+		 */
> >>+		goto try_again;

> >That's just a fail.. steals should not ever be allowed. It's a fair lock
> >after all.
> 
> The code is unfair, but this unfairness help it to run faster than ticket
> spinlock in this particular case. And the regular qspinlock slowpath is
> fair. A little bit of unfairness in this particular case helps its speed.

*groan*, no, unfairness not cool. ticket lock is absolutely fair; we
should preserve this.

BTW; can you share your benchmark thingy? 
