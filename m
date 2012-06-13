Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:58907 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980Ab2FMSvU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Jun 2012 14:51:20 -0400
Received: by wibhj8 with SMTP id hj8so5616864wib.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Jun 2012 11:51:19 -0700 (PDT)
Date: Wed, 13 Jun 2012 20:52:51 +0200
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Linaro-mm-sig] [PATCHv2 3/6] common: dma-mapping: introduce
 dma_get_sgtable() function
Message-ID: <20120613185251.GN4829@phenom.ffwll.local>
References: <1339588218-24398-1-git-send-email-m.szyprowski@samsung.com>
 <1339588218-24398-4-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339588218-24398-4-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Abhinav Kochhar <abhinav.k@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kyungmin Park <kyungmin.park@samsung.com>, Subash Patel <subash.ramaswamy@linaro.org>
Message-ID: <20120613185251.y68oqpEYjeXlqh6RTPloDppqOq1-6VzLophf2uJwboE@z>

On Wed, Jun 13, 2012 at 01:50:15PM +0200, Marek Szyprowski wrote:
> This patch adds dma_get_sgtable() function which is required to let
> drivers to share the buffers allocated by DMA-mapping subsystem. Right
> now the driver gets a dma address of the allocated buffer and the kernel
> virtual mapping for it. If it wants to share it with other device (= map
> into its dma address space) it usually hacks around kernel virtual
> addresses to get pointers to pages or assumes that both devices share
> the DMA address space. Both solutions are just hacks for the special
> cases, which should be avoided in the final version of buffer sharing.
> 
> To solve this issue in a generic way, a new call to DMA mapping has been
> introduced - dma_get_sgtable(). It allocates a scatter-list which
> describes the allocated buffer and lets the driver(s) to use it with
> other device(s) by calling dma_map_sg() on it.
> 
> This patch provides a generic implementation based on virt_to_page()
> call. Architectures which require more sophisticated translation might
> provide their own get_sgtable() methods.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
-- 
Daniel Vetter
Mail: daniel@ffwll.ch
Mobile: +41 (0)79 365 57 48
