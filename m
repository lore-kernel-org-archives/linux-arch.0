From: Richard Kuo <rkuo@codeaurora.org>
Subject: Re: [RFC][PATCH 10/31] locking,hexagon: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Mon, 25 Apr 2016 19:39:12 -0500
Message-ID: <20160426003912.GA26991@codeaurora.org>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.685243711@infradead.org>
 <20160423021658.GX3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45507 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcDZAjX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2016 20:39:23 -0400
Content-Disposition: inline
In-Reply-To: <20160423021658.GX3430@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Sat, Apr 23, 2016 at 04:16:58AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 22, 2016 at 11:04:23AM +0200, Peter Zijlstra wrote:
> > +#define ATOMIC_FETCH_OP(op)						\
> > +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> > +{									\
> > +	int output, val;						\
> > +									\
> > +	__asm__ __volatile__ (						\
> > +		"1:	%0 = memw_locked(%2);\n"			\
> > +		"	%1 = "#op "(%0,%3);\n"				\
> > +		"	memw_locked(%2,P3)=%0;\n"			\
> 
> I'm thinking that wants to be:
> 
> 			memw_locked(%2,P3)=%1;
> 
> > +		"	if !P3 jump 1b;\n"				\
> > +		: "=&r" (output), "=&r" (val)				\
> > +		: "r" (&v->counter), "r" (i)				\
> > +		: "memory", "p3"					\
> > +	);								\
> > +	return output;							\
> > +}

I think you are right.  With the above fix,

Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
