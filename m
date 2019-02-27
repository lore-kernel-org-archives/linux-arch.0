Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46837 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfB0EgN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 23:36:13 -0500
Date: Wed, 27 Feb 2019 14:36:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 11/20] ia64: Add unconditional mmiowb() to
 arch_spin_unlock()
References: <20190222185026.10973-1-will.deacon@arm.com>
        <20190222185026.10973-12-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-12-will.deacon@arm.com>
MIME-Version: 1.0
Message-ID: <1551241306.u5r150hwwb.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190227043605.HOxANXLvXYfspg0TeF4M6OgimDY_S0bUWCYewJ3KmRM@z>

Will Deacon's on February 23, 2019 4:50 am:
> The mmiowb() macro is horribly difficult to use and drivers will continue
> to work most of the time if they omit a call when it is required.
>=20
> Rather than rely on driver authors getting this right, push mmiowb() into
> arch_spin_unlock() for ia64. If this is deemed to be a performance issue,
> a subsequent optimisation could make use of ARCH_HAS_MMIOWB to elide
> the barrier in cases where no I/O writes were performned inside the
> critical section.

mmiowb() was always the wrong approach. IIRC what happened is that an
ia64 platform found that real wmb() semantics were too expensive, so=20
they kind of "relaxed" it, breaking everything, and then said drivers
that wanted to unbreak themselves had to add these mmiowb() in.

The right way to go of course would have been to implement wmb()
the way existing drivers expected, and add a faster io_wmb() that
only ordered mmio stores from the CPU added to the few drivers that
the platform cared about.

I think it was argued the wmb() was still technically correct because
the reordering did not happen at the CPU, but somewhere else in the=20
interconnect or PCI controller. But that was just a crazy burden to
put on driver writers, and it was why the documentation was always
incomprehensible.

Not sure why Linus ever went along with it, but awesome you're removing
it. Thank you!

Thanks,
Nick
=
