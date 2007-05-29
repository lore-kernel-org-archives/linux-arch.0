Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:51039 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395AbXE2DPZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 23:15:25 -0400
Date: Tue, 29 May 2007 05:15:23 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070529031523.GC529@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk> <20070527222408.GA26268@xi.wantstofly.org> <1180310431.3711.27.camel@mulgrave.il.steeleye.com> <20070528100513.GC26046@flint.arm.linux.org.uk> <1180361875.3689.3.camel@mulgrave.il.steeleye.com> <20070528143936.GF31933@xi.wantstofly.org> <1180408018.3689.70.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1180408018.3689.70.camel@mulgrave.il.steeleye.com>
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, May 28, 2007 at 10:06:58PM -0500, James Bottomley wrote:

> > > > > Ok, output on parisc is:
> > > > > 
> > > > > jejb@ioz:~$ ./a.out
> > > > > firstfirstfirst
> > > > > firstfirstfirst
> > > > > secondsecondsec
> > > > > 
> > > > > Which is correct.  It remains correct even if I drop the msync().
> > > > 
> > > > With Lennert's new program, I get mostly:
> > > > 
> > > > firstfirstfirst
> > > > firstfirstfirst
> > > > firstfirstfirst
> > > > 
> > > > but occasionally:
> > > > 
> > > > firstfirstfirst
> > > > firstfirstfirst
> > > > secondsecondsec
> > > > 
> > > > However, if I open code the memcpy() in the MAPREAD to copy one word
> > > > at a time, then I reliably get the "secondsecondsec" line.  But if I
> > > > convert the memcpy() in MAPWRITE in the same way, I'm back to mostly
> > > > getting the failure with the occasional success.  Utterly confused.
> > > > 
> > > > Unless someone's got a theory, I'm stumped.
> > > 
> > > I think you're not flushing correctly in munmap() ... but I'm not sure
> > > the linux API actually requires this.
> > 
> > Having to (conditionally) invalidate the kernel direct mapping for
> > every userland page we unmap would kind of suck..
> 
> Lets just verify it is a stale kernel mapping first.  Try this patch:
> it will cohere the kernel aliases but not the user ones,

Hmm.  I don't understand what you're saying.

By the time we call the final read(2) (which is what returns the
stale data), there _are_ no user mappings of the page in question.

Flushing the kernel direct mapping by unconditionally calling
flush_dcache_page() in do_generic_mapping_read() makes the issue go
away and makes fsx-linux happy.

Flushing the kernel direct mapping by forcibly context switching
between munmap() and read() (VIVT cache, context switch does full
cache flush+invalidate) makes the issue go away, too.  
