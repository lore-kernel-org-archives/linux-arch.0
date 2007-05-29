Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:58796
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750888AbXE2F6d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 May 2007 01:58:33 -0400
Date: Mon, 28 May 2007 22:58:44 -0700 (PDT)
Message-Id: <20070528.225844.59466719.davem@davemloft.net>
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070528143936.GF31933@xi.wantstofly.org>
References: <20070528100513.GC26046@flint.arm.linux.org.uk>
	<1180361875.3689.3.camel@mulgrave.il.steeleye.com>
	<20070528143936.GF31933@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: buytenh@wantstofly.org
Cc: James.Bottomley@steeleye.com, rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, akpm@linux-foundation.org, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

From: Lennert Buytenhek <buytenh@wantstofly.org>
Date: Mon, 28 May 2007 16:39:36 +0200

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

You don't have to do it for all pages, you just have to do whatever
flush_dcache_page() would do, for dirty+shared+writable mmap()'s of
files.

unmap's of shared+writable regions of files are so rare, only test
programs and the odd database do it when they shut down.

