Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:60681 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750AbZLXNG2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2009 08:06:28 -0500
Date: Thu, 24 Dec 2009 13:06:25 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
	areas
Message-ID: <20091224130625.GC3165@console-pimps.org>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de> <1261603345-2494-2-git-send-email-James.Bottomley@suse.de> <20091224100853.GA3165@console-pimps.org> <20091224123913.GD5335@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091224123913.GD5335@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: James Bottomley <James.Bottomley@suse.de>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20091224130625.C2zPNOETEU8eABryvYrEZWRfEA0ZIeE_i7gpgEVSzj4@z>

On Thu, Dec 24, 2009 at 05:39:13AM -0700, Matthew Wilcox wrote:
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

Aha yes, that would make more sense.

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
> 
> Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

Sounds good to me!
