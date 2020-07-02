From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
Date: Thu, 2 Jul 2020 09:02:19 +0100
Message-ID: <20200702080219.GB16113@willie-the-truck>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-6-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-ppc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200702074839.1057733-6-npiggin@gmail.com>
Sender: kvm-ppc-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
> new file mode 100644
> index 000000000000..f84da77b6bb7
> --- /dev/null
> +++ b/arch/powerpc/include/asm/qspinlock.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_QSPINLOCK_H
> +#define _ASM_POWERPC_QSPINLOCK_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +
> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
> +
> +#define smp_mb__after_spinlock()   smp_mb()
> +
> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
> +{
> +	smp_mb();
> +	return atomic_read(&lock->val);
> +}

Why do you need the smp_mb() here?

Will
