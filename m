Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268031AbUIIV5e@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55562 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266196AbUIIV4w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 17:56:52 -0400
Date: Thu, 9 Sep 2004 22:56:43 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: [RFC] flush_cache_page in kernel/ptrace.c
Message-ID: <20040909225643.G6434@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King <rmk@arm.linux.org.uk>
To: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

Hi,

(This has turned into something of a rambling message, sorry.)

I'm presently looking at sorting out cache issues on ARM VIPT aliasing
caches, and I'm concerned with the above usage of flush_cache_page().

At present, flush_cache_page() is used to handle the case where we
unmap a page or alter the page permissions on the target page with
one exception - access_process_vm().  Based upon the former, the
decision to implement this function is:

	do we need to flush the cache when we unmap or change
	the mapping permissions?

However, access_process_vm() also includes into this:

	or we need to ensure cache coherency between the kernel
	and user space mapping of this page.

I argue that the use of flush_cache_page() here in the generic
code is wrong, and if an architecture wishes to use it for this
purpose, it should do so within it's architecture private
implementation of copy_to_user_page() and copy_from_user_page().

Further, I wish to question why access_process_vm() is different
from the case where a user binary has a shared file mmapping and
another process writes data into that file.  In this case we
make no attempt to call flush_cache_page() prior to writing the
page cache page, yet we do ultimately expect the same behaviour.


As for why... In the case of kernel/ptrace.c, the VIPT cache I'm
looking at would need:

- flush_cache_page would have to set up a temporary mapping of
  the same cache colour as the user mapping of the page, then
  flush the cache line entries in that user coherent mapping,
  and tear it down.

- copy_*_user_page() reads/writes the kernel mapping, and then
  uses flush_dcache_page() to ensure coherency

- flush_dcache_page() then flushes the kernel mapping, and then
  tries to find a user space mapping of the page, or will setup
  it's own mapping and flush that.

IOW, flush_cache_page() and flush_dcache_page() are both grossly
inefficient and overhanded for what needs to be done here, which
can be done far more effectively inside an appropriate
copy_*_user_page() implementation:

- map the page at an user coherent mapping
- flush cache lines for the affected region in the user coherent
  and kernel mappings
- copy data to/from kernel mapping and, if copy_to_user_page,
  ensure it's written back
- tear down user coherent mapping


Rambling on a bit, what this then gives me is a sane and clean
usage model for flush_cache_page().  At this point, all users
of flush_cache_page() have the PFN for the page to be flushed
readily available.

Why is this important?  Because on ARM VIPT caches, to be able
to flush cache lines, we need to have a mapping setup which
corresponds to the cache colour of the desired lines to be
flushed - which in turn means that flush_cache_page() may need
to create its own mapping, especially if it's being asked to
operate on a page outside our currently visible MM space.

Why can't the page tables be walked to obtain this information?
Check out pte_offset_map() / pte_offset_map_nested() - it would
be a violation of the semantics of these to call either inside
flush_dcache_page().

Comments?


(And am I hating these aliasing VIPT writeback caches yet?  Most
 certainly I am.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
