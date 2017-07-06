Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751899AbdGFU04 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 16:26:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v66KPewl010478
        for <linux-arch@vger.kernel.org>; Thu, 6 Jul 2017 16:26:50 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bhqu9k663-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 06 Jul 2017 16:26:50 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 6 Jul 2017 16:26:50 -0400
Date: Thu, 6 Jul 2017 13:26:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/9] net/netfilter/nf_conntrack_core: Fix
 net_conntrack_lock()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170705232955.GA15992@linux.vnet.ibm.com>
 <1499297503-23852-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <113516eb-8615-4468-0127-1a491d34c83c@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <113516eb-8615-4468-0127-1a491d34c83c@colorfullife.com>
Message-ID: <20170706202642.GQ2393@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, oleg@redhat.com, akpm@linux-foundation.org, mingo@redhat.com, dave@stgolabs.net, tj@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, will.deacon@arm.com, peterz@infradead.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, torvalds@linux-foundation.org, stable@vger.kernel.org, Sasha Levin <sasha.levin@oracle.com>, Pablo Neira Ayuso <pablo@netfilter.org>
Message-ID: <20170706202642.vcEBFLoZhPLDBTu82PrJVglvDJZt6MRTkZ7IhMcFMmQ@z>

On Thu, Jul 06, 2017 at 08:45:59PM +0200, Manfred Spraul wrote:
> Hi Paul,
> 
> On 07/06/2017 01:31 AM, Paul E. McKenney wrote:
> >From: Manfred Spraul <manfred@colorfullife.com>
> >
> >As we want to remove spin_unlock_wait() and replace it with explicit
> >spin_lock()/spin_unlock() calls, we can use this to simplify the
> >locking.
> >
> >In addition:
> >- Reading nf_conntrack_locks_all needs ACQUIRE memory ordering.
> >- The new code avoids the backwards loop.
> >
> >Only slightly tested, I did not manage to trigger calls to
> >nf_conntrack_all_lock().
> 
> If you want:
> Attached would be V2, with adapted comments.

I do like the improved comments, thank you!  Queued, and will be part
of a later v3 of the series.

							Thanx, Paul

> --
>     Manfred

> >From e3562faa1bc96e883108505e05deecaf38c87a26 Mon Sep 17 00:00:00 2001
> From: Manfred Spraul <manfred@colorfullife.com>
> Date: Sun, 21 Aug 2016 07:17:55 +0200
> Subject: [PATCH 1/2] net/netfilter/nf_conntrack_core: Fix net_conntrack_lock()
> 
> As we want to remove spin_unlock_wait() and replace it with explicit
> spin_lock()/spin_unlock() calls, we can use this to simplify the
> locking.
> 
> In addition:
> - Reading nf_conntrack_locks_all needs ACQUIRE memory ordering.
> - The new code avoids the backwards loop.
> 
> Only slightly tested, I did not manage to trigger calls to
> nf_conntrack_all_lock().
> 
> V2: With improved comments, to clearly show how the barriers
>     pair.
> 
> Fixes: b16c29191dc8
> Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
> Cc: <stable@vger.kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: netfilter-devel@vger.kernel.org
> ---
>  net/netfilter/nf_conntrack_core.c | 52 ++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
> 
> diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
> index 9979f46..51390fe 100644
> --- a/net/netfilter/nf_conntrack_core.c
> +++ b/net/netfilter/nf_conntrack_core.c
> @@ -96,19 +96,26 @@ static struct conntrack_gc_work conntrack_gc_work;
> 
>  void nf_conntrack_lock(spinlock_t *lock) __acquires(lock)
>  {
> +	/* 1) Acquire the lock */
>  	spin_lock(lock);
> -	while (unlikely(nf_conntrack_locks_all)) {
> -		spin_unlock(lock);
> 
> -		/*
> -		 * Order the 'nf_conntrack_locks_all' load vs. the
> -		 * spin_unlock_wait() loads below, to ensure
> -		 * that 'nf_conntrack_locks_all_lock' is indeed held:
> -		 */
> -		smp_rmb(); /* spin_lock(&nf_conntrack_locks_all_lock) */
> -		spin_unlock_wait(&nf_conntrack_locks_all_lock);
> -		spin_lock(lock);
> -	}
> +	/* 2) read nf_conntrack_locks_all, with ACQUIRE semantics
> +	 * It pairs with the smp_store_release() in nf_conntrack_all_unlock()
> +	 */
> +	if (likely(smp_load_acquire(&nf_conntrack_locks_all) == false))
> +		return;
> +
> +	/* fast path failed, unlock */
> +	spin_unlock(lock);
> +
> +	/* Slow path 1) get global lock */
> +	spin_lock(&nf_conntrack_locks_all_lock);
> +
> +	/* Slow path 2) get the lock we want */
> +	spin_lock(lock);
> +
> +	/* Slow path 3) release the global lock */
> +	spin_unlock(&nf_conntrack_locks_all_lock);
>  }
>  EXPORT_SYMBOL_GPL(nf_conntrack_lock);
> 
> @@ -149,28 +156,27 @@ static void nf_conntrack_all_lock(void)
>  	int i;
> 
>  	spin_lock(&nf_conntrack_locks_all_lock);
> -	nf_conntrack_locks_all = true;
> 
> -	/*
> -	 * Order the above store of 'nf_conntrack_locks_all' against
> -	 * the spin_unlock_wait() loads below, such that if
> -	 * nf_conntrack_lock() observes 'nf_conntrack_locks_all'
> -	 * we must observe nf_conntrack_locks[] held:
> -	 */
> -	smp_mb(); /* spin_lock(&nf_conntrack_locks_all_lock) */
> +	nf_conntrack_locks_all = true;
> 
>  	for (i = 0; i < CONNTRACK_LOCKS; i++) {
> -		spin_unlock_wait(&nf_conntrack_locks[i]);
> +		spin_lock(&nf_conntrack_locks[i]);
> +
> +		/* This spin_unlock provides the "release" to ensure that
> +		 * nf_conntrack_locks_all==true is visible to everyone that
> +		 * acquired spin_lock(&nf_conntrack_locks[]).
> +		 */
> +		spin_unlock(&nf_conntrack_locks[i]);
>  	}
>  }
> 
>  static void nf_conntrack_all_unlock(void)
>  {
> -	/*
> -	 * All prior stores must be complete before we clear
> +	/* All prior stores must be complete before we clear
>  	 * 'nf_conntrack_locks_all'. Otherwise nf_conntrack_lock()
>  	 * might observe the false value but not the entire
> -	 * critical section:
> +	 * critical section.
> +	 * It pairs with the smp_load_acquire() in nf_conntrack_lock()
>  	 */
>  	smp_store_release(&nf_conntrack_locks_all, false);
>  	spin_unlock(&nf_conntrack_locks_all_lock);
> -- 
> 2.9.4
> 
