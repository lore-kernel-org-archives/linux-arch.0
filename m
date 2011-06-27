Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:57141 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932140Ab1F0NbH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2011 09:31:07 -0400
MIME-version: 1.0
Content-transfer-encoding: 7BIT
Content-type: text/plain; charset=us-ascii
Received: from eu_spt1 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LNG00HZ5AVS3300@mailout4.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 27 Jun 2011 14:31:04 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LNG0093MAVROJ@spt1.w1.samsung.com> for
 linux-arch@vger.kernel.org; Mon, 27 Jun 2011 14:31:03 +0100 (BST)
Date: Mon, 27 Jun 2011 15:30:59 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: RE: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method
 to more generic alloc/free_attrs
In-reply-to: <201106271522.05486.arnd@arndb.de>
Message-ID: <000801cc34ce$739df1e0$5ad9d5a0$%szyprowski@samsung.com>
Content-language: pl
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <201106241751.35655.arnd@arndb.de>
 <000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
 <201106271522.05486.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Message-ID: <20110627133059.NAdHke1B9Yw9NfKQJlL8CfYsTZ8CoejwyMLXrtZS8gg@z>

Hello,

On Monday, June 27, 2011 3:22 PM Arnd Bergmann wrote:

> On Monday 27 June 2011, Marek Szyprowski wrote:
> > > On a related note, do you plan to make the CMA work use this
> > > transparently, or do you want to have a DMA_ATTR_LARGE or
> > > DMA_ATTR_CONTIGUOUS for CMA?
> >
> > IMHO it will be better to hide the CMA from the drivers. Memory allocated
> > from CMA doesn't really differ from the one allocated by
> dma_alloc_coherent()
> > (which internally use alloc_pages()), so I really see no reason for
> adding
> > additional attribute for it.
> 
> Ok, fair enough. On a semi-related topic, IIRC we still need to make sure
> that dma_alloc_coherent() pages are unmapped from the linear mapping. I
> hope
> this is independent of both CMA and this patch.

Right, that's one more big item that is still on the TODO list.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center


