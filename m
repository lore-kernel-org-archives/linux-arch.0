From: James Bottomley <James.Bottomley@suse.de>
Subject: xfs failure on parisc (and presumably other VI cache systems)
 caused by I/O to vmalloc/vmap areas
Date: Tue, 08 Sep 2009 13:27:49 -0500
Message-ID: <1252434469.13003.3.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38592 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751362AbZIHS1x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 8 Sep 2009 14:27:53 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Parisc List <linux-parisc@vger.kernel.org>, Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>, linux-arch@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>

This bug was observed on parisc, but I would expect it to affect all
architectures with virtually indexed caches.

The inception of this problem is the changes we made to block and SCSI
to eliminate the special case path for kernel buffers.  This change
forced every I/O to go via the full scatter gather processing.  In this
way we thought we'd removed the restrictions about using vmalloc/vmap
areas for I/O from the kernel. XFS acually took advantage of this, hence
the problems.

Actually, if you look at the implementation of blk_rq_map_kern(), it
still won't accept vmalloc pages on most architectures because
virt_to_page() assumes an offset mapped page ... x86 actually has a bug
on for the vmalloc case if you enable DEBUG_VIRTUAL).  The only reason
xfs gets away with this is because it builds the vmalloc'd bio manually,
essentially open coding blk_rq_map_kern().

The problem comes because by the time we get to map scatter gather
lists, all we have is the page, we've lost the virtual address.  There's
a macro: sg_virt() which claims to recover the virtual address, but all
it really does is provide the offset map of the page physical address.
This means that sg_virt() returns a different address from the one the
page was actually used by if it's in a vmalloc/vmap area (because we
remapped the page within the kernel virtual address space).  This means
that for virtually indexed caches, we end up flushing the wrong page
alias ... and hence corrupting data because we do DMA with a possibly
dirty cache line set above the page.

The generic fix is simple:  flush the potentially dirty page along the
correct cache alias before feeding it into the block routines and losing
the alias address information.

The slight problem is that we don't have an API to handle this ...
flush_kernel_dcache_page() would be the correct one except that it only
takes a page as the argument, not the virtual address.  So, I propose as
part of this change to introduce a new API:  flush_kernel_dcache_addr()
which performs exactly the same as flush_kernel_dcache_page except that
it flushes through the provided virtual address (whether offset mapped
or mapped via vmalloc/vmap).

I'll send out the patch series as a reply to this email.

James
