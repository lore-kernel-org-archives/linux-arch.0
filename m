Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4342 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbXE0Kth (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2007 06:49:37 -0400
Date: Sun, 27 May 2007 11:49:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: [CFT] read+shared mmap write+read data corruption
Message-ID: <20070527104930.GB25023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: Lennert Buytenhek <buytenh@wantstofly.org>, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

Lennert Buytenhek recently reported on the linux-arm-kernel list that
fsx-linux fails on his Xscale ARM platforms.  Originally, a problem was
noticed with DB4 databases being corrupted.

After a little bit of digging, I found what appears to be a hole in
the cache alias handling for the page cache; I'm not certain what the
solution is at present [*].  However, I don't think this is an ARM
specific issue.

So, if you have a cache which needs a flush_dcache_page() implementation,
can you please grab:

  http://www.wantstofly.org/~buytenh/cache-issue.c

Build this, and then run:

$ ./cache-issue | od -t x1 -Ax

If the output is a load of zero bytes instead of "0123456789abcdef" then
the read after a shared mmap() write returned stale data.

Note: this program is much more likely to show the issue than fsx-linux -
on my platforms, fsx-linux doesn't show any problems after several minutes
of running, whereas Lennert's program shows a problem immediately.

Also note that our msync() syscall is a no-op; my original test was with
a version of the above with msync(MS_INVALIDATE) in.

* - the hole is:

void do_generic_mapping_read(struct address_space *mapping,
                             struct file_ra_state *_ra,
                             struct file *filp,
                             loff_t *ppos,
                             read_descriptor_t *desc,
                             read_actor_t actor)
{
...
                /* If users can be writing to this page using arbitrary
                 * virtual addresses, take care about potential aliasing
                 * before reading the page on the kernel side.
                 */
                if (mapping_writably_mapped(mapping))
                        flush_dcache_page(page);

is false for both read calls, since at the time this test is done, there
are no shared writable mappings.  However, that's not to say that there
haven't _been_ shared writable mappings.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
