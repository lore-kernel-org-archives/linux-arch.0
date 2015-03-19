From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Thu, 19 Mar 2015 19:25:17 -0400
Message-ID: <550B5ADD.7030000@hp.com>
References: <20150316131613.720617163@infradead.org> <20150316133112.278511476@infradead.org> <5509E51D.7040909@hp.com> <20150319101242.GM21418@twins.programming.kicks-ass.net> <20150319122536.GD11574@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:57207 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbCSXZc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 19:25:32 -0400
In-Reply-To: <20150319122536.GD11574@worktop.ger.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On 03/19/2015 08:25 AM, Peter Zijlstra wrote:
> On Thu, Mar 19, 2015 at 11:12:42AM +0100, Peter Zijlstra wrote:
>> So I was now thinking of hashing the lock pointer; let me go and quickly
>> put something together.
> A little something like so; ideally we'd allocate the hashtable since
> NR_CPUS is kinda bloated, but it shows the idea I think.
>
> And while this has loops in (the rehashing thing) their fwd progress
> does not depend on other CPUs.
>
> And I suspect that for the typical lock contention scenarios its
> unlikely we ever really get into long rehashing chains.
>
> ---
>   include/linux/lfsr.h                |   49 ++++++++++++
>   kernel/locking/qspinlock_paravirt.h |  143 ++++++++++++++++++++++++++++++++----
>   2 files changed, 178 insertions(+), 14 deletions(-)

This is a much better alternative.

> --- /dev/null
> +++ b/include/linux/lfsr.h
> @@ -0,0 +1,49 @@
> +#ifndef _LINUX_LFSR_H
> +#define _LINUX_LFSR_H
> +
> +/*
> + * Simple Binary Galois Linear Feedback Shift Register
> + *
> + * http://en.wikipedia.org/wiki/Linear_feedback_shift_register
> + *
> + */
> +
> +extern void __lfsr_needs_more_taps(void);
> +
> +static __always_inline u32 lfsr_taps(int bits)
> +{
> +	if (bits ==  1) return 0x0001;
> +	if (bits ==  2) return 0x0001;
> +	if (bits ==  3) return 0x0003;
> +	if (bits ==  4) return 0x0009;
> +	if (bits ==  5) return 0x0012;
> +	if (bits ==  6) return 0x0021;
> +	if (bits ==  7) return 0x0041;
> +	if (bits ==  8) return 0x008E;
> +	if (bits ==  9) return 0x0108;
> +	if (bits == 10) return 0x0204;
> +	if (bits == 11) return 0x0402;
> +	if (bits == 12) return 0x0829;
> +	if (bits == 13) return 0x100D;
> +	if (bits == 14) return 0x2015;
> +
> +	/*
> +	 * For more taps see:
> +	 *   http://users.ece.cmu.edu/~koopman/lfsr/index.html
> +	 */
> +	__lfsr_needs_more_taps();
> +
> +	return 0;
> +}
> +
> +static inline u32 lfsr(u32 val, int bits)
> +{
> +	u32 bit = val&  1;
> +
> +	val>>= 1;
> +	if (bit)
> +		val ^= lfsr_taps(bits);
> +	return val;
> +}
> +
> +#endif /* _LINUX_LFSR_H */
> --- a/kernel/locking/qspinlock_paravirt.h
> +++ b/kernel/locking/qspinlock_paravirt.h
> @@ -2,6 +2,9 @@
>   #error "do not include this file"
>   #endif
>
> +#include<linux/hash.h>
> +#include<linux/lfsr.h>
> +
>   /*
>    * Implement paravirt qspinlocks; the general idea is to halt the vcpus instead
>    * of spinning them.
> @@ -107,7 +110,120 @@ static void pv_kick_node(struct mcs_spin
>   		pv_kick(pn->cpu);
>   }
>
> -static DEFINE_PER_CPU(struct qspinlock *, __pv_lock_wait);
> +/*
> + * Hash table using open addressing with an LFSR probe sequence.
> + *
> + * Since we should not be holding locks from NMI context (very rare indeed) the
> + * max load factor is 0.75, which is around the point where open addressing
> + * breaks down.
> + *
> + * Instead of probing just the immediate bucket we probe all buckets in the
> + * same cacheline.
> + *
> + * http://en.wikipedia.org/wiki/Hash_table#Open_addressing
> + *
> + */
> +
> +#define HB_RESERVED	((struct qspinlock *)1)
> +
> +struct pv_hash_bucket {
> +	struct qspinlock *lock;
> +	int cpu;
> +};
> +
> +/*
> + * XXX dynamic allocate using nr_cpu_ids instead...
> + */
> +#define PV_LOCK_HASH_BITS	(2 + NR_CPUS_BITS)
> +

