From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCHv3 0/5] fix xfs by making I/O to vmap/vmalloc areas work
Date: Fri,  5 Feb 2010 09:50:52 -0600
Message-ID: <1265385057-2575-1-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52402 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab0BEPvF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 5 Feb 2010 10:51:05 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-parisc@vger.kernel.org, rmk@arm.linux.org.uk, lethal@linux-sh.org, torvalds@linux-foundation.org, hch@lst.de, James Bottomley <James.Bottomley@HansenPartnership.com>

From: James Bottomley <James.Bottomley@HansenPartnership.com>

This is essentially a small tidy up from the previous series.  I
thought about the Ben H additions, but since power doesn't seem to
need this, they seemed a bit moot (we can expand the API when an
actual user comes along).

The patch series adds a flush/invalidate_kernel_vmap_range() API that
drivers using vmap/vmalloc areas must use before sending tohse areas
for I/O.  This makes it crystal clear that coherence on these areas is
the responsibility of the driver alone.  Fortunately xfs is the only
thing in the kernel actually doing I/O to vmap areas.

Sin ce xfs is completely broken on most VIPT architectures without
this, I'd like to submit it as a bug fix for 2.6.33.  Unfortunately,
we actually have some parisc xfs users whose data is curently at
severe risk.

James

---

James Bottomley (5):
  mm: add coherence API for DMA to vmalloc/vmap areas
  parisc: add mm API for DMA to vmalloc/vmap areas
  arm: add mm API for DMA to vmalloc/vmap areas
  sh: add mm API for DMA to vmalloc/vmap areas
  xfs: fix xfs to work with Virtually Indexed architectures

 Documentation/cachetlb.txt           |   24 ++++++++++++++++++++++++
 arch/arm/include/asm/cacheflush.h    |   10 ++++++++++
 arch/parisc/include/asm/cacheflush.h |   12 ++++++++++++
 arch/sh/include/asm/cacheflush.h     |    8 ++++++++
 fs/xfs/linux-2.6/xfs_buf.c           |   30 +++++++++++++++++++++++++++++-
 include/linux/highmem.h              |    6 ++++++
 6 files changed, 89 insertions(+), 1 deletions(-)
