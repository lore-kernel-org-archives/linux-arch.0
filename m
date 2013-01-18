From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 28/76] ARC: I/O and DMA Mappings
Date: Fri, 18 Jan 2013 15:55:43 +0000
Message-ID: <201301181555.43487.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-29-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:51751 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab3ARPzr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 10:55:47 -0500
In-Reply-To: <1358511930-7424-29-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> TBD: Do we need early ioremap support like openrisc
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Can you explain why early ioremap is necessary for you?

I wasn't aware that openrisc has it. In a lot of cases,
you can use fixmap as a replacement.

> +
> +#ifndef _ASM_ARC_IO_H
> +#define _ASM_ARC_IO_H
> +
> +#include <asm/byteorder.h>
> +#include <asm/page.h>
> +
> +extern void __iomem *ioremap(unsigned long physaddr, unsigned long size);
> +extern void iounmap(const void __iomem *addr);
> +
> +#define ioremap_nocache(phy, sz)	ioremap(phy, sz)
> +#define ioremap_wc(phy, sz)		ioremap(phy, sz)
> +
> +/* Change struct page to physical address */
> +#define page_to_phys(page)		(page_to_pfn(page) << PAGE_SHIFT)
> +
> +#include <asm-generic/io.h>

I think I commented before that asm-generic/io.h has a number of
problems and you should at least override the __raw_{read,write}{b,w,l,q}
functions with your own ones using inline assembly.

You should also define a non-NULL PCI_IOBASE.

	Arnd
