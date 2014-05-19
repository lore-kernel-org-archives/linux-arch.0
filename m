From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 10/19] qspinlock, x86: Allow unfair spinlock in a
	virtual guest
Date: Mon, 19 May 2014 16:30:22 -0400
Message-ID: <537A69DE.5080000@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-11-git-send-email-Waiman.Long@hp.com>
	<20140508191228.GS2844@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140508191228.GS2844@laptop.programming.kicks-ass.net>
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

On 05/08/2014 03:12 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:38AM -0400, Waiman Long wrote:
>
>
> No, we want the unfair thing for VIRT, not PARAVIRT.
>

Yes, you are right. I will change that to VIRT.

>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 9e7659e..10e87e1 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -227,6 +227,14 @@ static __always_inline int get_qlock(struct qspinlock *lock)
>>   {
>>   	struct __qspinlock *l = (void *)lock;
>>
>> +#ifdef CONFIG_PARAVIRT_UNFAIR_LOCKS
>> +	if (static_key_false(&paravirt_unfairlocks_enabled))
>> +		/*
>> +		 * Need to use atomic operation to get the lock when
>> +		 * lock stealing can happen.
>> +		 */
>> +		return cmpxchg(&l->locked, 0, _Q_LOCKED_VAL) == 0;
> That's missing {}.

It is a single statement which doesn't need braces according to kernel 
coding style. I could move the comments up a bit to make it easier to read.

>> +#endif
>
>>   	barrier();
>>   	ACCESS_ONCE(l->locked) = _Q_LOCKED_VAL;
>>   	barrier();
>
> But no, what you want is:
>
> static __always_inline bool virt_lock(struct qspinlock *lock)
> {
> #ifdef CONFIG_VIRT_MUCK
> 	if (static_key_false(&virt_unfairlocks_enabled)) {
> 		while (!queue_spin_trylock(lock))
> 			cpu_relax();
>
> 		return true;
> 	}
> #else
> 	return false;
> }
>
>
> void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> {
> 	if (virt_lock(lock))
> 		return;
>
> 	...
> }

This is a possible way of doing it. I can do that in the patch series to 
simplify it. Hopefully that will speed up the review process and get it 
done quicker.

-Longman
