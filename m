Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53082 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754190Ab1FXPYl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jun 2011 11:24:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/8] ARM: dma-mapping: implement dma_map_single on top of dma_map_page
Date: Fri, 24 Jun 2011 17:24:20 +0200
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <20110620143911.GD26089@n2100.arm.linux.org.uk> <000101cc2f5c$ec21da40$c4658ec0$%szyprowski@samsung.com>
In-Reply-To: <000101cc2f5c$ec21da40$c4658ec0$%szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201106241724.21113.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>
Message-ID: <20110624152420.DurGgEq4-IXdTKR_k4Pvl5zVP1sr8hKVh3SMaxxiVTM@z>

On Monday 20 June 2011, Marek Szyprowski wrote:
> > This also breaks dmabounce when used with a highmem-enabled system -
> > dmabounce refuses the dma_map_page() API but allows the dma_map_single()
> > API.
> 
> I really not sure how this change will break dma bounce code. 
> 
> Does it mean that it is allowed to call dma_map_single() on kmapped HIGH_MEM 
> page?

dma_map_single on a kmapped page already doesn't work, the argument needs to
be inside of the linear mapping in order for virt_to_page to work.

	Arnd
