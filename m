Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46378 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCCKH7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Mar 2019 05:07:59 -0500
Date: Sun, 03 Mar 2019 20:07:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <87tvgkia0k.fsf@concordia.ellerman.id.au>
In-Reply-To: <87tvgkia0k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Message-ID: <1551607531.yk1v9azmym.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190303100752.cf1C__W-ltr0VSXHwVXbfDPsFP8_M7P_x_ANsbFYZMU@z>

Michael Ellerman's on March 3, 2019 7:26 pm:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Will Deacon's on March 2, 2019 12:03 am:
>>> In preparation for removing all explicit mmiowb() calls from driver
>>> code, implement a tracking system in asm-generic based loosely on the
>>> PowerPC implementation. This allows architectures with a non-empty
>>> mmiowb() definition to have the barrier automatically inserted in
>>> spin_unlock() following a critical section containing an I/O write.
>>
>> Is there a reason to call this "mmiowb"? We already have wmb that
>> orders cacheable stores vs mmio stores don't we?
>>
>> Yes ia64 "sn2" is broken in that case, but that can be fixed (if
>> anyone really cares about the platform any more). Maybe that's
>> orthogonal to what you're doing here, I just don't like seeing
>> "mmiowb" spread.
>>
>> This series works for spin locks, but you would want a driver to
>> be able to use wmb() to order locks vs mmio when using a bit lock
>> or a mutex or whatever else. Calling your wmb-if-io-is-pending
>> version io_mb_before_unlock() would kind of match with existing
>> patterns.
>>
>>> +static inline void mmiowb_set_pending(void)
>>> +{
>>> +	struct mmiowb_state *ms =3D __mmiowb_state();
>>> +	ms->mmiowb_pending =3D ms->nesting_count;
>>> +}
>>> +
>>> +static inline void mmiowb_spin_lock(void)
>>> +{
>>> +	struct mmiowb_state *ms =3D __mmiowb_state();
>>> +	ms->nesting_count++;
>>> +}
>>> +
>>> +static inline void mmiowb_spin_unlock(void)
>>> +{
>>> +	struct mmiowb_state *ms =3D __mmiowb_state();
>>> +
>>> +	if (unlikely(ms->mmiowb_pending)) {
>>> +		ms->mmiowb_pending =3D 0;
>>> +		mmiowb();
>>> +	}
>>> +
>>> +	ms->nesting_count--;
>>> +}
>>
>> Humour me for a minute and tell me what this algorithm is doing, or
>> what was broken about the powerpc one, which is basically:
>>
>> static inline void mmiowb_set_pending(void)
>> {
>> 	struct mmiowb_state *ms =3D __mmiowb_state();
>> 	ms->mmiowb_pending =3D 1;
>> }
>>
>> static inline void mmiowb_spin_lock(void)
>> {
>> }
>=20
> The current powerpc code clears io_sync in spin_lock().
>=20
> ie, it would be equivalent to:
>=20
> static inline void mmiowb_spin_lock(void)
> {
>  	ms->mmiowb_pending =3D 0;
> }

Ah okay that's what I missed. How about we just not do that?

Thanks,
Nick
=
