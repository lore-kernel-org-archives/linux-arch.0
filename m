From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: SMP barriers semantics
Date: Mon, 26 Apr 2010 10:21:21 +0100
Message-ID: <1272273681.11974.6.camel@e102109-lin.cambridge.arm.com>
References: <20100406142054.GE5288@laptop>
	 <1272039830.15107.76.camel@e102109-lin.cambridge.arm.com>
	 <20100423165628.GA15349@shareable.org>
	 <1272043500.15107.87.camel@e102109-lin.cambridge.arm.com>
	 <20100424014536.GD15349@shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:58904 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751010Ab0DZJZp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Apr 2010 05:25:45 -0400
In-Reply-To: <20100424014536.GD15349@shareable.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Nick Piggin <npiggin@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>, linux-arch@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>, Francois Romieu <romieu@fr.zoreil.com>

On Sat, 2010-04-24 at 02:45 +0100, Jamie Lokier wrote:
> Catalin Marinas wrote:
> > On recent ARM cores, it's only the Strongly Ordered memory that can have
> > the write buffering disabled. But using such mapping for
> > dma_alloc_coherent() introduces other problems like cache attribute
> > aliases for a physical location (since the kernel maps the RAM as Normal
> > memory already). Such aliases are not allowed hence we moved to Normal
> > Non-cacheable for dma_alloc_coherent().
> 
> I'm surprised aliases between Normal-Cached and Normal-Uncached are ok,
> while aliases between Normal-Cached and SO-Uncached are not ok.

In theory, all of the aliases are banned but the Normal cacheable vs
non-cacheable have been allowed in practice and current ARM
implementations can cope with it (such "palliative" measures have been
introduced in 2006). Other aliases aren't guaranteed to work correctly.

Normal Non-cacheable memory uses the write buffer (at both the CPU and
L2 cache level) while the Strongly Ordered doesn't. Normal memory
accesses on the same CPU check the write buffer as well since a CPU is
coherent with itself (on the D side).

-- 
Catalin
