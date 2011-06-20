Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37797 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab1FTPHB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 11:07:01 -0400
Date: Mon, 20 Jun 2011 16:06:10 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
	method to more generic alloc/free_attrs
Message-ID: <20110620150610.GG26089@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com> <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>
Message-ID: <20110620150610.3hT7JhHnhcABZQ9BUAhOfUMyX3VEAiy4NZIyID1090U@z>

On Mon, Jun 20, 2011 at 11:45:41PM +0900, KyongHo Cho wrote:
> I still don't agree with your idea that change alloc_coherent() with alloc().
> As I said before, we actually do not need dma_alloc_writecombine() anymore
> because it is not different from dma_alloc_coherent() in ARM.

Wrong - there is a difference.  For pre-ARMv6 CPUs, it returns memory
with different attributes from DMA coherent memory.

And we're not going to sweep away pre-ARMv6 CPUs any time soon.  So
you can't ignore dma_alloc_writecombine() which must remain to sanely
support framebuffers.
