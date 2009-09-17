Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:40290 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbZIQXHM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Sep 2009 19:07:12 -0400
From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 0/6] fix xfs by making I/O to vmap/vmalloc areas work
Date: Thu, 17 Sep 2009 18:06:55 -0500
Message-ID: <1253228821-4700-1-git-send-email-James.Bottomley@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@HansenPartnership.com>
Message-ID: <20090917230655.Ugm7PWHFjAQew5KDb_Pffne7K2bzJi2yn_pRQejkuaI@z>

From: James Bottomley <James.Bottomley@HansenPartnership.com>

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

