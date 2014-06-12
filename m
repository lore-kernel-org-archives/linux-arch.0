From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v11 06/16] qspinlock: prolong the stay in the pending
	bit path
Date: Thu, 12 Jun 2014 16:54:52 -0400
Message-ID: <539A139C.50400@hp.com>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-7-git-send-email-Waiman.Long@hp.com>
	<20140611102606.GK3213@twins.programming.kicks-ass.net>
	<5398C894.6040808@hp.com>
	<20140612060032.GQ6758@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140612060032.GQ6758@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 06/12/2014 02:00 AM, Peter Zijlstra wrote:
> On Wed, Jun 11, 2014 at 05:22:28PM -0400, Long, Wai Man wrote:
>
>>>> @@ -233,11 +233,25 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>>>   	 */
>>>>   	for (;;) {
>>>>   		/*
>>>> -		 * If we observe any contention; queue.
>>>> +		 * If we observe that the queue is not empty or both
>>>> +		 * the pending and lock bits are set, queue
>>>>   		 */
>>>> -		if (val&  ~_Q_LOCKED_MASK)
>>>> +		if ((val&  _Q_TAIL_MASK) ||
>>>> +		    (val == (_Q_LOCKED_VAL|_Q_PENDING_VAL)))
>>>>   			goto queue;
>>>> +		if (val == _Q_PENDING_VAL) {
>>>> +			/*
>>>> +			 * Pending bit is set, but not the lock bit.
>>>> +			 * Assuming that the pending bit holder is going to
>>>> +			 * set the lock bit and clear the pending bit soon,
>>>> +			 * it is better to wait than to exit at this point.
>>>> +			 */
>>>> +			cpu_relax();
>>>> +			val = atomic_read(&lock->val);
>>>> +			continue;
>>>> +		}
>>>> +
>>>>   		new = _Q_LOCKED_VAL;
>>>>   		if (val == new)
>>>>   			new |= _Q_PENDING_VAL;
>>> Wouldn't something like:
>>>
>>> 	while (atomic_read(&lock->val) == _Q_PENDING_VAL)
>>> 		cpu_relax();
>>>
>>> before the cmpxchg loop have gotten you all this?
>> That is not exactly the same. The loop will exit if other bits are set or the pending
>> bit cleared. In the case, we will need to do the same check at the beginning of the
>> for loop in order to avoid doing an extra cmpxchg that is not necessary.
> If other bits get set we should stop poking at the pending bit and get
> queued. The only transition we want to wait for is: 0,1,0 ->  0,0,1.
>
> What extra unneeded cmpxchg() is there? If we have two cpus waiting in
> this loop for the pending bit to go away then both will attempt to grab
> the now free pending bit, one will loose and get queued?
>
> There's no avoiding that contention.

If two tasks see the pending bit goes away and try to grab it with 
cmpxchg, there is no way we can avoid the contention. However, if some 
how the pending bit holder get the lock and another task set the pending 
bit before the current task, the spinlock value will become 
_Q_PENDING_VAL|_Q_LOCKED_VAL. The while loop will end and the code will 
blindly try to do a cmpxchg unless we check for this case before hand. 
This is what my code does by going back to the beginning of the for loop.

-Longman
