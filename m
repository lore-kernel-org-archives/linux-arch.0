From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: add dma-mapping-linear.h
Date: Mon, 1 Jun 2009 11:48:34 +0100
Message-ID: <200906011148.35592.arnd@arndb.de>
References: <200905282104.55818.arnd@arndb.de> <200906011128.10670.arnd@arndb.de> <20090601104353.GA25391@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:60536 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756162AbZFAKsp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Jun 2009 06:48:45 -0400
In-Reply-To: <20090601104353.GA25391@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 01 June 2009, Russell King wrote:
> 
> Err - there's only one highmem implementation on ARM.

Sorry for not being clear enough, I meant three implementations of
page_to_dma(), depending on highmem and platform:

	return (dma_addr_t)__virt_to_bus((unsigned long)page_address(page));
	return (dma_addr_t)__pfn_to_bus(page_to_pfn(page));
	return __arch_page_to_dma(dev, page);

The generic code right now does the first, which won't work with highmem
and also won't handle platform specific requirements that are not present
on the other architectures.

	Arnd <><
