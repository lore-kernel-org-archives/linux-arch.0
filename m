Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f73.google.com ([209.85.166.73]:49038 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfCLA6I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Mar 2019 20:58:08 -0400
Received: by mail-io1-f73.google.com with SMTP id w19so574857ioa.15
        for <linux-arch@vger.kernel.org>; Mon, 11 Mar 2019 17:58:07 -0700 (PDT)
Date: Mon, 11 Mar 2019 18:57:48 -0600
In-Reply-To: <20190312005749.30166-1-yuzhao@google.com>
Message-ID: <20190312005749.30166-3-yuzhao@google.com>
Mime-Version: 1.0
References: <20190310011906.254635-1-yuzhao@google.com> <20190312005749.30166-1-yuzhao@google.com>
Subject: [PATCH v4 3/4] arm64: mm: call ctor for stage2 pmd page
From: Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Joel Fernandes <joel@joelfernandes.org>, "Kirill A . Shutemov" <kirill@shutemov.name>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Chintan Pandya <cpandya@codeaurora.org>, Jun Yao <yaojun8558363@gmail.com>, Laura Abbott <labbott@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Yu Zhao <yuzhao@google.com>
Message-ID: <20190312005748.5dUZgSA8EYB7FChE2KWVwoeHEGZSl_hmQyKoSCQ4YS8@z>

Call pgtable_pmd_page_dtor() for pmd page allocated by
mmu_memory_cache_alloc() so kernel won't crash when it's freed
through stage2_pmd_free()->pmd_free()->pgtable_pmd_page_dtor().

This is needed if we are going to enable split pmd pt lock.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 arch/arm64/include/asm/stage2_pgtable.h | 15 ++++++++++++---
 virt/kvm/arm/mmu.c                      | 13 +++++++++++--
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/stage2_pgtable.h b/arch/arm64/include/asm/stage2_pgtable.h
index 5412fa40825e..0d9207144257 100644
--- a/arch/arm64/include/asm/stage2_pgtable.h
+++ b/arch/arm64/include/asm/stage2_pgtable.h
@@ -174,10 +174,19 @@ static inline bool stage2_pud_present(struct kvm *kvm, pud_t pud)
 		return 1;
 }
 
-static inline void stage2_pud_populate(struct kvm *kvm, pud_t *pud, pmd_t *pmd)
+static inline int stage2_pud_populate(struct kvm *kvm, pud_t *pud, pmd_t *pmd)
 {
-	if (kvm_stage2_has_pmd(kvm))
-		pud_populate(NULL, pud, pmd);
+	if (!kvm_stage2_has_pmd(kvm))
+		return 0;
+
+	/* paired with pgtable_pmd_page_dtor() in pmd_free() below */
+	if (!pgtable_pmd_page_ctor(virt_to_page(pmd))) {
+		free_page((unsigned long)pmd);
+		return -ENOMEM;
+	}
+
+	pud_populate(NULL, pud, pmd);
+	return 0;
 }
 
 static inline pmd_t *stage2_pmd_offset(struct kvm *kvm,
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index e9d28a7ca673..11922d84be83 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -1037,6 +1037,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			     phys_addr_t addr)
 {
+	int ret;
 	pud_t *pud;
 	pmd_t *pmd;
 
@@ -1048,7 +1049,9 @@ static pmd_t *stage2_get_pmd(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
 		if (!cache)
 			return NULL;
 		pmd = mmu_memory_cache_alloc(cache);
-		stage2_pud_populate(kvm, pud, pmd);
+		ret = stage2_pud_populate(kvm, pud, pmd);
+		if (ret)
+			return ERR_PTR(ret);
 		get_page(virt_to_page(pud));
 	}
 
@@ -1061,6 +1064,9 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struct kvm_mmu_memory_cache
 	pmd_t *pmd, old_pmd;
 
 	pmd = stage2_get_pmd(kvm, cache, addr);
+	if (IS_ERR(pmd))
+		return PTR_ERR(pmd);
+
 	VM_BUG_ON(!pmd);
 
 	old_pmd = *pmd;
@@ -1198,6 +1204,7 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 			  phys_addr_t addr, const pte_t *new_pte,
 			  unsigned long flags)
 {
+	int ret;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte, old_pte;
@@ -1227,7 +1234,9 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_mmu_memory_cache *cache,
 		if (!cache)
 			return 0; /* ignore calls from kvm_set_spte_hva */
 		pmd = mmu_memory_cache_alloc(cache);
-		stage2_pud_populate(kvm, pud, pmd);
+		ret = stage2_pud_populate(kvm, pud, pmd);
+		if (ret)
+			return ret;
 		get_page(virt_to_page(pud));
 	}
 
-- 
2.21.0.360.g471c308f928-goog
