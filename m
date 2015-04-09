From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
	for the qspinlock
Date: Thu, 09 Apr 2015 16:36:51 -0400
Message-ID: <5526E2E3.7030503@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
	<20150409181327.GY5029@twins.programming.kicks-ass.net>
	<20150409182314.GU24151@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150409182314.GU24151@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On 04/09/2015 02:23 PM, Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 08:13:27PM +0200, Peter Zijlstra wrote:
>> On Mon, Apr 06, 2015 at 10:55:44PM -0400, Waiman Long wrote:
>>> +#define PV_HB_PER_LINE	(SMP_CACHE_BYTES / sizeof(struct pv_hash_bucket))
>>> +static struct qspinlock **pv_hash(struct qspinlock *lock, struct pv_node *node)
>>> +{
>>> +	unsigned long init_hash, hash = hash_ptr(lock, pv_lock_hash_bits);
>>> +	struct pv_hash_bucket *hb, *end;
>>> +
>>> +	if (!hash)
>>> +		hash = 1;
>>> +
>>> +	init_hash = hash;
>>> +	hb =&pv_lock_hash[hash_align(hash)];
>>> +	for (;;) {
>>> +		for (end = hb + PV_HB_PER_LINE; hb<  end; hb++) {
>>> +			if (!cmpxchg(&hb->lock, NULL, lock)) {
>>> +				WRITE_ONCE(hb->node, node);
>>> +				/*
>>> +				 * We haven't set the _Q_SLOW_VAL yet. So
>>> +				 * the order of writing doesn't matter.
>>> +				 */
>>> +				smp_wmb(); /* matches rmb from pv_hash_find */
>>> +				goto done;
>>> +			}
>>> +		}
>>> +
>>> +		hash = lfsr(hash, pv_lock_hash_bits, 0);
>> Since pv_lock_hash_bits is a variable, you end up running through that
>> massive if() forest to find the corresponding tap every single time. It
>> cannot compile-time optimize it.
>>
>> Hence:
>> 		hash = lfsr(hash, pv_taps);
>>
>> (I don't get the bits argument to the lfsr).
>>
>> In any case, like I said before, I think we should try a linear probe
>> sequence first, the lfsr was over engineering from my side.
>>
>>> +		hb =&pv_lock_hash[hash_align(hash)];
>>>   
> So one thing this does -- and one of the reasons I figured I should
> ditch the LFSR instead of fixing it -- is that you end up scanning each
> bucket HB_PER_LINE times.

I am aware of that when I was trying to add the hash table debug code, 
but I want to get the code out for review and so hasn't made any change 
yet. I have just done testing by adding some debug code to check the 
hashing efficiency. With the kernel build workload, with over 1M calls 
to pv_hash(), all of them get an empty entry on the first try. Maybe the 
minimum hash table size of 256 helps.

>
> The 'fix' would be to LFSR on cachelines instead of HBs but then you're
> stuck with the 0-th cacheline.

This should not be a big problem. I just need to add a check at the end 
of the for loop that if hash is 0, change it to a certain non-0 value 
instead of calling lfsr().

As for ditching the lfsr idea, I am fine with that. So there will be 4 
entries (1 cacheline) for each hash value. If all the entries are full, 
we proceed to the next cacheline.  Right?

Cheers,
Longman
