Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65398 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752647AbdLMK7J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 05:59:09 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 03/12] arm/mm: Provide pmdp_establish() helper
Date: Wed, 13 Dec 2017 13:57:47 +0300
Message-ID: <20171213105756.69879-4-kirill.shutemov@linux.intel.com>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20171213105747.IqLEvYg_33YXt5MzqpXPikeSWAL_4DMDI08FpHEV2ps@z>

ARM LPAE doesn't have hardware dirty/accessed bits.

generic_pmdp_establish() is the right implementation of pmdp_establish
for this case.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable-3level.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 1a7a17b2a1ba..2a4836087358 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -249,6 +249,9 @@ PMD_BIT_FUNC(mkyoung,   |= PMD_SECT_AF);
 #define pfn_pmd(pfn,prot)	(__pmd(((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 #define mk_pmd(page,prot)	pfn_pmd(page_to_pfn(page),prot)
 
+/* No hardware dirty/accessed bits -- generic_pmdp_establish() fits */
+#define pmdp_establish generic_pmdp_establish
+
 /* represent a notpresent pmd by faulting entry, this is used by pmdp_invalidate */
 static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 {
-- 
2.15.0
