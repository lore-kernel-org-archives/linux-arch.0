Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:43109 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753305AbXE1AAe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2007 20:00:34 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070527222408.GA26268@xi.wantstofly.org>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	 <20070527222408.GA26268@xi.wantstofly.org>
Content-Type: text/plain
Date: Sun, 27 May 2007 19:00:31 -0500
Message-Id: <1180310431.3711.27.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, davej@codemonkey.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-05-28 at 00:24 +0200, Lennert Buytenhek wrote:
> On Sun, May 27, 2007 at 11:49:30AM +0100, Russell King wrote:
> 
> > So, if you have a cache which needs a flush_dcache_page()
> > implementation, can you please grab:
> > 
> >   http://www.wantstofly.org/~buytenh/cache-issue.c
> 
> Davide Libenzi pointed out that there is an error in this program,
> in that it doesn't lseek() back to the beginning of the file, so it
> ends up reading bytes 16-31 instead.  *blush*

Ah ... that explains why making the flush_dcache_page() unconditional
didn't fix the problem ...

> The program below accurately (AFAICT) reflects what fsx-linux does
> just before it dies in this testcase.  It write(2)s to a file, reads
> from the file via an mmap() region, read(2)s from the file, writes
> to the file via an mmap() region, and finally, read(2)s from the file
> again.  The last read(2) call returns the data written by the first
> write(2) call, and doesn't see the data written by the mmap() write,
> and so the last line of output is firstfirstfirst instead of the
> expected secondsecondsec.
> 
> fsx-linux does call msync(), but it calls it with a third argument
> of zero.  Changing the third msync() argument from 0 to MS_SYNC seems
> to make the issue disappear, which makes me suspect that fsx-linux's
> calling msync(pointer, size, 0); isn't guaranteed to be doing what it
> expects it to be doing.
> 
> If it _is_ in fact a bug in fsx, it would seem that most of the 2615
> fsx versions out there are affected.

Ok, output on parisc is:

jejb@ioz:~$ ./a.out
firstfirstfirst
firstfirstfirst
secondsecondsec

Which is correct.  It remains correct even if I drop the msync().

James


