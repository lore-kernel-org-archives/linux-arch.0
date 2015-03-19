From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Thu, 19 Mar 2015 14:43:36 +0100
Message-ID: <20150319134336.GE11574@worktop.ger.corp.intel.com>
References: <20150316131613.720617163@infradead.org>
 <20150316133112.278511476@infradead.org>
 <5509E51D.7040909@hp.com>
 <20150319101242.GM21418@twins.programming.kicks-ass.net>
 <20150319122536.GD11574@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54484 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbCSNn4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 09:43:56 -0400
Content-Disposition: inline
In-Reply-To: <20150319122536.GD11574@worktop.ger.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On Thu, Mar 19, 2015 at 01:25:36PM +0100, Peter Zijlstra wrote:
> +static struct qspinlock **pv_hash(struct qspinlock *lock)
> +{
> +	u32 hash = hash_ptr(lock, PV_LOCK_HASH_BITS);
> +	struct pv_hash_bucket *hb, *end;
> +
> +	if (!hash)
> +		hash = 1;
> +
> +	hb = &__pv_lock_hash[hash_align(hash)];
> +	for (;;) {
> +		for (end = hb + PV_HB_PER_LINE; hb < end; hb++) {
> +			if (cmpxchg(&hb->lock, NULL, HB_RESERVED)) {

That should be: !cmpxchg(), bit disturbing that that booted.

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
> +		hb = &__pv_lock_hash[hash_align(hash)];
> +	}
> +
> +done:
> +	return &hb->lock;
> +}
