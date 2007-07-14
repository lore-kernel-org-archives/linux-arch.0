Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:35124 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbXGNQdX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 14 Jul 2007 12:33:23 -0400
Date: Sat, 14 Jul 2007 17:33:19 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/7] Generic Virtual Memmap support for SPARSEMEM
Message-ID: <20070714163319.GA14184@infradead.org>
References: <exportbomb.1184333503@pinky> <E1I9LJY-00006o-GK@hellhawk.shadowen.org> <20070714152058.GA12478@infradead.org> <Pine.LNX.4.64.0707140905140.31138@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707140905140.31138@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andy Whitcroft <apw@shadowen.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Nick Piggin <npiggin@suse.de>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Sat, Jul 14, 2007 at 09:06:58AM -0700, Christoph Lameter wrote:
> > > +#ifndef CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP
> > > +void __meminit vmemmap_verify(pte_t *pte, int node,
> > > +				unsigned long start, unsigned long end)
> > > +{
> > > +	unsigned long pfn = pte_pfn(*pte);
> > > +	int actual_node = early_pfn_to_nid(pfn);
> > > +
> > > +	if (actual_node != node)
> > > +		printk(KERN_WARNING "[%lx-%lx] potential offnode "
> > > +			"page_structs\n", start, end - 1);
> > > +}
> > 
> > Given tht this function is a tiny noop please just put them into the
> > arch dir for !CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP architectures
> > and save yourself both the ifdef mess and the config option.
> 
> Then its no longer generic. You are ripping the basic framework of 
> sparsemem apart.

It's not generic.  Most of it is under a maze of obscure config options.
The patchset in it's current form is a complete mess of obscure ifefery
and not quite generic code.  And it only adds new memory models without
ripping old stuff out.  So while I really like the basic idea the patches
need quite a lot more work until they're mergeable.
