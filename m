From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
Date: Wed, 15 Apr 2020 20:42:16 +0200
Message-ID: <CAK8P3a0x10bCQMC=iGm+fU2G1Vc=Zo-4yjaX4Jwso6rgazVzYw@mail.gmail.com>
References: <20200415165218.20251-1-will@kernel.org> <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416846AbgDOSmf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Apr 2020 14:42:35 -0400
In-Reply-To: <20200415172813.GA2272@lakrids.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Robin Murphy <robin.murphy@arm.com>

On Wed, Apr 15, 2020 at 7:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Will,
>
> On Wed, Apr 15, 2020 at 05:52:11PM +0100, Will Deacon wrote:
> > do_csum() over-reads the source buffer and therefore abuses
> > READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> > READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> > '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> > and fall back to normal loads.
>
> I'm confused by this. The whole point of READ_ONCE_NOCHECK() is that it
> isn't checked by KASAN, so if that semantic is removed it has no reason
> to exist.
>
> Changing that will break the unwind/stacktrace code across multiple
> architectures. IIRC they use READ_ONCE_NOCHECK() for two reasons:
>
> 1. Races with concurrent modification, as might happen when a thread's
>    stack is corrupted. Allowing the unwinder to bail out after a sanity
>    check means the resulting report is more useful than a KASAN splat in
>    the unwinder. I made the arm64 unwinder robust to this case.
>
> 2. I believe that the frame record itself /might/ be poisoned by KASAN,
>    since it's not meant to be an accessible object at the C langauge
>    level. I could be wrong about this, and would have to check.

I thought the main reason was deadlocks when a READ_ONCE()
is called inside of code that is part of the KASAN handling. If
READ_ONCE() ends up recursively calling itself, the kernel
tends to crash once it overflows its stack.

> I would like to keep the unwinding robust in the first case, even if the
> second case doesn't apply, and I'd prefer to not mark the entirety of
> the unwinding code as unchecked as that's sufficiently large an subtle
> that it could have nasty bugs.
>
> Is there any way we keep something like READ_ONCE_NOCHECK() around even
> if we have to give it reduced functionality relative to READ_ONCE()?
>
> I'm not enirely sure why READ_ONCE_NOCHECK() had to go, so if there's a
> particular pain point I'm happy to take a look.

As I understood, only this particular instance was removed, not all of them.

         Arnd
