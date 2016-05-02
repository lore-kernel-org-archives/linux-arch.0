From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH 14/31] locking,metag: Implement
 atomic_fetch_{add,sub,and,or,xor}()
Date: Mon, 2 May 2016 10:15:15 +0200
Message-ID: <20160502081515.GA3430@twins.programming.kicks-ass.net>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.941873289@infradead.org>
 <20160430002031.GB15188@jhogan-linux.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:50938 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcEBIQh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2016 04:16:37 -0400
Content-Disposition: inline
In-Reply-To: <20160430002031.GB15188@jhogan-linux.le.imgtec.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de, will.deacon@arm.com, paulmck@linux.vnet.ibm.com, boqun.feng@gmail.com, waiman.long@hpe.com, fweisbec@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rth@twiddle.net, vgupta@synopsys.com, linux@arm.linux.org.uk, egtvedt@samfundet.no, realmz6@gmail.com, ysato@users.sourceforge.jp, rkuo@codeaurora.org, tony.luck@intel.com, geert@linux-m68k.org, ralf@linux-mips.org, dhowells@redhat.com, jejb@parisc-linux.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, dalias@libc.org, davem@davemloft.net, cmetcalf@mellanox.com, jcmvbkbc@gmail.com, arnd@arndb.de, dbueso@suse.de, fengguang.wu@intel.com

On Sat, Apr 30, 2016 at 01:20:31AM +0100, James Hogan wrote:
> > +	asm volatile (							\
> > +		"1:	LNKGETD %1, [%2]\n"				\
> > +		"	" #op "	%0, %1, %3\n"				\
> 
> i was hoping never to have to think about meta asm constraints again :-P

There is a solution for that: rm -rf arch/metag :-)

> and/or/xor are only available in the data units, as determined by %1 in
> this case, so the constraint for result shouldn't have "a" in it.
> 
> diff --git a/arch/metag/include/asm/atomic_lnkget.h b/arch/metag/include/asm/atomic_lnkget.h
> index 50ad05050947..def2c642f053 100644
> --- a/arch/metag/include/asm/atomic_lnkget.h
> +++ b/arch/metag/include/asm/atomic_lnkget.h
> @@ -84,7 +84,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
>  		"	ANDT	%0, %0, #HI(0x3f000000)\n"		\
>  		"	CMPT	%0, #HI(0x02000000)\n"			\
>  		"	BNZ 1b\n"					\
> -		: "=&d" (temp), "=&da" (result)				\
> +		: "=&d" (temp), "=&d" (result)				\
>  		: "da" (&v->counter), "bd" (i)				\
>  		: "cc");						\
> 
> That also ensures the "bd" constraint for %3 (meaning "an op2 register
> where op1 [%1 in this case] is a data unit register and the instruction
> supports O2R") is consistent.
> 
> So with that change this patch looks good to me:

Right, so I'd _never_ have thought to look at that,

> Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks!

> Note that for the ATOMIC_OP_RETURN() case (add/sub only) either address
> or data units can be used (hence the "da" for %1), but then the "bd"
> constraint on %3 is wrong as op1 [%1] may not be in data unit (sorry I
> didn't spot that at the time). I'll queue a fix, something like below
> probably ("br" means "An Op2 register and the instruction supports O2R",
> i.e. op1/%1 doesn't have to be a data unit register):
> 
> diff --git a/arch/metag/include/asm/atomic_lnkget.h b/arch/metag/include/asm/atomic_lnkget.h
> index 50ad05050947..def2c642f053 100644
> --- a/arch/metag/include/asm/atomic_lnkget.h
> +++ b/arch/metag/include/asm/atomic_lnkget.h
> @@ -61,7 +61,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
>  		"	CMPT	%0, #HI(0x02000000)\n"			\
>  		"	BNZ 1b\n"					\
>  		: "=&d" (temp), "=&da" (result)				\
> -		: "da" (&v->counter), "bd" (i)				\
> +		: "da" (&v->counter), "br" (i)				\
>  		: "cc");						\
>  									\
>  	smp_mb();							\
>  									\							\

Thanks, again :-)
