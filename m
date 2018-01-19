Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37921 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755754AbeASBwl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 20:52:41 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v10 20/27] powerpc: introduce get_mm_addr_key() helper
Date: Thu, 18 Jan 2018 17:50:41 -0800
Message-ID: <1516326648-22775-21-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20180119015041.Cd6nuY2DwveHjweSV593PA4KRoF4iFuad-HNsTYmf7U@z>

get_mm_addr_key() helper returns the pkey associated with
an address corresponding to a given mm_struct.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mmu.h  |    9 +++++++++
 arch/powerpc/mm/hash_utils_64.c |   24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 6364f5c..bb38312 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -260,6 +260,15 @@ static inline bool early_radix_enabled(void)
 }
 #endif
 
+#ifdef CONFIG_PPC_MEM_KEYS
+extern u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address);
+#else
+static inline u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
+{
+	return 0;
+}
+#endif /* CONFIG_PPC_MEM_KEYS */
+
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index dc0f76e..1e1c03b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1573,6 +1573,30 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_PPC_MEM_KEYS
+/*
+ * Return the protection key associated with the given address and the
+ * mm_struct.
+ */
+u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
+{
+	pte_t *ptep;
+	u16 pkey = 0;
+	unsigned long flags;
+
+	if (!mm || !mm->pgd)
+		return 0;
+
+	local_irq_save(flags);
+	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
+	if (ptep)
+		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
+	local_irq_restore(flags);
+
+	return pkey;
+}
+#endif /* CONFIG_PPC_MEM_KEYS */
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 static inline void tm_flush_hash_page(int local)
 {
-- 
1.7.1