As said here, we should make it dynamically allocated depending on 
num_possible_cpus().

> +#if PV_LOCK_HASH_BITS<  6
> +#undef PV_LOCK_HASH_BITS
> +#define PB_LOCK_HASH_BITS	6
> +#endif
> +
> +#define PV_LOCK_HASH_SIZE	(1<<  PV_LOCK_HASH_BITS)
> +
> +static struct pv_hash_bucket __pv_lock_hash[PV_LOCK_HASH_SIZE] ____cacheline_aligned;
> +
> +#define PV_HB_PER_LINE		(SMP_CACHE_BYTES / sizeof(struct pv_hash_bucket))
> +
> +static inline u32 hash_align(u32 hash)
> +{
> +	return hash&  ~(PV_HB_PER_LINE - 1);
> +}
> +
> +static struct qspinlock **pv_hash(struct qspinlock *lock)
> +{
> +	u32 hash = hash_ptr(lock, PV_LOCK_HASH_BITS);
> +	struct pv_hash_bucket *hb, *end;
> +
> +	if (!hash)
> +		hash = 1;
> +
> +	hb =&__pv_lock_hash[hash_align(hash)];
> +	for (;;) {
> +		for (end = hb + PV_HB_PER_LINE; hb<  end; hb++) {
> +			if (cmpxchg(&hb->lock, NULL, HB_RESERVED)) {
> +				WRITE_ONCE(hb->cpu, smp_processor_id());
> +				/*
> +				 * Since we must read lock first and cpu
> +				 * second, we must write cpu first and lock
> +				 * second, therefore use HB_RESERVE to mark an
> +				 * entry in use before writing the values.
> +				 *
> +				 * This can cause hb_hash_find() to not find a
> +				 * cpu even though _Q_SLOW_VAL, this is not a
> +				 * problem since we re-check l->locked before
> +				 * going to sleep and the unlock will have
> +				 * cleared l->locked already.
> +				 */
> +				smp_wmb(); /* matches rmb from pv_hash_find */
> +				WRITE_ONCE(hb->lock, lock);
> +				goto done;
> +			}
> +		}
> +
> +		hash = lfsr(hash, PV_LOCK_HASH_BITS);
> +		hb =&__pv_lock_hash[hash_align(hash)];
> +	}
> +
> +done:
> +	return&hb->lock;
> +}
> +
> +static int pv_hash_find(struct qspinlock *lock)
> +{
> +	u64 hash = hash_ptr(lock, PV_LOCK_HASH_BITS);
> +	struct pv_hash_bucket *hb, *end;
> +	int cpu = -1;
> +
> +	if (!hash)
> +		hash = 1;
> +
> +	hb =&__pv_lock_hash[hash_align(hash)];
> +	for (;;) {
> +		for (end = hb + PV_HB_PER_LINE; hb<  end; hb++) {
> +			struct qspinlock *l = READ_ONCE(hb->lock);
> +
> +			/*
> +			 * If we hit an unused bucket, there is no match.
> +			 */
> +			if (!l)
> +				goto done;
> +
> +			if (l == lock) {
> +				smp_rmb(); /* matches wmb from pv_hash() */
> +				cpu = READ_ONCE(hb->cpu);
> +				goto done;
> +			}
> +		}
> +
> +		hash = lfsr(hash, PV_LOCK_HASH_BITS);
> +		hb =&__pv_lock_hash[hash_align(hash)];
> +	}
> +done:
> +	return cpu;
> +}
>   

We should probably abstract out the pv_hash and pv_hash_find into 
generic functions that can be put into header like hash.h instead of 
doing it locally here.

-Longman
