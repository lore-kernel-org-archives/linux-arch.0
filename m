Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49179 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756051Ab1GGMiy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Jul 2011 08:38:54 -0400
Date: Thu, 7 Jul 2011 13:38:25 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/8] ARM: dma-mapping: use
	asm-generic/dma-mapping-common.h
Message-ID: <20110707123825.GO8286@n2100.arm.linux.org.uk>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com> <201106241736.43576.arnd@arndb.de> <000601cc34c4$430f91f0$c92eb5d0$%szyprowski@samsung.com> <201106271519.43581.arnd@arndb.de> <20110707120918.GF7810@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110707120918.GF7810@wantstofly.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Joerg Roedel' <joro@8bytes.org>
Message-ID: <20110707123825.8aCVKZpdSQGke3qj-pzRVOPQsVEKk7-zRktnzmLwd2A@z>

On Thu, Jul 07, 2011 at 02:09:18PM +0200, Lennert Buytenhek wrote:
> On Mon, Jun 27, 2011 at 03:19:43PM +0200, Arnd Bergmann wrote:
> 
> > > > I suppose for the majority of the cases, the overhead of the indirect
> > > > function call is near-zero, compared to the overhead of the cache
> > > > management operation, so it would only make a difference for coherent
> > > > systems without an IOMMU. Do we care about micro-optimizing those?
> 
> FWIW, when I was hacking on ARM access point routing performance some
> time ago, turning the L1/L2 cache maintenance operations into inline
> functions (inlined into the ethernet driver) gave me a significant and
> measurable performance boost.

On what architecture?  Can you show what you did to gain that?
