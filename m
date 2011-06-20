Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59928 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab1FTOk3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 10:40:29 -0400
Date: Mon, 20 Jun 2011 15:40:12 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 4/8] ARM: dma-mapping: implement dma sg methods on top
	of generic dma ops
Message-ID: <20110620144012.GE26089@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1308556213-24970-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>
Message-ID: <20110620144012.gcR7stJ0G4WiikAEWV4qQubAp7h1t7nIzKTgbv5PSdw@z>

On Mon, Jun 20, 2011 at 09:50:09AM +0200, Marek Szyprowski wrote:
> This patch converts all dma_sg methods to be generic (independent of the
> current DMA mapping implementation for ARM architecture). All dma sg
> operations are now implemented on top of respective
> dma_map_page/dma_sync_single_for* operations from dma_map_ops structure.

No.  We really don't want to do this.  If we want to move the dsb() out
of the mapping functions (which I have a patch for) to avoid doing a
dsb() on each and every sg segment, then we must not use the generic
stuff.
