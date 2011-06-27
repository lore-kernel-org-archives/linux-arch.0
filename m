From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
 to more generic alloc/free_attrs
Date: Mon, 27 Jun 2011 16:41:48 +0200
Message-ID: <000b01cc34d8$58856820$09903860$%szyprowski@samsung.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
 <201106241753.49654.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:65207 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab1F0Oly (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2011 10:41:54 -0400
Received: from eu_spt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LNG00AI9E5TV420@mailout4.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 27 Jun 2011 15:41:53 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LNG0024KE5S32@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 27 Jun 2011 15:41:52 +0100 (BST)
In-reply-to: <201106241753.49654.arnd@arndb.de>
Content-language: pl
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>

Hello,

On Friday, June 24, 2011 5:54 PM Arnd Bergmann wrote:

> On Monday 20 June 2011, Marek Szyprowski wrote:
> > mmap method is introduced to let the drivers create a user space mapping
> > for a DMA buffer in generic, architecture independent way.
> 
> One more thing: please split out the mmap change into a separate patch.

Ok, no problem.

> I sense that there might be some objections to that, and it's better
> to let people know about it early on than having them complain
> later when that has already been merged.

Ok, I will also prepare much more detailed description for mmap patch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
