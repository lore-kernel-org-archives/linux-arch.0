From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
 for the qspinlock
Date: Mon, 13 Apr 2015 12:19:14 -0400
Message-ID: <552BEC82.8070809@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com> <1428375350-9213-10-git-send-email-Waiman.Long@hp.com> <20150409181327.GY5029@twins.programming.kicks-ass.net> <5526F218.2070909@hp.com> <20150413150934.GI5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:48308 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275AbbDMQTX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Apr 2015 12:19:23 -0400
In-Reply-To: <20150413150934.GI5029@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 04/13/2015 11:09 AM, Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 05:41:44PM -0400, Waiman Long wrote:
>>>> +__visible void __pv_queue_spin_unlock(struct qspinlock *lock)
>>>> +{
>>>> +	struct __qspinlock *l = (void *)lock;
>>>> +	struct pv_node *node;
>>>> +
>>>> +	if (likely(cmpxchg(&l->locked, _Q_LOCKED_VAL, 0) == _Q_LOCKED_VAL))
>>>> +		return;
>>>> +
>>>> +	/*
>>>> +	 * The queue head has been halted. Need to locate it and wake it up.
>>>> +	 */
>>>> +	node = pv_hash_find(lock);
>>>> +	smp_store_release(&l->locked, 0);
>>> Ah yes, clever that.
>>>
>>>> +	/*
>>>> +	 * At this point the memory pointed at by lock can be freed/reused,
>>>> +	 * however we can still use the PV node to kick the CPU.
>>>> +	 */
>>>> +	if (READ_ONCE(node->state) == vcpu_halted)
>>>> +		pv_kick(node->cpu);
>>>> +}
>>>> +PV_CALLEE_SAVE_REGS_THUNK(__pv_queue_spin_unlock);
>>> However I feel the PV_CALLEE_SAVE_REGS_THUNK thing belongs in the x86
>>> code.
>> That is why I originally put my version of the qspinlock_paravirt.h header
>> file under arch/x86/include/asm. Maybe we should move it back there. Putting
>> the thunk in arch/x86/kernel/kvm.c didn't work when you consider that the
>> Xen code also need that.
> Well the function is 'generic' and belong here I think. Its just the
> PV_CALLEE_SAVE_REGS_THUNK thing that arch specific. Should have live in
> arch/x86/kernel/paravirt-spinlocks.c instead?

Another alternative is to put the PV_CALLEE_SAVE_REGS_THUNK into a 
separate asm/qspinlock_paravirt.h file and included in the generic 
qspinlock_paravirt.h file. By putting the thunk with the 
__pv_queue_spin_unlock together in the same file, we can make the thunk 
and the unlock fast path (_Q_SLOW_VAL not set) go into two adjacent 
instruction cachelines. I think that may help a bit in term of performance.

Cheers,
Longman
