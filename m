Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:34317 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbZLXMjP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2009 07:39:15 -0500
Date: Thu, 24 Dec 2009 05:39:13 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
	areas
Message-ID: <20091224123913.GD5335@parisc-linux.org>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de> <1261603345-2494-2-git-send-email-James.Bottomley@suse.de> <20091224100853.GA3165@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091224100853.GA3165@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: James Bottomley <James.Bottomley@suse.de>, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20091224123913.v1SRDr2LN6yL2tHsGXroCItMLIzlFClcUbY3Y5m-5XM@z>

On Thu, Dec 24, 2009 at 10:08:53AM +0000, Matt Fleming wrote:
> On Wed, Dec 23, 2009 at 03:22:21PM -0600, James Bottomley wrote:
> > +
> > +  void flush_kernel_vmap_range(void *vaddr, int size)
> > +       flushes the kernel cache for a given virtual address range in
> > +       the vmap area.  This API makes sure that and data the kernel
> 
>   	      	   	       	   	      	^^^ code and data?

I'd guess it's a typo for 'any data'.

> > +  void invalidate_kernel_vmap_range(void *vaddr, int size)
> > +       invalidates the kernel cache for a given virtual address range
> > +       in the vmap area.  This API is designed to make sure that while
> > +       I/O went on to an address range in the vmap area, the processor
> > +       didn't speculate cache reads and thus make the cache over the
> > +       virtual address stale.
> > +
> 
> Could this sentence be reworked a little? I find the "over the virtual
> address" part a little difficult to parse.

How about:

invalidates the processor cache for a given virtual address range
in the vmap area.  This API addresses the problem that the processor
may have performed speculative reads into its cache of the vmapped
area while I/O was occurring to the underlying physical pages.

Signed-off-by: Matthew Wilcox <willy@linux.intel.com>

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
