Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38416 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCCKFb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Mar 2019 05:05:31 -0500
Date: Sun, 03 Mar 2019 20:05:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
        <1551583190.duzqnmfnvg.astroid@bobo.none>
        <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
In-Reply-To: <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <1551606848.8cceyn7nhv.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190303100523.D-pC4-m5-fdDM4duztzwbExIpGq_B9zSWV7Jd_HYkG8@z>

Linus Torvalds's on March 3, 2019 2:29 pm:
> On Sat, Mar 2, 2019, 19:34 Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
>>
>> It doesn't have to be done all at once with this series, obviously this
>> is a big improvement on its own. But why perpetuate the nomenclature
>> and concept for new code added now?
>>
>=20
> What nomenclature?
>=20
> Nobody will be using mmiowb(). That's the whole point of the patch series=
.
>=20
> It's now an entirely internal name, and nobody cares.

Why even bother with it at all, "internal" or not?  Just get rid of=20
mmiowb, the concept is obsolete.

> And none of this has anything to do with wmb(), since it's about IO being
> ordered across cpu's by spin locks, not by barriers.
>=20
> So I'm not seeing what you're arguing about.

Pretend ia64 doesn't exist for a minute. Now the regular mb/wmb barriers=20
orders IO across CPUs with respect to their cacheable accesses. =20
Regardless of whether that cacheable access is a spin lock, a bit lock,=20
an atomic, a mutex... This is how it was before mmiowb came along.

Nothing wrong with this series to make spinlocks order mmio, but why=20
call it mmiowb? Another patch could rename ia64's mmiowb and then the
name can be removed from the tree completely.

Thanks,
Nick

=
