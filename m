Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([205.233.218.70]:3474 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751277AbWEUP7z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 May 2006 11:59:55 -0400
Subject: Re: [PATCH] move scatterlist accessors into scatterlist.h on ia64,
	sh and sh64
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
References: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sun, 21 May 2006 16:59:38 +0100
Message-Id: <1148227178.3875.308.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, lethal@linux-sh.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-05-21 at 09:31 -0500, James Bottomley wrote:
> However, your accessor is:
> 
> #define sg_dma_address(sg)      (virt_to_bus((sg)->dma_address))
> 
> so you're calling virt_to_bus() on an already physical address.

It doesn't matter for kernel addresses on CPUs like SH and MIPS, because
it's just a mask anyway. There's a 1:1 mapping from virtual<->physical
addresses, and all you have to do to get a physical address is mask out
the top bits.

-- 
dwmw2

