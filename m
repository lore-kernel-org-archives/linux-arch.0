Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57408 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab1GZPfp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2011 11:35:45 -0400
From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 01/23] memblock: Make memblock_overlaps_region() static
Date: Tue, 26 Jul 2011 17:35:12 +0200
Message-ID: <1311694534-5161-2-git-send-email-tj@kernel.org>
In-Reply-To: <1311694534-5161-1-git-send-email-tj@kernel.org>
References: <1311694534-5161-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@redhat.com, Tejun Heo <tj@kernel.org>
Message-ID: <20110726153512.5wK0zKxuaS250oqgwul0D-VwrtXO-xYIjcfPf9yLqdE@z>

It isn't used outside of memblock.c.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 mm/memblock.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a75723d..5ecacc1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -47,7 +47,8 @@ static unsigned long __init_memblock memblock_addrs_overlap(phys_addr_t base1, p
 	return ((base1 < (base2 + size2)) && (base2 < (base1 + size1)));
 }
 
-long __init_memblock memblock_overlaps_region(struct memblock_type *type, phys_addr_t base, phys_addr_t size)
+static long __init_memblock memblock_overlaps_region(struct memblock_type *type,
+					phys_addr_t base, phys_addr_t size)
 {
 	unsigned long i;
 
-- 
1.7.6

