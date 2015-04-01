From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Wed, 01 Apr 2015 12:20:30 -0400
Message-ID: <551C1ACE.4090408@hp.com>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.278511476@infradead.org> <5509E51D.7040909@hp.com>
	<20150319101242.GM21418@twins.programming.kicks-ass.net>
	<20150319122536.GD11574@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150319122536.GD11574@worktop.ger.corp.intel.com>
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
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

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
>
> --- /dev/null
>
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

After more careful reading, I think the assumption that the presence of 
an unused bucket means there is no match is not true. Consider the scenario:

1. cpu 0 puts lock1 into hb[0]
2. cpu 1 puts lock2 into hb[1]
3. cpu 2 clears hb[0]
4. cpu 3 looks for lock2 and doesn't find it

I was thinking about putting some USED flag in the buckets, but then we 
will eventually fill them all up as used. If we put the entries into a 
hashed linked list, we have to deal with the complicated synchronization 
issues with link list update.

At this point, I am thinking using back your previous idea of passing 
the queue head information down the queue. I am now convinced that the 
unlock call site patching should work. So I will incorporate that in my 
next update.

Please let me know if you think my reasoning is not correct.

Thanks,
Longman
