Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51906 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbeERRub (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2018 13:50:31 -0400
Date: Fri, 18 May 2018 18:50:04 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: dma_sync_*_for_cpu and direction=TO_DEVICE (was Re: [PATCH
 02/20] dma-mapping: provide a generic dma-noncoherent implementation)
Message-ID: <20180518175004.GF17671@n2100.armlinux.org.uk>
References: <20180511075945.16548-1-hch@lst.de>
 <20180511075945.16548-3-hch@lst.de>
 <bad125dff49f6e49c895e818c9d1abb346a46e8e.camel@synopsys.com>
 <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ac5b1e3-9b96-9c7c-4dfe-f65be45ec179@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "hch@lst.de" <hch@lst.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "monstr@monstr.eu" <monstr@monstr.eu>, "deanbo422@gmail.com" <deanbo422@gmail.com>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, "green.hu@gmail.com" <green.hu@gmail.com>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20180518175004.W26FNv8Y5Dx5j5oEooLna96VVPlhQ6ynO7wsefvK4cQ@z>

On Fri, May 18, 2018 at 10:20:02AM -0700, Vineet Gupta wrote:
> I never understood the need for this direction. And if memory serves me
> right, at that time I was seeing twice the amount of cache flushing !

It's necessary.  Take a moment to think carefully about this:

	dma_map_single(, dir)

	dma_sync_single_for_cpu(, dir)

	dma_sync_single_for_device(, dir)

	dma_unmap_single(, dir)

In the case of a DMA-incoherent architecture, the operations done at each
stage depend on the direction argument:

	map		for_cpu		for_device	unmap
TO_DEV	writeback	none		writeback	none
TO_CPU	invalidate	invalidate*	invalidate	invalidate*
BIDIR	writeback	invalidate	writeback	invalidate

* - only necessary if the CPU speculatively prefetches.

The multiple invalidations for the TO_CPU case handles different
conditions that can result in data corruption, and for some CPUs, all
four are necessary.

This is what is implemented for 32-bit ARM, depending on the CPU
capabilities, as we have DMA incoherent devices and we have CPUs that
speculatively prefetch data, and so may load data into the caches while
DMA is in operation.


Things get more interesting if the implementation behind the DMA API has
to copy data between the buffer supplied to the mapping and some DMA
accessible buffer:

	map		for_cpu		for_device	unmap
TO_DEV	copy to dma	none		copy to dma	none
TO_CPU	none		copy to cpu	none		copy to cpu
BIDIR	copy to dma	copy to cpu	copy to dma	copy to cpu

So, in both cases, the value of the direction argument defines what you
need to do in each call.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
