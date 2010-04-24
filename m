From: Jamie Lokier <jamie@shareable.org>
Subject: Re: SMP barriers semantics
Date: Sat, 24 Apr 2010 02:45:36 +0100
Message-ID: <20100424014536.GD15349@shareable.org>
References: <20100406142054.GE5288@laptop> <1272039830.15107.76.camel@e102109-lin.cambridge.arm.com> <20100423165628.GA15349@shareable.org> <1272043500.15107.87.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.shareable.org ([80.68.89.115]:50061 "EHLO
	mail2.shareable.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752394Ab0DXBpz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 23 Apr 2010 21:45:55 -0400
Content-Disposition: inline
In-Reply-To: <1272043500.15107.87.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nick Piggin <npiggin@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

Catalin Marinas wrote:
> On recent ARM cores, it's only the Strongly Ordered memory that can have
> the write buffering disabled. But using such mapping for
> dma_alloc_coherent() introduces other problems like cache attribute
> aliases for a physical location (since the kernel maps the RAM as Normal
> memory already). Such aliases are not allowed hence we moved to Normal
> Non-cacheable for dma_alloc_coherent().

I'm surprised aliases between Normal-Cached and Normal-Uncached are ok,
while aliases between Normal-Cached and SO-Uncached are not ok.

Is it theoretically ok by the ARM specs, or just optimistic programming? :-)

If optimism, it's easy to imagine an implementation where
(unrequested) speculative reads populate the cached mapping, and then
accesses to the Normal-Uncached alias of it get a cache hit and use
that, wrongly.  Or, conversely, if it definitely does not treat that
as a cache hit, it's hard to imagine why SO-Uncached would be different.

-- Jamie
