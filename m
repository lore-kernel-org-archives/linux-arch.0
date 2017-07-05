Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34501 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdGEVWo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Jul 2017 17:22:44 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 04/38] powerpc: introduce pte_get_hash_gslot() helper
Date: Wed,  5 Jul 2017 14:21:41 -0700
Message-ID: <1499289735-14220-5-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Message-ID: <20170705212141.55lxxUugwtJoz_JypIYOO_DOto-Crn1pORDGZEenEfk@z>

Introduce pte_get_hash_gslot()() which returns the slot number of the
HPTE in the global hash table.

This function will come in handy as we work towards re-arranging the
PTE bits in the later patches.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h |    3 +++
 arch/powerpc/mm/hash_utils_64.c           |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d27f885..277158c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -156,6 +156,9 @@ static inline int hash__pte_none(pte_t pte)
 	return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
 }
 
+unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
+		int ssize, real_pte_t rpte, unsigned int subpg_index);
+
 /* This low level function performs the actual PTE insertion
  * Setting the PTE depends on the MMU type and other factors. It's
  * an horrible mess that I'm not going to try to clean up now but
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1b494d0..d3604da 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1591,6 +1591,24 @@ static inline void tm_flush_hash_page(int local)
 }
 #endif
 
+/*
+ * return the global hash slot, corresponding to the given
+ * pte, which contains the hpte.
+ */
+unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
+		int ssize, real_pte_t rpte, unsigned int subpg_index)
+{
+	unsigned long hash, slot, hidx;
+
+	hash = hpt_hash(vpn, shift, ssize);
+	hidx = __rpte_to_hidx(rpte, subpg_index);
+	if (hidx & _PTEIDX_SECONDARY)
+		hash = ~hash;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot += hidx & _PTEIDX_GROUP_IX;
+	return slot;
+}
+
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-- 
1.7.1
