From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 18/31] locking,powerpc: Implement
 atomic{,64}_fetch_{add,sub,and,or,xor}{,_relaxed,_acquire,_release}()
Date: Sat, 23 Apr 2016 04:31:13 +0200
Message-ID: <20160423023113.GY3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093924.212277819@infradead.org>
 <20160422164157.GB3369@insomnia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41987 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbcDWCcv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 22:32:51 -0400
Content-Disposition: inline
In-Reply-To: <20160422164157.GB3369@insomnia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Sat, Apr 23, 2016 at 12:41:57AM +0800, Boqun Feng wrote:
> > +#define ATOMIC_FETCH_OP_RELAXED(op, asm_op)				\
> > +static inline int atomic_fetch_##op##_relaxed(int a, atomic_t *v)	\
> > +{									\
> > +	int res, t;							\
> > +									\
> > +	__asm__ __volatile__(						\
> > +"1:	lwarx	%0,0,%4		# atomic_fetch_" #op "_relaxed\n"	\
> > +	#asm_op " %1,%2,%0\n"						\
> 
> Should be
> 
> 	#asm_op " %1,%3,%0\n"
> 
> right? Because %2 is v->counter and %3 is @a.

Indeed, thanks!
