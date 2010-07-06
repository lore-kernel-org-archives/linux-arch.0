Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:31614 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637Ab0GFWnd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2010 18:43:33 -0400
From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 11/49] memblock: Remove unused memblock.debug struct member
Date: Tue,  6 Jul 2010 15:39:04 -0700
Message-ID: <1278455982-24621-12-git-send-email-yinghai@kernel.org>
In-Reply-To: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
References: <1278455982-24621-1-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20100706223904.pMklIfSuVIXrnBOai2KfRUaBF63QmIUyUBhU974scY8@z>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 include/linux/memblock.h |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3b41f61..5abb06b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -32,7 +32,6 @@ struct memblock_type {
 };
 
 struct memblock {
-	unsigned long debug;
 	phys_addr_t current_limit;
 	struct memblock_type memory;
 	struct memblock_type reserved;
@@ -55,9 +54,11 @@ extern phys_addr_t __init memblock_alloc(phys_addr_t size, phys_addr_t align);
 #define MEMBLOCK_ALLOC_ACCESSIBLE	0
 
 extern phys_addr_t __init memblock_alloc_base(phys_addr_t size,
-		phys_addr_t, phys_addr_t max_addr);
+					 phys_addr_t align,
+					 phys_addr_t max_addr);
 extern phys_addr_t __init __memblock_alloc_base(phys_addr_t size,
-		phys_addr_t align, phys_addr_t max_addr);
+					   phys_addr_t align,
+					   phys_addr_t max_addr);
 extern phys_addr_t __init memblock_phys_mem_size(void);
 extern phys_addr_t memblock_end_of_DRAM(void);
 extern void __init memblock_enforce_memory_limit(phys_addr_t memory_limit);
-- 
1.6.4.2

