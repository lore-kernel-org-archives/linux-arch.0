From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 24/40] metag: DMA
Date: Fri, 9 Nov 2012 14:25:13 +0000
Message-ID: <201211091425.13492.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-25-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52754 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877Ab2KIOZQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Nov 2012 09:25:16 -0500
In-Reply-To: <1351700061-7203-25-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org

On Wednesday 31 October 2012, James Hogan wrote:
> +static inline void
> +dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
> +                enum dma_data_direction direction)
> +{
> +       BUG_ON(!valid_dma_direction(direction));
> +       dma_sync_for_cpu((void *)bus_to_virt(dma_addr), size, direction);
> +}

bus_to_virt is deprecated an should not be visible to device drivers
any more for new stuff. Maybe you can remove the definition and introduce
a __bus_to_virt() function for internal use that also returns a pointer
type instead.

	Arnd
