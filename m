Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:35221 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261203AbUC1Lks (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 06:40:48 -0500
Date: Sun, 28 Mar 2004 03:40:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH: x86] Add dma_mmap_coherent()
Message-ID: <20040328114047.GO791@holomorphy.com>
References: <20040328112216.B2825@flint.arm.linux.org.uk> <20040328123556.E2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328123556.E2825@flint.arm.linux.org.uk>
To: linux-arch@vger.kernel.org
Cc: rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 28, 2004 at 11:22:16AM +0100, Russell King wrote:
>> This has only been compile tested.  There are two changes here:
>> 1. ensure that we zero the whole page - otherwise we may expose leak
>>    kernel data to userspace in the remainder of the last page.
>> 2. add dma_mmap_coherent().  I've added checks for the offset and
>>    size to ensure that we don't do anything silly (like mapping more
>>    memory than the original coherent allocation covered.)  Maybe this
>>    is something that remap_page_range() should be doing anyway?

On Sun, Mar 28, 2004 at 12:35:56PM +0100, Russell King wrote:
> Actually, there is a problem with this patch as it stands - get_free_pages
> returns kernel pages, and remap_page_range() won't touch them without
> the pages being marked reserved.  I'm also led to believe that splitting
> a struct page up into is constituent struct pages is no longer valid, so
> exactly how we do that is open to question.

I think we're just missing an API for it e.g. break_compound_page();
I don't see why we shouldn't arrange for it. Alternatively, clearing
PG_compound by hand is possible. Though I guess it raises the question
of what we're trying to do; e.g. why not allocate pieces separately?


-- wli
