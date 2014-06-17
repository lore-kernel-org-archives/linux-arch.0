From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 03/11] qspinlock: Add pending bit
Date: Tue, 17 Jun 2014 18:25:32 -0400
Message-ID: <53A0C05C.7010604@hp.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.196728583@chello.nl>
	<20140617203615.GA29634@laptop.dumpdata.com>
	<53A0AA6D.1070708@hp.com>
	<20140617210729.GB31817@laptop.dumpdata.com>
	<20140617211057.GD29634@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140617211057.GD29634@laptop.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, Peter Zijlstra <a.p.zijlstra@chello.nl>, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, gleb@redhat.com, virtualization@lists.linux-foundation.org, Peter Zijlstra <peterz@infradead.org>, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On 06/17/2014 05:10 PM, Konrad Rzeszutek Wilk wrote:
> On Tue, Jun 17, 2014 at 05:07:29PM -0400, Konrad Rzeszutek Wilk wrote:
>> On Tue, Jun 17, 2014 at 04:51:57PM -0400, Waiman Long wrote:
>>> On 06/17/2014 04:36 PM, Konrad Rzeszutek Wilk wrote:
>>>> On Sun, Jun 15, 2014 at 02:47:00PM +0200, Peter Zijlstra wrote:
>>>>> Because the qspinlock needs to touch a second cacheline; add a pending
>>>>> bit and allow a single in-word spinner before we punt to the second
>>>>> cacheline.
>>>> Could you add this in the description please:
>>>>
>>>> And by second cacheline we mean the local 'node'. That is the:
>>>> mcs_nodes[0] and mcs_nodes[idx]
>>>>
>>>> Perhaps it might be better then to split this in the header file
>>>> as this is trying to not be a slowpath code - but rather - a
>>>> pre-slow-path-lets-try-if-we can do another cmpxchg in case
>>>> the unlocker has just unlocked itself.
>>>>
>>>> So something like:
>>>>
>>>> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinlock.h
>>>> index e8a7ae8..29cc9c7 100644
>>>> --- a/include/asm-generic/qspinlock.h
>>>> +++ b/include/asm-generic/qspinlock.h
>>>> @@ -75,11 +75,21 @@ extern void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val);
>>>>    */
>>>>   static __always_inline void queue_spin_lock(struct qspinlock *lock)
>>>>   {
>>>> -	u32 val;
>>>> +	u32 val, new;
>>>>
>>>>   	val = atomic_cmpxchg(&lock->val, 0, _Q_LOCKED_VAL);
>>>>   	if (likely(val == 0))
>>>>   		return;
>>>> +
>>>> +	/* One more attempt - but if we fail mark it as pending. */
>>>> +	if (val == _Q_LOCKED_VAL) {
>>>> +		new = Q_LOCKED_VAL |_Q_PENDING_VAL;
>>>> +
>>>> +		old = atomic_cmpxchg(&lock->val, val, new);
>>>> +		if (old == _Q_LOCKED_VAL) /* YEEY! */
>>>> +			return;
>>> No, it can leave like that. The unlock path will not clear the pending bit.
>> Err, you are right. It needs to go back in the slowpath.
> What I should have wrote is:
>
> if (old == 0) /* YEEY */
>    return;

Unfortunately, that still doesn't work. If old is 0, it just meant the 
cmpxchg failed. It still haven't got the lock.
> As that would the same thing as this patch does on the pending bit - that
> is if we can on the second compare and exchange set the pending bit (and the
> lock) and the lock has been released - we are good.

That is not true. When the lock is freed, the pending bit holder will 
still have to clear the pending bit and set the lock bit as is done in 
the slowpath. We cannot skip the step here. The problem of moving the 
pending code here is that it includes a wait loop which we don't want to 
put in the fastpath.
>
> And it is a quick path.
>
>>> We are trying to make the fastpath as simple as possible as it may be
>>> inlined. The complexity of the queue spinlock is in the slowpath.
>> Sure, but then it shouldn't be called slowpath anymore as it is not
>> slow. It is a combination of fast path (the potential chance of
>> grabbing the lock and setting the pending lock) and the real slow
>> path (the queuing). Perhaps it should be called 'queue_spinlock_complex' ?
>>
> I forgot to mention - that was the crux of my comments - just change
> the slowpath to complex name at that point to better reflect what
> it does.

Actually in my v11 patch, I subdivided the slowpath into a slowpath for 
the pending code and slowerpath for actual queuing. Perhaps, we could 
use quickpath and slowpath instead. Anyway, it is a minor detail that we 
can discuss after the core code get merged.

-Longman
