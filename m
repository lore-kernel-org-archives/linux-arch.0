From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 10/28] mm: only allow page table mappings for built-in
 zsmalloc
Date: Wed, 8 Apr 2020 08:15:19 -0700
Message-ID: <20200408151519.GQ21484@bombadil.infradead.org>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-11-hch@lst.de>
 <c0c86feb-b3d8-78f2-127f-71d682ffc51f@infradead.org>
 <20200408151203.GN20730@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20200408151203.GN20730@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org, Christoph Hellwig <hch@lst.de>, Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>, Daniel Vetter <daniel@ffwll.ch>, Haiyang Zhang <haiyangz@microsoft.com>, linaro-mm-sig@lists.linaro.org, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Robin Murphy <robin.murphy@arm.com>, Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>, iommu@lists.linux-foundation.org, Sakari Ailus <sakari.ailus@linux.intel.com>, Andrew
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 08, 2020 at 05:12:03PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 08, 2020 at 08:01:00AM -0700, Randy Dunlap wrote:
> > Hi,
> > 
> > On 4/8/20 4:59 AM, Christoph Hellwig wrote:
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 36949a9425b8..614cc786b519 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -702,7 +702,7 @@ config ZSMALLOC
> > >  
> > >  config ZSMALLOC_PGTABLE_MAPPING
> > >  	bool "Use page table mapping to access object in zsmalloc"
> > > -	depends on ZSMALLOC
> > > +	depends on ZSMALLOC=y
> > 
> > It's a bool so this shouldn't matter... not needed.
> 
> My mm/Kconfig has:
> 
> config ZSMALLOC
> 	tristate "Memory allocator for compressed pages"
> 	depends on MMU
> 
> which I think means it can be modular, no?

Randy means that ZSMALLOC_PGTABLE_MAPPING is a bool, so I think hch's patch
is wrong ... if ZSMALLOC is 'm' then ZSMALLOC_PGTABLE_MAPPING would become
'n' instead of 'y'.
