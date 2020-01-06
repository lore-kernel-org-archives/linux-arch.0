Return-Path: <SRS0=948I=23=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53257 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbgAFPdh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Jan 2020 10:33:37 -0500
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <53b08fc3-f29f-65ec-f2e9-0f469cd79744@redhat.com>
Date: Mon, 6 Jan 2020 10:33:27 -0500
MIME-Version: 1.0
In-Reply-To: <20191230194042.67789-5-alex.kogan@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200106153327.qXQrxDdETgQs9T2UppeIGHakQkTxN2VD6V2Jvu7ylMs@z>

On 12/30/19 2:40 PM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
> The default value for the threshold can be overridden with
> the new kernel boot command-line option "numa_spinlock_threshold".
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++
>  kernel/locking/qspinlock.c                    |  3 ++
>  kernel/locking/qspinlock_cna.h                | 41 ++++++++++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b68cb80e477f..30d79819a3b0 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3200,6 +3200,14 @@
>  			Not specifying this option is equivalent to
>  			numa_spinlock=auto.
>  
> +	numa_spinlock_threshold=	[NUMA, PV_OPS]
> +			Set the threshold for the number of intra-node
> +			lock hand-offs before the NUMA-aware spinlock
> +			is forced to be passed to a thread on another NUMA node.
> +			Valid values are in the [0..31] range. Smaller values
> +			result in a more fair, but less performant spinlock, and
> +			vice versa. The default value is 16.
> +
>  	cpu0_hotplug	[X86] Turn on CPU0 hotplug feature when
>  			CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>  			Some features depend on CPU0. Known dependencies are:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 609980a53841..e382d8946ccc 100644
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
> index 3c99a4a6184b..30feff02865d 100644
> --- a/kernel/locking/qspinlock_cna.h
> +++ b/kernel/locking/qspinlock_cna.h
> @@ -51,13 +51,25 @@ struct cna_node {
>  	int			numa_node;
>  	u32			encoded_tail;
>  	u32			pre_scan_result; /* encoded tail or enum val */
> +	u32			intra_count;
>  };
>  
>  enum {
>  	LOCAL_WAITER_FOUND = 2,	/* 0 and 1 are reserved for @locked */
> +	FLUSH_SECONDARY_QUEUE = 3,
>  	MIN_ENCODED_TAIL
>  };
>  
> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs before
> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lock
> + * that does not have any fairness guarantees. The default setting can
> + * be changed with the "numa_spinlock_threshold" boot option.
> + */
> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;

Another minor nit. (1 << 31) is negative for an int value. I will
suggest that you either make intra_node_handoff_threshold an unsigned
int or limit the upper bound to 30.

Cheers,
Longman
