Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306B41F379
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205793; cv=none; b=Z2qgm69nEyp4ui0Dc2mRJM+BqF4XgX+1rFxkX1bGXtx3iLAvz+V68NBYM0VafM7di1Z83Ohngft41z15FQDdB5qwTdcmnG52yiD7C+Nkq6OyXJ8/5WEvxXTZdGdWh08jfPoHz7uiDm1P9T9HYc9hcq99xMVep/dhA11oXE6OciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205793; c=relaxed/simple;
	bh=K4BILLDY2841H2ZYcXQzOoDFaiqflkui3P4ZaLrKaBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNpNKXlOeQ/konBGXtEDcif4fqrC/I7O0QU1sdb8KCYVE2itGbf7pTdsjP/6ggm8vaZROTxuR/xgSWaGbgSkItffVD3hDcE3YY+hRagF5AXUtcdDFdvlIB6QtY028oO6JcvZ3lxh/dQ9HaKpBZmPReNLdiSl6CvAk42wU6oiFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lMGlT2lj; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lMGlT2lj"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc6dd436c6so39266735ad.2
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205790; x=1784810590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6QhVe14fP0y9rm/shff3jRao3xNlRAMh2yWf3Ip6xG8=;
        b=lMGlT2ljRCwC6NxeA0OUNZVyF2zzzdWsZ0aONLB8seSytpDUSpku11PAz86Z6EXghJ
         qE6f67bbwTM5EgO2s3LkiGRN2rL4qE9zkvZA6e/o/hswfuvUPgYEC2FqMT6ttQSg39jg
         Z6itqQGVtbcpVWoTO9AxaLKbLVqIO+D2CdBaKgRUm4yDcDyqV80+iiffMDKizX8b5Zg4
         qMNya+YxyRWxs6vdiA3S87lH2qEaa7PmTFbtz4tJpAgoyLuEEJu2ffHMY4ViauotaJcr
         RGFCNxfgphMaLfNWmC4U8hP+kGXZW7jkdGlWBdAXzdGoSRb7nXezU6eEkZaPrsthXSQo
         nHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205790; x=1784810590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6QhVe14fP0y9rm/shff3jRao3xNlRAMh2yWf3Ip6xG8=;
        b=QPXUyMnOIPrcVRnPIbPggBy1OHOHsDkb7c8oG+mmxmMma/+M9Zj07MZDtRu3YMUIbi
         zCr25fd1tH9+l9EfQmmqykjQOMYLVEbayCcvWS6qArKH9BwAtUTryUgiDCKD3y5E0NNv
         gnNc3SZdpJnQqdf0qd/IGSaT6ZrNhT9W1l9hO6tBF70ecZckgF1v+eB+Ol2KAQMftYes
         s8FmywSUU+tysKep1M8jT6TQSdk8iGdHB0/xf068u/fNGyhF4tgpeDIY8RowdJKbrGs/
         PwUo2OhztNHZ5cR8Mdt1VAhFQ6I8KcUj4e7EA4k+QO8mJZz7Wmc16R7jhJHRl78uoe5c
         DoOw==
X-Gm-Message-State: AOJu0YxTJQFG/2VJsca9qCNddKs+XpVOln3Z/vR0UZlnth/LJKWZJquE
	01fXWrrjUVvf1Qyybpare3k2eLf2T5SFgW7p9m8ImE5xj58x3pAnrLFhlNCeTc1uXrM=
X-Gm-Gg: AfdE7cmenPXvjJJzl7hHeLZ07bPq+SgME1H91/GjDzZDKq335xcw1G17cD8PS9Ezv0m
	NUEtYtJeEg4YYGKZ2kOmr4YoeL0IJ2mGALySINjnaBvu5R8T9BJUTQAW/3w0MuLMNvqagVgduxY
	/gyEXe+cghABlMsMJJV2K6If9sxcHf6ok02eFxVW1NXA3qGT6uiQHkF0U+FVVslIgLtCABDnCzl
	ydzsup3jz3Xh+MS2Fwg9hE2Udb4Na09lGBZDT0Ob6ajTB9kI3HzFB01CI7UlQ2L5+NsNo6YRyTn
	jg6D/iuPnGeLXlTJsKqO1MPcTx2vFhxEZfTYVKvo0US8+Oil7+e3EwzEmCCbEizRpTOnKrrP4MA
	uOhdZlHpevWPqv+FzkY01tvo2c45tDhyf1e+AZlGX12THPkYfaA2N8GxFhwjNUBLyj8ADWGOoyM
	Qzuzon4c1Fjs7sCrmgJ2jtJtI=
