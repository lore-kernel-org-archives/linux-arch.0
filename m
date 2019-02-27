Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:33320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0KUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Feb 2019 05:20:03 -0500
Date: Wed, 27 Feb 2019 11:19:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Message-ID: <20190227101925.GK32494@hirez.programming.kicks-ass.net>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com>
 <20190226183335.GN2861@worktop.programming.kicks-ass.net>
 <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjx89RpPw6EV4fwSDAPbQcs=-2a4oM9N94saa9hemNbmw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190227101925.eSowRBkRNcP7O6v-LwGngjQFuoiPs9Dg--mznYmlpac@z>

On Tue, Feb 26, 2019 at 11:02:50AM -0800, Linus Torvalds wrote:
> On Tue, Feb 26, 2019 at 10:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.
> 
> Yeah, I guess x86 _should_ really do __this_cpu_xchg() as just a
> read-write pair.

See the patches I just send.

> In general, a read-write pair is probably always the right thing to
> do, and the only reason we can't just do it in an
> architecture-independent way is that we'd want to avoid doing the
> address generation twice (for architectures where that is an issue).

The generic code has this right, see
include/asm-generic/percpu.h:raw_cpu_generic_xchg().

That is used in the majority of the architectures. With the patch I just
send, x86 will use two gs prefixed movs.
