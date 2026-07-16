Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8311541E6D3
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205820; cv=none; b=OgbzmlB7J/YfJqewwstmwlrR0yN6goS+cUKW/Wbe2zr74cdhD6ZE9NDUCyYKbUEdRQSLkUADaBhvvjtVi7UzOd9sy1fVHw1hNOei5/eJT5bxYrziPUpg9j5i5iLr502XsHQaIBjwgSDVzlkq7EF9u2LOjkjwGvU2cL99KFarGak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205820; c=relaxed/simple;
	bh=0k8mNrfRtb2i2Q5iPvc0HG7PxgNCQ+rZMgvG4YMKhTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ixkKIqSYPsPD5TQnpzqdgNMNzV4YyLDLmd2nfpIWxU+fuIPQ1Fh8AooiI4VE6YCwUQHNr4So8VFVveZF0EPFJ7Yu8bNd/suIldLExUQEwlqpsdJ0cyNTM1duhHk0kIq8h1snUzM0qKBMBLXoCiyPWnxRG74qJVlOjhpdmfvfY4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i8x6AC9e; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i8x6AC9e"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so4804190a12.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205818; x=1784810618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z21FwdUtYh7DDT6q0cWRgWwFAJ8AfleqYSoyR88c720=;
        b=i8x6AC9elZaZQMgyoJBO/FBURc8HJZZDeQFZnTN+h9igcesukhcYcoPVC1U/PNqn9D
         WVFLxqxfoJaUSObtSZZcZDfrDfW4hRPWSn2r4fPmLLVzpz2ivBWGcxx44iZgsYykmUOM
         XhOm5Twe/Dg7viY1Yo9KDO3jaFIl2sjrkj8IYqEwaHgmD/3934toJ7KNTJJ6SV41HJcX
         NsoWgEclGiObpOj5MDXI9wiOkLlWnQQx3XxdSxD2KDMrNN2CEEKRdq9P/FKVdsfW0m33
         5uHZ9fhdfMyof84L6mPCzWXmlHo39UrRsxFvK6HpYt8cXNP9F29FnvK7fLbgmT2uIf0G
         O/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205818; x=1784810618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z21FwdUtYh7DDT6q0cWRgWwFAJ8AfleqYSoyR88c720=;
        b=Sd1kwTRV3ZmYFZ3ypTKGZsIyM2qEPnPXYOGP9vtYBa8lcV2z1Q8Q+fvvfEd597YOWz
         NbYgwburvJ1YuO362sozcNR3EbNsMBxii8wh4SY4L9d/COei/wSaoKyCYisIS2YQTca8
         1TEiMgl8+0v6AqVw138MUbx8Kf4T4c+fAW8UhtmFrE7eC3K1oMZnuev5XUEypmbaXSNJ
         uaJe45Kj3bO2Q02Oq9hl8MIPKWerVfny1mdUOVHmLMlwhIiF93/zzDpPcHEDwUPL0DuI
         y0AHHYLc36OiJ6CtucLRK0AhNWK6iE1PHm1kLE9lcAFvBogqJ/wL7UQdRUAQBY6FlVA7
         O1DQ==
X-Gm-Message-State: AOJu0Yws3vNZhY3EUF/54+2XNuFTnaJADs3+bt4TWoeQmE7r5a+5pl94
	ATo7OqwtFop7JTpROk52RupCv5NNACw7o6ICAL+iQ5MjgSZlXhMjpCstBtyYTyLnQio=
X-Gm-Gg: AfdE7clnqTEdLSyZkFng+O3wYWadPChwf61rVIgNf5W0TmFqmsMU9gvaIgc0rRApnp0
	VdsQdpHhIylj8yq7RDvQcdaVFnhF6O+8aPj1vjWZqypJVHT+exS9v9KlWxMGfJRtHGojlQoP8ZI
	v5km3jl6RFuYpyOkdKHwXe7T0dT0oKEtrBgED/Xc8DirfakJ+upWbeRGdW11izUJ5mPReeKWClh
	41g5W3uz78fj57Qk0PrXaWR2gmdM8D+qzfxghwtPPgp89vT/+VPEq6yMQZ4XCqjBEBmxtywvDAN
	/AYbSXqLbkCFCiJOkbgVZE5SoLX+TV/PrNsBgSGmjItdXTSjRvpJ7o3aaNpZNY1BiM0SLIpxTD8
	UeGAwS28Q9D9cqqRQ696J2n8yINV/zHveyYFrkeuHr6TxiLhNqBIYlRjbXRBY8cqtA2M2B6ZpUq
	e9+HiOL0p3dSWZQSqqrUI+qJQ=
X-Received: by 2002:a05:6a21:a98:b0:3bf:6c08:fb88 with SMTP id adf61e73a8af0-3c36c3e7638mr7532060637.56.1784205817786;
        Thu, 16 Jul 2026 05:43:37 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.43.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:43:37 -0700 (PDT)
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
Subject: [PATCH v2 06/15] riscv: make pte_batch_hint() honor folio batch flags
Date: Thu, 16 Jul 2026 20:41:41 +0800
Message-Id: <40bc1db57d1fdad482a32ca6aa95031f7d5676e1.1784201104.git.cuiyunhui@bytedance.com>
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

Svnapot folded mappings may be exposed through a logical per-page PTE
view instead of the raw encoded block entry. Generic folio batching code
already defines which PTE bits are ignored when comparing entries, and
folded mappings need to use the same comparison rules. Otherwise RISC-V
can reject a batch that generic MM would consider equivalent simply
because the hint path compared a different view of the same mapping.

