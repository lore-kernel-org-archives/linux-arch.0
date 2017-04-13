From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] arm64/locking: qspinlocks and qrwlocks support
Date: Thu, 13 Apr 2017 20:12:12 +0200
Message-ID: <20170413181212.y3ezah76qoztxhnn@hirez.programming.kicks-ass.net>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
 <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58584 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755282AbdDMSMU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Apr 2017 14:12:20 -0400
Content-Disposition: inline
In-Reply-To: <1491860104-4103-4-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jan Glauber <jglauber@cavium.com>

On Tue, Apr 11, 2017 at 01:35:04AM +0400, Yury Norov wrote:

> +++ b/arch/arm64/include/asm/qspinlock.h
> @@ -0,0 +1,20 @@
> +#ifndef _ASM_ARM64_QSPINLOCK_H
> +#define _ASM_ARM64_QSPINLOCK_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +
> +#define	queued_spin_unlock queued_spin_unlock
> +/**
> + * queued_spin_unlock - release a queued spinlock
> + * @lock : Pointer to queued spinlock structure
> + *
> + * A smp_store_release() on the least-significant byte.
> + */
> +static inline void queued_spin_unlock(struct qspinlock *lock)
> +{
> +	smp_store_release((u8 *)lock, 0);
> +}

I'm afraid this isn't enough for arm64. I suspect you want your own
variant of queued_spin_unlock_wait() and queued_spin_is_locked() as
well.

Much memory ordering fun to be had there.
