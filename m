From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 03/19] qspinlock: Add pending bit
Date: Fri, 09 May 2014 20:49:50 -0400
Message-ID: <536D77AE.40306@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-4-git-send-email-Waiman.Long@hp.com>
	<20140508185712.GM2844@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140508185712.GM2844@laptop.programming.kicks-ass.net>
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

On 05/08/2014 02:57 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:31AM -0400, Waiman Long wrote:
>> +/**
>> + * trylock_pending - try to acquire queue spinlock using the pending bit
>> + * @lock : Pointer to queue spinlock structure
>> + * @pval : Pointer to value of the queue spinlock 32-bit word
>> + * Return: 1 if lock acquired, 0 otherwise
>> + */
>> +static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
> Still don't like you put it in a separate function, but you don't need
> the pointer thing. Note how after you fail the trylock_pending() you
> touch the second (node) cacheline.
>
>> @@ -110,6 +184,9 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>
>>   	BUILD_BUG_ON(CONFIG_NR_CPUS>= (1U<<  _Q_TAIL_CPU_BITS));
>>
>> +	if (trylock_pending(lock,&val))
>> +		return;	/* Lock acquired */
>> +
>>   	node = this_cpu_ptr(&mcs_nodes[0]);
>>   	idx = node->count++;
>>   	tail = encode_tail(smp_processor_id(), idx);
>> @@ -119,15 +196,18 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>   	node->next = NULL;
>>
>>   	/*
>> +	 * we already touched the queueing cacheline; don't bother with pending
>> +	 * stuff.
>> +	 *
>>   	 * trylock || xchg(lock, node)
>>   	 *
>> -	 * 0,0 ->  0,1 ; trylock
>> -	 * p,x ->  n,x ; prev = xchg(lock, node)
>> +	 * 0,0,0 ->  0,0,1 ; trylock
>> +	 * p,y,x ->  n,y,x ; prev = xchg(lock, node)
>>   	 */
> And any value of @val we might have had here is completely out-dated.
> The only thing that makes sense it to set:
>
> 	val = 0;
>
> Which makes us start with a trylock, alternatively we can re-read val.

That is true. I will make the change to get rid of the pointer thing.

As for the separate trylock_pending function, my original goal was to 
have a better delineation of different portions of the code.  Given the 
fact that I broke up the slowpath function into 2 in a later patch, I 
may not really need to separate it out. I will pull it back in the next 
version.

-Longman
