From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 10/31] locking,hexagon: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Sat, 23 Apr 2016 04:16:58 +0200
Message-ID: <20160423021658.GX3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.685243711@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:46698 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbcDWCRb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Apr 2016 22:17:31 -0400
Content-Disposition: inline
In-Reply-To: <20160422093923.685243711@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Fri, Apr 22, 2016 at 11:04:23AM +0200, Peter Zijlstra wrote:
> +#define ATOMIC_FETCH_OP(op)						\
> +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
> +{									\
> +	int output, val;						\
> +									\
> +	__asm__ __volatile__ (						\
> +		"1:	%0 = memw_locked(%2);\n"			\
> +		"	%1 = "#op "(%0,%3);\n"				\
> +		"	memw_locked(%2,P3)=%0;\n"			\

I'm thinking that wants to be:

			memw_locked(%2,P3)=%1;

> +		"	if !P3 jump 1b;\n"				\
> +		: "=&r" (output), "=&r" (val)				\
> +		: "r" (&v->counter), "r" (i)				\
> +		: "memory", "p3"					\
> +	);								\
> +	return output;							\
> +}
