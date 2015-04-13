From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v15 09/15] pvqspinlock: Implement simple paravirt support
	for the qspinlock
Date: Mon, 13 Apr 2015 11:45:00 -0400
Message-ID: <552BE47C.6040202@hp.com>
References: <1428375350-9213-1-git-send-email-Waiman.Long@hp.com>
	<1428375350-9213-10-git-send-email-Waiman.Long@hp.com>
	<20150409181327.GY5029@twins.programming.kicks-ass.net>
	<5526F218.2070909@hp.com>
	<20150413144729.GG5029@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150413144729.GG5029@twins.programming.kicks-ass.net>
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

On 04/13/2015 10:47 AM, Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 05:41:44PM -0400, Waiman Long wrote:
>>>> +void __init __pv_init_lock_hash(void)
>>>> +{
>>>> +	int pv_hash_size = 4 * num_possible_cpus();
>>>> +
>>>> +	if (pv_hash_size<   (1U<<   LFSR_MIN_BITS))
>>>> +		pv_hash_size = (1U<<   LFSR_MIN_BITS);
>>>> +	/*
>>>> +	 * Allocate space from bootmem which should be page-size aligned
>>>> +	 * and hence cacheline aligned.
>>>> +	 */
>>>> +	pv_lock_hash = alloc_large_system_hash("PV qspinlock",
>>>> +					       sizeof(struct pv_hash_bucket),
>>>> +					       pv_hash_size, 0, HASH_EARLY,
>>>> +					&pv_lock_hash_bits, NULL,
>>>> +					       pv_hash_size, pv_hash_size);
>>> 	pv_taps = lfsr_taps(pv_lock_hash_bits);
>>>
>> I don't understand what you meant here.
> Let me explain (even though I propose taking all the LFSR stuff out).
>
> pv_lock_hash_bit is a runtime variable, therefore it cannot compile time
> evaluate the forest of if statements required to compute the taps value.
>
> Therefore its best to compute the taps _once_, and this seems like a
> good place to do so.

OK, I got it. That make sense.

>>>> +				goto done;
>>>> +			}
>>>> +		}
>>>> +
>>>> +		hash = lfsr(hash, pv_lock_hash_bits, 0);
>>> Since pv_lock_hash_bits is a variable, you end up running through that
>>> massive if() forest to find the corresponding tap every single time. It
>>> cannot compile-time optimize it.
>> The minimum bits size is now 8. So unless the system has more than 64 vCPUs,
>> it will get the right value in the first if statement.
> Still, no reason to not pre-compute the taps value, its simple enough.
>

Still, we need to keep the hash_bits value as it will needed by the 
hashing function.

I have taken out the lfsr code and use linear probing in the updated 
qspinlock patch that I am working on. However, we can always add that 
back in as an additional patch.

Cheers,
Longman
