From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization
	for 2 contending tasks
Date: Fri, 28 Feb 2014 11:38:25 -0500
Message-ID: <5310BB81.3090508@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000909070404030104070106"
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140228092945.GG27965@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org

This is a multi-part message in MIME format.
--------------000909070404030104070106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 02/28/2014 04:29 AM, Peter Zijlstra wrote:
> On Thu, Feb 27, 2014 at 03:42:19PM -0500, Waiman Long wrote:
>>>> +	old = xchg(&qlock->lock_wait, _QSPINLOCK_WAITING|_QSPINLOCK_LOCKED);
>>>> +
>>>> +	if (old == 0) {
>>>> +		/*
>>>> +		 * Got the lock, can clear the waiting bit now
>>>> +		 */
>>>> +		smp_u8_store_release(&qlock->wait, 0);
>>> So we just did an atomic op, and now you're trying to optimize this
>>> write. Why do you need a whole byte for that?
>>>
>>> Surely a cmpxchg loop with the right atomic op can't be _that_ much
>>> slower? Its far more readable and likely avoids that steal fail below as
>>> well.
>> At low contention level, atomic operations that requires a lock prefix are
>> the major contributor to the total execution times. I saw estimate online
>> that the time to execute a lock prefix instruction can easily be 50X longer
>> than a regular instruction that can be pipelined. That is why I try to do it
>> with as few lock prefix instructions as possible. If I have to do an atomic
>> cmpxchg, it probably won't be faster than the regular qspinlock slowpath.
> At low contention the cmpxchg won't have to be retried (much) so using
> it won't be a problem and you get to have arbitrary atomic ops.
>
>> Given that speed at low contention level which is the common case is
>> important to get this patch accepted, I have to do what I can to make it run
>> as far as possible for this 2 contending task case.
> What I'm saying is that you can do the whole thing with a single
> cmpxchg. No extra ops needed. And at that point you don't need a whole
> byte, you can use a single bit.
>
> that removes the whole NR_CPUS dependent logic.

After modifying it to do a deterministic cmpxchg, the test run time of 2 
contending tasks jumps up from 600ms (best case) to about 1700ms which 
was worse than the original qspinlock's 1300-1500ms. It is the 
opportunistic nature of the xchg() code that can potentially combine 
multiple steps in the deterministic atomic sequence which can saves 
time. Without that, I would rather prefer going back to the basic 
qspinlock queuing sequence for 2 contending tasks.

Please take a look at the performance data in my patch 3 to see if the 
slowdown at 2 and 3 contending tasks are acceptable or not.

The reason why I need a whole byte for the lock bit is because of the 
simple unlock code of assigning 0 to the lock byte by the lock holder. 
Utilizing other bits in the low byte for other purpose will complicate 
the unlock path and slow down the no-contention case.

>>>> +		/*
>>>> +		 * Someone has steal the lock, so wait again
>>>> +		 */
>>>> +		goto try_again;
>>> That's just a fail.. steals should not ever be allowed. It's a fair lock
>>> after all.
>> The code is unfair, but this unfairness help it to run faster than ticket
>> spinlock in this particular case. And the regular qspinlock slowpath is
>> fair. A little bit of unfairness in this particular case helps its speed.
> *groan*, no, unfairness not cool. ticket lock is absolutely fair; we
> should preserve this.

We can preserve that by removing patch 3.

> BTW; can you share your benchmark thingy?

I have attached the test program that I used to generate the timing data 
for patch 3.

-Longman



--------------000909070404030104070106
Content-Type: application/x-gzip;
 name="locktest.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="locktest.tar.gz"

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
/tgAUAAA
--------------000909070404030104070106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--------------000909070404030104070106--
