Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60433 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2DJMYg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 08:24:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 07/10] ARM: dma-mapping: move all dma bounce code to separate dma ops structure
Date: Tue, 10 Apr 2012 12:24:24 +0000
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <1334055852-19500-8-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1334055852-19500-8-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201204101224.24959.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120410122424.rCW4eFf0T7PtYz60SFJDJXzRhNRk2tBWVgtSfG8_gpk@z>

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch removes dma bounce hooks from the common dma mapping
> implementation on ARM architecture and creates a separate set of
> dma_map_ops for dma bounce devices.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

I could be misunderstanding something, but it looks like this
one should come before patch 6, where you remove
some of the dmabounce functions. Can you clarify?

	Arnd
