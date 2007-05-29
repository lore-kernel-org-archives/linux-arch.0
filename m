Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:50373 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751578AbXE2OcS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 29 May 2007 10:32:18 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070529031523.GC529@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	 <20070527222408.GA26268@xi.wantstofly.org>
	 <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
	 <20070528100513.GC26046@flint.arm.linux.org.uk>
	 <1180361875.3689.3.camel@mulgrave.il.steeleye.com>
	 <20070528143936.GF31933@xi.wantstofly.org>
	 <1180408018.3689.70.camel@mulgrave.il.steeleye.com>
	 <20070529031523.GC529@xi.wantstofly.org>
Content-Type: text/plain
Date: Tue, 29 May 2007 09:32:16 -0500
Message-Id: <1180449136.3700.6.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2007-05-29 at 05:15 +0200, Lennert Buytenhek wrote:
> On Mon, May 28, 2007 at 10:06:58PM -0500, James Bottomley wrote:
> > > Having to (conditionally) invalidate the kernel direct mapping for
> > > every userland page we unmap would kind of suck..
> > 
> > Lets just verify it is a stale kernel mapping first.  Try this patch:
> > it will cohere the kernel aliases but not the user ones,
> 
> Hmm.  I don't understand what you're saying.

I agree its likely a stale kernel cache ... but the symptoms could be
dirty user cache as well ... I was just trying to verify beyond doubt
that it's the former.

> By the time we call the final read(2) (which is what returns the
> stale data), there _are_ no user mappings of the page in question.

> Flushing the kernel direct mapping by unconditionally calling
> flush_dcache_page() in do_generic_mapping_read() makes the issue go
> away and makes fsx-linux happy.
> 
> Flushing the kernel direct mapping by forcibly context switching
> between munmap() and read() (VIVT cache, context switch does full
> cache flush+invalidate) makes the issue go away, too.  

I'm not that familiar with the mechanics of a VIVT cache.  If you unmap,
and thus remove the page table entries, does that mean a dirty VIVT line
at those entries gets discarded if the processor can't find a mapping?
Or does the TLB pin entries for dirty cache lines until they're flushed?

James


