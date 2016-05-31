Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:48563 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbcEaK3w (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 06:29:52 -0400
Message-ID: <20160531101925.702692792@infradead.org>
Date: Tue, 31 May 2016 12:19:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH -v2 00/33] implement atomic_fetch_$op
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, peterz@infradead.org, dbueso@suse.de, fengguang.wu@intel.com
Message-ID: <20160531101925.r3vXzenC9bMDwK383_kt1JeSEEVrWmVJuc5H5xWOrQ4@z>

As there have been a few requests for atomic_fetch_$op primitives and recently
by Linus, I figured I'd go and implement the lot.

The atomic_fetch_$op differs from the existing atomic_$op_return we already
have by returning the old value instead of the new value. This is especially
useful when the operation is irreversible (like bitops), and allows for things
like test-and-set.

This version incorporates all feedback from last time and is now complete thanks
to Will implementing ARMv8.1-LSE versions.

No known build breakage from the build-bot.

Notes:
 - arc asm/atomic.h is a bit of a mess after the eznps merge, I would
   recommend a restructure or split of that file, but could not find
   the will to do it.
 - arc, metag and tile could convert to _relaxed.

I'm aiming to merge this for v4.8 which should get this a fair few weeks in -next.

