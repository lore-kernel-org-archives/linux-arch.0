Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54846 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbcEDPBo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 May 2016 11:01:44 -0400
Date: Wed, 4 May 2016 17:01:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: kmap_atomic and preemption
Message-ID: <20160504150138.GR3430@twins.programming.kicks-ass.net>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA23075F4EA065E@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA23075F4EA065E@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160504150138.6OZAbLtxLNqLdA0t32ftFI2RV0x3kt13kwSyXOD09LQ@z>

On Wed, May 04, 2016 at 02:16:11PM +0000, Vineet Gupta wrote:
> > static inline void *kmap_atomic(struct page *page)
> > {
> > 	preempt_disable();
> > 	pagefault_disable();
> > 	if (!PageHighMem(page))
> > 		return page_address(page);
> >
> > 	return __kmap_atomic(page);
> > }
> 
> I actually want to return early for !PageHighMem and avoid the pointless 2
> LD-ADD-ST to memory for map and 2 LD-SUB-ST for unmap for regular pages for such
> cases.

So I'm fairly sure people rely on the fact you cannot have pagefault
inside a kmap_atomic().

But you could potentially get away with leaving preemption enabled. Give
it a try, see if something goes *bang* ;-)
