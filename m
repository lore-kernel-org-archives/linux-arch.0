From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 18/28] mm: enforce that vmap can't map pages executable
Date: Wed, 8 Apr 2020 17:32:44 +0200
Message-ID: <20200408153244.GA27818@lst.de>
References: <20200408115926.1467567-1-hch@lst.de> <20200408115926.1467567-19-hch@lst.de> <20200408123835.GB36478@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200408123835.GB36478@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, x86@kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Laura Abbott <labbott@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>, Robin Murphy <robin.murphy@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-ar
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 08, 2020 at 01:38:36PM +0100, Mark Rutland wrote:
> > +static inline pgprot_t pgprot_nx(pgprot_t prot)
> > +{
> > +	return __pgprot(pgprot_val(prot) | _PAGE_NX);
> > +}
> > +#define pgprot_nx pgprot_nx
> > +
> >  #ifdef CONFIG_X86_PAE
> 
> I reckon for arm64 we can do similar in our <asm/pgtable.h>:
> 
> #define pgprot_nx(pgprot_t prot) \
> 	__pgprot_modify(prot, 0, PTE_PXN)
> 
> ... matching the style of our existing pgprot_*() modifier helpers.

I've added that for the next version with attribution to you.
