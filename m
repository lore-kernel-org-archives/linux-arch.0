Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53]:56863 "EHLO
	g2t2354.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961AbbDMPvl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 11:51:41 -0400
Message-ID: <552BE608.7000901@hp.com>
Date: Mon, 13 Apr 2015 11:51:36 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
 for the qspinlock
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com> <1428375350-9213-10-git-send-email-Waiman.Long@hp.com> <20150409181327.GY5029@twins.programming.kicks-ass.net> <5526F218.2070909@hp.com> <20150413150832.GH5029@twins.programming.kicks-ass.net>
In-Reply-To: <20150413150832.GH5029@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150413155136.AggeSRc2JAS8TofkHhISFogd25ZVT1yz8v3ldinqHgs@z>

On 04/13/2015 11:08 AM, Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 05:41:44PM -0400, Waiman Long wrote:
>
>>>> +static void pv_wait_head(struct qspinlock *lock, struct mcs_spinlock *node)
>>>> +{
>>>> +	struct __qspinlock *l = (void *)lock;
>>>> +	struct qspinlock **lp = NULL;
>>>> +	struct pv_node *pn = (struct pv_node *)node;
>>>> +	int slow_set = false;
>>>> +	int loop;
>>>> +
>>>> +	for (;;) {
>>>> +		for (loop = SPIN_THRESHOLD; loop; loop--) {
>>>> +			if (!READ_ONCE(l->locked))
>>>> +				return;
>>>> +
>>>> +			cpu_relax();
>>>> +		}
>>>> +
>>>> +		WRITE_ONCE(pn->state, vcpu_halted);
>>>> +		if (!lp)
>>>> +			lp = pv_hash(lock, pn);
>>>> +		/*
>>>> +		 * lp must be set before setting _Q_SLOW_VAL
>>>> +		 *
>>>> +		 * [S] lp = lock                [RmW] l = l->locked = 0
>>>> +		 *     MB                             MB
>>>> +		 * [S] l->locked = _Q_SLOW_VAL  [L]   lp
>>>> +		 *
>>>> +		 * Matches the cmpxchg() in pv_queue_spin_unlock().
>>>> +		 */
>>>> +		if (!slow_set&&
>>>> +		    !cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL)) {
>>>> +			/*
>>>> +			 * The lock is free and _Q_SLOW_VAL has never been
>>>> +			 * set. Need to clear the hash bucket before getting
>>>> +			 * the lock.
>>>> +			 */
>>>> +			WRITE_ONCE(*lp, NULL);
>>>> +			return;
>>>> +		} else if (slow_set&&   !READ_ONCE(l->locked))
>>>> +			return;
>>>> +		slow_set = true;
>>> I'm somewhat puzzled by the slow_set thing; what is wrong with the thing
>>> I had, namely:
>>>
>>> 		if (!lp) {
>>> 			lp = pv_hash(lock, pn);
>>>
>>> 			/*
>>> 			 * comment
>>> 			 */
>>> 			lv = cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL);
>>> 			if (lv != _Q_LOCKED_VAL) {
>>> 				/* we're woken, unhash and return */
>>> 				WRITE_ONCE(*lp, NULL);
>>> 				return;
>>> 			}
>>> 		}
>>>> +
>>>> +		pv_wait(&l->locked, _Q_SLOW_VAL);
>>> If we get a spurious wakeup (due to device interrupts or random kick)
>>> we'll loop around but ->locked will remain _Q_SLOW_VAL.
>> The purpose of the slow_set flag is not about the lock value. It is to make
>> sure that pv_hash_find() will always find a match. Consider the following
>> scenario:
>>
>> cpu1            cpu2                    cpu3
>> ----            ----                    ----
>> pv_wait
>> spurious wakeup
>> loop l->locked
>>
>>                  read _Q_SLOW_VAL
>>                  pv_hash_find()
>>                  unlock
>>
>>                                          pv_hash()<- same entry
>>
>> cmpxchg(&l->locked)
>> clear hash (?)
>>
>> Here, the entry for cpu3 will be removed leading to panic when
>> pv_hash_find() can find the entry. So the hash entry can only be
>> removed if the other cpu has no chance to see _Q_SLOW_VAL.
> Still confused. Afaict that cannot happen with my code. We only do the
> cmpxchg(, _Q_SLOW_VAL) _once_.
>
> Only on the first time around that loop will we hash the lock and set
> the slow flag. And cpu3 cannot come in on the same entry because we've
> not yet released the lock when we find and unhash.
>
>

Maybe I am not clear in my illustration. More than one locks can be 
hashed to the same value. So cpu3 is accessing a different lock which 
has the same hashed value as the lock used by cpu1 and cpu2.

Anyway, I remove the slow_set flag by unrolling the retry loop so that 
after pv_wait(), it goes into the 2nd loop instead of going back to the 
top. As a result, cmpxchg and pv_hash can only be called once.

Cheers,
Longman
