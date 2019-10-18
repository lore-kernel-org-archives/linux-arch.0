Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbfJRQJb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Oct 2019 12:09:31 -0400
Subject: Re: [PATCH v5 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
References: <20191016042903.61081-1-alex.kogan@oracle.com>
 <20191016042903.61081-5-alex.kogan@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <e83bfc8c-1c5b-572f-ef3a-a85e114f2677@redhat.com>
Date: Fri, 18 Oct 2019 12:09:29 -0400
MIME-Version: 1.0
In-Reply-To: <20191016042903.61081-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20191018160929.KYayVMfaLljxhMyP9jPOMqph0B2ofU_S7iD9oselKkg@z>

On 10/16/19 12:29 AM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  kernel/locking/qspinlock.c     |  3 +++
>  kernel/locking/qspinlock_cna.h | 30 +++++++++++++++++++++++++++---
>  2 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 6d8c4a52e44e..1d0d884308ef 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -597,6 +597,9 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath);
>  #if !defined(_GEN_CNA_LOCK_SLOWPATH) && defined(CONFIG_NUMA_AWARE_SPINLOCKS)
>  #define _GEN_CNA_LOCK_SLOWPATH
>  
> +#undef pv_init_node
> +#define pv_init_node			cna_init_node
> +
>  #undef pv_wait_head_or_lock
>  #define pv_wait_head_or_lock		cna_pre_scan
>  
> diff --git a/kernel/locking/qspinlock_cna.h b/kernel/locking/qspinlock_cna.h
> index 4d095f742d31..b92a6f9a19db 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -50,9 +50,19 @@ struct cna_node {
>  	struct mcs_spinlock	mcs;
>  	int			numa_node;
>  	u32			encoded_tail;
> -	u32			pre_scan_result; /* 0 or an encoded tail */
> +	u32			pre_scan_result; /* 0, 1 or an encoded tail */
> +	u32			intra_count;
>  };
>  
> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs. It can
> + * be tuned and depend, e.g., on the number of CPUs per node. For now,
> + * choose a value that provides reasonable long-term fairness without
> + * sacrificing performance compared to a version that does not have any
> + * fairness guarantees.
> + */
> +#define INTRA_NODE_HANDOFF_THRESHOLD (1 << 16)

I think 64k is too high. I will be more comfortable with a number like
(1 << 8). The worst case latency for a lock waiter from the other node
is just not acceptable.

Cheers,
Longman
