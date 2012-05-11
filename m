Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:50809 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2EKHw7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 May 2012 03:52:59 -0400
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=us-ascii
Date: Fri, 11 May 2012 09:52:53 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCHv9 10/10] ARM: dma-mapping: add support for IOMMU mapper
In-reply-to: <CAP=VYLr=NeGvppR4ONpnRh=gjCSPdKxYj1HYh_FvadAeUzcbBQ@mail.gmail.com>
Message-ID: <02e301cd2f4b$11e02f90$35a08eb0$%szyprowski@samsung.com>
Content-language: pl
References: <1334756652-30830-1-git-send-email-m.szyprowski@samsung.com>
 <1334756652-30830-11-git-send-email-m.szyprowski@samsung.com>
 <CAP=VYLr=NeGvppR4ONpnRh=gjCSPdKxYj1HYh_FvadAeUzcbBQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Paul Gortmaker' <paul.gortmaker@windriver.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Subash Patel' <subashrp@gmail.com>, linux-next@vger.kernel.org
Message-ID: <20120511075253.clXu2m321oe6Qf2Axxw5ufGiBlMjaVSgq0V5n1_T_RE@z>

Hello,

On Friday, May 11, 2012 4:09 AM Paul Gortmaker wrote:

> On Wed, Apr 18, 2012 at 9:44 AM, Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > This patch add a complete implementation of DMA-mapping API for
> > devices which have IOMMU support.
> 
> Hi Marek,
> 
> It looks like this patch breaks no-MMU builds on ARM, at least
> according to git bisect.  Here is a link to a linux-next failure:
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/6291233/
> 
> arch/arm/mm/dma-mapping.c:726:42: error: 'pgprot_kernel' undeclared
> (first use in this function)
> make[2]: *** [arch/arm/mm/dma-mapping.o] Error 1
> 
> Please have a look, thanks.

Thanks for reporting this issue, I will send a fix in a minute.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


