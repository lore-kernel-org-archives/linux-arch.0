Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:48234 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbZLXKI4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Dec 2009 05:08:56 -0500
Date: Thu, 24 Dec 2009 10:08:53 +0000
From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
	areas
Message-ID: <20091224100853.GA3165@console-pimps.org>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de> <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
Message-ID: <20091224100853.AAt3D3K2jdKVe-Mape72doLgzyKRvTd0TrOsv3hIjKs@z>

On Wed, Dec 23, 2009 at 03:22:21PM -0600, James Bottomley wrote:
> +
> +  void flush_kernel_vmap_range(void *vaddr, int size)
> +       flushes the kernel cache for a given virtual address range in
> +       the vmap area.  This API makes sure that and data the kernel

  	      	   	       	   	      	^^^ code and data?

> +  void invalidate_kernel_vmap_range(void *vaddr, int size)
> +       invalidates the kernel cache for a given virtual address range
> +       in the vmap area.  This API is designed to make sure that while
> +       I/O went on to an address range in the vmap area, the processor
> +       didn't speculate cache reads and thus make the cache over the
> +       virtual address stale.
> +

Could this sentence be reworked a little? I find the "over the virtual
address" part a little difficult to parse.
