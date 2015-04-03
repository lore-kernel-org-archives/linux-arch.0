Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:37371 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbbDCNnx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2015 09:43:53 -0400
Date: Fri, 3 Apr 2015 15:43:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Message-ID: <20150403134334.GG32047@worktop.ger.corp.intel.com>
References: <20150401171223.GO23123@twins.programming.kicks-ass.net>
 <20150401174239.GO24151@twins.programming.kicks-ass.net>
 <20150401181744.GE32047@worktop.ger.corp.intel.com>
 <551C3EF5.6090809@hp.com>
 <20150401184858.GA9791@dyad.arnhem.chello.nl>
 <551C4E02.8030806@hp.com>
 <20150401210317.GZ27490@worktop.programming.kicks-ass.net>
 <551D6E2E.1080801@hp.com>
 <20150402172057.GA27490@worktop.programming.kicks-ass.net>
 <20150402194834.GF32047@worktop.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150402194834.GF32047@worktop.ger.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150403134334.wgeYYC__vRdzYeGTLRAHKKHQaL447rGsLehLR4AaqEI@z>

On Thu, Apr 02, 2015 at 09:48:34PM +0200, Peter Zijlstra wrote:
> @@ -158,20 +257,20 @@ static void pv_wait_head(struct qspinloc
>  void __pv_queue_spin_unlock(struct qspinlock *lock)
>  {
>  	struct __qspinlock *l = (void *)lock;
> +	struct pv_hash_bucket *hb;
>  
>  	if (xchg(&l->locked, 0) != _Q_SLOW_VAL)
>  		return;
>  
>  	/*
>  	 * At this point the memory pointed at by lock can be freed/reused,
> +	 * however we can still use the pointer value to search in our hash
> +	 * table.
>  	 *
> +	 * Also, if we observe _Q_SLOW_VAL we _must_ now observe 'our' hash
> +	 * bucket. See pv_wait_head().
>  	 */
> +	hb = pv_hash_find(lock);
> +	pv_kick(hb->cpu);
> +	WRITE_ONCE(hb->lock, NULL); /* unhash */
>  }

So I _think_ I found a problem with this approach :/

If, as per the above, the lock does indeed get freed, it can get
re-allocated and stuck in the hash table (again) before we get the
lookup and unhash it.

I'll have to ponder that a bit more.
