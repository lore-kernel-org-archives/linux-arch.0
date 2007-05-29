Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2643 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756041AbXE2ROJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2007 13:14:09 -0400
Date: Tue, 29 May 2007 18:13:57 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070529171357.GA18216@flint.arm.linux.org.uk>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <20070527222408.GA26268@xi.wantstofly.org> <1180310431.3711.27.camel@mulgrave.il.steeleye.com> <20070528100513.GC26046@flint.arm.linux.org.uk> <1180361875.3689.3.camel@mulgrave.il.steeleye.com> <20070528143936.GF31933@xi.wantstofly.org> <1180408018.3689.70.camel@mulgrave.il.steeleye.com> <20070529031523.GC529@xi.wantstofly.org> <1180449136.3700.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180449136.3700.6.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Tue, May 29, 2007 at 09:32:16AM -0500, James Bottomley wrote:
> I agree its likely a stale kernel cache ... but the symptoms could be
> dirty user cache as well ... I was just trying to verify beyond doubt
> that it's the former.

If that were true, with a VIVT cache you'd have userspace randomly
SEGVing since stale data would leak through when things get remapped
(eg, objects which are only loaded for a short time) etc.

That isn't the case.

> > Flushing the kernel direct mapping by unconditionally calling
> > flush_dcache_page() in do_generic_mapping_read() makes the issue go
> > away and makes fsx-linux happy.
> > 
> > Flushing the kernel direct mapping by forcibly context switching
> > between munmap() and read() (VIVT cache, context switch does full
> > cache flush+invalidate) makes the issue go away, too.  
> 
> I'm not that familiar with the mechanics of a VIVT cache.  If you unmap,
> and thus remove the page table entries, does that mean a dirty VIVT line
> at those entries gets discarded if the processor can't find a mapping?
> Or does the TLB pin entries for dirty cache lines until they're flushed?

We _always_ write out data from the cache for the range we're going to
unmap with VIVT.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
