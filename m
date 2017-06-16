Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0052.outbound.protection.outlook.com ([104.47.34.52]:35390
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750798AbdFPSvu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Jun 2017 14:51:50 -0400
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v7 09/36] x86/mm: Simplify p[gum]d_page() macros
Date: Fri, 16 Jun 2017 13:51:25 -0500
Message-ID: <20170616185125.18967.33160.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, xen-devel@lists.xen.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20170616185125.NTT2Z0201OA9t-owbnTpGOlzwu-H-7I3lvxujUl6lp4@z>

Create a pgd_pfn() macro similar to the p[um]d_pfn() macros and then
use the p[gum]d_pfn() macros in the p[gum]d_page() macros instead of
duplicating the code.

Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/pgtable.h |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 77037b6..b64ea52 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -195,6 +195,11 @@ static inline unsigned long p4d_pfn(p4d_t p4d)
 	return (p4d_val(p4d) & p4d_pfn_mask(p4d)) >> PAGE_SHIFT;
 }
 
+static inline unsigned long pgd_pfn(pgd_t pgd)
+{
+	return (pgd_val(pgd) & PTE_PFN_MASK) >> PAGE_SHIFT;
+}
+
 static inline int p4d_large(p4d_t p4d)
 {
 	/* No 512 GiB pages yet */
@@ -704,8 +709,7 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pmd_page(pmd)		\
-	pfn_to_page((pmd_val(pmd) & pmd_pfn_mask(pmd)) >> PAGE_SHIFT)
+#define pmd_page(pmd)	pfn_to_page(pmd_pfn(pmd))
 
 /*
  * the pmd page can be thought of an array like this: pmd_t[PTRS_PER_PMD]
@@ -773,8 +777,7 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pud_page(pud)		\
-	pfn_to_page((pud_val(pud) & pud_pfn_mask(pud)) >> PAGE_SHIFT)
+#define pud_page(pud)	pfn_to_page(pud_pfn(pud))
 
 /* Find an entry in the second-level page table.. */
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
@@ -824,8 +827,7 @@ static inline unsigned long p4d_page_vaddr(p4d_t p4d)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define p4d_page(p4d)		\
-	pfn_to_page((p4d_val(p4d) & p4d_pfn_mask(p4d)) >> PAGE_SHIFT)
+#define p4d_page(p4d)	pfn_to_page(p4d_pfn(p4d))
 
 /* Find an entry in the third-level page table.. */
 static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
@@ -859,7 +861,7 @@ static inline unsigned long pgd_page_vaddr(pgd_t pgd)
  * Currently stuck as a macro due to indirect forward reference to
  * linux/mmzone.h's __section_mem_map_addr() definition:
  */
-#define pgd_page(pgd)		pfn_to_page(pgd_val(pgd) >> PAGE_SHIFT)
+#define pgd_page(pgd)	pfn_to_page(pgd_pfn(pgd))
 
 /* to find an entry in a page-table-directory. */
 static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
