From: Michal Hocko <mhocko@kernel.org>
Subject: Re: Regression after commit 19809c2da28a ("mm, vmalloc: use
 __GFP_HIGHMEM implicitly")
Date: Wed, 14 Feb 2018 15:04:30 +0100
Message-ID: <20180214140430.GB3443@dhcp22.suse.cz>
References: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
 <20180208130649.GA15846@bombadil.infradead.org>
 <20180208232004.GA21027@bombadil.infradead.org>
 <20180211092652.GV21609@dhcp22.suse.cz>
 <20180211112808.GA4551@bombadil.infradead.org>
 <20180211120515.GB4551@bombadil.infradead.org>
 <20180211235107.GE4680@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59835 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030450AbeBNOEd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Feb 2018 09:04:33 -0500
Content-Disposition: inline
In-Reply-To: <20180211235107.GE4680@bombadil.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>, Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, James.Bottomley@HansenPartnership.com, davem@redhat.com

On Sun 11-02-18 15:51:07, Matthew Wilcox wrote:
> On Sun, Feb 11, 2018 at 04:05:15AM -0800, Matthew Wilcox wrote:
> > On Sun, Feb 11, 2018 at 03:28:08AM -0800, Matthew Wilcox wrote:
> > > Now, longer-term, perhaps we should do the following:
> > > 
> > > #ifdef CONFIG_ZONE_DMA32
> > > #define OPT_ZONE_DMA32	ZONE_DMA32
> > > #elif defined(CONFIG_64BIT)
> > > #define OPT_ZONE_DMA	OPT_ZONE_DMA
> > > #else
> > > #define OPT_ZONE_DMA32 ZONE_NORMAL
> > > #endif
> > 
> > For consistent / coherent memory, we have an allocation function.
> > But we don't have an allocation function for streaming memory, which is
> > what these drivers want.  They also flush the DMA memory and then access
> > the memory through a different virtual mapping, which I'm not sure is
> > going to work well on virtually-indexed caches like SPARC and PA-RISC
> > (maybe not MIPS either?)
> 
> Perhaps I (and a number of other people ...) have misunderstood the
> semantics of GFP_DMA32.  Perhaps GFP_DMA32 is not "allocate memory below
> 4GB", perhaps it's "allocate memory which can be mapped below 4GB".

Well, GFP_DMA32 is clearly under-documented. But I _believe_ the
intention was to really return a physical memory within 32b address
range.

> Machines with an IOMMU can use ZONE_NORMAL.  Machines with no IOMMU can
> choose to allocate memory with a physical address below 4GB.

This would be something for the higher level allocator I think. The page
allocator is largely unaware of IOMMU or any remapping and that is good
IMHO.

> After all, it has 'DMA' right there in the name.

The name is misnomer following GFP_DMA which is arguably a better fit.
GFP_MEM32 would be a better name.

Btw. I believe the GFP_VMALLOC32 shows that our GFP_DM32 needs some
love. The user shouldn't really care about lowmem zones layout.
GFP_DMA32 should simply use the appropriate zone regardless the arch
specific details.

-- 
Michal Hocko
SUSE Labs
