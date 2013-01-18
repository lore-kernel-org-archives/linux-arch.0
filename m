From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 73/76] ARC: [Review] Multi-platform image #6: cpu-to-dma-addr optional
Date: Fri, 18 Jan 2013 15:07:32 +0000
Message-ID: <201301181507.33094.arnd@arndb.de>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358512827-7694-1-git-send-email-vgupta@synopsys.com> <1358512827-7694-2-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49684 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab3ARPHi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 10:07:38 -0500
In-Reply-To: <1358512827-7694-2-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013, Vineet Gupta wrote:
> All the current platforms can work with 0x8000_0000 based dma_addr_t
> since the Bus Bridges typically ignore the top bit (the only excpetion
> was Angel4 PCI-AHM bridge which we no longer care for).
> That way we don't need plat-specific cpu-addr to bus-addr conversion.
> 
> Hooks still provided - just in case a platform has an obscure device
> which say needs 0 based bus address.
> 
> That way <asm/dma_mapping.h> no longer needs to unconditinally include
> <plat/dma_addr.h>
> 
> Also verfied that on Angel4 board, other peripherals (IDE-disk / EMAC)
> work fine with 0x8000_0000 based dma addresses.
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
