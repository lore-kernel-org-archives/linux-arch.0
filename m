Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:46741 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261292AbUC1Mv7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 07:51:59 -0500
Date: Sun, 28 Mar 2004 04:51:59 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH: x86] Add dma_mmap_coherent()
Message-ID: <20040328125159.GQ791@holomorphy.com>
References: <20040328112216.B2825@flint.arm.linux.org.uk> <20040328123556.E2825@flint.arm.linux.org.uk> <20040328114047.GO791@holomorphy.com> <20040328133633.F2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328133633.F2825@flint.arm.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 28, 2004 at 03:40:47AM -0800, William Lee Irwin III wrote:
>> I think we're just missing an API for it e.g. break_compound_page();
>> I don't see why we shouldn't arrange for it. Alternatively, clearing
>> PG_compound by hand is possible. Though I guess it raises the question
>> of what we're trying to do; e.g. why not allocate pieces separately?

On Sun, Mar 28, 2004 at 01:36:33PM +0100, Russell King wrote:
> dma_alloc_coherent() is supposed to allocate a contiguous memory area.
> However, x86 can get around this problem if it uses the ->nopage
> method of mapping the pages into memory.
> This all brings up one fundamental question: what really are the
> semantics of dma_alloc_coherent() - if it returns a kernel direct
> mapped address, are the pages supposed to be marked reserved or not.
> And this leads on to this question: if the pages are not marked
> reserved, how do we mmap() the pages given that remap_page_range()
> won't touch them?

There isn't really an API for mapping discontiguous physical memory any
higher-level than pagetable etc. manipulations. Maybe it's supposed to
do that internally when remap_page_range() doesn't suffice.


-- wli
