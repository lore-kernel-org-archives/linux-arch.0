Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:38677 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816AbXHBN0a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Aug 2007 09:26:30 -0400
Date: Thu, 2 Aug 2007 14:26:21 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] vmemmap: pull out the vmemmap code into its own file
Message-ID: <20070802132621.GA9511@infradead.org>
References: <exportbomb.1186045945@pinky> <E1IGWw3-0002Xr-Dm@hellhawk.shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1IGWw3-0002Xr-Dm@hellhawk.shadowen.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>, Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 02, 2007 at 10:25:35AM +0100, Andy Whitcroft wrote:
> + * Special Kconfig settings:
> + *
> + * CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP
> + *
> + * 	The architecture has its own functions to populate the memory
> + * 	map and provides a vmemmap_populate function.
> + *
> + * CONFIG_ARCH_POPULATES_SPARSEMEM_VMEMMAP_PMD
> + *
> + * 	The architecture provides functions to populate the pmd level
> + * 	of the vmemmap mappings.  Allowing mappings using large pages
> + * 	where available.
> + *
> + * 	If neither are set then PAGE_SIZE mappings are generated which
> + * 	require one PTE/TLB per PAGE_SIZE chunk of the virtual memory map.
> + */

This is the kinda of mess I mean.  Which architecturs set either of these
and why?  This code would be a lot more acceptable if we hadn't three
different variants of the arch interface.

