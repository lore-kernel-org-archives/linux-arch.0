From: Ram Pai <linuxram@us.ibm.com>
Subject: [RFC v5 05/38] powerpc: capture the PTE format changes in the dump pte report
Date: Wed,  5 Jul 2017 14:21:42 -0700
Message-ID: <1499289735-14220-6-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
Sender: owner-linux-mm@kvack.org
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com, linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
List-Id: linux-arch.vger.kernel.org

The H_PAGE_F_SECOND,H_PAGE_F_GIX are not in the 64K main-PTE.
capture these changes in the dump pte report.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/dump_linuxpagetables.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index 44fe483..5627edd 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -213,7 +213,7 @@ struct flag_info {
 		.val	= H_PAGE_4K_PFN,
 		.set	= "4K_pfn",
 	}, {
-#endif
+#else /* CONFIG_PPC_64K_PAGES */
 		.mask	= H_PAGE_F_GIX,
 		.val	= H_PAGE_F_GIX,
 		.set	= "f_gix",
@@ -224,6 +224,7 @@ struct flag_info {
 		.val	= H_PAGE_F_SECOND,
 		.set	= "f_second",
 	}, {
+#endif /* CONFIG_PPC_64K_PAGES */
 #endif
 		.mask	= _PAGE_SPECIAL,
 		.val	= _PAGE_SPECIAL,
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
