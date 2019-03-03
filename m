Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35118 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfCCBnR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 2 Mar 2019 20:43:17 -0500
Date: Sun, 03 Mar 2019 11:43:09 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
In-Reply-To: <20190301140348.25175-2-will.deacon@arm.com>
MIME-Version: 1.0
Message-ID: <1551575210.6lwpiqtg5k.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190303014309.Y1vKFxetx4IczbrOsd_2BnpFqovCJyQOoZeJefu58SM@z>

Will Deacon's on March 2, 2019 12:03 am:
> In preparation for removing all explicit mmiowb() calls from driver
> code, implement a tracking system in asm-generic based loosely on the
> PowerPC implementation. This allows architectures with a non-empty
> mmiowb() definition to have the barrier automatically inserted in
> spin_unlock() following a critical section containing an I/O write.

Is there a reason to call this "mmiowb"? We already have wmb that
orders cacheable stores vs mmio stores don't we?

Yes ia64 "sn2" is broken in that case, but that can be fixed (if
anyone really cares about the platform any more). Maybe that's
orthogonal to what you're doing here, I just don't like seeing
"mmiowb" spread.

This series works for spin locks, but you would want a driver to
be able to use wmb() to order locks vs mmio when using a bit lock
or a mutex or whatever else. Calling your wmb-if-io-is-pending
version io_mb_before_unlock() would kind of match with existing
patterns.

> +static inline void mmiowb_set_pending(void)
> +{
> +	struct mmiowb_state *ms =3D __mmiowb_state();
> +	ms->mmiowb_pending =3D ms->nesting_count;
> +}
> +
> +static inline void mmiowb_spin_lock(void)
> +{
> +	struct mmiowb_state *ms =3D __mmiowb_state();
> +	ms->nesting_count++;
> +}
> +
> +static inline void mmiowb_spin_unlock(void)
> +{
> +	struct mmiowb_state *ms =3D __mmiowb_state();
> +
> +	if (unlikely(ms->mmiowb_pending)) {
> +		ms->mmiowb_pending =3D 0;
> +		mmiowb();
> +	}
> +
> +	ms->nesting_count--;
> +}

Humour me for a minute and tell me what this algorithm is doing, or
what was broken about the powerpc one, which is basically:

static inline void mmiowb_set_pending(void)
{
	struct mmiowb_state *ms =3D __mmiowb_state();
	ms->mmiowb_pending =3D 1;
}

static inline void mmiowb_spin_lock(void)
{
}

static inline void mmiowb_spin_unlock(void)
{
	struct mmiowb_state *ms =3D __mmiowb_state();

	if (unlikely(ms->mmiowb_pending)) {
		ms->mmiowb_pending =3D 0;
		mmiowb();
	}
}

> diff --git a/include/asm-generic/mmiowb_types.h b/include/asm-generic/mmi=
owb_types.h
> new file mode 100644
> index 000000000000..8eb0095655e7
> --- /dev/null
> +++ b/include/asm-generic/mmiowb_types.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_GENERIC_MMIOWB_TYPES_H
> +#define __ASM_GENERIC_MMIOWB_TYPES_H
> +
> +#include <linux/types.h>
> +
> +struct mmiowb_state {
> +	u16	nesting_count;
> +	u16	mmiowb_pending;
> +};

Really need more than 255 nested spin locks? I had the idea that 16
bit operations were a bit more costly than 8 bit on some CPUs... may
not be true, but at least the smaller size packs a bit better on
powerpc.

Thanks,
Nick

=
