Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266310AbUHGHGJ@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:58037 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266290AbUHGHGI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 7 Aug 2004 03:06:08 -0400
Date: Sat, 7 Aug 2004 00:05:29 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: copy_page_range()
Message-Id: <20040807000529.5ca6e8fe.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: torvalds@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Every couple months I look at this thing.

The main issue is that it's very cache unfriendly,
especially with how sparsely populated the page tables
are for 64-bit processes.

As a simple example, it's at the top of the kernel
profile for 64-bit lat_proc {fork,exec,shell} on
sparc64.

And it's in fact the pmd array scans that take all
of the cache misses, and thus most of the run time.

An idea I've always been entertaining is to associate
a bitmask with each pmd table.  For example, a possible
current implementation could be to abuse page_struct->index
for this bitmask, and use virt_to_page(pmdp)->index to get
at it.

This divides the pmd table into BITS_PER_LONG sections.
If the bit is set in ->index then we populated at least
one of the pmd entries in that section.  We never clear
bits, except at pmd table allocation time.

Then the pmd scan iterates over ->index, and only actually
dereferences the pmd entries iff it finds a set bit, and
it only dereferences the section of pmd entries represented
by that bit.

Another idea I've also considered is to implement the
pgd/pmd levels as a more compact tree, based upon virtual
address, such as a radix tree.

I think all of this could be experimented with if we
abstracted out the pmd/pgd/pte iteration.  So much stuff
in the kernel mm code is of the form:

	for_each_pgd(pgdp)
		for_each_pmd(pgdp, pmdp)
			for_each_pte(pmdp, ptep)
				do_something(ptep)

At 2-levels, as on most of the 32-bit platforms, things
aren't so bad.

Comments?
