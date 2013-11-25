From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: Preventing IPI sending races in arch code
Date: Mon, 25 Nov 2013 13:35:38 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307515715C@IN01WEMBXA.internal.synopsys.com>
References: <52932BE2.5010201@synopsys.com>
 <20131125110006.GU3866@twins.programming.kicks-ass.net>
 <529334CA.1000401@synopsys.com>
 <20131125122726.GZ10022@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:45304 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693Ab3KYNfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 08:35:45 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Gilad Ben-Yossef <gilad@benyossef.com>, Noam Camus <noamc@ezchip.com>, David Daney <david.daney@cavium.com>, James Hogan <james.hogan@imgtec.com>, thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>

On 11/25/2013 05:57 PM, Peter Zijlstra wrote:
> On Mon, Nov 25, 2013 at 05:00:18PM +0530, Vineet Gupta wrote:
>> While we are at it, I wanted to confirm another potential race (ARC/blackfin..)
>> The IPI handler clears the interrupt before atomically-read-n-clear the msg word.
>>
>> do_IPI
>>    plat_smp_ops.ipi_clear(irq);
>>    while ((pending = xchg(&ipi_data->bits, 0) != 0)
>>       find_next_bit(....)
>>       switch(next-msg)
>>
>> Depending on arch this could lead to an immediate IPI interrupt, and again
>> ipi_data->bits could get out of syn with IPI senders. 
> I'm obviously lacking in platform knowledge here, what does that
> ipi_clear() actually do? Tell the platform the interrupt has arrived and
> it can stop asserting the line?

Correct.

> So sure, then someone can again assert the interrupt, but given we just
> established a protocol for raising the thing; namely something like
> this:
>
> void arch_send_ipi(int cpu, int type)
> {
>   u32 *pending_ptr = per_cpu_ptr(ipi_bits, cpu);
>   u32 new, old;
>
>   do {
>   	new = old = *pending_ptr;
> 	new |= 1U << type;
>   } while (cmpxchg(pending_ptr, old, new) != old)
>
>   if (!old) /* only raise the actual IPI if we set the first bit */
>   	raise_ipi(cpu);
> }
>
> Who would re-assert it if we have !0 pending?

I see your point. So in receiver, it is OK to de-assert the IPI before processing
the msg itself.

Actually your code seems to be optimizing away asserting an IPI, if sender already
had a pending msg (assuming we retain the xchg loop in receiver). Was that an
intended optimization - or just a side effect of your code ;-)

Before reading ur email I was coding something like below:

void arch_send_ipi(int cpu, int type)
{
  u32 *pending_ptr = per_cpu_ptr(ipi_bits, cpu);

  while (cmpxchg(pending_ptr, 0, 1 << type) != 0)
	cpu_relax();

  raise_ipi(cpu);
}

But obviously your version is nicer due to optimization, unless I'm over-analyzing it.


> Also, the above can be thought of as a memory ordering issue:
>
>   STORE pending
>   MB /* implied by cmpxchg */
>   STORE ipi /* raise the actual thing */
>
> In that case the other end must be:
>
>   LOAD ipi
>   MB /* implied by xchg */
>   LOAD pending
>
> Which is what your code seems to do.

...

>
>> IMO the while loop is
>> completely useless specially if IPIs are not coalesced in h/w. 
> Agreed, the while loops seems superfluous.

Not with your version of sender, since we need it as described above.

>> And we need to move
>> the xchg ahead of ACK'ing the IPI
>>
>> do_IPI
>>    pending = xchg(&ipi_data->bits, 0);
>>    plat_smp_ops.ipi_clear(irq);
>>    while (ffs....)
>>       switch(next-msg)
>>       ...
>>
>> Does that look sane to you.
> This I'm not at all certain of; continuing with the memory order analogy
> this would allow for the case where we see 0 pending, set a bit, try and
> raise the interrupt but then do not because its already assert.
>
> And since you just removed the while() loop, we'll be left with a !0
> pending vector and nobody processing it.

Right we need it with ur version of sender. Bit don't with my simplistic one.

-Vineet
