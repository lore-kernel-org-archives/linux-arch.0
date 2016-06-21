Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:53724 "EHLO
	kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbcFUEpX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 00:45:23 -0400
Date: Tue, 21 Jun 2016 14:27:22 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
Subject: Re: [PATCH -v2 14/33] locking,m68k: Implement
 atomic_fetch_{add,sub,and,or,xor}()
In-Reply-To: <87twgniwh7.fsf@linux-m68k.org>
Message-ID: <alpine.LNX.2.00.1606211350360.26385@nippy.intranet>
References: <20160531101925.702692792@infradead.org> <20160531102642.333689893@infradead.org> <CAMuHMdXG4veEOqr5vcZQEQH55=CT6CPXOfqrc_m=fpXEseAdLA@mail.gmail.com> <20160616101309.GD30921@twins.programming.kicks-ass.net> <mvmk2hpxq1a.fsf@hawking.suse.de>
 <20160617154024.GY30154@twins.programming.kicks-ass.net> <87twgniwh7.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?ISO-8859-15?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, cmetcalf@mellanox.com, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, dbueso@suse.de, Wu Fengguang <fengguang.wu@intel.com>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Message-ID: <20160621042722.juhB4Z4xkMGmWPTnnSTFa4OPioEOl7E3T74Clys936Y@z>


On Mon, 20 Jun 2016, Andreas Schwab wrote:

> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > Could either of you comment on the below patch?
> >
> > All atomic functions that return a value should imply full memory 
> > barrier semantics -- this very much includes a compiler barrier / 
> > memory clobber.
> 
> I wonder if it is possible to find a case where this makes a real 
> difference, ie. where the compiler erroneously reused a value due to the 
> missing barrier.

What the compiler does erroneously is a compiler bug by definition. But I 
think that was not what you meant.

Perhaps you're asking whether gcc in particular does what you expect, 
despite ambiguous source code. But what about other tools like static 
analyzers?

Ambiguous code is likely to attract patches like this for as long as it 
remains ambiguous. That's a waste of everyone's time, if patches like this 
could be written and reviewed just once.

-- 

> 
> Andreas.
> 
> 
