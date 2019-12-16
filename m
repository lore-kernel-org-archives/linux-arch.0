Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.135]:50109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbfLPMGn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Dec 2019 07:06:43 -0500
MIME-Version: 1.0
References: <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com> <20191213144359.GA3826@willie-the-truck>
In-Reply-To: <20191213144359.GA3826@willie-the-truck>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 16 Dec 2019 13:06:22 +0100
Message-ID: <CAK8P3a0qgbqKTtRWTh6c0R2E93rehKbkBcB18TL3JX_RWHsTZA@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191216120622.bTkbFr5QWFQcw3xeqKTSjFPU7b8y4ROTGms1zM-ErXo@z>

On Mon, Dec 16, 2019 at 11:28 AM Will Deacon <will@kernel.org> wrote:
> On Fri, Dec 13, 2019 at 02:17:08PM +0100, Arnd Bergmann wrote:
> > On Thu, Dec 12, 2019 at 9:50 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > > On Thu, Dec 12, 2019 at 11:34 AM Will Deacon <will@kernel.org> wrote:
> > > > The root of my concern in all of this, and what started me looking at it in
> > > > the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
> > > > for a pointer means that local variables in macros declared using typeof()
> > > > suddenly start generating *hideous* code, particularly when pointless stack
> > > > spills get stackprotector all excited.
> > >
> > > Yeah, removing volatile can be a bit annoying.
> > >
> > > For the particular case of the bitops, though, it's not an issue.
> > > Since you know the type there, you can just cast it.
> > >
> > > And if we had the rule that READ_ONCE() was an arithmetic type, you could do
> > >
> > >     typeof(0+(*p)) __var;
> > >
> > > since you might as well get the integer promotion anyway (on the
> > > non-volatile result).
> > >
> > > But that doesn't work with structures or unions, of course.
> > >
> > > I'm not entirely sure we have READ_ONCE() with a struct. I do know we
> > > have it with 64-bit entities on 32-bit machines, but that's ok with
> > > the "0+" trick.
> >
> > I'll have my randconfig builder look for instances, so far I found one,
> > see below. My feeling is that it would be better to enforce at least
> > the size being a 1/2/4/8, to avoid cases where someone thinks
> > the access is atomic, but it falls back on a memcpy.
>
> I've been using something similar built on compiletime_assert_atomic_type()
> and I spotted another instance in the xdp code (xskq_validate_desc()) which
> tries to READ_ONCE() on a 128-bit descriptor, although a /very/ quick read
> of the code suggests that this probably can't be concurrently modified if
> the ring indexes are synchronised properly.

That's the only other one I found. I have not checked how many are structs
that are the size of a normal u8/u16/u32/u64, or if there are types that
have a lower alignment than there size, such as a __u16[2] that might
span a page boundary.

> However, enabling this for 32-bit ARM is total carnage; as Linus mentioned,
> a whole bunch of code appears to be relying on atomic 64-bit access of
> READ_ONCE(); the perf ring buffer, io_uring, the scheduler, pm_runtime,
> cpuidle, ... :(
>
> Unfortunately, at least some of these *do* look like bugs, but I can't see
> how we can fix them, not least because the first two are user ABI afaict. It
> may also be that in practice we get 2x32-bit stores, and that works out fine
> when storing a 32-bit virtual address. I'm not sure what (if anything) the
> compiler guarantees in these cases.

Would it help if 32-bit architectures use atomic64_read() and atomic64_set()
to implement a 64-bit READ_ONCE()/WRITE_ONCE(), or would that make it
worse in other ways?

On mips32, riscv32 and some minor 32-bit architectures with SMP support
(xtensa,  csky, hexagon, openrisc, parisc32, sparc32 and ppc32 AFAICT) this
ends up using a spinlock for GENERIC_ATOMIC64, but at least ARMv6+,
i586+ and most ARC should be fine.

(Side note: the ARMv7 implementation is suboptimimal for ARMv7VE+
if LPAE is disabled, I think we need to really add Kconfig options for
ARMv7VE and 32-bit ARMv8 improve this and things like integer divide).

      Arnd