X-Received: by 2002:a05:6a20:6a26:b0:3c3:990b:2292 with SMTP id adf61e73a8af0-3c3990b4230mr1076478637.57.1784205789867;
        Thu, 16 Jul 2026 05:43:09 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.43.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:43:07 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: linux-riscv@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v2 03/15] riscv/mm: implement Svnapot contpte read-side helpers
Date: Thu, 16 Jul 2026 20:41:38 +0800
Message-Id: <0c93b57b5315147c6ae6586371d795fb629dcc7a.1784201104.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <cover.1784201104.git.cuiyunhui@bytedance.com>
References: <cover.1784201104.git.cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Svnapot keeps a contiguous mapping encoded in a block of page-table
entries, while generic MM code expects the public PTE getters to return
a normal per-page view for the address being queried. Without a dedicated
read path, exposing the raw NAPOT encoding through the public helpers
would leak arch-private representation details into generic MM users and
make folded mappings harder to integrate with existing PTE walkers.

Add Svnapot-aware contpte read-side helpers and route the public PTE
getters through them, so generic MM sees the logical sub-PTE for the
current page while RISC-V raw helpers continue to operate on the encoded
entries.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h |  50 +++++-
 arch/riscv/mm/Makefile           |   1 +
 arch/riscv/mm/contpte.c          | 273 +++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/mm/contpte.c

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a0f64e980e981..fce6d04ea65db 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -312,6 +312,11 @@ static inline unsigned long pte_napot(pte_t pte)
 	return 0;
 }
 
+static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
+{
+	return pte;
+}
+
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 /* Yields the page frame number (PFN) of a page table entry */
@@ -350,6 +355,11 @@ static inline int pte_present(pte_t pte)
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_PROT_NONE));
 }
 
+static inline bool pte_present_napot(pte_t pte)
+{
+	return pte_present(pte) && pte_napot(pte);
+}
+
 #define pte_accessible pte_accessible
 static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 {
@@ -538,6 +548,13 @@ static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
 #define pte_leaf_size(pte)	(pte_napot(pte) ?				\
 					napot_cont_size(napot_cont_order(pte)) :\
 					PAGE_SIZE)
+
+void __napotpte_try_fold(struct mm_struct *mm, unsigned long addr,
+			 pte_t *ptep, pte_t pte);
+void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte);
+pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte);
+pte_t napotpte_ptep_get_lockless(pte_t *ptep);
 #endif
 
 #ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
@@ -689,6 +706,37 @@ static inline pte_t __ptep_get_lockless(pte_t *ptep)
 	return __ptep_get(ptep);
 }
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+
+#define ptep_get ptep_get
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	pte_t pte = __ptep_get(ptep);
+
+	if (likely(!pte_present_napot(pte)))
+		return pte;
+
+	return napotpte_ptep_get(ptep, pte);
+}
+
+#define ptep_get_lockless ptep_get_lockless
+static inline pte_t ptep_get_lockless(pte_t *ptep)
+{
+	pte_t pte = __ptep_get_lockless(ptep);
+
+	if (likely(!pte_present_napot(pte)))
+		return pte;
+
+	return napotpte_ptep_get_lockless(ptep);
+}
+
+#else
+
+#define ptep_get __ptep_get
+#define ptep_get_lockless __ptep_get_lockless
+
+#endif
+
 static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
 					   unsigned long addr, pte_t *ptep,
 					   pte_t pte, cydp_t flags)
@@ -822,8 +870,6 @@ static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
 
 #define __ptep_clear_flush_young __ptep_clear_flush_young
 
-#define ptep_get __ptep_get
-#define ptep_get_lockless __ptep_get_lockless
 #define set_pte __set_pte
 #define set_ptes __set_ptes
 
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index b916a68d324ad..fd260903cd340 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -19,6 +19,7 @@ obj-y += context.o
 obj-y += pmem.o
 
 obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
