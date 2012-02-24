From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv6 7/7] ARM: dma-mapping: add support for IOMMU mapper
Date: Fri, 24 Feb 2012 14:31:01 +0000
Message-ID: <201202241431.02170.arnd@arndb.de>
References: <1328900324-20946-1-git-send-email-m.szyprowski@samsung.com> <201202241249.44731.arnd@arndb.de> <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62216 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754654Ab2BXObH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Feb 2012 09:31:07 -0500
In-Reply-To: <013301ccf2f6$bc4ad840$34e088c0$%szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: 'Krishna Reddy' <vdumpa@nvidia.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>

On Friday 24 February 2012, Marek Szyprowski wrote:
> I want to use some kind of chained arrays, each of at most of PAGE_SIZE. This code 
> doesn't really need to keep these page pointers in contiguous virtual memory area, so
> it will not be a problem here.
> 
Sounds like sg_alloc_table(), could you reuse that instead of rolling your own?

	Arnd
