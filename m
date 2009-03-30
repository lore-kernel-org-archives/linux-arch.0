Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:51128 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbZC3PSO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2009 11:18:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Removing __kernel_old_uid_t, git_t, dev_t
Date: Mon, 30 Mar 2009 17:17:56 +0200
References: <49D071A8.4010703@petalogix.com> <200903301558.10598.arnd@arndb.de> <10f740e80903300741h387e6342veba0ccceea6714e9@mail.gmail.com>
In-Reply-To: <10f740e80903300741h387e6342veba0ccceea6714e9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200903301717.57184.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert.uytterhoeven@gmail.com>
Cc: michal.simek@petalogix.com, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, David Miller <davem@davemloft.net>
Message-ID: <20090330151756.0CaDj1B1wv9XMVIKkoJxme2GvHaEbC83vSRx4rE-EmI@z>

On Monday 30 March 2009, Geert Uytterhoeven wrote:
> On Mon, Mar 30, 2009 at 15:58, Arnd Bergmann <arnd@arndb.de> wrote:
> > +/*
> > + * int-ll64 is used on all 32 bit architectures and on x86-64,
> > + * so use it as a reasonable default.
> > + */
> > +#include <asm-generic/int-ll64.h>
> > +
> 
> Most 64-bit archs have been migrated to ll64 by now.
> Alpha, ia64, and mips64 are the remaining exceptions.

Right, the comment is stale.

> > +/*
> > + * DMA addresses may be larger than pointers, but not smaller.
> > + * Do not define the dma64_addr_t type, which never really
> > + * worked.
> > + */
> > +#if defined(CONFIG_64BIT) || defined(CONFIG_PHYS_64BIT)
> > +typedef u64 dma_addr_t;
> > +#else
> > +typedef u32 dma_addr_t;
> > +#endif /* 64 bit DMA pointer */
> 
> Is there any specific reason why dma_addr_t is in <asm/types.h>, while
> phys_addr_t is in
> <linux/types.h>?

dma_addr_t is a big mess that was traditionally defined per
architecture, in lots of wrong ways, including the misconception
of dma64_addr_t. Sparc64 still uses a 32 bit dma_addr_t, possibly
because it always uses an IOMMU (?). It can save some space in
scatterlists, but might come back to bite us if someone tries
to build a sparc64 system with actual 64-bit DMA.

phys_addr_t is a new definition that was added last August (after
I did my patch) by Jeremy Fitzhardinge and is for DMA purposes.

> Furthermore, CONFIG_PHYS_64BIT is used on PPC only. Probably it should be
> replaced by CONFIG_PHYS_ADDR_T_64BIT, which is always set if CONFIG_64BIT,
> so the #ifdef above becomes even simpler?

Yes, they could be consolidated now, which would make the default
dma_addr_t the same as phys_addr_t, with the possible exception of
sparc64.

	Arnd <><
