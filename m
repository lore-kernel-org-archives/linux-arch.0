From: James Bottomley <James.Bottomley@suse.de>
Subject: [PATCH 0/6] fix xfs by making I/O to vmap/vmalloc areas work
Date: Wed,  9 Sep 2009 10:52:10 -0500
Message-ID: <1252511536-22066-1-git-send-email-James.Bottomley@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47981 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752261AbZIIPw2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Sep 2009 11:52:28 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Russell King <rmk@arm.linux.org.uk>, Christoph Hellwig <hch@lst.de>, Paul Mundt <lethal@linux-sh.org>, James Bottomley <James.Bottomley@suse.de>

Here's version two of the patch set.  It actually compiles on both x86
and parisc.  I could do with someone to test it on arm and sh.

The key test is how xfs behaves.  What I did to recreate the problem
on parisc was simply create an 8GB xfs filesystem, use cp -a to pump
about a GB of data into it from my git trees, then unmount and run
xfs_check.  Before the patches, xfs_check reports the whole fs to be
corrupt.  After the patches it reports everything to be OK.

James

---

 arch/arm/include/asm/cacheflush.h    |   10 ++++++++++
 arch/parisc/include/asm/cacheflush.h |    8 ++++++++
 arch/sh/include/asm/cacheflush.h     |    8 ++++++++
 fs/bio.c                             |   19 +++++++++++++++++--
 fs/xfs/linux-2.6/xfs_buf.c           |   10 ++++++++++
 include/linux/highmem.h              |    6 ++++++
 6 files changed, 59 insertions(+), 2 deletions(-)