Install a Svnapot-aware pte_batch_hint() implementation. If the caller
passes a logical sub-PTE instead of a raw NAPOT entry, rebuild the
corresponding block PTE first, apply the same folio batch flags as the
generic batching code, and only return a multi-entry hint if the
remaining raw PTEs in the folded block still match.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 26 +++++++++++++
 arch/riscv/mm/contpte.c          | 66 ++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 771faabb2b00b..da7ffea0dcd98 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -6,6 +6,13 @@
 #ifndef _ASM_RISCV_PGTABLE_H
 #define _ASM_RISCV_PGTABLE_H
 
+#ifndef __ASSEMBLY__
+#ifndef __LINUX_FPB_T
+#define __LINUX_FPB_T
+typedef int __bitwise fpb_t;
+#endif
+#endif
+
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
@@ -591,6 +598,8 @@ void napotpte_clear_young_dirty_ptes(struct vm_area_struct *vma,
 				     unsigned int nr, cydp_t flags);
 void napotpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 			     pte_t *ptep, unsigned int nr);
+unsigned int napotpte_pte_batch_hint_from_pte(pte_t *ptep, pte_t orig_pte,
+					      fpb_t flags);
 int napotpte_ptep_set_access_flags(struct vm_area_struct *vma,
 				   unsigned long address, pte_t *ptep,
 				   pte_t entry, int dirty);
@@ -1033,6 +1042,16 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return napotpte_ptep_clear_flush_young(vma, address, ptep);
 }
 
+#define pte_batch_hint pte_batch_hint
+static inline unsigned int
+pte_batch_hint(pte_t *ptep, pte_t pte, fpb_t flags)
+{
+	if (!pte_present(pte))
+		return 1;
+
+	return napotpte_pte_batch_hint_from_pte(ptep, pte, flags);
+}
+
 #else /* CONFIG_RISCV_ISA_SVNAPOT */
 
 #define napotpte_ptep_set_access_flags(vma, address, ptep, entry, dirty) \
@@ -1095,6 +1114,13 @@ static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young __ptep_clear_flush_young
 
+#define pte_batch_hint pte_batch_hint
+static inline unsigned int
+pte_batch_hint(pte_t *ptep, pte_t pte, fpb_t flags)
+{
+	return 1;
+}
+
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 #define set_pte __set_pte
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 3f8a0a2970afb..9ffdffdc2b0c0 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -176,6 +176,32 @@ static inline bool napotpte_is_consistent(pte_t pte, pte_t orig_pte)
 	       pte_val(pte_mask_ad(pte)) == pte_val(pte_mask_ad(orig_pte));
 }
 
+static inline bool
+napotpte_is_batch_consistent(pte_t pte, pte_t batch_pte, fpb_t flags)
+{
+	return pte_present_napot(pte) &&
+	       pte_val(__pte_batch_clear_ignored(pte, flags)) ==
+	       pte_val(batch_pte);
+}
+
+static inline pte_t
+napotpte_normalize_batch_pte(pte_t *ptep, pte_t orig_pte, fpb_t flags)
+{
+	unsigned long pfn;
+	pgprot_t prot;
+	unsigned int off;
+
+	if (pte_present_napot(orig_pte))
+		return __pte_batch_clear_ignored(orig_pte, flags);
+
+	off = ptep - napot_align_ptep(ptep);
+	pfn = pte_pfn(orig_pte) - off;
+	prot = __pgprot(pte_protval_no_pfn_no_napot(orig_pte));
+
+	return __pte_batch_clear_ignored(pte_mknapot(pfn_pte(pfn, prot),
+					     napotpte_order()), flags);
+}
+
 static bool napotpte_all_subptes_same(pte_t *ptep, pte_t expected_pte)
 {
 	pte_t *start;
@@ -328,6 +354,46 @@ pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
 }
 EXPORT_SYMBOL(napotpte_ptep_get_lockless);
 
+unsigned int napotpte_pte_batch_hint_from_pte(pte_t *ptep, pte_t orig_pte,
+					      fpb_t flags)
+{
+	pte_t batch_pte, pte;
+	pte_t *start;
+	unsigned int i, nr, off;
+
+	if (!napot_hw_supported())
+		return 1;
+
+	if (!pte_present_napot(orig_pte) && !pte_present_napot(READ_ONCE(*ptep)))
+		return 1;
+
+	/*
+	 * @orig_pte may be either the raw NAPOT entry read from the page
+	 * table or the logical sub-PTE returned by ptep_get(). In the latter
+	 * case, the public view has the NAPOT bit stripped and the PFN adjusted
+	 * by the slot offset within the folded block.
+	 *
+	 * If the caller passes a logical sub-PTE, rebuild the corresponding
+	 * block PTE first. Then apply the same folio batch flags as the generic
+	 * batching code, and only return a multi-entry hint if every remaining
+	 * raw PTE in the folded block still matches.
+	 */
+	batch_pte = napotpte_normalize_batch_pte(ptep, orig_pte, flags);
+
+	start = napot_align_ptep(ptep);
+	nr = napotpte_pte_num();
+	off = ptep - start;
+
+	for (i = off; i < nr; i++) {
+		pte = READ_ONCE(start[i]);
+		if (!napotpte_is_batch_consistent(pte, batch_pte, flags))
+			return 1;
+	}
+
+	return nr - off;
+}
+EXPORT_SYMBOL(napotpte_pte_batch_hint_from_pte);
+
 static void napotpte_try_unfold_range(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep,
 				      unsigned int nr)
-- 
2.39.5

