From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
	PV guest
Date: Mon, 17 Mar 2014 13:44:34 -0400
Message-ID: <53273482.3030102@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>
	<20140313151515.GC25546@laptop.programming.kicks-ass.net>
	<53220F7F.2040701@hp.com>
	<20140314083001.GN27965@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140314083001.GN27965@twins.programming.kicks-ass.net>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu
List-Id: linux-arch.vger.kernel.org

On 03/14/2014 04:30 AM, Peter Zijlstra wrote:
> On Thu, Mar 13, 2014 at 04:05:19PM -0400, Waiman Long wrote:
>> On 03/13/2014 11:15 AM, Peter Zijlstra wrote:
>>> On Wed, Mar 12, 2014 at 02:54:52PM -0400, Waiman Long wrote:
>>>> +static inline void arch_spin_lock(struct qspinlock *lock)
>>>> +{
>>>> +	if (static_key_false(&paravirt_unfairlocks_enabled))
>>>> +		queue_spin_lock_unfair(lock);
>>>> +	else
>>>> +		queue_spin_lock(lock);
>>>> +}
>>> So I would have expected something like:
>>>
>>> 	if (static_key_false(&paravirt_spinlock)) {
>>> 		while (!queue_spin_trylock(lock))
>>> 			cpu_relax();
>>> 		return;
>>> 	}
>>>
>>> At the top of queue_spin_lock_slowpath().
>> I don't like the idea of constantly spinning on the lock. That can cause all
>> sort of performance issues.
> Its bloody virt; _that_ is a performance issue to begin with.
>
> Anybody half sane stops using virt (esp. if they care about
> performance).
>
>> My version of the unfair lock tries to grab the
>> lock ignoring if there are others waiting in the queue or not. So instead of
>> the doing a cmpxchg of the whole 32-bit word, I just do a cmpxchg of the
>> lock byte in the unfair version. A CPU has only one chance to steal the
>> lock. If it can't, it will be lined up in the queue just like the fair
>> version. It is not as unfair as the other unfair locking schemes that spins
>> on the lock repetitively. So lock starvation should be less a problem.
>>
>> On the other hand, it may not perform as well as the other unfair locking
>> schemes. It is a compromise to provide some lock unfairness without
>> sacrificing the good cacheline behavior of the queue spinlock.
> But but but,.. any kind of queueing gets you into a world of hurt with
> virt.
>
> The simple test-and-set lock (as per the above) still sucks due to lock
> holder preemption, but at least the suckage doesn't queue. Because with
> queueing you not only have to worry about the lock holder getting
> preemption, but also the waiter(s).
>
> Take the situation of 3 (v)CPUs where cpu0 holds the lock but is
> preempted. cpu1 queues, cpu2 queues. Then cpu1 gets preempted, after
> which cpu0 gets back online.
>
> The simple test-and-set lock will now let cpu2 acquire. Your queue
> however will just sit there spinning, waiting for cpu1 to come back from
> holiday.
>
> I think you're way over engineering this. Just do the simple
> test-and-set lock for virt&&  !paravirt (as I think Paolo Bonzini
> suggested RHEL6 already does).

The PV ticketlock code was designed to handle lock holder preemption by 
redirecting CPU resources in a preempted guest to another guest that can 
better use it and then return the preempted CPU back sooner.

Using a simple test-and-set lock will not allow us to enable this PV 
spinlock functionality as there is no structure to decide who does what. 
I can extend the current unfair lock code to allow those waiting in the 
queue to also attempt to steal the lock, though at a lesser frequency so 
that the queue head has a higher chance of getting the lock. This will 
solve the lock waiter preemption problem that you worry about. This does 
make the code a bit more complex, but it allow us to enable both the 
unfair lock and the PV spinlock code together to solve the lock waiter 
and lock holder preemption problems.

-Longman
