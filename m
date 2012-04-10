Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:49472 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab2DJLsH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 07:48:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 05/10] ARM: dma-mapping: use asm-generic/dma-mapping-common.h
Date: Tue, 10 Apr 2012 11:47:20 +0000
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <1334055852-19500-6-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1334055852-19500-6-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201204101147.20733.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120410114720.GVH2eAVRVtAMRRP1RUwVg4hEvPU408weeqC0qytuw9A@z>

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch modifies dma-mapping implementation on ARM architecture to
> use common dma_map_ops structure and asm-generic/dma-mapping-common.h
> helpers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/Kconfig                   |    1 +
>  arch/arm/include/asm/device.h      |    1 +
>  arch/arm/include/asm/dma-mapping.h |  196 +++++-------------------------------
>  arch/arm/mm/dma-mapping.c          |  148 ++++++++++++++++-----------
>  4 files changed, 115 insertions(+), 231 deletions(-)

Looks good in principle. One question: Now that many of the functions are only
used in the dma_map_ops, can you make them 'static' instead?

	Arnd
