Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45834 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKRMH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Feb 2019 12:12:07 -0500
MIME-Version: 1.0
References: <20190109210706.GA27268@linux.ibm.com> <20190109210748.29074-5-paulmck@linux.ibm.com>
 <20190211153043.GC32385@fuggles.cambridge.arm.com>
In-Reply-To: <20190211153043.GC32385@fuggles.cambridge.arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Feb 2019 18:11:48 +0100
Message-ID: <CAK8P3a3bkQoVfkV-+pNniirLN5Z_Wv3eG2TXW35kdJixCOH9_Q@mail.gmail.com>
Subject: Re: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy
 ordering for port I/O accesses
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Matthew Wilcox <willy@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Laight <David.Laight@aculab.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Message-ID: <20190211171148.qrfGBePqtYSHIeEG61T1iVkBS449lthHXY9s32F8SJo@z>

On Mon, Feb 11, 2019 at 4:30 PM Will Deacon <will.deacon@arm.com> wrote:

> Given the lack of Intel response here, I went away to do some digging.
> As evidenced by the commit message, there is certainly an understanding
> amongst some developers that inX/outX() are strongly ordered on x86 and
> this was re-enforced by Linus in March last year:
>
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg131212.html
>
> It was this information on which I based my patch. The Intel SDM is not
> quite as assertive in its claims.
>
> However, it has also occurred to me that this patch is actually missing
> the point. memory-barriers.txt should be documenting the *Linux* memory
> model, not the x86 one, and so the port accessors should be defined to
> have the same ordering semantics as the MMIO accessors. If this wasn't
> the case, then macros such as ioreadX() and iowriteX() would be unusable
> in portable driver code.

My interpretation of the ioreadX() and iowriteX() semantics is that they
only guarantee readl()/writel() barrier semantics, even though they
may in fact provide stronger barriers for PIO on architectures that use
CONFIG_GENERIC_IOMAP (which falls back to inX()/outX()).

> The inX/outX implementation in asm-generic would
> also be bogus, despite being widely used.

They likely are. The asm-generic files tend to provide a generic
abstraction as much as that is possible, but without having access
to the architecture specific semantics, they raditionally don't know
what should be done here. We now have __io_pbw()/__io_paw()/
__io_pbr()/__io_par() to let architectures get it right, but that is
a fairly recent addition, so nothing other than riscv defines them
today.
To make things worse, a lot of machines are unable to provide
__io_paw(), e.g. when all bus writes are posted.

      Arnd
