From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH] mm: move phys_mem_access_prot_allowed() declaration to pgtable.h
Date: Mon, 12 Sep 2016 20:35:03 +0800
Message-ID: <1473683703-15727-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35715 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbcILMfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Sep 2016 08:35:43 -0400
Received: by mail-pf0-f171.google.com with SMTP id i75so11983601pfa.2
        for <linux-arch@vger.kernel.org>; Mon, 12 Sep 2016 05:35:42 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ralf@linux-mips.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, akpm@linux-foundation.org, paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com, kumba@gentoo.org, yamada.masahiro@socionext.com, kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com, toshi.kani@hpe.com, JBeulich@suse.com, dan.j.williams@intel.com
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
index d4458b6..ad625dd 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -814,4 +814,7 @@ static inline int pmd_clear_huge(pmd_t *pmd)
 #endif
 #endif
 
+struct file;
+int phys_mem_access_prot_allowed(struct file *file, unsigned long pfn,
+			unsigned long size, pgprot_t *vma_prot);
 #endif /* _ASM_GENERIC_PGTABLE_H */
-- 
2.7.4
