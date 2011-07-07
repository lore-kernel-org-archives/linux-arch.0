Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw.wantstofly.org ([80.101.37.227]:51270 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755856Ab1GGMQY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2011 08:16:24 -0400
Date: Thu, 7 Jul 2011 14:09:18 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH 3/8] ARM: dma-mapping: use
 asm-generic/dma-mapping-common.h
Message-ID: <20110707120918.GF7810@wantstofly.org>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
 <201106241736.43576.arnd@arndb.de>
 <000601cc34c4$430f91f0$c92eb5d0$%szyprowski@samsung.com>
 <201106271519.43581.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106271519.43581.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>, 'Russell King - ARM Linux' <linux@arm.linux.org.uk>
Message-ID: <20110707120918.DmbEahADKiiTcUjN1Vc9HExvxpLyReT0p1WGHOtoIkg@z>

On Mon, Jun 27, 2011 at 03:19:43PM +0200, Arnd Bergmann wrote:

> > > I suppose for the majority of the cases, the overhead of the indirect
> > > function call is near-zero, compared to the overhead of the cache
> > > management operation, so it would only make a difference for coherent
> > > systems without an IOMMU. Do we care about micro-optimizing those?

FWIW, when I was hacking on ARM access point routing performance some
time ago, turning the L1/L2 cache maintenance operations into inline
functions (inlined into the ethernet driver) gave me a significant and
measurable performance boost.

Such things can remain product-specific hacks, though.


> > Even in coherent case, the overhead caused by additional function call
> > should have really negligible impact on drivers performance.
> 
> What about object code size? I guess since ixp23xx is the only platform
> that announces itself as coherent, we probably don't need to worry about
> it too much either. Lennert?

I don't think so.  ixp23xx isn't a very popular platform anymore either,
having been discontinued some time ago.


thanks,
Lennert
