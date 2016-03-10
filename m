From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] mm: slub: Ensure that slab_unlock() is atomic
Date: Thu, 10 Mar 2016 11:21:21 +0530
Message-ID: <56E10B59.1060700@synopsys.com>
References: <1457447457-25878-1-git-send-email-vgupta@synopsys.com>
 <alpine.DEB.2.20.1603080857360.4047@east.gentwo.org>
 <56DEF3D3.6080008@synopsys.com>
 <alpine.DEB.2.20.1603081438020.4268@east.gentwo.org>
 <56DFC604.6070407@synopsys.com>
 <20160309101349.GJ6344@twins.programming.kicks-ass.net>
 <56E023A5.2000105@synopsys.com>
 <20160309145119.GN6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35939 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbcCJFvr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Mar 2016 00:51:47 -0500
In-Reply-To: <20160309145119.GN6356@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-parisc@vger.kernel, Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org, Noam Camus <noamc@ezchip.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, linux-snps-arc@lists.infradead.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>

On Wednesday 09 March 2016 08:21 PM, Peter Zijlstra wrote:
>> But in SLUB: bit_spin_lock() + __bit_spin_unlock() is acceptable ? How so
>> (ignoring the performance thing for discussion sake, which is a side effect of
>> this implementation).
> 
> The sort answer is: Per definition. They are defined to work together,
> which is what makes __clear_bit_unlock() such a special function.
> 
>> So despite the comment below in bit_spinlock.h I don't quite comprehend how this
>> is allowable. And if say, by deduction, this is fine for LLSC or lock prefixed
>> cases, then isn't this true in general for lot more cases in kernel, i.e. pairing
>> atomic lock with non-atomic unlock ? I'm missing something !
> 
> x86 (and others) do in fact use non-atomic instructions for
> spin_unlock(). But as this is all arch specific, we can make these
> assumptions. Its just that generic code cannot rely on it.

OK despite being obvious now, I was not seeing the similarity between spin_*lock()
and bit_spin*lock() :-(

ARC also uses standard ST for spin_unlock() so by analogy __bit_spin_unlock() (for
LLSC case) would be correctly paired with bit_spin_lock().

But then why would anyone need bit_spin_unlock() at all. Specially after this
patch from you which tightens __bit_spin_lock() even more for the general case.

Thing is if the API exists majority of people would would use the more
conservative version w/o understand all these nuances. Can we pursue the path of
moving bit_spin_unlock() over to __bit_spin_lock(): first changing the backend
only and if proven stable replacing the call-sites themselves.

> 
> So let me try and explain.
> 
> 
> The problem as identified is:
> 
> CPU0						CPU1
> 
> bit_spin_lock()					__bit_spin_unlock()
> 1:
> 	/* fetch_or, r1 holds the old value */
> 	spin_lock
> 	load	r1, addr
> 						load	r1, addr
> 						bclr	r2, r1, 1
> 						store	r2, addr
> 	or	r2, r1, 1
> 	store	r2, addr	/* lost the store from CPU1 */
> 	spin_unlock
> 
> 	and	r1, 1
> 	bnz	2	/* it was set, go wait */
> 	ret
> 
> 2:
> 	load	r1, addr
> 	and	r1, 1
> 	bnz	2	/* wait until its not set */
> 
> 	b	1	/* try again */
> 
> 
> 
> For LL/SC we replace:
> 
> 	spin_lock
> 	load	r1, addr
> 
> 	...
> 
> 	store	r2, addr
> 	spin_unlock
> 
> With the (obvious):
> 
> 1:
> 	load-locked	r1, addr
> 
> 	...
> 
> 	store-cond	r2, addr
> 	bnz		1 /* or whatever branch instruction is required to retry */
> 
> 
> In this case the failure cannot happen, because the store from CPU1
> would have invalidated the lock from CPU0 and caused the
> store-cond to fail and retry the loop, observing the new value. 

You did it again, A picture is worth thousand words !

Thx,
-Vineet
