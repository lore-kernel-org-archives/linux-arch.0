Return-Path: <SRS0=qOhU=AN=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGBKrM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 06:47:12 -0400
Date: Thu, 02 Jul 2020 20:47:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 5/8] powerpc/64s: implement queued spinlocks and rwlocks
References: <20200702074839.1057733-1-npiggin@gmail.com>
        <20200702074839.1057733-6-npiggin@gmail.com>
        <20200702080219.GB16113@willie-the-truck>
        <1593685459.r2tfxtfdp6.astroid@bobo.none>
        <20200702103506.GA16418@willie-the-truck>
In-Reply-To: <20200702103506.GA16418@willie-the-truck>
MIME-Version: 1.0
Message-ID: <1593686722.w9psaqk7yp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org
Message-ID: <20200702104705.kOEFS9jI0wq4GfZ1LxRei2DIdebYqxTYFk1B0DJL04Q@z>

Excerpts from Will Deacon's message of July 2, 2020 8:35 pm:
> On Thu, Jul 02, 2020 at 08:25:43PM +1000, Nicholas Piggin wrote:
>> Excerpts from Will Deacon's message of July 2, 2020 6:02 pm:
>> > On Thu, Jul 02, 2020 at 05:48:36PM +1000, Nicholas Piggin wrote:
>> >> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/incl=
ude/asm/qspinlock.h
>> >> new file mode 100644
>> >> index 000000000000..f84da77b6bb7
>> >> --- /dev/null
>> >> +++ b/arch/powerpc/include/asm/qspinlock.h
>> >> @@ -0,0 +1,20 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 */
>> >> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>> >> +#define _ASM_POWERPC_QSPINLOCK_H
>> >> +
>> >> +#include <asm-generic/qspinlock_types.h>
>> >> +
>> >> +#define _Q_PENDING_LOOPS	(1 << 9) /* not tuned */
>> >> +
>> >> +#define smp_mb__after_spinlock()   smp_mb()
>> >> +
>> >> +static __always_inline int queued_spin_is_locked(struct qspinlock *l=
ock)
>> >> +{
>> >> +	smp_mb();
>> >> +	return atomic_read(&lock->val);
>> >> +}
>> >=20
>> > Why do you need the smp_mb() here?
>>=20
>> A long and sad tale that ends here 51d7d5205d338
>>=20
>> Should probably at least refer to that commit from here, since this one=20
>> is not going to git blame back there. I'll add something.
>=20
> Is this still an issue, though?
>=20
> See 38b850a73034 (where we added a similar barrier on arm64) and then
> c6f5d02b6a0f (where we removed it).
>=20

Oh nice, I didn't know that went away. Thanks for the heads up.

I'm going to say I'm too scared to remove it while changing the
spinlock algorithm, but I'll open an issue and we should look at=20
removing it.

Thanks,
Nick
