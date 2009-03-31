Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:59861 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbZCaA0e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2009 20:26:34 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Removing __kernel_old_uid_t, git_t, dev_t
Date: Tue, 31 Mar 2009 02:26:26 +0200
References: <200903301558.10598.arnd@arndb.de> <200903301717.57184.arnd@arndb.de> <20090330.141156.62568451.davem@davemloft.net>
In-Reply-To: <20090330.141156.62568451.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200903310226.27480.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: geert.uytterhoeven@gmail.com, michal.simek@petalogix.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org
Message-ID: <20090331002626.oHvtIqhWyeH5ngRN2khiD-4P9cHIyL9-mAGvecP2mg0@z>

On Monday 30 March 2009, David Miller wrote:
> There is no reason to use anything larger than a 32-bit DMA address
> type on sparc64, and using 32-bit saves lots of space in many
> data structures so I am unlikely to ever change this. :-)

Ok, fair enough. So I'll change my asm-generic/types.h to use

#ifndef dma_addr_t
#ifdef CONFIG_PHYS_ADDR_T_64BIT
typedef u64 dma_addr_t;
#else
typedef u32 dma_addr_t;
#endif /* CONFIG_PHYS_ADDR_T_64BIT */
#endif /* dma_addr_t */

If you eventually want to use the the generic version, you
just need to add

#define dma_addr_t dma_addr_t

before the #include. Or you just ignore the asm-generic version
and don't have to do anything.

	Arnd <><
