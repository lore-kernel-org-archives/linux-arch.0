Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:49780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfBZSd6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 13:33:58 -0500
Date: Tue, 26 Feb 2019 19:33:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/20] asm-generic/mmiowb: Add generic implementation
 of mmiowb() tracking
Message-ID: <20190226183335.GN2861@worktop.programming.kicks-ass.net>
References: <20190222185026.10973-1-will.deacon@arm.com>
 <20190222185026.10973-2-will.deacon@arm.com>
 <CAHk-=wgamK0=rNsCfDfDzmNXUF_MqUHb0okzqN1Tir9vm65pNg@mail.gmail.com>
 <20190226182624.GC28709@fuggles.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226182624.GC28709@fuggles.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190226183335.MWJt87Ltj9yedG4pl6TfFmtV6rLEusOzBSI6Y_mOcbA@z>

On Tue, Feb 26, 2019 at 06:26:24PM +0000, Will Deacon wrote:
> On Fri, Feb 22, 2019 at 01:49:32PM -0800, Linus Torvalds wrote:
> So I *am* using __this_cpu_xchg() here, which means the architecture can
> get away with plain old loads and stores (which is what RISC-V does, for
> example), but I see that's not the case on e.g. x86 so I'll rework using
> read() and write() because it doesn't hurt.

Right, so the problem on x86 is that XCHG has an implicit LOCK prefix,
so there no !atomic variant. So even the cpu-local xchg gets the LOCK
prefix penalty, even though all we really wanted is a single
instruction.

Arguably we could fix that for __this_cpu_xchg(), which isn't IRQ-safe.
