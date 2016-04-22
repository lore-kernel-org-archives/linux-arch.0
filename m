From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 01/31] locking: Flip arguments to atomic_fetch_or
Date: Fri, 22 Apr 2016 16:18:21 +0200
Message-ID: <20160422141821.GQ3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.095484070@infradead.org>
 <CAMuHMdV79ShATdNZZDWSREpeHEEbSa+UFDynzQRHo63E4L8atw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41153 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbcDVOUj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 10:20:39 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdV79ShATdNZZDWSREpeHEEbSa+UFDynzQRHo63E4L8atw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, boqun.feng@gmail.com, waiman.long@hpe.com, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Miao Steven <realmz6@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, "James E.J. Bottomley" <jejb@parisc-linux.org>

On Fri, Apr 22, 2016 at 01:09:38PM +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 22, 2016 at 11:04 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > All the atomic operations have their arguments the wrong way around;
> 
> s/wrong/other/?

Nah, I find they really are the wrong way around. I forever write:
atomic_add(&v, val); and then have the compiler yell at me.

> > make atomic_fetch_or() consistent and flip them.
> 
> BTW, there are a few other inconsistencies:
> 
> atomic_add_unless()
> atomic_cmpxchg()
> atomic_inc_not_zero_hint()
> atomic_set()
> atomic_xchg
> 
> git grep "\<atomic_.*atomic_t\>.*\<int\>"

Yes, but fixing those will be much more pain :/ atomic_fetch_or() was
freshly introduced and only has a few callers, furthermore, the
following patches would require it to be in line with the other
atomic_$op() due to them all being generated from the same 'template'.
