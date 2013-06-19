From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dma-mapping: Add BUG_ON for uninitialized dma_ops
Date: Wed, 19 Jun 2013 17:20:46 +0200
Message-ID: <201306191720.47185.arnd@arndb.de>
References: <f35c5051a207b0a117f2fff27365d0ea892d1610.1370263476.git.michal.simek@xilinx.com> <201306141636.29390.arnd@arndb.de> <1371226483.2726.19.camel@dabdike>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56486 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756882Ab3FSPUz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Jun 2013 11:20:55 -0400
In-Reply-To: <1371226483.2726.19.camel@dabdike>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, Linux-Arch <linux-arch@vger.kernel.org>

On Friday 14 June 2013, James Bottomley wrote:
> This is the MMAP_PAGE_ZERO exploit.  The original exploit relied on a
> leaky personality capability clearing mask and was fixed in 2.6.31 by
> 
> commit f9fabcb58a6d26d6efde842d1703ac7cfa9427b6
> Author: Julien Tinnes <jt@cr0.org>
> Date:   Fri Jun 26 20:27:40 2009 +0200
> 
>     personality: fix PER_CLEAR_ON_SETID
> 
> So it's not really relevant to 3.x kernels, is it?

Probably not. There is always a risk that something like this
can turn into an exploit, but it needs a combination with a couple
of other bugs.

	Arnd
