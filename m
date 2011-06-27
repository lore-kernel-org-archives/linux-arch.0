Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57448 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757151Ab1F0NW1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2011 09:22:27 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent method to more generic alloc/free_attrs
Date: Mon, 27 Jun 2011 15:22:05 +0200
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <201106241751.35655.arnd@arndb.de> <000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
In-Reply-To: <000701cc34c5$0c50b800$24f22800$%szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201106271522.05486.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Message-ID: <20110627132205.1M6YjqfUCRPQ8zYMEAIhKJlDEtLHw5y5jSpCFume334@z>

On Monday 27 June 2011, Marek Szyprowski wrote:
> > On a related note, do you plan to make the CMA work use this
> > transparently, or do you want to have a DMA_ATTR_LARGE or
> > DMA_ATTR_CONTIGUOUS for CMA?
> 
> IMHO it will be better to hide the CMA from the drivers. Memory allocated
> from CMA doesn't really differ from the one allocated by dma_alloc_coherent()
> (which internally use alloc_pages()), so I really see no reason for adding
> additional attribute for it.

Ok, fair enough. On a semi-related topic, IIRC we still need to make sure
that dma_alloc_coherent() pages are unmapped from the linear mapping. I hope
this is independent of both CMA and this patch.

	Arnd
