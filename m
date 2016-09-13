From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v2] mm: move phys_mem_access_prot_allowed() declaration to pgtable.h
Date: Tue, 13 Sep 2016 15:26:37 +0800
Message-ID: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35617 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752456AbcIMH1A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Sep 2016 03:27:00 -0400
Received: by mail-pf0-f176.google.com with SMTP id z123so6956606pfz.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Sep 2016 00:27:00 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, akpm@linux-foundation.org, paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org, yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com, toshi.kani@hpe.com, dan.j.williams@intel.com, luto@kernel.org, JBeulich@suse.com
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, baoyou.xie@linaro.org, xie.baoyou@zte.com.cn

We get 1 warning when building kernel with W=1:
drivers/char/mem.c:220:12: warning: no previous prototype for 'phys_mem_access_prot_allowed' [-Wmissing-prototypes]
 int __weak phys_mem_access_prot_allowed(struct file *file,

In fact, its declaration is spreading to several header files
in different architecture, but need to be declare in common
header file.

So this patch moves phys_mem_access_prot_allowed() to pgtable.h.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 arch/mips/include/asm/pgtable.h      | 2 --
 arch/x86/include/asm/pgtable_types.h | 2 --
 include/asm-generic/pgtable.h        | 3 +++
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 70128d3..9e9e944 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -673,8 +673,6 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 struct file;
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 		unsigned long size, pgprot_t vma_prot);
-int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
-		unsigned long size, pgprot_t *vma_prot);
 #endif
 
 /*
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f1218f5..8b4de22 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -439,8 +439,6 @@ extern pgprot_t pgprot_writethrough(pgprot_t prot);
 struct file;
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
                               unsigned long size, pgprot_t vma_prot);
-int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
-                              unsigned long size, pgprot_t *vma_prot);
 
 /* Install a pte for a particular vaddr in kernel space. */
 void set_pte_vaddr(unsigned long vaddr, pte_t pte);
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index d4458b6..c4f8fd2 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -800,6 +800,9 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 #endif
 #endif
 
+struct file;
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+			unsigned long size, pgprot_t *vma_prot);
 #endif /* !__ASSEMBLY__ */
 
 #ifndef io_remap_pfn_range
-- 
2.7.4
