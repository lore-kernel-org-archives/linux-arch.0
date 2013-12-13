From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/4] arch: Clean up asm/barrier.h implementations using
 asm-generic/barrier.h
Date: Fri, 13 Dec 2013 20:53:15 +0100
Message-ID: <20131213195315.GH2480@laptop.programming.kicks-ass.net>
References: <20131213145657.265414969@infradead.org>
 <20131213150640.846368594@infradead.org>
 <CAMuHMdXs16E1WZ4FL=r9BkLBF-q7B432pzpVoGiH-53HZxVx-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:52146 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3LMTyE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2013 14:54:04 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdXs16E1WZ4FL=r9BkLBF-q7B432pzpVoGiH-53HZxVx-Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kerne.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Victor Kaplansky <VICTORK@il.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Michael Ellerman <michael@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Russell King <linux@arm.linux.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Luck <tony.luck@intel.com>

On Fri, Dec 13, 2013 at 08:16:28PM +0100, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Fri, Dec 13, 2013 at 3:57 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > There are a few architectures (m32r, m68k) that could probably
> > do away with their barrier.h file entirely but are kept for now due to
> > their unconventional nop() implementation.
> 
> m32r uses `__asm__ __volatile__ ("nop" : : )' instead of
> `asm volatile ("nop")'. Isn't the latter just a shorthand of the former?

Yes.. however it might be there's a gcc bug on that platform or whatnot
that they care about.

> m68k has an additional `barrier()', which I think is unneeded.

Strictly speaking yes, but I didn't want to grep through the m68k arch
code to figure out if someone somehow started to rely on that.

In both cases, I was too lazy to really figure it out and hoped the
relevant maintainers would see and clean it up for me ;-)

> I looked at the asm output for drivers/block/ataflop.c and
> drivers/video/macfb.c, with and without the barrier.
> For ataflop, there were no differences.
> For macfb, removing the barrier allowed the compiler to keep the base
> addresses of the MMIO registers in registers, but there were no changes
> to the register accesses themselves.
> 
> So IMHO both m32r and m68k can switch to the asm-generic version.

I'm all for it.

> I'm wondering whether we can just drop nop() from the in-kernel API?
> There are few users outside arch/:
> 
> drivers/block/ataflop.c
> drivers/net/ethernet/amd/am79c961a.c
> drivers/tty/serial/crisv10.c
> drivers/video/macfb.c
> 
> From a quick glance, all of them (ab)use nop() instead of one of the other
> primitives. For the macfb case, it seems to be due to missing ordering
> inside the nubus_*() I/O accessors.

Yeah, its not something that really makes sense outside of arch/; in a
previous thread someone also asked why that thing is in barrier.h to
begin with.

That said, even if you remove the generic nop() usage, arch/ is likely
to still need it so we couldn't just remove it, we'd have to stuff it
someplace else -- which might be a good idea anyhow.
