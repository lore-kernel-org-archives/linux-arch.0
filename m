Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55176
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752104AbXE0XFp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 May 2007 19:05:45 -0400
Date: Sun, 27 May 2007 16:05:51 -0700 (PDT)
Message-Id: <20070527.160551.59654871.davem@davemloft.net>
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: David Miller <davem@davemloft.net>
In-Reply-To: <1180275384.3711.12.camel@mulgrave.il.steeleye.com>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
	<1180275384.3711.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James.Bottomley@steeleye.com
Cc: rmk@arm.linux.org.uk, linux-arch@vger.kernel.org, buytenh@wantstofly.org, akpm@linux-foundation.org
List-ID: <linux-arch.vger.kernel.org>

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sun, 27 May 2007 09:16:24 -0500

> On Sun, 2007-05-27 at 11:49 +0100, Russell King wrote:
> > So, if you have a cache which needs a flush_dcache_page() implementation,
> > can you please grab:
> > 
> >   http://www.wantstofly.org/~buytenh/cache-issue.c
> > 
> > Build this, and then run:
> > 
> > $ ./cache-issue | od -t x1 -Ax
> > 
> > If the output is a load of zero bytes instead of "0123456789abcdef" then
> > the read after a shared mmap() write returned stale data.
> > 
> > Note: this program is much more likely to show the issue than fsx-linux -
> > on my platforms, fsx-linux doesn't show any problems after several minutes
> > of running, whereas Lennert's program shows a problem immediately.
> > 
> > Also note that our msync() syscall is a no-op; my original test was with
> > a version of the above with msync(MS_INVALIDATE) in.
> 
> Regardless of how we implement it, the way I read POSIX, it does require
> at least msync(x, 4096, MS_SYNC|MS_INVALIDATE) before accessing the data
> in another way.

I used to have code in flush_cache_range() on sparc64 that would
have handled this case.

I think whatever in the world POSIX says, quality of implementation
says we should not be returning zeros in this test program, yet we
are. :-)

If we accept the msync() requirement (I don't think we should) then
this is the kind of obscure thing that causes application programmers
to scratch their heads for days if not weeks, and it will only anger
and frustrate them further when we tell them they have to stick an
msync() in there to see non-corrupt data.

Perhaps one way to catch this is to make the filemap read-page code
unconditionally call a new interface "check_dcache_page()" or similar,
instead of the guarded flush_dcache_page() call there now.

Then on unmap's of SHARED+WRITABLE mappings of files, we mark
or flush dirty pages as is appropriate for however the platform
handles D-cache aliasing.

On sparc64 for example, I'd set PG_arch_1 and record the cpu in
page->flags if PG_arch_1 wasn't already set, else I'd flush.

Then I'd have check_dcache_page() do something like:

	if (PG_arch_1 || shared_writable_mappings_exist)
		flush();
