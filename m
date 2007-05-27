Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hancock.steeleye.com ([71.30.118.248]:49058 "EHLO
	hancock.sc.steeleye.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753512AbXE0OQ1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2007 10:16:27 -0400
Subject: Re: [CFT] read+shared mmap write+read data corruption
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20070527104930.GB25023@flint.arm.linux.org.uk>
References: <20070527104930.GB25023@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Sun, 27 May 2007 09:16:24 -0500
Message-Id: <1180275384.3711.12.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Lennert Buytenhek <buytenh@wantstofly.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2007-05-27 at 11:49 +0100, Russell King wrote:
> Lennert Buytenhek recently reported on the linux-arm-kernel list that
> fsx-linux fails on his Xscale ARM platforms.  Originally, a problem was
> noticed with DB4 databases being corrupted.
> 
> After a little bit of digging, I found what appears to be a hole in
> the cache alias handling for the page cache; I'm not certain what the
> solution is at present [*].  However, I don't think this is an ARM
> specific issue.

Yes, I confirm seeing the same results on parisc (VIPT large caches).

> So, if you have a cache which needs a flush_dcache_page() implementation,
> can you please grab:
> 
>   http://www.wantstofly.org/~buytenh/cache-issue.c
> 
> Build this, and then run:
> 
> $ ./cache-issue | od -t x1 -Ax
> 
> If the output is a load of zero bytes instead of "0123456789abcdef" then
> the read after a shared mmap() write returned stale data.
> 
> Note: this program is much more likely to show the issue than fsx-linux -
> on my platforms, fsx-linux doesn't show any problems after several minutes
> of running, whereas Lennert's program shows a problem immediately.
> 
> Also note that our msync() syscall is a no-op; my original test was with
> a version of the above with msync(MS_INVALIDATE) in.

Regardless of how we implement it, the way I read POSIX, it does require
at least msync(x, 4096, MS_SYNC|MS_INVALIDATE) before accessing the data
in another way.

> * - the hole is:
> 
> void do_generic_mapping_read(struct address_space *mapping,
>                              struct file_ra_state *_ra,
>                              struct file *filp,
>                              loff_t *ppos,
>                              read_descriptor_t *desc,
>                              read_actor_t actor)
> {
> ...
>                 /* If users can be writing to this page using arbitrary
>                  * virtual addresses, take care about potential aliasing
>                  * before reading the page on the kernel side.
>                  */
>                 if (mapping_writably_mapped(mapping))
>                         flush_dcache_page(page);
> 
> is false for both read calls, since at the time this test is done, there
> are no shared writable mappings.  However, that's not to say that there
> haven't _been_ shared writable mappings.

The operation has to be done when we know the state of the object
(unless we want to persist the dirty state in a lazy fashion?  I think I
don't really want to go there) so that's either in msync or munmap.  I
think I favour the former.

James


