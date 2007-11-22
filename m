Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:38010 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbXKVIEQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Nov 2007 03:04:16 -0500
Date: Thu, 22 Nov 2007 09:04:14 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Message-ID: <20071122080414.GA31932@wotan.suse.de>
References: <20071120160220.GA22196@wotan.suse.de> <20071121135016.GB15318@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071121135016.GB15318@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, Nov 21, 2007 at 01:50:16PM +0000, Ralf Baechle wrote:
> On Tue, Nov 20, 2007 at 05:02:20PM +0100, Nick Piggin wrote:
> 
> > + TYPE	    FULL		    CACHEABLE (SMP CONDITIONAL) IO
> > + =========  ======================= =========================== ============
> > + GENERAL    mb()		    smp_mb()			io_mb()
> > + WRITE	    wmb()		    smp_wmb()			io_wmb()
> > + READ	    rmb()		    smp_rmb()			io_rmb()
> > + DATA DEP.  read_barrier_depends()  smp_read_barrier_depends()
> 
> A while ago I went through the kernel looking at the uses mb(), wmb() and
> rmb() and found that every use was either fishy or should have been a
> smp_mb(), smp_wmb() or wmp_rmb().  Which leads me to the question if there
> is any need for the non-smp_ variants left or can we just bury them?

I don't know driver code very well, however it seems like there is a
legitimate need for barriers there, _however_ I think a lot of those went
in when writel could be unordered on some architectures.

The sane way to do it is to make all drivers default to strongly ordered
IO (eg. make readl writel strongly ordered). And then yes indeed I believe
most of the mb/wmb/rmb can go away.

We still need full memory barrires in order to order cacheable access with
IO access (eg. in order to support SMP locking of IO routines). However in
that case I believe an easily understood lock-based primitive should be
provided, along with a fully ordering implementations of the regular memory
barriers, rather than mmiowb (which clearly very few driver writers or anyone
else understands). 

After that, if some architectures want to implement more relaxed variants
of the IO accessors, then OK. And we can use io_ memory barriers for that.

