From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 17:45:58 +0100
Message-ID: <200906011745.59793.arnd@arndb.de>
References: <200905282104.55818.arnd@arndb.de> <200906011111.28521.arnd@arndb.de> <4A23D2C7.6070400@petalogix.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59599 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbZFAQqO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 12:46:14 -0400
In-Reply-To: <4A23D2C7.6070400@petalogix.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michal.simek@petalogix.com
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, lethal@linux-sh.org, chris@zankel.net, John Williams <john.williams@petalogix.com>

On Monday 01 June 2009, Michal Simek wrote:

> Microblaze have it but it is not cleared(checked) and not in mainline -
> I want to look at it when mmu is in mainline.
> As I wrote before  you can use Microblaze as tested arch.

Ok. It should become really easy once the asm-generic version is there.
Do you know if all DMA capable devices on microblaze are coherent
(or if all of them are noncoherent)?

If it is indeed coherent, the below code should be enough, otherwise
you need to add some cache flushes in the functions below.

	Arnd <><

---
#ifndef _ASM_MICROBLAZE_DMA_MAPPING_H
#define _ASM_MICROBLAZE_DMA_MAPPING_H

static inline int
__dma_coherent_dev(struct device *dev)
{
	return 1;
}

static inline void
dma_cache_sync(struct device *dev, void *cpu_addr, size_t size,
	       enum dma_data_direction direction)
{
}

static inline int dma_get_cache_alignment(void)
{
	return 1 << L1_CACHE_SHIFT;
}

#include <asm-generic/dma-mapping-linear.h>

#endif _ASM_MICROBLAZE_DMA_MAPPING_H
