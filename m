Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2974 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755175AbXFKRiW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2007 13:38:22 -0400
Date: Mon, 11 Jun 2007 18:38:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [BUG] Fault handlers can deadlock
Message-ID: <20070611173815.GC16265@flint.arm.linux.org.uk>
References: <20070611160026.GA16265@flint.arm.linux.org.uk> <20070611094116.34e83ae6.akpm@linux-foundation.org> <20070611165322.GB16265@flint.arm.linux.org.uk> <20070611103142.a9e55928.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070611103142.a9e55928.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 11, 2007 at 10:31:42AM -0700, Andrew Morton wrote:
> The code is there to improve debuggability and for no other reason.  It is
> to fix the situation where the kernel references an invalida address while
> holding down_write(mmap_sem).  We used to take the fault and then deadlock
> on do_page_fault()'s down_read().  Now, we do the trylock and if that fails
> we chech that a) it was running kernel code and b) the kernel didn't expect
> a fault to occur at that EIP.  If both of those are true, go off and report
> the oops rather than deadlocking.
> 
> And I don't think I spot anything in either the ARM or i386 comments which
> contradicts that? 

No, I think ARM is right and there isn't a problem (apart from
ambiguous comments), provided people use a recent enough kernel.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
