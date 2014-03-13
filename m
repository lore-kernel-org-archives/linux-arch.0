From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
	PV guest
Date: Thu, 13 Mar 2014 16:05:19 -0400
Message-ID: <53220F7F.2040701@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>
	<20140313151515.GC25546@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140313151515.GC25546@laptop.programming.kicks-ass.net>
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

On 03/13/2014 11:15 AM, Peter Zijlstra wrote:
> On Wed, Mar 12, 2014 at 02:54:52PM -0400, Waiman Long wrote:
>> +static inline void arch_spin_lock(struct qspinlock *lock)
>> +{
>> +	if (static_key_false(&paravirt_unfairlocks_enabled))
>> +		queue_spin_lock_unfair(lock);
>> +	else
>> +		queue_spin_lock(lock);
>> +}
> So I would have expected something like:
>
> 	if (static_key_false(&paravirt_spinlock)) {
> 		while (!queue_spin_trylock(lock))
> 			cpu_relax();
> 		return;
> 	}
>
> At the top of queue_spin_lock_slowpath().

I don't like the idea of constantly spinning on the lock. That can cause 
all sort of performance issues. My version of the unfair lock tries to 
grab the lock ignoring if there are others waiting in the queue or not. 
So instead of the doing a cmpxchg of the whole 32-bit word, I just do a 
cmpxchg of the lock byte in the unfair version. A CPU has only one 
chance to steal the lock. If it can't, it will be lined up in the queue 
just like the fair version. It is not as unfair as the other unfair 
locking schemes that spins on the lock repetitively. So lock starvation 
should be less a problem.

On the other hand, it may not perform as well as the other unfair 
locking schemes. It is a compromise to provide some lock unfairness 
without sacrificing the good cacheline behavior of the queue spinlock.

>> +static inline int arch_spin_trylock(struct qspinlock *lock)
>> +{
>> +	if (static_key_false(&paravirt_unfairlocks_enabled))
>> +		return queue_spin_trylock_unfair(lock);
>> +	else
>> +		return queue_spin_trylock(lock);
>> +}
> That just doesn't make any kind of sense; a trylock cannot be fair or
> unfair.

Because I use a different cmpxchg for the fair and unfair versions, I 
also need a different version for trylock.

-Longman
