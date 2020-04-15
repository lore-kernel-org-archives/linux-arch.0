Return-Path: <SRS0=yBTr=57=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404698AbgDOT0M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 15:26:12 -0400
Date: Wed, 15 Apr 2020 20:26:05 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
Message-ID: <20200415192605.GA21804@willie-the-truck>
References: <20200415165218.20251-1-will@kernel.org>
 <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415172813.GA2272@lakrids.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Robin Murphy <robin.murphy@arm.com>
Message-ID: <20200415192605.Kf_rTULRxcPrL1WIruRsuwtty0lrqDfj34UgH6Q7sVA@z>

On Wed, Apr 15, 2020 at 06:28:14PM +0100, Mark Rutland wrote:
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

Oh, I thought it was there to be used by things like KASAN itself and
because READ_ONCE() was implemented using a static function, then that
function had to be marked as __no_sanitize_address when used in these
cases. Now that it's just a macro, that's not necessary so it's just
the same as normal READ_ONCE().

Do we have a "nocheck" version where we don't require the READ_ONCE()
semantics? I think abusing a relaxed concurrency primitive for this is
not the right thing to do, particularly when the __no_sanitize_address
annotation is available. I fact, it's almost an argument in favour
of removing READ_ONCE_NOCHECK() so that people use the annotation instead!

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

Ok.

> I would like to keep the unwinding robust in the first case, even if the
> second case doesn't apply, and I'd prefer to not mark the entirety of
> the unwinding code as unchecked as that's sufficiently large an subtle
> that it could have nasty bugs.

Hmm, maybe. I don't really see what's wrong with annotating the unwinding
code, though. You can still tell kasan about the accesses you're making,
like we do in the checksumming code here, and it's not hard to move the
frame-pointer chasing code into a separate function.

> Is there any way we keep something like READ_ONCE_NOCHECK() around even
> if we have to give it reduced functionality relative to READ_ONCE()?
> 
> I'm not enirely sure why READ_ONCE_NOCHECK() had to go, so if there's a
> particular pain point I'm happy to take a look.

I got rid if it because I thought it wasn't required now that it's
implemented entirely as a macro. I'd be reluctant to bring it back if
there isn't a non-ONCE version of the helper.

Will
