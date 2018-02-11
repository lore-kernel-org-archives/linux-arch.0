From: Matthew Wilcox <willy@infradead.org>
Subject: Re: Regression after commit 19809c2da28a ("mm, vmalloc: use
 __GFP_HIGHMEM implicitly")
Date: Sun, 11 Feb 2018 15:51:07 -0800
Message-ID: <20180211235107.GE4680@bombadil.infradead.org>
References: <627DA40A-D0F6-41C1-BB5A-55830FBC9800@canonical.com>
 <20180208130649.GA15846@bombadil.infradead.org>
 <20180208232004.GA21027@bombadil.infradead.org>
 <20180211092652.GV21609@dhcp22.suse.cz>
 <20180211112808.GA4551@bombadil.infradead.org>
 <20180211120515.GB4551@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20180211120515.GB4551@bombadil.infradead.org>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@kernel.org>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>, Laura Abbott <labbott@redhat.com>, linux-mm@kvack.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, James.Bottomley@HansenPartnership.com, davem@redhat.com
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 11, 2018 at 04:05:15AM -0800, Matthew Wilcox wrote:
> On Sun, Feb 11, 2018 at 03:28:08AM -0800, Matthew Wilcox wrote:
> > Now, longer-term, perhaps we should do the following:
> > 
> > #ifdef CONFIG_ZONE_DMA32
> > #define OPT_ZONE_DMA32	ZONE_DMA32
> > #elif defined(CONFIG_64BIT)
> > #define OPT_ZONE_DMA	OPT_ZONE_DMA
> > #else
> > #define OPT_ZONE_DMA32 ZONE_NORMAL
> > #endif
> 
> For consistent / coherent memory, we have an allocation function.
> But we don't have an allocation function for streaming memory, which is
> what these drivers want.  They also flush the DMA memory and then access
> the memory through a different virtual mapping, which I'm not sure is
> going to work well on virtually-indexed caches like SPARC and PA-RISC
> (maybe not MIPS either?)

Perhaps I (and a number of other people ...) have misunderstood the
semantics of GFP_DMA32.  Perhaps GFP_DMA32 is not "allocate memory below
4GB", perhaps it's "allocate memory which can be mapped below 4GB".
Machines with an IOMMU can use ZONE_NORMAL.  Machines with no IOMMU can
choose to allocate memory with a physical address below 4GB.

After all, it has 'DMA' right there in the name.  If someone's relying
on it to allocate physical memory below 4GB, they're arguably misusing it.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
