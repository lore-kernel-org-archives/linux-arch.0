Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39632 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfCCStL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Mar 2019 13:49:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id r123so1905264lff.6
        for <linux-arch@vger.kernel.org>; Sun, 03 Mar 2019 10:49:09 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e21sm1108457lfb.68.2019.03.03.10.49.06
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 10:49:07 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id g12so1899400lfb.13
        for <linux-arch@vger.kernel.org>; Sun, 03 Mar 2019 10:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <CAHk-=whxaYGTmHyoWeegL=ihHMDW_FJehUJVN_nP++Su=foL+g@mail.gmail.com>
 <1551583190.duzqnmfnvg.astroid@bobo.none> <CAHk-=whVN58nWh29jvXx+X-Yx9dCC6BeAZOtKak+d01y_UVg=A@mail.gmail.com>
 <1551606848.8cceyn7nhv.astroid@bobo.none>
In-Reply-To: <1551606848.8cceyn7nhv.astroid@bobo.none>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Mar 2019 10:48:50 -0800
Message-ID: <CAHk-=wi9ZnP_17qwPB_b3hJ+C7DP3oxcRAPuDBCoEbe2QrbQew@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190303184850.z-kqbNDCpxdoExWv_ULi47C-zrmeeorMGoRZOEB0cJU@z>

On Sun, Mar 3, 2019 at 2:05 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Why even bother with it at all, "internal" or not?  Just get rid of
> mmiowb, the concept is obsolete.

It *is* gone, for chrissake!  Only the name remains as an internal
detail of "this is what we need to do".

> Pretend ia64 doesn't exist for a minute. Now the regular mb/wmb barriers
> orders IO across CPUs with respect to their cacheable accesses.

Stop with the total red herring already.

THIS HAS NOTHING TO DO WITH mb()/wmb().

As long as you keep bringing those up, you're only showing that you're
talking about the wrong thing.

> Regardless of whether that cacheable access is a spin lock, a bit lock,
> an atomic, a mutex... This is how it was before mmiowb came along.

No.

Beflore mmiowb() came along, there was one rule: do what x86 does.

And x86 orders mmio inside spinlocks.

Seriously.

Notice how there's not a single "barrier" mentioned here anywhere in
the above. No "mb()", no "wmb()", no nothing. Only "spinlocks order
IO".

That's the fundamental rule (that we broke for ia64), and all that
matters for this patch series.

Stop talking about wmb(). It's irrelevant. A spinlock does not
*contain* a wmb().

Nobody even _cares_ about wmb(). They are entirely irrelevant wrt IO,
because IO is ordered on any particular CPU anyway (which is what
wmb() enforces).

Only when you do special things like __raw_writel() etc does wmb()
matter, but at that point this whole series is entirely irrelevant,
and once again, that's still about just ordering on a single CPU.

So as long as you talk about wmb(), all you show is that you're
talking about something entirely different FROM THIS WHOLE SERIES.

And like it or not, ia64 still exists. We support it. It doesn't
_matter_ and we don't much care any more, but it still exists. Which
is why we have that concept of mmiowb().

On other platforms, mmiowb() might be a wmb(). Or it might not. It
might be some other barrier, or it might be a no-op entirely without a
barrier at all. It doesn't matter. But mmiowb() exists, and is now
happily entirely hidden inside the rule of "spinlocks order MMIO
across CPU's".

                 Linus
