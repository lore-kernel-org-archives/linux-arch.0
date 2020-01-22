Return-Path: <SRS0=lDRc=3L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:52700 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbgAVJ4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:56:41 -0500
Date: Wed, 22 Jan 2020 10:56:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 5/5] locking/qspinlock: Introduce the shuffle
 reduction optimization into CNA
Message-ID: <20200122095622.GS14914@hirez.programming.kicks-ass.net>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-6-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191230194042.67789-6-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200122095622.gLio2KI9CdM8WIPeGjHW4TiCOEf3PcY6-VT2qTmNY7Q@z>

On Mon, Dec 30, 2019 at 02:40:42PM -0500, Alex Kogan wrote:
> @@ -251,8 +281,11 @@ __always_inline u32 cna_pre_scan(struct qspinlock *lock,
>  	struct cna_node *cn = (struct cna_node *)node;
>  
>  	cn->pre_scan_result =
> -		cn->intra_count == intra_node_handoff_threshold ?
> -			FLUSH_SECONDARY_QUEUE : cna_scan_main_queue(node, node);
> +		(node->locked <= 1 && probably(SHUFFLE_REDUCTION_PROB_ARG)) ?
> +			PASS_LOCK_IMMEDIATELY :
> +			cn->intra_count == intra_node_handoff_threshold ?
> +				FLUSH_SECONDARY_QUEUE :
> +				cna_scan_main_queue(node, node);
>  
>  	return 0;
>  }

Let me just, once again, remind people that the Linux Kernel is not part
of the Obfuscated C code contest.

> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

Seriously, in what universe is that actually readable code? Steve quick,
say what it does.
