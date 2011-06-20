Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59920 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab1FTOjd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 10:39:33 -0400
Date: Mon, 20 Jun 2011 15:39:11 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/8] ARM: dma-mapping: implement dma_map_single on top
	of dma_map_page
Message-ID: <20110620143911.GD26089@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <1308556213-24970-3-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308556213-24970-3-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>
Message-ID: <20110620143911.FKR_9OpI_R8DXmYrji71_7AIAsMJSlrtx69_3oAQmqI@z>

On Mon, Jun 20, 2011 at 09:50:07AM +0200, Marek Szyprowski wrote:
> This patch consolidates dma_map_single and dma_map_page calls. This is
> required to let dma-mapping framework on ARM architecture use common,
> generic dma-mapping helpers.

This breaks DMA API debugging, which requires that dma_map_page and
dma_unmap_page are paired separately from dma_map_single and
dma_unmap_single().

This also breaks dmabounce when used with a highmem-enabled system -
dmabounce refuses the dma_map_page() API but allows the dma_map_single()
API.
