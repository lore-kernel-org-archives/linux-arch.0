From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v6 16/62] powerpc: cleaup AMR,iAMR when a key is allocated or freed
Date: Sat, 15 Jul 2017 20:56:18 -0700
Message-ID: <1500177424-13695-17-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
List-Id: linux-arch.vger.kernel.org

cleanup the bits corresponding to a key in the AMR, and IAMR
register, when the key is newly allocated/activated or is freed.
We dont want some residual bits cause the hardware enforce
unintended behavior when the key is activated or freed.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 4327842..7f5c21d 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -42,6 +42,8 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 		mm_set_pkey_is_allocated(mm, pkey));
 }
 
+extern void __arch_activate_pkey(int pkey);
+extern void __arch_deactivate_pkey(int pkey);
 /*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  */
@@ -70,6 +72,12 @@ static inline int mm_pkey_alloc(struct mm_struct *mm)
 		ffz((u32)mm_pkey_allocation_map(mm))
 		- 1;
 	mm_set_pkey_allocated(mm, ret);
+
+	/*
+	 * enable the key in the hardware
+	 */
+	if (ret > 0)
+		__arch_activate_pkey(ret);
 	return ret;
 }
 
@@ -81,6 +89,10 @@ static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 	if (!mm_pkey_is_allocated(mm, pkey))
 		return -EINVAL;
 
+	/*
+	 * Disable the key in the hardware
+	 */
+	__arch_deactivate_pkey(pkey);
 	mm_set_pkey_free(mm, pkey);
 
 	return 0;
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
