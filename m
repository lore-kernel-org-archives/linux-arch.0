Return-Path: <SRS0=qOhU=AN=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbgGBKZu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 06:25:50 -0400
Date: Thu, 02 Jul 2020 20:25:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
References: <20200702074839.1057733-1-npiggin@gmail.com>
        <20200702074839.1057733-6-npiggin@gmail.com>
        <20200702080219.GB16113@willie-the-truck>
In-Reply-To: <20200702080219.GB16113@willie-the-truck>
MIME-Version: 1.0
Message-ID: <1593685459.r2tfxtfdp6.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org
Message-ID: <20200702102543.u5x5xIQkwTw-GL8PUv8vlJ_Ah-30mo_lP-4yfPx9f5E@z>

Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
> On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include=
/asm/qspinlock.h
>> new file mode 100644
>> index 000000000000..f84da77b6bb7
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/qspinlock.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>> +#define _ASM_POWERPC_QSPINLOCK_H
>> +
>> +#include <asm-generic/qspinlock_types.h>
>> +
>> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>> +
>> +#define smp_mb__after_spinlock()   smp_mb()
>> +
>> +static __always_inline int queued_spin_is_locked(struct qspinlock *lock=
)
>> +{
>> +	smp_mb();
>> +	return atomic_read(&lock->val);
>> +}
>=20
> Why do you need the smp_mb() here?

A long and sad tale that ends here 51d7d5205d338

Should probably at least refer to that commit from here, since this one=20
is not going to git blame back there. I'll add something.

Thanks,
Nick
