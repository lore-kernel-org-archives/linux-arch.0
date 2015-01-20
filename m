Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:38841 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753491AbbATKoB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jan 2015 05:44:01 -0500
Date: Tue, 20 Jan 2015 10:43:59 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Behaviour of smp_mb__{before,after}_spin* and acquire/release
Message-ID: <20150120104359.GC24303@arm.com>
References: <20150113163353.GE31784@arm.com>
 <20150113184510.GA31525@redhat.com>
 <20150114113147.GG4050@arm.com>
 <20150120034040.GN9719@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150120034040.GN9719@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20150120104359.hfeHPORJKuMRBXbf3I_gNviQz9JbpDb0O-BgI6QFUPo@z>

Hi Paul,

On Tue, Jan 20, 2015 at 03:40:40AM +0000, Paul E. McKenney wrote:
> On Wed, Jan 14, 2015 at 11:31:47AM +0000, Will Deacon wrote:
> > On Tue, Jan 13, 2015 at 06:45:10PM +0000, Oleg Nesterov wrote:
> > > On 01/13, Will Deacon wrote:
> > > >
> > > >   1. Does smp_mb__before_spinlock actually have to order prior loads
> > > >      against later loads and stores? Documentation/memory-barriers.txt
> > > >      says it does, but that doesn't match the comment
> > > 
> > > The comment says that smp_mb__before_spinlock() + spin_lock() should
> > > only serialize STOREs with LOADs. This is because it was added to ensure
> > > that the setting of condition can't race with ->state check in ttwu().
> > 
> > Yup, that makes sense. The comment is consistent with the code, and I think
> > the code is doing what it's supposed to do.
> > 
> > > But since we use wmb() it obviously serializes STOREs with STORES. I do
> > > not know if this should be documented, but we already have another user
> > > which seems to rely on this fact: set_tlb_flush_pending().
> > 
> > In which case, it's probably a good idea to document that too.
> > 
> > > As for "prior loads", this doesn't look true...
> > 
> > Agreed. I'd propose something like the diff below, but it also depends on
> > my second question since none of this is true for smp_load_acquire.
> 
> OK, finally getting to this, apologies for the delay...

No problem, it's hardly urgent :)

> It does look like I was momentarily confusing the memory ordering implied
> by lock acquisition with that by smp_lock_acquire().  Your patch looks good,
> would you be willing to resend with commit log and Signed-off-by?

Hey, if you get confused by it then what hope do the rest of us have?

Patch below, thanks.

Will

--->8
