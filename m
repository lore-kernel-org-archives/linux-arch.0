Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48684 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab1GLH6Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jul 2011 03:58:25 -0400
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/6] memblock: Use MEMBLOCK_ALLOC_ACCESSIBLE instead of ANYWHERE in memblock_alloc_try_nid()
Date: Tue, 12 Jul 2011 09:58:07 +0200
Message-ID: <1310457490-3356-4-git-send-email-tj@kernel.org>
In-Reply-To: <1310457490-3356-1-git-send-email-tj@kernel.org>
References: <1310457490-3356-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, benh@kernel.crashing.org, yinghai@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Tejun Heo <tj@kernel.org>
Message-ID: <20110712075807.YGEDpUOftAJdTwrpVIMhPB4vYCScXo55z0VNAN21U_0@z>

After node affine allocation fails, memblock_alloc_try_nid() calls
memblock_alloc_base() with @max_addr set to MEMBLOCK_ALLOC_ANYWHERE.
This is inconsistent with memblock_alloc() and what the function's
sole user - sparc/mm/init_64 - expects, although it doesn't make any
difference as sparc64 doesn't have highmem and ACCESSIBLE equals
ANYWHERE.

This patch makes memblock_alloc_try_nid() use ACCESSIBLE instead of
ANYWHERE.  This isn't complete as node affine allocation doesn't
consider memblock.current_limit.  It will be handled with future
changes.

This patch doesn't introduce any behavior difference.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 mm/memblock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a0562d1..87e512d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -612,7 +612,7 @@ phys_addr_t __init memblock_alloc_try_nid(phys_addr_t size, phys_addr_t align, i
 
 	if (res)
 		return res;
-	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ANYWHERE);
+	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
 }
 
 
-- 
1.7.6

