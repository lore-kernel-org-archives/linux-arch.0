Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab2DJLoN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 07:44:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 04/10] ARM: dma-mapping: remove offset parameter to prepare for generic dma_ops
Date: Tue, 10 Apr 2012 11:43:27 +0000
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
In-Reply-To: <1334055852-19500-5-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201204101143.27915.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, Kyungmin Park <kyungmin.park@samsung.com>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
Message-ID: <20120410114327.fyt0cNP38fSvebRfQBUrzWp6qI1RpUAkwUz17eICb0k@z>

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> This patch removes the need for offset parameter in dma bounce
> functions. This is required to let dma-mapping framework on ARM
> architecture use common, generic dma-mapping helpers.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

This one worries me a little. I always thought that the range sync 
functions were specifically needed for the dmabounce code. At the
very least, I would expect the changeset comment to have an explanation
of why this was initially done this way and why it's now safe to do
do it otherwise.

	Arnd
