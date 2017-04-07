From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Fri, 7 Apr 2017 17:13:59 +0100
Message-ID: <20170407161359.GV19342@arm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
 <20170406141352.GF18204@arm.com>
 <20170407013011.7df92f04@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:57996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933632AbdDGQNm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Apr 2017 12:13:42 -0400
Content-Disposition: inline
In-Reply-To: <20170407013011.7df92f04@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: David Miller <davem@davemloft.net>, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, anton@samba.org, linuxppc-dev@ozlabs.org, peterz@infradead.org

On Fri, Apr 07, 2017 at 01:30:11AM +1000, Nicholas Piggin wrote:
> On Thu, 6 Apr 2017 15:13:53 +0100
> Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Apr 06, 2017 at 10:59:58AM +1000, Nicholas Piggin wrote:
> > > Thanks for taking a look. The default spin primitives should just
> > > continue to do the right thing for you in that case.
> > > 
> > > Arm has a yield instruction, ia64 has a pause... No unusual
> > > requirements that I can see.  
> > 
> > Yield tends to be implemented as a NOP in practice, since it's in the
> > architecture for SMT CPUs and most ARM CPUs are single-threaded. We do have
> > the WFE instruction (wait for event) which is used in our implementation of
> > smp_cond_load_acquire, but I don't think we'd be able to use it with the
> > proposals here.
> > 
> > WFE can stop the clock for the CPU until an "event" is signalled by
> > another CPU. This could be done by an explicit SEV (send event) instruction,
> > but that tends to require heavy barriers on the signalling side. Instead,
> > the preferred way to generate an event is to clear the exclusive monitor
> > reservation for the CPU executing the WFE. That means that the waiter
> > does something like:
> > 
> > 	LDXR x0, [some_address]	// Load exclusive from some_address
> > 	CMP  x0, some value	// If the value matches what I want
> > 	B.EQ out		// then we're done
> > 	WFE			// otherwise, wait
> > 
> > at this point, the waiter will stop on the WFE until its monitor is cleared,
> > which happens if another CPU writes to some_address.
> > 
> > We've wrapped this up in the arm64 code as __cmpwait, and we use that
> > to build smp_cond_load_acquire. It would be nice to use the same machinery
> > for the conditional spinning here, unless you anticipate that we're only
> > going to be spinning for a handful of iterations anyway?
> 
> So I do want to look at adding spin loop primitives as well as the
> begin/in/end primitives to help with powerpc's SMT priorities.
> 
> So we'd have:
> 
>   spin_begin();
>   spin_do {
>     if (blah) {
>         spin_end();
>         return;
>     }
>   } spin_until(!locked);
>   spin_end();
> 
> So you could implement your monitor with that. There's a handful of core
> places. mutex, bit spinlock, seqlock, polling idle, etc. So I think if it
> is beneficial for you in smp_cond_load_acquire, it should be useful in
> those too.

Yeah, I think we should be able to implement spin_until like we do for
smp_cond_load_acquir, although it means we need to pass in the pointer as
well.

Will
