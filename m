From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 13/20] intel-iommu: switch from ioremap_cache to memremap
Date: Wed, 14 Oct 2015 15:22:51 +0200
Message-ID: <20151014132251.GV10641@suse.de>
References: <20151009221537.32203.5867.stgit@dwillia2-desk3.jf.intel.com>
 <20151009221646.32203.98367.stgit@dwillia2-desk3.jf.intel.com>
 <20151012215830.GT10641@suse.de>
 <CAPcyv4h8zca3uNUH3ZoSVxrTYXr1XPD8AFrs60JzjKAu+45nog@mail.gmail.com>
 <CAPcyv4i=cAT-mmhCbbv_77gdJggXxHk3jRoOg=Qm5H3tsMAK1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPcyv4i=cAT-mmhCbbv_77gdJggXxHk3jRoOg=Qm5H3tsMAK1Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Oct 12, 2015 at 03:19:24PM -0700, Dan Williams wrote:
> On Mon, Oct 12, 2015 at 3:05 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> > On Mon, Oct 12, 2015 at 2:58 PM, Joerg Roedel <jroedel@suse.de> wrote:
> >> Hi Dan,
> >>
> >> On Fri, Oct 09, 2015 at 06:16:46PM -0400, Dan Williams wrote:
> >>> In preparation for deprecating ioremap_cache() convert its usage in
> >>> intel-iommu to memremap.  This also eliminates the mishandling of the
> >>> __iomem annotation in the implementation.
> >>
> >> I appreciate the change, but in the cover letter you write the API is
> >> only implemented for x86 so far? The VT-d driver is also used on ia64,
> >> will it still work there with this patch?
> >>
> >>
> >
> > I did convert ia64 in the series [1]  but you're right this patch
> > can't go in independently of that conversion.  If you ack this one
> > I'll carry them in order.
> >
> > [1]: https://lkml.org/lkml/2015/10/9/702
> 
> Ah sorry, got ahead of myself ;-p.  You can safely take this patch
> through your tree.  The ia64 patch can happen asynchronously because
> kernel/memremap.c has:
> 
> __weak void *arch_memremap(resource_size_t offset, size_t size,
> unsigned long flags)
> 
> ...as a temporary fallback until the conversion is complete.

Okay, thanks, applied.
