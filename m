From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 20/38] powerpc: ability to associate pkey to a vma
Date: Wed,  5 Jul 2017 14:21:57 -0700
Message-ID: <1499289735-14220-21-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

arch-independent code expects the arch to  map
a  pkey  into the vma's protection bit setting.
The patch provides that ability.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mman.h  |    8 +++++++-
 arch/powerpc/include/asm/pkeys.h |   14 ++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 30922f6..067eec2 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,6 +13,7 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <asm/cpu_has_feature.h>
 
 /*
@@ -22,7 +23,12 @@
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 		unsigned long pkey)
 {
-	return (prot & PROT_SAO) ? VM_SAO : 0;
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	return (((prot & PROT_SAO) ? VM_SAO : 0) |
+			pkey_to_vmflag_bits(pkey));
+#else
+	return ((prot & PROT_SAO) ? VM_SAO : 0);
+#endif
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 4b01c37..f148e84 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -1,13 +1,23 @@
 #ifndef _ASM_PPC64_PKEYS_H
 #define _ASM_PPC64_PKEYS_H
 
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
+				VM_PKEY_BIT3 | VM_PKEY_BIT4)
+
+static inline u64 pkey_to_vmflag_bits(u16 pkey)
+{
+	return (((pkey & 0x1UL) ? VM_PKEY_BIT0 : 0x0UL) |
+		((pkey & 0x2UL) ? VM_PKEY_BIT1 : 0x0UL) |
+		((pkey & 0x4UL) ? VM_PKEY_BIT2 : 0x0UL) |
+		((pkey & 0x8UL) ? VM_PKEY_BIT3 : 0x0UL) |
+		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
+}
+
 #define arch_max_pkey()  32
 #define AMR_AD_BIT 0x1UL
 #define AMR_WD_BIT 0x2UL
 #define IAMR_EX_BIT 0x1UL
 #define AMR_BITS_PER_PKEY 2
-#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
-				VM_PKEY_BIT3 | VM_PKEY_BIT4)
 /*
  * Bits are in BE format.
  * NOTE: key 31, 1, 0 are not used.
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
