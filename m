Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42265 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755621AbeASBwT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jan 2018 20:52:19 -0500
From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH v10 12/27] powerpc: ability to associate pkey to a vma
Date: Thu, 18 Jan 2018 17:50:33 -0800
Message-ID: <1516326648-22775-13-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
References: <1516326648-22775-1-git-send-email-linuxram@us.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Message-ID: <20180119015033.7B8lrJECKhdpyfH4MKJ5ooGCD_RkMsY-KFMcbamD4GU@z>

arch-independent code expects the arch to  map
a  pkey  into the vma's protection bit setting.
The patch provides that ability.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mman.h  |    7 ++++++-
 arch/powerpc/include/asm/pkeys.h |   11 +++++++++++
 arch/powerpc/mm/pkeys.c          |    8 ++++++++
 3 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 30922f6..2999478 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <asm/cpu_has_feature.h>
 
 /*
@@ -22,7 +23,11 @@
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 		unsigned long pkey)
 {
-	return (prot & PROT_SAO) ? VM_SAO : 0;
+#ifdef CONFIG_PPC_MEM_KEYS
+	return (((prot & PROT_SAO) ? VM_SAO : 0) | pkey_to_vmflag_bits(pkey));
+#else
+	return ((prot & PROT_SAO) ? VM_SAO : 0);
+#endif
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 2b5bb35..c7cc433 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -41,6 +41,17 @@
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 			    VM_PKEY_BIT3 | VM_PKEY_BIT4)
 
+/* Override any generic PKEY permission defines */
+#define PKEY_DISABLE_EXECUTE   0x4
+#define PKEY_ACCESS_MASK       (PKEY_DISABLE_ACCESS | \
+				PKEY_DISABLE_WRITE  | \
+				PKEY_DISABLE_EXECUTE)
+
+static inline u64 pkey_to_vmflag_bits(u16 pkey)
+{
+	return (((u64)pkey << VM_PKEY_SHIFT) & ARCH_VM_PKEY_FLAGS);
+}
+
 #define arch_max_pkey() pkeys_total
 
 #define pkey_alloc_mask(pkey) (0x1 << pkey)
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b466a2c..ee31ab5 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -39,6 +39,14 @@ int pkey_initialize(void)
 		     (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
 
 	/*
+	 * pkey_to_vmflag_bits() assumes that the pkey bits are contiguous
+	 * in the vmaflag. Make sure that is really the case.
+	 */
+	BUILD_BUG_ON(__builtin_clzl(ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT) +
+		     __builtin_popcountl(ARCH_VM_PKEY_FLAGS >> VM_PKEY_SHIFT)
+				!= (sizeof(u64) * BITS_PER_BYTE));
+
+	/*
 	 * Disable the pkey system till everything is in place. A subsequent
 	 * patch will enable it.
 	 */
-- 
1.7.1
