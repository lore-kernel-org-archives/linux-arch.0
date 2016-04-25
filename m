From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][PATCH 03/31] locking,arc: Implement
 atomic_fetch_{add,sub,and,andnot,or,xor}()
Date: Mon, 25 Apr 2016 04:26:54 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E9F138@us01wembx1.internal.synopsys.com>
References: <20160422090413.393652501@infradead.org>
 <20160422093923.218866387@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075F4E9EF11@us01wembx1.internal.synopsys.com>
 <20160422141614.GP3430@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39830 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbcDYE1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Apr 2016 00:27:05 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "mingo@kernel.org" <mingo@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "will.deacon@arm.com" <will.deacon@arm.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "waiman.long@hpe.com" <waiman.long@hpe.com>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "egtvedt@samfundet.no" <egtvedt@samfundet.no>, "realmz6@gmail.com" <realmz6@gmail.com>, "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>

On Friday 22 April 2016 07:46 PM, Peter Zijlstra wrote:
> On Fri, Apr 22, 2016 at 10:50:41AM +0000, Vineet Gupta wrote:
>
>>> > > +#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
>>> > > +static inline int atomic_fetch_##op(int i, atomic_t *v)			\
>>> > > +{									\
>>> > > +	unsigned int val, result;			                \
>>> > > +	SCOND_FAIL_RETRY_VAR_DEF                                        \
>>> > > +									\
>>> > > +	/*								\
>>> > > +	 * Explicit full memory barrier needed before/after as		\
>>> > > +	 * LLOCK/SCOND thmeselves don't provide any such semantics	\
>>> > > +	 */								\
>>> > > +	smp_mb();							\
>>> > > +									\
>>> > > +	__asm__ __volatile__(						\
>>> > > +	"1:	llock   %[val], [%[ctr]]		\n"		\
>>> > > +	"	mov %[result], %[val]			\n"		\
>> > 
>> > Calling it result could be a bit confusing, this is meant to be the "orig" value.
>> > So it indeed "result" of the API, but for atomic operation it is pristine value.
>> > 
>> > Also we can optimize away that MOV - given there are plenty of regs, so
>> > 
>>> > > +	"	" #asm_op " %[val], %[val], %[i]	\n"		\
>>> > > +	"	scond   %[val], [%[ctr]]		\n"		\
>> > 
>> > Instead have
>> > 
>> > +	"	" #asm_op " %[result], %[val], %[i]	\n"		\
>> > +	"	scond   %[result], [%[ctr]]		\n"		\
>> > 
>> > 
> Indeed, how about something like so?
>
> ---
> Subject: locking,arc: Implement atomic_fetch_{add,sub,and,andnot,or,xor}()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Apr 18 01:16:09 CEST 2016
>
> Implement FETCH-OP atomic primitives, these are very similar to the
> existing OP-RETURN primitives we already have, except they return the
> value of the atomic variable _before_ modification.
>
> This is especially useful for irreversible operations -- such as
> bitops (because it becomes impossible to reconstruct the state prior
> to modification).
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: Vineet Gupta <vgupta@synopsys.com>
