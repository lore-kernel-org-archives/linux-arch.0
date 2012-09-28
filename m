Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16444 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231Ab2I1Xg6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 Sep 2012 19:36:58 -0400
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 3/3] x86: implement HAVE_PMD_SPECAIL
Date: Sat, 29 Sep 2012 02:37:21 +0300
Message-ID: <1348875441-19561-4-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com>
References: <1348875441-19561-1-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill@shutemov.name>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, linux-arch@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Message-ID: <20120928233721.ojlB4YmwA_HLnw2JVLdlYPblaY5S0gW-Sh1G1qP1hQA@z>

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

We can use the same bit as for special PTE.

There's no conflict with _PAGE_SPLITTING since it's only defined for PSE
pmd, but special PMD is only valid for non-PSE.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig               |    1 +
 arch/x86/include/asm/pgtable.h |   14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 50a1d1f..b2146c3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -97,6 +97,7 @@ config X86
 	select KTIME_SCALAR if X86_32
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select HAVE_PMD_SPECIAL
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS || UPROBES)
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 49afb3f..ff61694 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -167,6 +167,12 @@ static inline int has_transparent_hugepage(void)
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static inline int pmd_special(pmd_t pmd)
+{
+	return !pmd_trans_huge(pmd) &&
+		pmd_flags(pmd) & _PAGE_SPECIAL;
+}
+
 static inline pte_t pte_set_flags(pte_t pte, pteval_t set)
 {
 	pteval_t v = native_pte_val(pte);
@@ -290,6 +296,11 @@ static inline pmd_t pmd_mknotpresent(pmd_t pmd)
 	return pmd_clear_flags(pmd, _PAGE_PRESENT);
 }
 
+static inline pmd_t pmd_mkspecial(pmd_t pmd)
+{
+	return pmd_set_flags(pmd, _PAGE_SPECIAL);
+}
+
 /*
  * Mask out unsupported bits in a present pgprot.  Non-present pgprots
  * can use those bits for other purposes, so leave them be.
@@ -474,7 +485,8 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 
 static inline int pmd_bad(pmd_t pmd)
 {
-	return (pmd_flags(pmd) & ~_PAGE_USER) != _KERNPG_TABLE;
+	pmdval_t flags = pmd_flags(pmd);
+	return (flags & ~(_PAGE_USER | _PAGE_SPECIAL)) != _KERNPG_TABLE;
 }
 
 static inline unsigned long pages_to_mb(unsigned long npg)
-- 
1.7.7.6

