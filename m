Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34441 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbcDCFqU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Apr 2016 01:46:20 -0400
Subject: [PATCH] mm/mmap: kill hook arch_rebalance_pgtables
From: Konstantin Khlebnikov <koct9i@gmail.com>
Date: Sun, 03 Apr 2016 08:46:15 +0300
Message-ID: <145966237520.3981.8917077611530564532.stgit@zurg>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Message-ID: <20160403054615.5lEMMc0ZTgDmCu6ObpR6W1VBirEMWnokxWSJ9NalZNY@z>

Nobody use it.

Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
---
 mm/mmap.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index bd2e1a533bc1..fba246b8f1a5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -55,10 +55,6 @@
 #define arch_mmap_check(addr, len, flags)	(0)
 #endif
 
-#ifndef arch_rebalance_pgtables
-#define arch_rebalance_pgtables(addr, len)		(addr)
-#endif
-
 #ifdef CONFIG_HAVE_ARCH_MMAP_RND_BITS
 const int mmap_rnd_bits_min = CONFIG_ARCH_MMAP_RND_BITS_MIN;
 const int mmap_rnd_bits_max = CONFIG_ARCH_MMAP_RND_BITS_MAX;
@@ -1911,7 +1907,6 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (offset_in_page(addr))
 		return -EINVAL;
 
-	addr = arch_rebalance_pgtables(addr, len);
 	error = security_mmap_addr(addr);
 	return error ? error : addr;
 }

