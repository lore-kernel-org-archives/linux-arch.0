Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:42242 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdGPBYY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2017 21:24:24 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: semantics of dma_map_single()
Message-ID: <dc128260-6641-828a-3bb6-c2f0b4f09f78@synopsys.com>
Date: Sat, 15 Jul 2017 18:24:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>, bart.vanassche@sandisk.com, Alexander Duyck <alexander.h.duyck@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20170716012403.C8PkKwjx5vhOBmo_ZHYcrPwRgm5vCMh1KKBR-gZ36SM@z>

P.S. Apologies in advance for the explicit TO list, it seemed adding people who've 
touched the dma mapping code (for ARC atleast), would respond sooner ;-)

The question is does dma_map_single() imply a single region (possibly > PAGE_SIZE) 
or does it imply PAGE_SIZE. Documentation/DMA-API* is not explicit about one or 
the other and the code below seems to point to "a" struct page, although it could 
also mean multiple pages, specially if the pages are contiguous, say as those 
returned by alloc_pages(with order > 0)


	static inline dma_addr_t dma_map_single_attrs(dev, size, dir, attrs)
	{
		addr = ops->map_page(dev,
			virt_to_page(ptr), <--- this is one struct page
			offset_in_page(ptr), size, dir, attrs);
	}

ARC dma_map_single() currently only handles cache coherency for only one struct 
page or PAGE_SIZE worth of memory, and we have a customer who seem to assume that 
it handles a region.

Looking at other arches dma mapping backend, it is not clear either what the 
semantics are.

Thx,
-Vineet
