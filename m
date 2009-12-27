From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
 areas
Date: Sun, 27 Dec 2009 09:37:30 -0600
Message-ID: <1261928250.2697.9.camel@mulgrave.site>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
	 <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
	 <20091224100853.GA3165@console-pimps.org>
	 <20091224123913.GD5335@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:45838 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151AbZL0Phd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Dec 2009 10:37:33 -0500
In-Reply-To: <20091224123913.GD5335@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, 2009-12-24 at 05:39 -0700, Matthew Wilcox wrote:
> On Thu, Dec 24, 2009 at 10:08:53AM +0000, Matt Fleming wrote:
> > On Wed, Dec 23, 2009 at 03:22:21PM -0600, James Bottomley wrote:
> > > +
> > > +  void flush_kernel_vmap_range(void *vaddr, int size)
> > > +       flushes the kernel cache for a given virtual address range in
> > > +       the vmap area.  This API makes sure that and data the kernel
> > 
> >   	      	   	       	   	      	^^^ code and data?
> 
> I'd guess it's a typo for 'any data'.
> 
> > > +  void invalidate_kernel_vmap_range(void *vaddr, int size)
> > > +       invalidates the kernel cache for a given virtual address range
> > > +       in the vmap area.  This API is designed to make sure that while
> > > +       I/O went on to an address range in the vmap area, the processor
> > > +       didn't speculate cache reads and thus make the cache over the
> > > +       virtual address stale.
> > > +
> > 
> > Could this sentence be reworked a little? I find the "over the virtual
> > address" part a little difficult to parse.
> 
> How about:
> 
> invalidates the processor cache for a given virtual address range
> in the vmap area.  This API addresses the problem that the processor
> may have performed speculative reads into its cache of the vmapped
> area while I/O was occurring to the underlying physical pages.

So better, I think is

invalidates the cache for a given virtual address range in the vmap area
which prevents the processor from making the cache stale by
speculatively reading data while the I/O was occurring to the physical
pages.

James
