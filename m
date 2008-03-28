Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42088 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbYC1EPV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Mar 2008 00:15:21 -0400
Date: Fri, 28 Mar 2008 05:15:20 +0100
From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 1/2]: x86: implement pte_special
Message-ID: <20080328041519.GF8083@wotan.suse.de>
References: <20080328033149.GD8083@wotan.suse.de> <20080327.204431.201380891.davem@davemloft.net> <20080328040442.GE8083@wotan.suse.de> <20080327.210910.101408473.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080327.210910.101408473.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: akpm@linux-foundation.org, shaggy@austin.ibm.com, axboe@oracle.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080328041520.mqURlMDxGj4745qVUGdvlP0BKOu_uEbEifRDvHaKWbI@z>

On Thu, Mar 27, 2008 at 09:09:10PM -0700, David Miller wrote:
> From: Nick Piggin <npiggin@suse.de>
> Date: Fri, 28 Mar 2008 05:04:42 +0100
> 
> > BTW. if you are still interested, then the powerpc64 patch might be a
> > better starting point for you. I don't know how the sparc tlb flush
> > design looks like, but if it doesn't do a synchronous IPI to invalidate
> > other threads, then you can't use the x86 approach.
> 
> I have soft bits available on sparc64, that's not my issue.
> 
> My issue is that if you implemented this differently, every platform
> would get the optimization, without having to do anything special
> at all, and I think that's such a much nicer way.

Oh, they wouldn't. It is completely tied to the low level details of
their TLB and pagetable teardown design. That's the unfortunate part
about it.

The other thing is that the "how do I know if I can refcount the page
behind this (mm,vaddr,pte) tuple" can be quite arch specific as well.
And it is also non-trivial to do because that information can be dynamic
depending on what driver mapped in that given tuple.

It is *possible*, but not trivial.

