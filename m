Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35157 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdGPD7L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 15 Jul 2017 23:59:11 -0400
From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 28/62] powerpc: check key protection for user page access
Date: Sat, 15 Jul 2017 20:56:30 -0700
Message-ID: <1500177424-13695-29-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Message-ID: <20170716035630.livNx-UaN47kr8FOcb_1Tt4YVbINncVSQodnVUmgdOY@z>

Make sure that the kernel does not access user pages without
checking their key-protection.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0056e58..425d98b 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -474,6 +474,20 @@ static inline void write_uamor(u64 value)
 
 #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
+
+#define pte_access_permitted(pte, write) \
+	(pte_present(pte) && \
+	 ((!(write) || pte_write(pte)) && \
+	  arch_pte_access_permitted(pte_val(pte), !!write, 0)))
+
+/*
+ * We store key in pmd for huge tlb pages. So need
+ * to check for key protection.
+ */
+#define pmd_access_permitted(pmd, write) \
+	(pmd_present(pmd) && \
+	 ((!(write) || pmd_write(pmd)) && \
+	  arch_pte_access_permitted(pmd_val(pmd), !!write, 0)))
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-- 
1.7.1
