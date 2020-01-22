Return-Path: <SRS0=lDRc=3L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:37346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVJXA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:23:00 -0500
Date: Wed, 22 Jan 2020 10:22:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200122092238.GV14879@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121202919.GM11457@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20200122092238.g5q-WsuWeFOl2ldPmwKzjreIswE75NJ2EJ7Ug-Sab9M@z>

On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
> @@ -92,8 +92,8 @@ static int __init cna_init_nodes(void)
>  }
>  early_initcall(cna_init_nodes);
>  
> -static inline bool cna_try_change_tail(struct qspinlock *lock, u32 val,
> -				       struct mcs_spinlock *node)
> +static inline bool cna_try_clear_tail(struct qspinlock *lock, u32 val,
> +				      struct mcs_spinlock *node)
>  {
>  	struct mcs_spinlock *head_2nd, *tail_2nd;
>  	u32 new;

Also, that whole function is placed wrong; it should be between
cna_wait_head_or_lock() and cna_pass_lock(), then it's in the order they
appear in the slow path, ie. the order they actually run.
