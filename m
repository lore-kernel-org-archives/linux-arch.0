From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [RFC PATCH] Update the cachetlb.txt file WRT flush_dcache_page
 and update_mmu_cache
Date: Tue, 11 May 2010 20:31:03 +0900
Message-ID: <20100511203024W.fujita.tomonori@lab.ntt.co.jp>
References: <20100507132418.28009.6013.stgit@e102109-lin.cambridge.arm.com>
	<20100510170616O.fujita.tomonori@lab.ntt.co.jp>
	<1273486607.3023.37.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:53360 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab0EKLby (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 11 May 2010 07:31:54 -0400
In-Reply-To: <1273486607.3023.37.camel@e102109-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com
Cc: fujita.tomonori@lab.ntt.co.jp, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com, benh@kernel.crashing.org, davem@davemloft.net, rmk@arm.linux.org.uk

On Mon, 10 May 2010 11:16:47 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> > I don't think that just replacing sparc64 with IA64 helps much here
> > since we still have the problem that the whole cache handling
> > (architectures, subsystems, file systems) is inconsistent. I think
> > that we need to agree on it first.
> 
> Yes, this need to be agreed and hopefully this thread is a starting
> point for such discussion.

Hopefully, but I'm not sure what we need to agree is clear enough.

If we invert the meaning of PG_arch_1 (from PG_dcache_dirty to
PG_dcache_clean) like the way IA64 and POWERPC to use the bit to solve
I/D coherency, we can avoid calling flush_dcache_page() at low level
drivers or their subsystems (ide_* macros, libata,
bio_flush_dcache_pages, rq_flush_dcache_pages, etc). Architectures
that need to handle D aliasing and I/D coherence need two bits
respectively (needs another PG_arch_2 bit) to do flushes effectively.

Right?
