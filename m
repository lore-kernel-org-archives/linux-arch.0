From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCHv2 1/5] mm: add coherence API for DMA to vmalloc/vmap
	areas
Date: Thu, 24 Dec 2009 10:08:53 +0000
Message-ID: <20091224100853.GA3165@console-pimps.org>
References: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de> <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1261603345-2494-2-git-send-email-James.Bottomley@suse.de>
Sender: linux-parisc-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-arch.vger.kernel.org

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
