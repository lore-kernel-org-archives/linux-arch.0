Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25875 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261292AbUC1NTk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 08:19:40 -0500
Date: Sun, 28 Mar 2004 14:19:34 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH: x86] Add dma_mmap_coherent()
Message-ID: <20040328141934.A10358@flint.arm.linux.org.uk>
References: <20040328112216.B2825@flint.arm.linux.org.uk> <20040328123556.E2825@flint.arm.linux.org.uk> <20040328114047.GO791@holomorphy.com> <20040328133633.F2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328133633.F2825@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Mar 28, 2004 at 01:36:33PM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 28, 2004 at 01:36:33PM +0100, Russell King wrote:
> On Sun, Mar 28, 2004 at 03:40:47AM -0800, William Lee Irwin III wrote:
> > I think we're just missing an API for it e.g. break_compound_page();
> > I don't see why we shouldn't arrange for it. Alternatively, clearing
> > PG_compound by hand is possible. Though I guess it raises the question
> > of what we're trying to do; e.g. why not allocate pieces separately?
> 
> dma_alloc_coherent() is supposed to allocate a contiguous memory area.
> 
> However, x86 can get around this problem if it uses the ->nopage
> method of mapping the pages into memory.
> 
> This all brings up one fundamental question: what really are the
> semantics of dma_alloc_coherent() - if it returns a kernel direct
> mapped address, are the pages supposed to be marked reserved or not.
> 
> And this leads on to this question: if the pages are not marked
> reserved, how do we mmap() the pages given that remap_page_range()
> won't touch them?

Furthermore, should these pages contribute to the processes RSS?
If pages are faulted in via ->nopage, and the pages are not marked
reserved, they will contribute to the RSS.  I suspect that reviewing
existing implementations will reveal some which do and some which
don't - certainly ALSA marks pages reserved, and thus does not
contribute to RSS.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
