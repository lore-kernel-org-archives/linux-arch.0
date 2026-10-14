Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48F40F74B
	for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2026 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950371; cv=none; b=OLJNOTkmB9nPPRkKsqg+jMAQllV71GlgBegBLw7lWCQ3e+PX8/Et0bL01VEnj70CPab40qvWG0LaLWiut2jZMAizIaHEXSZ3GwBDJNLdMVEWrrpydvQSAJToHy4PSR43JHa9XSZZHlqoLm46pM69QMJMBoBZtTTDoYImHliqxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950371; c=relaxed/simple;
	bh=2w5umFoZK3WNnwboh5jSN7oXDRrASZlgjKUz9nnxA94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZ2pCAr6/7ulubpJ6+sq6IZiWJ5zW+Yf+OodJ2C4Me8+kZNm90OQVdrSub3X3mkV7Fx91n5TcV9eFPEWMFrnu6eDTO5FCki83d+fJ2ao5dCt/DGimf6mzarWVkqYInL5PAluDyEpOa8Y/M+Pjqo+x4Etw3MwiGHV/U0tOAGt2h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KzKFi4pq; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KzKFi4pq"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a706146559so2227007a91.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 20:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791950369; x=1792555169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzz+6ZrUL/XqwIV03DwVqkSlHpqf/7QArXuFo8Cud/0=;
        b=KzKFi4pqtrMihXZ4/MTKtfH/6CDKpdDKrWa19JHLohLJMoZx8RMHXA8QPeXBZWUXzr
         P1/qSZLOPKIFnK+H0pal7ttU1eKn1MuOyHXLz/iNSlVSW4M9Kj0Ca6fRMGZHdv+ibxRN
         0YYIwQ4ZzCsKFNoTy+tjFkJejY0Ry9SejNLFtA4xkodmXhTtIu/oIIzUAXbOTmGRN37e
         kkiJ/kqQrYYpZG6jpuSAXWM6540S9+SSoIZKoHwL8AupP/KXu2Ydo00hIBpI53BzcSbL
         ZLjbX2tPTlOclaFf5JRdiwstWuYwSeqJaIrdAXcZuYTSRPBag+NQFaNmUgf8J0+GYXyb
         dGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791950369; x=1792555169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uzz+6ZrUL/XqwIV03DwVqkSlHpqf/7QArXuFo8Cud/0=;
        b=dpScoGgMGzjbkN0DczBcApX2ApbIk974EiTXKR1LC6B6iWdxFSs2rYN1RBKqEfHXVM
         p+CEW+9x2khyfvOpQAC1daqp8tm5qQE2En4qGtMZHiWHI2ChiRcIKiIaDPWjkMIqrU3I
         ALof4S1FSabp4wkCI7RmvFO79eAHKOlKsa/kCUI3FYvyymozOhKWoK9HumzwLSBA1P4M
         S6StD00k6wrarfKyRPejV4DU16PguAl0oa3fwxpFPnlZChIdz/IVnHe28A/N1izTCX+/
         IcmvW0wmM98GBChg17GnZiOmHDeFmyoyRzfXRxCEtWY6IBZ6YBxudSBmWS5kBTxfCUcD
         xW6A==
X-Forwarded-Encrypted: i=1; AKwUvBzNIIrqibhvC/Kb3FfuxZDEGC9LDx2a4awydbWJmDNY00rmbSOuqaeFJW2zmaWTDR004Ly5NN4i6mFc@vger.kernel.org
X-Gm-Message-State: AFq9FYJOVtfz1dS8WR1OdOVia7wBrkFq+11Z4rAx3GEROTuGrzKbG4Xv
	SgRcW4EpRdRZwo+s1JMTM3Mo0LTgYBgS22gXL9E9qrYSSiHRln+iblZZujsdqjOOSSk=
X-Gm-Gg: AYBFou3DQIVbjTSQosSOSTAJ+rlM2WaVwnbuq8qQScf4bHR8Zj/ccbqOTg6T54E/ogD
	uRnkaEUbPzZgb/oMrfwzfxyPX7oNeJOC84KszxJhZXAklUBg7rPrfmjbgwiapnia5CpIQxbUqfv
	n9frkITVtoDmhyDItaWti4pMcZ4eEU5YN4fub+g9HcKE7Xejlu3RhvAXI5/gdNIQzVQaFTrkPDi
	tOAxghDf4VHtZF11Mknz6SBS1uzlXOJeNjBNENgBMaW6NKdRfZ2+6sEIAwHS9cgBEqP20t6EGD0
	z1tYldcu3V/qKZVnZeZuCAieolcsF/iK+J9vAcKX3xI9cQFAFp2ASUMpWuBpyUL5doRLNuRFE9V
	zFej/Ovl7R35pPrqlPRe6cixPdoyvR3EPURJpiddNCoXVE0zfJd+khyO0Ko89rBMhTkwWvcCUMf
	m1FpzcMEOle7O5/87v39nCu0VFKuKYQuCoNwH0kSaROQizWKbVsB2kztOsxlc0+7ek63yD+u9x9
	GtrxHT5iAf3MwFxL4a6
X-Received: by 2002:a17:90a:d44d:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3ab39fea5c6mr13397037a91.0.1791950368643;
        Tue, 13 Oct 2026 20:59:28 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24a538sm2492305a91.9.2026.10.13.20.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:59:28 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mm: generalize PMD page table allocation
