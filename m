Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26898 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261168AbUC1LgA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 28 Mar 2004 06:36:00 -0500
Date: Sun, 28 Mar 2004 12:35:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH: x86] Add dma_mmap_coherent()
Message-ID: <20040328123556.E2825@flint.arm.linux.org.uk>
References: <20040328112216.B2825@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040328112216.B2825@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Mar 28, 2004 at 11:22:16AM +0100
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
List-ID: <linux-arch.vger.kernel.org>

On Sun, Mar 28, 2004 at 11:22:16AM +0100, Russell King wrote:
> This has only been compile tested.  There are two changes here:
> 
> 1. ensure that we zero the whole page - otherwise we may expose leak
>    kernel data to userspace in the remainder of the last page.
> 2. add dma_mmap_coherent().  I've added checks for the offset and
>    size to ensure that we don't do anything silly (like mapping more
>    memory than the original coherent allocation covered.)  Maybe this
>    is something that remap_page_range() should be doing anyway?

Actually, there is a problem with this patch as it stands - get_free_pages
returns kernel pages, and remap_page_range() won't touch them without
the pages being marked reserved.  I'm also led to believe that splitting
a struct page up into is constituent struct pages is no longer valid, so
exactly how we do that is open to question.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
