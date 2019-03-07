Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40981 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfCGBNg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Mar 2019 20:13:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id z25so12686533ljk.8
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2019 17:13:34 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id j5sm590050ljg.47.2019.03.06.17.13.29
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 17:13:30 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z7so12688216lji.0
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2019 17:13:29 -0800 (PST)
MIME-Version: 1.0
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com>
 <1551575210.6lwpiqtg5k.astroid@bobo.none> <87ef7n7x9v.fsf@concordia.ellerman.id.au>
 <CAHk-=wgbnn7x+i72NqnvXotbxjsk2Ag56Q5YP0OSvhY9sUk7QA@mail.gmail.com> <87k1hbv7ba.fsf@concordia.ellerman.id.au>
In-Reply-To: <87k1hbv7ba.fsf@concordia.ellerman.id.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2019 17:13:13 -0800
Message-ID: <CAHk-=wi_tsKOxpJVEWnfh4Zkx58oYtGfKCx_-hPNJx4Yu0-_-w@mail.gmail.com>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of
 mmiowb() tracking
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20190307011313.zwcObF7uXb_fd8QnuSgcmkz1UmAL0xcXZ0ugK709xj0@z>

On Wed, Mar 6, 2019 at 4:48 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> It's a bit hard to grep for, but I did find one case:
>
> static void netxen_nic_io_write_128M(struct netxen_adapter *adapter,
>                 void __iomem *addr, u32 data)
> {
>         read_lock(&adapter->ahw.crb_lock);
>         writel(data, addr);
>         read_unlock(&adapter->ahw.crb_lock);
> }
>
> It looks like that driver is using the rwlock to exclude cases that can
> just do a readl()/writel() (readers) vs another case that has to reconfigure a
> window or something, before doing readl()/writel() and then configuring
> the window back. So that seems like a valid use for a rwlock.

Oh, it's actually fairly sane: the IO itself is apparently windowed on
that hardware, and the *common* case is that you'd access "window 1".

So if everybody accesses window 1, they can all work in parallel - the
read case.

But if somebody needs to access any of the other special IO windows,
they need to take the write lock, then change the window pointer to
the window they want to access, do the access, and then set it back to
the default "window 1".

So yes. That driver very much relies on exclusion of the IO through an rwlock.

I'm guessing nobody uses that hardware on Power? Or maybe the "window
1 is common" is *so* common that the other cases basically never
happen and don't really end up ever causing problems?

[ Time passes, I look at it ]

Actually, the driver probably works on Power, because *setting* the
window isn't just a write to the window register, it's always
serialized by a read _from_ the window register to verify that the
write "took". Apparently the hardware itself really needs that "don't
do accesses to the window before I've settled".

And that would basically serialize the only operation that really
needs serialization, so in the case of _that_ driver, it all looks
safe. Even if it's partly by luck.

> > Perhaps more importantly, what about sleeping locks? When they
> > actually *block*, they get the barrier thanks to the scheduler, but
> > you can have a nice non-contended sequence that never does that.
>
> Yeah.
>
> The mutex unlock fast path is just:

Yup. Both lock/unlock have fast paths that should be just trivial
atomic sequences.

But the good news is that *usually* device IO is protected by a
spinlock, since you almost always have interrupt serialization needs
too whenever you have any sequence of MMIO that isn't just some "write
single word to start the engine".

So the "use mutex to serialize IO" may be fairly unusual.

                  Linus