Date: Wed, 14 Oct 2026 11:59:09 +0800
Message-ID: <20261014035910.687847-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014035910.687847-1-songmuchun@bytedance.com>
References: <20261014035910.687847-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The generic PMD allocator assumes order-0 page tables and zero-valued
empty entries. MIPS and LoongArch need pmd_init() to install their invalid
entries, while MIPS and parisc use PMD_TABLE_ORDER to describe the
allocation size.

Default PMD_TABLE_ORDER to zero, honor architecture overrides, and invoke
pmd_init() from the generic allocator. MIPS, LoongArch, and parisc can then
use the generic GFP selection, constructor handling, and kernel ptdesc
marking instead of duplicating most of the helper.

Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/loongarch/include/asm/pgalloc.h | 21 ---------------------
 arch/mips/include/asm/pgalloc.h      | 25 -------------------------
 arch/parisc/include/asm/pgalloc.h    | 17 -----------------
 include/asm-generic/pgalloc.h        | 12 ++++++++++--
 4 files changed, 10 insertions(+), 65 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index a3f93a8b58be..1fc9a0751f19 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -8,7 +8,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-#define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
 #include <asm-generic/pgalloc.h>
 
@@ -47,26 +46,6 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 #define __pte_free_tlb(tlb, pte, address)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #ifndef __PAGETABLE_PMD_FOLDED
-
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	pmd_t *pmd;
-	struct ptdesc *ptdesc;
-
-	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, 0);
-	if (!ptdesc)
-		return NULL;
-
-	if (!pagetable_pmd_ctor(mm, ptdesc)) {
-		pagetable_free(ptdesc);
-		return NULL;
-	}
-
-	pmd = ptdesc_address(ptdesc);
-	pmd_init(pmd);
-	return pmd;
-}
-
 #define __pmd_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 9ec9cf01e92e..2f123455e363 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -13,7 +13,6 @@
 #include <linux/mm.h>
 #include <linux/sched.h>
 
-#define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
 #include <asm-generic/pgalloc.h>
 
@@ -29,11 +28,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
 }
 
-/*
- * Initialize a new pmd table with invalid pointers.
- */
-extern void pmd_init(void *addr);
-
 #ifndef __PAGETABLE_PMD_FOLDED
 
 static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
@@ -52,25 +46,6 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #ifndef __PAGETABLE_PMD_FOLDED
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	pmd_t *pmd;
-	struct ptdesc *ptdesc;
-
-	ptdesc = pagetable_alloc(GFP_KERNEL_ACCOUNT, PMD_TABLE_ORDER);
-	if (!ptdesc)
-		return NULL;
-
-	if (!pagetable_pmd_ctor(mm, ptdesc)) {
-		pagetable_free(ptdesc);
-		return NULL;
-	}
-
-	pmd = ptdesc_address(ptdesc);
-	pmd_init(pmd);
-	return pmd;
-}
-
 #define __pmd_free_tlb(tlb, x, addr)	tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
 
 #endif
diff --git a/arch/parisc/include/asm/pgalloc.h b/arch/parisc/include/asm/pgalloc.h
index 3b84ee93edaa..880a3e9ad0cb 100644
--- a/arch/parisc/include/asm/pgalloc.h
+++ b/arch/parisc/include/asm/pgalloc.h
@@ -10,7 +10,6 @@
 
 #include <asm/cache.h>
 
-#define __HAVE_ARCH_PMD_ALLOC_ONE
 #include <asm-generic/pgalloc.h>
 
 /* Allocate the top level pgd (page directory) */
@@ -29,22 +28,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 			(__u32)(__pa((unsigned long)pmd) >> PxD_VALUE_SHIFT)));
 }
 
-static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	struct ptdesc *ptdesc;
-	gfp_t gfp = GFP_PGTABLE_USER;
-
-	if (mm == &init_mm)
-		gfp = GFP_PGTABLE_KERNEL;
-	ptdesc = pagetable_alloc(gfp, PMD_TABLE_ORDER);
-	if (!ptdesc)
-		return NULL;
-	if (!pagetable_pmd_ctor(mm, ptdesc)) {
-		pagetable_free(ptdesc);
-		return NULL;
-	}
-	return ptdesc_address(ptdesc);
-}
 #endif
 
 static inline void
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index a1de7d246754..68e473908758 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -125,6 +125,10 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
+#ifndef PMD_TABLE_ORDER
+#define PMD_TABLE_ORDER	0
+#endif
+
 #ifndef __HAVE_ARCH_PMD_ALLOC_ONE
 /**
  * pmd_alloc_one - allocate memory for a PMD-level page table
@@ -140,11 +144,12 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long addr)
 {
 	struct ptdesc *ptdesc;
+	pmd_t *pmd;
 	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp = GFP_PGTABLE_KERNEL;
-	ptdesc = pagetable_alloc_noprof(gfp, 0);
+	ptdesc = pagetable_alloc_noprof(gfp, PMD_TABLE_ORDER);
 	if (!ptdesc)
 		return NULL;
 	if (!pagetable_pmd_ctor(mm, ptdesc)) {
@@ -152,10 +157,13 @@ static inline pmd_t *pmd_alloc_one_noprof(struct mm_struct *mm, unsigned long ad
 		return NULL;
 	}
 
+	pmd = ptdesc_address(ptdesc);
+	pmd_init(pmd);
+
 	if (mm == &init_mm)
 		ptdesc_set_kernel(ptdesc);
 
-	return ptdesc_address(ptdesc);
+	return pmd;
 }
 #define pmd_alloc_one(...)	alloc_hooks(pmd_alloc_one_noprof(__VA_ARGS__))
 #endif
-- 
2.54.0

