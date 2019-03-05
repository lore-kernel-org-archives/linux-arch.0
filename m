Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39890 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAVv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2019 19:21:51 -0500
Date: Tue, 05 Mar 2019 10:21:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <87tvgkia0k.fsf@concordia.ellerman.id.au>
        <1551607531.yk1v9azmym.astroid@bobo.none>
        <87d0n7bgh7.fsf@concordia.ellerman.id.au>
In-Reply-To: <87d0n7bgh7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Message-ID: <1551744761.r3fh0fxees.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190305002142.mLB1GfLJ2dchVtM6VyKZP5QdmAC1F3BG1himGnRQNEY@z>

Michael Ellerman's on March 4, 2019 11:01 am:
> Nicholas Piggin <npiggin@gmail.com> writes:
>> Michael Ellerman's on March 3, 2019 7:26 pm:
>>> Nicholas Piggin <npiggin@gmail.com> writes:
> ...
>>>> what was broken about the powerpc one, which is basically:
>>>>
>>>> static inline void mmiowb_set_pending(void)
>>>> {
>>>> 	struct mmiowb_state *ms =3D __mmiowb_state();
>>>> 	ms->mmiowb_pending =3D 1;
>>>> }
>>>>
>>>> static inline void mmiowb_spin_lock(void)
>>>> {
>>>> }
>>>=20
>>> The current powerpc code clears io_sync in spin_lock().
>>>=20
>>> ie, it would be equivalent to:
>>>=20
>>> static inline void mmiowb_spin_lock(void)
>>> {
>>>  	ms->mmiowb_pending =3D 0;
>>> }
>>
>> Ah okay that's what I missed. How about we just not do that?
>=20
> Yeah I thought of that too but it's not great. We'd start semi-randomly
> executing the sync in unlock depending on whether someone had done IO on
> that CPU prior to the spinlock.
>=20
> eg.
>=20
> 	writel(x, y);		// sets paca->io_sync
> 	...=09
>=20
> 	<schedule>
>=20
> 	spin_lock(a);
>         ...
>         // No IO in here
>         ...
>         spin_unlock(a);		// sync() here because other task did writel().
>=20
>=20
> Which wouldn't be *incorrect*, but would be kind of weird.

schedule is probably okay, we could clear pending there. But you
possibly could get interrupts, or some lock free mmios that set the
flag. Does it matter that much? A random cache miss could have the
same effect.

It may matter slightly less for powerpc because we don't inline
spin locks, although I have been hoping to for a while, this might
put the nail in that.

We can always tinker with it later though so I won't insist.

Thanks,
Nick

=
