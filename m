Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:37998 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751360AbXE1Ab3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2007 20:31:29 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070527.160551.59654871.davem@davemloft.net>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	 <1180275384.3711.12.camel@mulgrave.il.steeleye.com>
	 <20070527.160551.59654871.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 27 May 2007 19:31:27 -0500
Message-Id: <1180312287.3711.32.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, buytenh@wantstofly.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2007-05-27 at 16:05 -0700, David Miller wrote:
> From: James Bottomley <James.Bottomley@SteelEye.com>
> Date: Sun, 27 May 2007 09:16:24 -0500
> 
> > On Sun, 2007-05-27 at 11:49 +0100, Russell King wrote:
> > > So, if you have a cache which needs a flush_dcache_page() implementation,
> > > can you please grab:
> > > 
> > >   http://www.wantstofly.org/~buytenh/cache-issue.c
> > > 
> > > Build this, and then run:
> > > 
> > > $ ./cache-issue | od -t x1 -Ax
> > > 
> > > If the output is a load of zero bytes instead of "0123456789abcdef" then
> > > the read after a shared mmap() write returned stale data.
> > > 
> > > Note: this program is much more likely to show the issue than fsx-linux -
> > > on my platforms, fsx-linux doesn't show any problems after several minutes
> > > of running, whereas Lennert's program shows a problem immediately.
> > > 
> > > Also note that our msync() syscall is a no-op; my original test was with
> > > a version of the above with msync(MS_INVALIDATE) in.
> > 
> > Regardless of how we implement it, the way I read POSIX, it does require
> > at least msync(x, 4096, MS_SYNC|MS_INVALIDATE) before accessing the data
> > in another way.
> 
> I used to have code in flush_cache_range() on sparc64 that would
> have handled this case.
> 
> I think whatever in the world POSIX says, quality of implementation
> says we should not be returning zeros in this test program, yet we
> are. :-)

I wasn't advocating ... merely point out that POSIX gives us a get out
of jail free card.

> If we accept the msync() requirement (I don't think we should) then
> this is the kind of obscure thing that causes application programmers
> to scratch their heads for days if not weeks, and it will only anger
> and frustrate them further when we tell them they have to stick an
> msync() in there to see non-corrupt data.
> 
> Perhaps one way to catch this is to make the filemap read-page code
> unconditionally call a new interface "check_dcache_page()" or similar,
> instead of the guarded flush_dcache_page() call there now.
> 
> Then on unmap's of SHARED+WRITABLE mappings of files, we mark
> or flush dirty pages as is appropriate for however the platform
> handles D-cache aliasing.
> 
> On sparc64 for example, I'd set PG_arch_1 and record the cpu in
> page->flags if PG_arch_1 wasn't already set, else I'd flush.
> 
> Then I'd have check_dcache_page() do something like:
> 
> 	if (PG_arch_1 || shared_writable_mappings_exist)
> 		flush();

Actually, I'm not convinced we have a problem ... if I put an lseek back
to zero in the original program, it works on parisc as well.  On munmap
we do a flush_cache_range for the unmapped vmas ... we have to,
otherwise the data might be lost as the user mapping is zapped and we
wouldn't be able to guarantee coherency writing it to the backing store.

James




