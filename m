From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/4] arch: Clean up asm/barrier.h implementations using asm-generic/barrier.h
Date: Fri, 13 Dec 2013 20:16:28 +0100
Message-ID: <CAMuHMdXs16E1WZ4FL=r9BkLBF-q7B432pzpVoGiH-53HZxVx-Q@mail.gmail.com>
References: <20131213145657.265414969@infradead.org>
	<20131213150640.846368594@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34153 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab3LMTQ3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2013 14:16:29 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so411529pab.21
        for <linux-arch@vger.kernel.org>; Fri, 13 Dec 2013 11:16:28 -0800 (PST)
In-Reply-To: <20131213150640.846368594@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kerne.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Victor Kaplansky <VICTORK@il.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Michael Ellerman <michael@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Russell King <linux@arm.linux.org.uk>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tony Luck <tony.luck@intel.com>

Hi Peter,

On Fri, Dec 13, 2013 at 3:57 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> There are a few architectures (m32r, m68k) that could probably
> do away with their barrier.h file entirely but are kept for now due to
> their unconventional nop() implementation.

m32r uses `__asm__ __volatile__ ("nop" : : )' instead of
`asm volatile ("nop")'. Isn't the latter just a shorthand of the former?

m68k has an additional `barrier()', which I think is unneeded.
I looked at the asm output for drivers/block/ataflop.c and
drivers/video/macfb.c, with and without the barrier.
For ataflop, there were no differences.
For macfb, removing the barrier allowed the compiler to keep the base
addresses of the MMIO registers in registers, but there were no changes
to the register accesses themselves.

So IMHO both m32r and m68k can switch to the asm-generic version.

I'm wondering whether we can just drop nop() from the in-kernel API?
There are few users outside arch/:

drivers/block/ataflop.c
drivers/net/ethernet/amd/am79c961a.c
drivers/tty/serial/crisv10.c
drivers/video/macfb.c

From a quick glance, all of them (ab)use nop() instead of one of the other
primitives. For the macfb case, it seems to be due to missing ordering
inside the nubus_*() I/O accessors.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
