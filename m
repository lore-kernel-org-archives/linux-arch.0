From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv2 0/5] fix xfs by making I/O to vmap/vmalloc areas work
Date: Wed, 23 Dec 2009 15:22:20 -0600
Message-ID: <1261603345-2494-1-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58579 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757249AbZLWVWt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Dec 2009 16:22:49 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Russell King <rmk@arm.linux.org.uk>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <jejb@external.hp.com>

From: James Bottomley <jejb@external.hp.com>

After looking through all the feedback, here's the next version of the
patch.

This one is based on a new api: flush/invalidate_kernel_vmap_range()
making it clear that the fs/driver is the entity managing the vmaps
... it also drops the block inputs because coherency management is now
the responsibility of the user.  The xfs interface is nicely
simplified with this approach.  Could someone check this on arm and
sh?

Thanks,

James

---

James Bottomley (5):
  mm: add coherence API for DMA to vmalloc/vmap areas
  parisc: add mm API for DMA to vmalloc/vmap areas
  arm: add mm API for DMA to vmalloc/vmap areas
  sh: add mm API for DMA to vmalloc/vmap areas
  xfs: fix xfs to work with Virtually Indexed architectures

 Documentation/cachetlb.txt           |   27 +++++++++++++++++++++++++++
 arch/arm/include/asm/cacheflush.h    |   10 ++++++++++
 arch/parisc/include/asm/cacheflush.h |   12 ++++++++++++
 arch/sh/include/asm/cacheflush.h     |    8 ++++++++
 fs/xfs/linux-2.6/xfs_buf.c           |   20 +++++++++++++++++++-
 include/linux/highmem.h              |    6 ++++++
 6 files changed, 82 insertions(+), 1 deletions(-)
