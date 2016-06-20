Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36275 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbcFTRrM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2016 13:47:12 -0400
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement atomic_fetch_{add,sub,and,or,xor}()
References: <20160531101925.702692792@infradead.org>
	<20160531102642.333689893@infradead.org>
	<CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com>
	<20160616101309.GD30921@twins.programming.kicks-ass.net>
	<mvmk2hpxq1a.fsf@hawking.suse.de>
	<20160617154024.GY30154@twins.programming.kicks-ass.net>
Date: Mon, 20 Jun 2016 19:47:00 +0200
In-Reply-To: <20160617154024.GY30154@twins.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Fri, 17 Jun 2016 17:40:24 +0200")
Message-ID: <87twgniwh7.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?utf-8?B?RnLDqWTDqXJpYw==?= Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, cmetcalf@mellanox.com, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, dbueso@suse.de, Wu Fengguang <fengguang.wu@intel.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Message-ID: <20160620174700.dJQN5RLe-M2y5r2OJQlh71LGHPztvAKmdqFyyLVvEHA@z>

Peter Zijlstra <peterz@infradead.org> writes:

> Could either of you comment on the below patch?
>
> All atomic functions that return a value should imply full memory
> barrier semantics -- this very much includes a compiler barrier / memory
> clobber.

I wonder if it is possible to find a case where this makes a real
difference, ie. where the compiler erroneously reused a value due to
the missing barrier.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
