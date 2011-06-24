From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH/RFC 0/8] ARM: DMA-mapping framework redesign
Date: Fri, 24 Jun 2011 11:18:07 +0200
Message-ID: <20110624091807.GC29299@8bytes.org>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 8bytes.org ([88.198.83.132]:36327 "EHLO 8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563Ab1FXJSI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Jun 2011 05:18:08 -0400
Content-Disposition: inline
In-Reply-To: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi Marek,

On Mon, Jun 20, 2011 at 09:50:05AM +0200, Marek Szyprowski wrote:
> This patch series is a continuation of my works on implementing generic
> IOMMU support in DMA mapping framework for ARM architecture. Now I
> focused on the DMA mapping framework itself. It turned out that adding
> support for common dma_map_ops structure was not that hard as I initally
> thought. After some modification most of the code fits really well to
> the generic dma_map_ops methods.

I appreciate your progress on this generic dma_ops implementation. But
for now it looks very ARM specific. Do you have plans to extend it to
non-ARM iommu-api implementations too?

	Joerg