+obj-$(CONFIG_RISCV_ISA_SVNAPOT) += contpte.o
 obj-$(CONFIG_PTDUMP) += ptdump.o
 obj-$(CONFIG_KASAN)   += kasan_init.o
 
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
new file mode 100644
index 0000000000000..43ea76e424492
--- /dev/null
+++ b/arch/riscv/mm/contpte.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/align.h>
+#include <linux/cpufeature.h>
+#include <linux/efi.h>
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/mm_types.h>
+#include <linux/page_table_check.h>
+#include <linux/pgtable.h>
+
+#include <asm/tlbflush.h>
+
+static inline bool napot_hw_supported(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SVNAPOT);
+}
+
+static inline bool mm_is_user(struct mm_struct *mm)
+{
+	if (unlikely(mm_is_efi(mm)))
+		return false;
+
+	return mm != &init_mm;
+}
+
+static inline unsigned int napotpte_order(void)
+{
+	return NAPOT_CONT64KB_ORDER;
+}
+
+static inline unsigned long napotpte_size(void)
+{
+	return napot_cont_size(napotpte_order());
+}
+
+static inline unsigned int napotpte_pte_num(void)
+{
+	return napot_pte_num(napotpte_order());
+}
+
+static inline unsigned long napot_align_addr(unsigned long addr)
+{
+	return ALIGN_DOWN(addr, napotpte_size());
+}
+
+static inline pte_t *napot_align_ptep(pte_t *ptep)
+{
+	return PTR_ALIGN_DOWN(ptep, napotpte_pte_num() * sizeof(*ptep));
+}
+
+static inline pte_t pte_mask_ad(pte_t pte)
+{
+	return pte_mkold(pte_mkclean(pte));
+}
+
+void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte);
+
+static inline unsigned long pte_protval_no_pfn_no_napot(pte_t pte)
+{
+	return (pte_val(pte) & ~_PAGE_PFN_MASK) & ~_PAGE_NAPOT;
+}
+
+static inline pte_t napotpte_subpte(pte_t *ptep, pte_t pte)
+{
+	unsigned long pfn;
+	pgprot_t prot;
+
+	if (!pte_present_napot(pte))
+		return pte;
+
+	pfn = pte_pfn(pte) + (ptep - napot_align_ptep(ptep));
+	prot = __pgprot(pte_protval_no_pfn_no_napot(pte));
+
+	return pfn_pte(pfn, prot);
+}
+
+static inline pte_t __napot_ptep_get_and_clear(struct mm_struct *mm,
+					       unsigned long addr, pte_t *ptep)
+{
+	pte_t pte;
+
+	pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
+	page_table_check_pte_clear(mm, addr, pte_mknonnapot(pte, addr));
+
+	return pte;
+}
+
+static void napotpte_convert(struct mm_struct *mm, unsigned long addr,
+			     pte_t *ptep, pte_t target)
+{
+	unsigned long start_addr, end, ptent_addr;
+	pte_t *start_ptep;
+	pte_t ptent, pte;
+	unsigned int i, nr;
+
+	start_addr = napot_align_addr(addr);
+	start_ptep = napot_align_ptep(ptep);
+	nr = napotpte_pte_num();
+	end = start_addr + napotpte_size();
+
+	for (i = 0; i < nr; i++) {
+		ptent_addr = start_addr + i * PAGE_SIZE;
+		ptent = __napot_ptep_get_and_clear(mm, ptent_addr,
+						   start_ptep + i);
+		if (pte_dirty(ptent))
+			target = riscv_pte_mkhwdirty(target);
+		if (pte_young(ptent))
+			target = pte_mkyoung(target);
+	}
+
+	flush_tlb_mm_range(mm, start_addr, end, PAGE_SIZE);
+
+	page_table_check_ptes_set(mm, start_addr, start_ptep, target, nr);
+	if (pte_napot(target)) {
+		for (i = 0; i < nr; i++)
+			__set_pte_at(mm, start_ptep + i, target);
+		return;
+	}
+
+	for (i = 0; i < nr; i++) {
+		pte = pfn_pte(pte_pfn(target) + i,
+			      __pgprot(pte_protval_no_pfn_no_napot(target)));
+		if (pte_dirty(target))
+			pte = riscv_pte_mkhwdirty(pte);
+		if (pte_young(target))
+			pte = pte_mkyoung(pte);
+		__set_pte_at(mm, start_ptep + i, pte);
+	}
+}
+
+static inline bool napotpte_is_consistent(pte_t pte, pte_t orig_pte)
+{
+	return pte_present_napot(pte) &&
+	       pte_val(pte_mask_ad(pte)) == pte_val(pte_mask_ad(orig_pte));
+}
+
+void __napotpte_try_fold(struct mm_struct *mm, unsigned long addr,
+			 pte_t *ptep, pte_t pte)
+{
+	struct page *page;
+	struct folio *folio;
+	unsigned long folio_start, folio_end;
+	unsigned long cont_start, cont_end;
+	unsigned long pfn;
+	pgprot_t prot;
+	pte_t expected, cur;
+	pte_t *start;
+	unsigned int i, nr;
+
+	if (!napot_hw_supported() || !mm_is_user(mm))
+		return;
+
+	if (!pte_present(pte) || pte_napot(pte) || pte_special(pte))
+		return;
+
+	/*
+	 * Driver __GFP_COMP pages inserted by vm_insert_page() have valid
+	 * compound metadata. Fold them only after verifying the whole supported
+	 * Svnapot range is identical and contiguous.
+	 */
+	page = pte_page(pte);
+	folio = page_folio(page);
+	folio_start = addr - (page - &folio->page) * PAGE_SIZE;
+	folio_end = folio_start + folio_nr_pages(folio) * PAGE_SIZE;
+	cont_start = napot_align_addr(addr);
+	cont_end = cont_start + napotpte_size();
+	if (folio_start > cont_start || folio_end < cont_end)
+		return;
+
+	nr = napotpte_pte_num();
+	start = napot_align_ptep(ptep);
+
+	pfn = ALIGN_DOWN(pte_pfn(pte), nr);
+	prot = pte_pgprot(pte_mask_ad(pte));
+	expected = pfn_pte(pfn, prot);
+
+	/*
+	 * The caller must hold the PTL across validation and conversion.
+	 * Software PTE updates are serialized by the PTL; hardware A/D updates
+	 * may race and are re-read and folded into target by napotpte_convert().
+	 */
+	for (i = 0; i < nr; i++) {
+		cur = READ_ONCE(start[i]);
+		if (pte_val(pte_mask_ad(cur)) != pte_val(expected))
+			return;
+		pte_val(expected) += 1UL << _PAGE_PFN_SHIFT;
+	}
+
+	expected = pte_mknapot(pfn_pte(pfn, prot), napotpte_order());
+	napotpte_convert(mm, addr, ptep, expected);
+}
+EXPORT_SYMBOL(__napotpte_try_fold);
+
+void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, pte_t pte)
+{
+	pte_t target;
+	pgprot_t prot;
+
+	if (!napot_hw_supported() || !mm_is_user(mm) ||
+	    !pte_present_napot(pte))
+		return;
+
+	prot = __pgprot(pte_protval_no_pfn_no_napot(pte));
+	target = pfn_pte(pte_pfn(pte), prot);
+
+	napotpte_convert(mm, addr, ptep, target);
+}
+EXPORT_SYMBOL(__napotpte_try_unfold);
+
+pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte)
+{
+	pte_t pte, cur;
+	pte_t *start;
+	unsigned int i, nr;
+
+	if (!napot_hw_supported() || !pte_present_napot(orig_pte))
+		return orig_pte;
+
+	pte = orig_pte;
+	start = napot_align_ptep(ptep);
+	nr = napotpte_pte_num();
+
+	for (i = 0; i < nr; i++) {
+		cur = READ_ONCE(start[i]);
+		if (!napotpte_is_consistent(cur, orig_pte))
+			return napotpte_subpte(ptep, orig_pte);
+		if (pte_dirty(cur))
+			pte = riscv_pte_mkhwdirty(pte);
+		if (pte_young(cur))
+			pte = pte_mkyoung(pte);
+	}
+
+	return napotpte_subpte(ptep, pte);
+}
+EXPORT_SYMBOL(napotpte_ptep_get);
+
+pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
+{
+	pte_t orig_pte, pte;
+	pte_t *ptep;
+	unsigned int i, nr;
+
+	if (!napot_hw_supported())
+		return READ_ONCE(*orig_ptep);
+
+	nr = napotpte_pte_num();
+
+retry:
+	orig_pte = READ_ONCE(*orig_ptep);
+	if (!pte_present_napot(orig_pte))
+		return orig_pte;
+
+	ptep = napot_align_ptep(orig_ptep);
+
+	for (i = 0; i < nr; i++, ptep++) {
+		pte = READ_ONCE(*ptep);
+
+		if (!napotpte_is_consistent(pte, orig_pte))
+			goto retry;
+
+		if (pte_dirty(pte))
+			orig_pte = riscv_pte_mkhwdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+
+	return napotpte_subpte(orig_ptep, orig_pte);
+}
+EXPORT_SYMBOL(napotpte_ptep_get_lockless);
-- 
2.39.5

