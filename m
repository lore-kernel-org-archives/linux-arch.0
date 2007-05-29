Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:37601 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752017AbXE2DHC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 23:07:02 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070528143936.GF31933@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	 <20070527222408.GA26268@xi.wantstofly.org>
	 <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
	 <20070528100513.GC26046@flint.arm.linux.org.uk>
	 <1180361875.3689.3.camel@mulgrave.il.steeleye.com>
	 <20070528143936.GF31933@xi.wantstofly.org>
Content-Type: text/plain
Date: Mon, 28 May 2007 22:06:58 -0500
Message-Id: <1180408018.3689.70.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-05-28 at 16:39 +0200, Lennert Buytenhek wrote:
> On Mon, May 28, 2007 at 09:17:55AM -0500, James Bottomley wrote:
> 
> > > > Ok, output on parisc is:
> > > > 
> > > > jejb@ioz:~$ ./a.out
> > > > firstfirstfirst
> > > > firstfirstfirst
> > > > secondsecondsec
> > > > 
> > > > Which is correct.  It remains correct even if I drop the msync().
> > > 
> > > With Lennert's new program, I get mostly:
> > > 
> > > firstfirstfirst
> > > firstfirstfirst
> > > firstfirstfirst
> > > 
> > > but occasionally:
> > > 
> > > firstfirstfirst
> > > firstfirstfirst
> > > secondsecondsec
> > > 
> > > However, if I open code the memcpy() in the MAPREAD to copy one word
> > > at a time, then I reliably get the "secondsecondsec" line.  But if I
> > > convert the memcpy() in MAPWRITE in the same way, I'm back to mostly
> > > getting the failure with the occasional success.  Utterly confused.
> > > 
> > > Unless someone's got a theory, I'm stumped.
> > 
> > I think you're not flushing correctly in munmap() ... but I'm not sure
> > the linux API actually requires this.
> 
> Having to (conditionally) invalidate the kernel direct mapping for
> every userland page we unmap would kind of suck..

Lets just verify it is a stale kernel mapping first.  Try this patch: it
will cohere the kernel aliases but not the user ones, so if the problem
goes away its definitely a stale kernel alias rather than a dirty user
one.  Actually, I can't find a patch ... what I want is a
flush_kernel_dcache_page() before

		if (mapping_writably_mapped(mapping))
			flush_dcache_page(page);

But arm doesn't seem to implement the API ... you must have some
equivalent, though, if you can find it ... I think it's

 __cpuc_coherent_kern_range(lowmem_page_address(page), lowmem_page_address(page)+PAGE_SIZE);

But I'm not an arm expert.

James


