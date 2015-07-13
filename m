From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC][PATCH 02/24] arc: Provide atomic_{or,xor,and}
Date: Mon, 13 Jul 2015 12:43:45 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665ADA81@IN01WEMBXB.internal.synopsys.com>
References: <20150709172855.564686637@infradead.org>
 <20150709175308.217482496@infradead.org>
 <C2D7FE5348E1B147BCA15975FBA23075665AD246@IN01WEMBXB.internal.synopsys.com>
 <20150710070511.GE19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:50235 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbbGMMn6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 08:43:58 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "rth@twiddle.net" <rth@twiddle.net>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "will.deacon@arm.com" <will.deacon@arm.com>, "hskinnemoen@gmail.com" <hskinnemoen@gmail.com>, "realmz6@gmail.com" <realmz6@gmail.com>, "dhowells@redhat.com" <dhowells@redhat.com>, "rkuo@codeaurora.org" <rkuo@codeaurora.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "james.hogan@imgtec.com" <james.hogan@imgtec.com>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "jejb@parisc-linux.org" <jejb@parisc-linux.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "davem@davemloft.net" <davem@davemloft.net>, "cmetcalf@ezchip.com" <cmetcalf@ezchip.com>

On Friday 10 July 2015 12:35 PM, Peter Zijlstra wrote:
> On Fri, Jul 10, 2015 at 04:30:46AM +0000, Vineet Gupta wrote:
>> > 
>> > Since we are on the topic, the cmpxchg() loop in arch/arc/kernel/smp.c still
>> > irritates me.
>> > Do we need a new set of primitives to operate atomically on non atomic_t data or
>> > does that mean that the data *not* being atomic_t but requiring such semantics is
>> > the fundamental problem and thus needs to be converted first.
> So if you look at the last patch, there's already a few sites that do
> things like:
>
> +       atomic_or(*mask, (atomic_t *)&flushcache_cpumask);
>
> Which is of course ugly as hell, but does work.
>
> Esp. inside arch code.

Right - I don't have issues with using this API - but this requires atomic_t data
type.  The specific cmpxchg() loop that I'm referring to is not for atomic_t - so
that needs to be converted to atomic_t first ?

>
> Now the 'problem' with cmpxchg/xchg, the instructions working on !atomic
> data is:
>
>   http://lkml.kernel.org/r/alpine.LRH.2.02.1406011342470.20831@file01.intranet.prod.int.rdu2.redhat.com
>   http://lkml.kernel.org/r/20140606175316.GV13930@laptop.programming.kicks-ass.net
>
> And note that includes some arc.

Correct so we don't mix cmpxchg() with normal load/store.

>
> Adding more such primitives will only make it harder on those already
> 'broken' archs.

Not sure if I follow here - my point was not so much about expanding the
atomic_*() API but whether it makes sense to have "some" API for non atomic_t vs.
converting the non atomic_t to atomic_t and then use the API as that is the
fundamental problem for such cases.

-Vineet
