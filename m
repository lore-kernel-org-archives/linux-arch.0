From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv8 07/10] ARM: dma-mapping: move all dma bounce code to separate dma ops structure
Date: Tue, 10 Apr 2012 13:17:08 +0000
Message-ID: <201204101317.08765.arnd@arndb.de>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com> <201204101224.24959.arnd@arndb.de> <002801cd1718$b556a1e0$2003e5a0$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62404 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912Ab2DJNRY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 09:17:24 -0400
In-Reply-To: <002801cd1718$b556a1e0$2003e5a0$%szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Chunsang Jeong' <chunsang.jeong@linaro.org>, 'Krishna Reddy' <vdumpa@nvidia.com>, 'KyongHo Cho' <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, 'Konrad Rzeszutek Wilk' <konrad.wilk@oracle.com>, 'Hiroshi Doyu' <hdoyu@nvidia.com>, 'Subash Patel' <subashrp@gmail.com>

On Tuesday 10 April 2012, Marek Szyprowski wrote:
> Before patch no 6, there were custom methods for all scatter/gather
> related operations. They iterated over the whole scatter list and called
> cache related operations directly (which in turn checked if we use dma
> bounce code or not and called respective version). Patch no 6 changed
> them not to use such shortcut for direct calling cache related operations.
> 
> Instead it provides similar loop over scatter list and calls methods
> from the current device's dma_map_ops structure. This way, after patch no 
> 7 these functions call simple dma_map_page() method for all standard 
> devices and dma bounce aware version for devices registered for dma 
> bouncing (with use different dma_map_ops).

Ok, thanks for the explanation.

> I can provide a separate set of scatter/gather list related functions for
> the linear dma mapping implementation and dma bouncing implementation 
> if you think that the current approach is too complicated or 
> over-engineered.

It's probably not needed, though I have not looked at the big picture
with all the patches applied. which I should do at some point.

	Arnd
