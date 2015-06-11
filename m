From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 18/28] ARC: add smp barriers around atomics per
 memory-barrriers.txt
Date: Thu, 11 Jun 2015 13:03:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665A529E@IN01WEMBXB.internal.synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
 <1433850508-26317-19-git-send-email-vgupta@synopsys.com>
 <20150609123024.GX3644@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075665A4FEA@IN01WEMBXB.internal.synopsys.com>
 <20150610105323.GF3644@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:50874 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753610AbbFKND5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Jun 2015 09:03:57 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

On Wednesday 10 June 2015 04:23 PM, Peter Zijlstra wrote:
> On Wed, Jun 10, 2015 at 09:17:16AM +0000, Vineet Gupta wrote:
>> I wanted to clarify a couple of things
>> (1) ACQUIRE barrier implies store/{store,load} while RELEASE implies
>> {load,store}/store and given what DMB provides for ARCv2, smp_mb() is the only fit ?
> Please see Documentation/memory-barriers.txt, but a quick recap:
>
>  - ACQUIRE: both loads and stores before to the barrier are allowed to
>    be observed after it.  Neither loads nor stores after the barrier are
>    allowed to be observed before it.
>
>  - RELEASE: both loads and stores before it must be observed before the
>    barrier. However, any load or store after it may be observed before
>    it.
>
> Therefore:
>
>  X = Y = 0;
>
> 	[S] X = 1
> 	    ACQUIRE
>
> 	    RELEASE
> 	[S] Y = 1
>
> is in fact fully unordered, because both stores are allowed to cross in,
> and could cross one another on the inside, like:
>
> 	    ACQUIRE
> 	[S] Y = 1
> 	[S] X = 1
> 	    RELEASE

Thx for that.  I think I was mixing smp_load_acquire() / store_release() with the
spin lock ACQUIRE/RELEASE. As Paul put it on a lwn article, after re-reading
memory-barrier.txt I've indeed felt a hit on my already meager brain power :-)

>> (2) Do we need smp_mb() on both sides of spin lock/unlock - doesn't ACQUIRE imply
>> we have a smp_mb() after lock but before any subsequent critical section - so the
>> top hunk is not necessarily needed. Similarly RELEASE requires a smp_mb() before
>> the memory operation for lock, but not after.
> You do not need an smp_mb() on both sides, as you say, after lock and
> before unlock is sufficient. The main point being that things can not
> escape out of the critical section. Its fine for them to leak in.

Ok - neverthless I will probably keep the extraneous barriers around for now since
I see some weird hackbench regression on a dual core SMP build by removing the
those 3 barriers (and/or replacing them with a nop so as to keep the icache / bpu
micro-arch profile exactly same as before).

-Vineet
