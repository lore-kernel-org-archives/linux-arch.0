From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Behaviour of smp_mb__{before,after}_spin* and acquire/release
Date: Mon, 19 Jan 2015 19:40:40 -0800
Message-ID: <20150120034040.GN9719@linux.vnet.ibm.com>
References: <20150113163353.GE31784@arm.com>
 <20150113184510.GA31525@redhat.com>
 <20150114113147.GG4050@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:52048 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbATDkr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jan 2015 22:40:47 -0500
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 19 Jan 2015 20:40:46 -0700
Content-Disposition: inline
In-Reply-To: <20150114113147.GG4050@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wed, Jan 14, 2015 at 11:31:47AM +0000, Will Deacon wrote:
> Hi Oleg,
> 
> On Tue, Jan 13, 2015 at 06:45:10PM +0000, Oleg Nesterov wrote:
> > On 01/13, Will Deacon wrote:
> > >
> > >   1. Does smp_mb__before_spinlock actually have to order prior loads
> > >      against later loads and stores? Documentation/memory-barriers.txt
> > >      says it does, but that doesn't match the comment
> > 
> > The comment says that smp_mb__before_spinlock() + spin_lock() should
> > only serialize STOREs with LOADs. This is because it was added to ensure
> > that the setting of condition can't race with ->state check in ttwu().
> 
> Yup, that makes sense. The comment is consistent with the code, and I think
> the code is doing what it's supposed to do.
> 
> > But since we use wmb() it obviously serializes STOREs with STORES. I do
> > not know if this should be documented, but we already have another user
> > which seems to rely on this fact: set_tlb_flush_pending().
> 
> In which case, it's probably a good idea to document that too.
> 
> > As for "prior loads", this doesn't look true...
> 
> Agreed. I'd propose something like the diff below, but it also depends on
> my second question since none of this is true for smp_load_acquire.

OK, finally getting to this, apologies for the delay...

It does look like I was momentarily confusing the memory ordering implied
by lock acquisition with that by smp_lock_acquire().  Your patch looks good,
would you be willing to resend with commit log and Signed-off-by?

							Thanx, Paul

> Will
> 
> --->8
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 70a09f8a0383..9c0e3c45a807 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -1724,10 +1724,9 @@ for each construct.  These operations all imply certain barriers:
> 
>       Memory operations issued before the ACQUIRE may be completed after
>       the ACQUIRE operation has completed.  An smp_mb__before_spinlock(),
> -     combined with a following ACQUIRE, orders prior loads against
> -     subsequent loads and stores and also orders prior stores against
> -     subsequent stores.  Note that this is weaker than smp_mb()!  The
> -     smp_mb__before_spinlock() primitive is free on many architectures.
> +     combined with a following ACQUIRE, orders prior stores against
> +     subsequent loads and stores. Note that this is weaker than smp_mb()!
> +     The smp_mb__before_spinlock() primitive is free on many architectures.
> 
>   (2) RELEASE operation implication:
> 
> 
