From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
Date: Thu, 2 Jul 2020 11:35:06 +0100
Message-ID: <20200702103506.GA16418@willie-the-truck>
References: <20200702074839.1057733-1-npiggin@gmail.com>
 <20200702074839.1057733-6-npiggin@gmail.com>
 <20200702080219.GB16113@willie-the-truck>
 <1593685459.r2tfxtfdp6.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGBKfM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 06:35:12 -0400
Content-Disposition: inline
In-Reply-To: <1593685459.r2tfxtfdp6.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org

On Thu, Jul 02, 2020 at 08:25:43PM +1000, Nicholas Piggin wrote:
> Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
> > On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
> >> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
> >> new file mode 100644
> >> index 000000000000..f84da77b6bb7
> >> --- /dev/null
> >> +++ b/arch/powerpc/include/asm/qspinlock.h
> >> @@ -0,0 +1,20 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +#ifndef _ASM_POWERPC_QSPINLOCK_H
> >> +#define _ASM_POWERPC_QSPINLOCK_H
> >> +
> >> +#include <asm-generic/qspinlock_types.h>
> >> +
> >> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
> >> +
> >> +#define smp_mb__after_spinlock()   smp_mb()
> >> +
> >> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
> >> +{
> >> +	smp_mb();
> >> +	return atomic_read(&lock->val);
> >> +}
> > 
> > Why do you need the smp_mb() here?
> 
> A long and sad tale that ends here 51d7d5205d338
> 
> Should probably at least refer to that commit from here, since this one 
> is not going to git blame back there. I'll add something.

Is this still an issue, though?

See 38b850a73034 (where we added a similar barrier on arm64) and then
c6f5d02b6a0f (where we removed it).

Will
