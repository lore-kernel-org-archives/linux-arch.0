Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37265 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752723AbdLMK6M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Dec 2017 05:58:12 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 05/12] mips: Use generic_pmdp_establish as pmdp_establish
Date: Wed, 13 Dec 2017 13:57:49 +0300
Message-ID: <20171213105756.69879-6-kirill.shutemov@linux.intel.com>
In-Reply-To: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
References: <20171213105756.69879-1-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrea Arcangeli <aarcange@redhat.com>, Michal Hocko <mhocko@kernel.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ralf Baechle <ralf@linux-mips.org>, David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Message-ID: <20171213105749.7JRp8NqgpP2xnjwS8qv_u48mwe9lN72tD6U3oumTS8s@z>

MIPS doesn't support hardware dirty/accessed bits.
generic_pmdp_establish() is suitable in this case.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/pgtable.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 1a508a74d48d..129e0328367f 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -534,6 +534,9 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
+/* We don't have hardware dirty/accessed bits, generic_pmdp_establish is fine.*/
+#define pmdp_establish generic_pmdp_establish
+
 #define has_transparent_hugepage has_transparent_hugepage
 extern int has_transparent_hugepage(void);
 
-- 
2.15.0
