Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48917 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab2I1Xgv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Sep 2012 19:36:51 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/3] asm-generic: introduce pmd_special() and pmd_mkspecial()
Date: Sat, 29 Sep 2012 02:37:19 +0300
Message-ID: <1348875441-19561-2-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill@shutemov.name>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20120928233719.FZ1Y9NIDkbsKMEmlJ8QaN7A9yKlBeh_CMVwiRzX98TY@z>

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Special PMD is similar to special PTE: it requires special handling.
Currently, it's needed to mark PMD with all PTEs set to zero page.

If an arch wants to provide support of special PMD it need to select
HAVE_PMD_SPECIAL config option and implement pmd_special() and
pmd_mkspecial().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/Kconfig                  |    6 ++++++
 include/asm-generic/pgtable.h |   12 ++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 72f2fa1..a74ba25 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -281,4 +281,10 @@ config SECCOMP_FILTER
 
 	  See Documentation/prctl/seccomp_filter.txt for details.
 
+config HAVE_PMD_SPECIAL
+	bool
+	help
+	  An arch should select this symbol if it provides pmd_special()
+	  and pmd_mkspecial().
+
 source "kernel/gcov/Kconfig"
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index ff4947b..393f3f0 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -59,6 +59,18 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
 
+#ifndef CONFIG_HAVE_PMD_SPECIAL
+static inline int pmd_special(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pmd;
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 int ptep_clear_flush_young(struct vm_area_struct *vma,
 			   unsigned long address, pte_t *ptep);
-- 
1.7.7.6

