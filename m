From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 0/6] fix xfs by making I/O to vmap/vmalloc areas work
Date: Tue, 17 Nov 2009 11:03:46 -0600
Message-ID: <1258477432-2513-1-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-parisc-owner@vger.kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: James Bottomley <James.Bottomley@suse.de>
List-Id: linux-arch.vger.kernel.org

Here's version three of the patch.  This one makes sure the invalidate
works correctly.  I verified it on parisc by making my system print out
the virtual addresses it was invalidating and matching up with the ones
that were initially flushed, but since invalidate is a nop on parisc, I
can't verify live that the issue is fixed.  I'd really appreciate someone
from arm and sh testing here.

Thanks,

James

---

James Bottomley (6):
  mm: add coherence API for DMA to vmalloc/vmap areas
  parisc: add mm API for DMA to vmalloc/vmap areas
  arm: add mm API for DMA to vmalloc/vmap areas
  sh: add mm API for DMA to vmalloc/vmap areas
  block: permit I/O to vmalloc/vmap kernel pages
  xfs: fix xfs to work with Virtually Indexed architectures

 arch/arm/include/asm/cacheflush.h    |   10 ++++++++++
 arch/parisc/include/asm/cacheflush.h |    8 ++++++++
 arch/sh/include/asm/cacheflush.h     |    8 ++++++++
 fs/bio.c                             |   20 ++++++++++++++++++--
 fs/xfs/linux-2.6/xfs_buf.c           |   20 ++++++++++++++++++++
 include/linux/highmem.h              |    6 ++++++
 6 files changed, 70 insertions(+), 2 deletions(-)

