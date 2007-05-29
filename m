Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4919 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbXE2JND (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2007 05:13:03 -0400
Date: Tue, 29 May 2007 10:12:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070529091252.GA4832@flint.arm.linux.org.uk>
References: <20070527.160551.59654871.davem@davemloft.net> <1180312287.3711.32.camel@mulgrave.il.steeleye.com> <20070528124411.GA31764@xi.wantstofly.org> <20070528.223550.39158516.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070528.223550.39158516.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: buytenh@wantstofly.org, James.Bottomley@steeleye.com, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 28, 2007 at 10:35:50PM -0700, David Miller wrote:
> From: Lennert Buytenhek <buytenh@wantstofly.org>
> Date: Mon, 28 May 2007 14:44:11 +0200
> > As far as I understand it, the munmap() does flush out the copy of
> > the data at the user virtual address, but the subsequent read() call
> > reads from an address in the kernel direct mapped window, for which
> > there is still data in the cache due to the earlier read() syscall,
> > and the mapping_writably_mapped() test fails so we don't end up
> > calling flush_dcache_page().
> 
> That is what is happening for sure.
> 
> That mapping_writably_mapped() check depends upon munmap()
> flush out the lines from the cache on the user side at
> least enough to make them coherent on the kernel side.
> 
> As I said my flush_cache_range() on sparc64 used to do this,
> but I removed it for whatever reason, perhaps I did not
> consider this case back then.
> 
> I'm not advocating a full flush on flush_cache_range(), but rather to
> set a page state bit, which will force a flush on the
> "check_dcache_page()" call which we could replace this conditionalized
> flush_dcache_page() call with.

Could we have PG_arch_2 as bit 13 for this purpose, guaranteed to be
cleared on page cache page allocation?  IOW, same rules as far as the
non-arch code is concerned as PG_arch_1.

Such a bit could be set in tlb_remove_tlb_entry() rather than having to
walk the page tables twice (once in flush_cache_range and again in
zap_*_range) though I wonder if that's too late in zap_pte_range().
(Walking the page tables on flush_cache_range would be too disgusting;
I don't fancy coding page table walks in assembly for some subset of
ARM CPUs.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
