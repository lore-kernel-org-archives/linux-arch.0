Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64544 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755937Ab2DJMWf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 08:22:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 08/10] ARM: dma-mapping: remove redundant code and cleanup
Date: Tue, 10 Apr 2012 12:22:23 +0000
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <1334055852-19500-9-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1334055852-19500-9-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201204101222.23522.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120410122223.bUCsNs6Dl-U0fmh8gLin0sAx_CNJ5NYyhmjko2rAqZs@z>

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> 
> This patch just performs a global cleanup in DMA mapping implementation
> for ARM architecture. Some of the tiny helper functions have been moved
> to the caller code, some have been merged together.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
