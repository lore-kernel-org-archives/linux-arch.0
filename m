Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35162 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbdGEVWy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 17:22:54 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 10/38] powerpc: use helper functions in flush_hash_page()
Date: Wed,  5 Jul 2017 14:21:47 -0700
Message-ID: <1499289735-14220-11-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170705212147.TR7ceqrdbFk-xs2BHabH_ZLbkmJWtwIgPEvUNiVrilA@z>

replace redundant code in flush_hash_page() with helper function
pte_get_hash_gslot().

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c |   13 ++++---------
 1 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d3604da..d863696 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1615,23 +1615,18 @@ unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		     unsigned long flags)
 {
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long index, shift, gslot;
 	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
 	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(pte, index);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
+		gslot = pte_get_hash_gslot(vpn, shift, ssize, pte, index);
+		DBG_LOW(" sub %ld: gslot=%lx\n", index, gslot);
 		/*
 		 * We use same base page size and actual psize, because we don't
 		 * use these functions for hugepage
 		 */
-		mmu_hash_ops.hpte_invalidate(slot, vpn, psize, psize,
+		mmu_hash_ops.hpte_invalidate(gslot, vpn, psize, psize,
 					     ssize, local);
 	} pte_iterate_hashed_end();
 
-- 
1.7.1
