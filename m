Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56786 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfGPKXd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 06:23:33 -0400
Date: Tue, 16 Jul 2019 12:23:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/5] locking/qspinlock: Make
 arch_mcs_spin_unlock_contended more generic
Message-ID: <20190716102314.GO3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-2-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-2-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190716102314.0wd1_71yRkwRTX65uDs31I8zQD-wzJ2G92RWBB2G7DI@z>

On Mon, Jul 15, 2019 at 03:25:32PM -0400, Alex Kogan wrote:

> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index e14b32c69639..961781624638 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -558,7 +558,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	if (!next)
>  		next = smp_cond_load_relaxed(&node->next, (VAL));
>  
> -	arch_mcs_spin_unlock_contended(&next->locked);
> +	arch_mcs_spin_unlock_contended(&next->locked, 1);
>  	pv_kick_node(lock, next);

My problem with this patch is that the above reads really daft. Should
we rename the whole function? arch_mcs_pass_lock() perhaps?
