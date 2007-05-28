Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:41305 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753488AbXE1OR5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2007 10:17:57 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070528100513.GC26046@flint.arm.linux.org.uk>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	 <20070527222408.GA26268@xi.wantstofly.org>
	 <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
	 <20070528100513.GC26046@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Mon, 28 May 2007 09:17:55 -0500
Message-Id: <1180361875.3689.3.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-05-28 at 11:05 +0100, Russell King wrote:
> On Sun, May 27, 2007 at 07:00:31PM -0500, James Bottomley wrote:
> > Ok, output on parisc is:
> > 
> > jejb@ioz:~$ ./a.out
> > firstfirstfirst
> > firstfirstfirst
> > secondsecondsec
> > 
> > Which is correct.  It remains correct even if I drop the msync().
> 
> With Lennert's new program, I get mostly:
> 
> firstfirstfirst
> firstfirstfirst
> firstfirstfirst
> 
> but occasionally:
> 
> firstfirstfirst
> firstfirstfirst
> secondsecondsec
> 
> However, if I open code the memcpy() in the MAPREAD to copy one word
> at a time, then I reliably get the "secondsecondsec" line.  But if I
> convert the memcpy() in MAPWRITE in the same way, I'm back to mostly
> getting the failure with the occasional success.  Utterly confused.
> 
> Unless someone's got a theory, I'm stumped.

I think you're not flushing correctly in munmap() ... but I'm not sure
the linux API actually requires this.

We *have* to do it this way on parisc.  In VIPT architectures, once
you've lost the mapping, there's no real way to flush the page (well,
except by setting up another congruent mapping pointing to the same
physical page) so we have to flush before it's torn down otherwise we'd
be at the mercy of cache eviction for coherency.  We do it in
tlb_start_vma().

James


