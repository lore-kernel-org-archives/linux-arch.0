Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay05.ispgateway.de ([80.67.31.99]:58721 "EHLO
	smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111Ab2F2LRq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jun 2012 07:17:46 -0400
Message-ID: <4FED8D03.10507@ladisch.de>
Date: Fri, 29 Jun 2012 13:09:55 +0200
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
Subject: Re: [PATCH] common: dma-mapping: add support for generic dma_mmap_*
 calls
References: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, David Gibson <david@gibson.dropbear.id.au>, Subash Patel <subash.ramaswamy@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>
Message-ID: <20120629110955.n6FtGaRMhUJcLn69pdcp012gb075aguUY1Lt6aYELr4@z>

Marek Szyprowski wrote:
> +++ b/drivers/base/dma-mapping.c
> ...
> +int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> +		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
> +{
> +	int ret = -ENXIO;
> +	...
> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +		return ret;

This will return -ENXIO if dma_mmap_from_coherent() succeeds.


Regards,
Clemens
