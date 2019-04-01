Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36616 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfDAJHU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 Apr 2019 05:07:20 -0400
Date: Mon, 1 Apr 2019 11:06:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190401090653.GF11158@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329152006.110370-4-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190401090653.FgEP5J0qygpvb48aIWkXlxD-qdvaeEsyIKU5ogRSK-M@z>

On Fri, Mar 29, 2019 at 11:20:04AM -0400, Alex Kogan wrote:
> diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
> index bc6d3244e1af..71ee4b64c5d4 100644
> --- a/kernel/locking/mcs_spinlock.h
> +++ b/kernel/locking/mcs_spinlock.h
> @@ -17,8 +17,18 @@
>  
>  struct mcs_spinlock {
>  	struct mcs_spinlock *next;
> +#ifndef CONFIG_NUMA_AWARE_SPINLOCKS
>  	int locked; /* 1 if lock acquired */
>  	int count;  /* nesting count, see qspinlock.c */
> +#else /* CONFIG_NUMA_AWARE_SPINLOCKS */
> +	uintptr_t locked; /* 1 if lock acquired, 0 if not, other values */
> +			  /* represent a pointer to the secondary queue head */
> +	u32 node_and_count;	/* node id on which this thread is running */
> +				/* with two lower bits reserved for nesting */
> +				/* count, see qspinlock.c */
> +	u32 encoded_tail; /* encoding of this node as the main queue tail */
> +	struct mcs_spinlock *tail;    /* points to the secondary queue tail */
> +#endif /* CONFIG_NUMA_AWARE_SPINLOCKS */
>  };

Please, have another look at the paravirt code, in particular at struct
pv_node and its usage. This is horrible.

>  #ifndef arch_mcs_spin_lock_contended
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 074f65b9bedc..7cc923a59716 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c

> @@ -527,6 +544,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  		next = READ_ONCE(node->next);
>  		if (next)
>  			prefetchw(next);
> +	} else {
> +		 /* In CNA, we must pass a non-zero value to successor when
> +		  * we unlock. This store should be harmless performance-wise,
> +		  * as we just initialized @node.
> +		  */

Buggered comment style, also, it confuses the heck out of me. What does
it want to say?

Also, why isn't it hidden in your pv_wait_head_or_lock() implementation?

> +		node->locked = 1;
>  	}
>  
