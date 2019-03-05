Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44794 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEAVd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Mar 2019 19:21:33 -0500
Date: Tue, 05 Mar 2019 10:21:24 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
References: <20190301140348.25175-1-will.deacon@arm.com>
        <20190301140348.25175-2-will.deacon@arm.com>
        <1551575210.6lwpiqtg5k.astroid@bobo.none>
        <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
        <1551583190.duzqnmfnvg.astroid@bobo.none>
        <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
        <1551606848.8cceyn7nhv.astroid@bobo.none>
        <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
In-Reply-To: <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <1551743521.hogpbicfcz.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190305002124.3sKFEv4519MCYbEjX0GRztdWuQILtOC3xriU__RB3pA@z>

Linus Torvalds's on March 4, 2019 4:48 am:
> On Sun, Mar 3, 2019 at 2:05 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> Why even bother with it at all, "internal" or not?  Just get rid of
>> mmiowb, the concept is obsolete.
>=20
> It *is* gone, for chrissake!  Only the name remains as an internal
> detail of "this is what we need to do".
>=20
>> Pretend ia64 doesn't exist for a minute. Now the regular mb/wmb barriers
>> orders IO across CPUs with respect to their cacheable accesses.
>=20
> Stop with the total red herring already.
>=20
> THIS HAS NOTHING TO DO WITH mb()/wmb().
>=20
> As long as you keep bringing those up, you're only showing that you're
> talking about the wrong thing.

Why? I'm talking about them because they are not taken care of by this=20
part of mmiowb removal. Talking about spin locks is the wrong thing
because we're already past that and everybody agrees it's the right
approach.

>> Regardless of whether that cacheable access is a spin lock, a bit lock,
>> an atomic, a mutex... This is how it was before mmiowb came along.
>=20
> No.
>=20
> Beflore mmiowb() came along, there was one rule: do what x86 does.
>=20
> And x86 orders mmio inside spinlocks.
>=20
> Seriously.
>
> Notice how there's not a single "barrier" mentioned here anywhere in
> the above. No "mb()", no "wmb()", no nothing. Only "spinlocks order
> IO".
>=20
> That's the fundamental rule (that we broke for ia64), and all that
> matters for this patch series.
>=20
> Stop talking about wmb(). It's irrelevant. A spinlock does not
> *contain* a wmb().

Well you don't have to talk about it but why do you want me to stop?
I don't understand. It's an open topic still after this series. I
can post a new thread about it if that would upset you less, I just
thought it would kind of fit here because we're talking about mmiowb,
I'm not trying to derail this series.

> Nobody even _cares_ about wmb(). They are entirely irrelevant wrt IO,
> because IO is ordered on any particular CPU anyway (which is what
> wmb() enforces).
>=20
> Only when you do special things like __raw_writel() etc does wmb()
> matter, but at that point this whole series is entirely irrelevant,
> and once again, that's still about just ordering on a single CPU.
>=20
> So as long as you talk about wmb(), all you show is that you're
> talking about something entirely different FROM THIS WHOLE SERIES.
>=20
> And like it or not, ia64 still exists. We support it. It doesn't
> _matter_ and we don't much care any more, but it still exists. Which
> is why we have that concept of mmiowb().
>=20
> On other platforms, mmiowb() might be a wmb(). Or it might not. It
> might be some other barrier, or it might be a no-op entirely without a
> barrier at all. It doesn't matter. But mmiowb() exists, and is now
> happily entirely hidden inside the rule of "spinlocks order MMIO
> across CPU's".

The driver writer still has to know exactly as much about mmiowb
(the concept, if not the name) before this series as afterward. That
is, sequences of mmio stores to a device from different CPUs can only
be atomic if you (put mmiowb before spin unlock | protect them with
spin locks).

I just don't understand the reason to expose the driver writer to
that additional detail. Intuitively, mb() should order stores to
all kind of memory the same as smp_mb() orders stores to cacheable
(without the detail of stores being reordered at the interconnect
or controller -- driver writer doesn't care about store queues in
the CPU or whatever details, they want the device to see IOs in
some order).

Thanks,
Nick

=
