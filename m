From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v3 07/23] powerpc: use helper functions in __hash_page_4K() for 4K PTE
Date: Wed, 21 Jun 2017 18:39:23 -0700
Message-ID: <1498095579-6790-8-git-send-email-linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

replace redundant code with helper functions
get_hidx_gslot() and set_hidx_slot()

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/hash64_4k.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
index 6fa450c..c673829 100644
--- a/arch/powerpc/mm/hash64_4k.c
+++ b/arch/powerpc/mm/hash64_4k.c
@@ -20,6 +20,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		   pte_t *ptep, unsigned long trap, unsigned long flags,
 		   int ssize, int subpg_prot)
 {
+	real_pte_t rpte;
 	unsigned long hpte_group;
 	unsigned long rflags, pa;
 	unsigned long old_pte, new_pte;
@@ -54,6 +55,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * need to add in 0x1 if it's a read-only user page
 	 */
 	rflags = htab_convert_pte_flags(new_pte);
+	rpte = __real_pte(__pte(old_pte), ptep);
 
 	if (cpu_has_feature(CPU_FTR_NOEXECUTE) &&
 	    !cpu_has_feature(CPU_FTR_COHERENT_ICACHE))
@@ -64,13 +66,10 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 		/*
 		 * There MIGHT be an HPTE for this pte
 		 */
-		hash = hpt_hash(vpn, shift, ssize);
-		if (old_pte & H_PAGE_F_SECOND)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += (old_pte & H_PAGE_F_GIX) >> H_PAGE_F_GIX_SHIFT;
+		unsigned long gslot = get_hidx_gslot(vpn, shift,
+						ssize, rpte, 0);
 
-		if (mmu_hash_ops.hpte_updatepp(slot, rflags, vpn, MMU_PAGE_4K,
+		if (mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn, MMU_PAGE_4K,
 					       MMU_PAGE_4K, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
@@ -118,8 +117,7 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 			return -1;
 		}
 		new_pte = (new_pte & ~_PAGE_HPTEFLAGS) | H_PAGE_HASHPTE;
-		new_pte |= (slot << H_PAGE_F_GIX_SHIFT) &
-			(H_PAGE_F_SECOND | H_PAGE_F_GIX);
+		new_pte |= set_hidx_slot(ptep, rpte, 0, slot);
 	}
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
-- 
1.8.3.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
