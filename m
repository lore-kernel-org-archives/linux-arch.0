From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 20/28] ARCv2: barriers
Date: Wed, 10 Jun 2015 09:34:18 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A4FFE@IN01WEMBXB.internal.synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-21-git-send-email-vgupta@synopsys.com>
 <20150609124008.GA3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:48144 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S933532AbbFJJef convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Jun 2015 05:34:35 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

On Tuesday 09 June 2015 06:10 PM, Peter Zijlstra wrote:
> On Tue, Jun 09, 2015 at 05:18:20PM +0530, Vineet Gupta wrote:
>
> A description of how your hardware works; or a reference to the platform
> documentation would not go amiss.

Honestly the docs group is working on a publicly sharable version of PRM
(Programmer's Reference Manual) but it might take some more time. I'm sure kernel
developers including you don't like to sign an NDA.... The information I have in
comments is pretty much what we have in there w.r.t. the barrier instructions. But
I will capture the the weak memory ordering and other details as part of changelog
here too.

>> [snip ....]
>> +/*
>> + * DMB:
>> + *   - Ensures that selected memory operation issued before it will complete
>> + *     before any subsequent memory operation of same type
>> + */
>> +#define smp_mb()	asm volatile("dmb 3\n" : : : "memory")
>> +#define smp_rmb()	asm volatile("dmb 1\n" : : : "memory")
>> +#define smp_wmb()	asm volatile("dmb 2\n" : : : "memory")
>> +
>> +/*
>> + * DSYNC:
>> + *   - Waits for completion of all outstanding memory operations before any new
>> + *     operations can begin
>> + *   - Includes implicit memory operations such as cache/TLB/BPU maintenance ops
>> + *   - Lighter version of SYNC as it doesn't wait for non-memory operations
>> + */
>> +#define mb()		asm volatile("dsync\n" : : : "memory")
> So mb() is supposed to order against things like DMA memory ops, is DMA
> part of point 1 or 3, if 3, this is not a suitable instruction.

Can u please explain the DMA case a bit more ? From what I understood and used in
say ethernet driver, it is more of a line drawn between say cpu updating a shared
buffer descriptor and kicking a MMIO register (which in turn could initiate a DMA)
but I'm not sure how mb() can possibly order with DMA per se (unless there's some
advanced form of IO-coherency)

-Vineet

>
>> +#else	/* CONFIG_ISA_ARCOMPACT */
>> +
>> +/* SYNC:
>> + *   - Waits for completion of all outstanding memory transactions AND all
>> + *     previous instructions to reture
>> + */
>> +#define mb()		asm volatile("sync\n" : : : "memory")
>> +
>> +#endif	/* CONFIG_ISA_ARCV2 */
>
>
