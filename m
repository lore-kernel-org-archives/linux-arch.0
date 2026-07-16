Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22735420860
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205891; cv=none; b=fz9KNMGqzmnwTiij6Sp3oXOg6pGLb/UyX8kLIE7KVWlDm92qibqjRdfh8auqYTcH9XXi82WYBhfhR8tcNfgboKtv3NreM1y2wwZEZxCZD9pw1d2q+8GnrfHu6/I4sxzUak59FSedu3mcUj8Ac4kLvBNg0FCGocHqHy2QKgW9fAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205891; c=relaxed/simple;
	bh=8QB7Nm89twoLMmPuv/JvcX/X4fT+yA9XR/MJbmS0oGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcQTmR2EErpIGyME4dGpEJrB2FgVYwo6Xy/J2HUwz4L4Zo6demH3aGZroy9091N8XXrMw0GOnWxBg/YvMZslU5UO4ahcaS+ZEy8iBfXB3o1tUI4N4hjyn8s9EaDKXQpVwKZmh+nQwy3/HvyZ2kFUtMXIh+dLfVHxsRrIggUH+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EN4Ycm9g; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EN4Ycm9g"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so2849517a12.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205889; x=1784810689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P62EVeZeD6Lr+EK73ByExkJlzskm2POoZpW1kwtVtAQ=;
        b=EN4Ycm9g0slYOsJopCov6pgza00nzUbxRgBoSu5NYgP8H4wRZnzQbKMJBIslkss026
         CVeC+X3pJWuKv/yminjErCaOhH78K6kiunf6OnjQjVAsKOCbKm6IEsQ/kylcQ8hrq1hF
         TQgVMzZ9ISmKRUR4YX10lCclrIlonYJJSTHXl/1nD7xQhg+X5X3/CyDSzMwTT9YnK70o
         e3EVd2d8ftse+yNHg1yP1cDp5BJt8wO2yzuFgaqtqKqWSblQF1hiMfwB5kfAX3cv/Vil
         x7u0r2f0Az9SkEk9j0VZ44ODMu04mq4YzOH69cX6U+QpvOGEIgRGkU+ZGBxSRtZi3Jmx
         gdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205889; x=1784810689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P62EVeZeD6Lr+EK73ByExkJlzskm2POoZpW1kwtVtAQ=;
        b=fD331n1gAEo97uGA2z8u+HJ9K3FI6yNA6KZEjo6rvgCV9cYrzdbQp9srcJyZo9G0YB
         t6EfVq3BPEvs9LaMNe8FeDX5phMm1iM3NUidOshSeIY0r+S+n32sFXwaOmFnCX7VbHes
         iANP+3U4YSvaz+7y31DIlpyGH/kjeg+fAMimSFXY3PtpXjHs0msjD5R215wba2NGlbKI
         JgW2EX8PrYGtvASzl1sxuBlOugVZvYWQx0u1+gXDyJ11TAn4PDm2OOlYIoQLOi75cd4m
         LKphiyKg6Vo4alJR3doawLExlOHw7XBVhvbi9kDUdu0WE0qgdCajoGyGtsJVhLNw6E8h
         kfnw==
X-Gm-Message-State: AOJu0Yyjzlksk+GQh+r6ZXKMiO/4uPkYgPrN00s6+FzK15TMTOGXj+jD
	KTzhToAISSKa8PjkNJJnsjo6QdximtO570/pKYojIR5xGFYmABh8X2vMunNmChO7mJ9doBLYy8Z
	aRNgN1zo=
X-Gm-Gg: AfdE7cm89qn90p7MRwBaYjOXTwMGPXOWuDO2erI3BYNxJowGzpUfWKzxsi+DF+5esQa
	ecB9FKxNATgvKWnL2KQ1XvWmXdfMRrYZlPNlG3ATYX1Shrlq5pSL6BvmGNesUFQAqZX0yFTi9ZH
	x083IrJzIygsf6IDk3UJ5XfOU16R7dvRPbSXq7Qd6iocezlASu7UndVCfYXT4geJNY0QjOFqmsY
	qckDpqJQ77r4bZZzK6r980QcTr1s7NJ2RxyCJAx/KkNpnl1bxwkrVmGOf46rGdVRjuCLYcBD3WM
	trw6KmZ5M8/Ueia2ncuWXH9q3iHruJrxP+p6XnsZ+unynW8Kj+ffGAA+p1M+6dC+54MrN16FiQa
	Q2MXPfSeGXrxOlpXjlHLevHZPZtoi0G4xdGCikRCgrR7jOMMTGsbVPyiuQuu/08rlzwG6/QUUBM
	NqBipgXfBaZFf9A5zI8qWT7Bg=
X-Received: by 2002:a05:6a21:7117:b0:3c3:89ce:b5bc with SMTP id adf61e73a8af0-3c389ced5b6mr3647677637.15.1784205889298;
        Thu, 16 Jul 2026 05:44:49 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:48 -0700 (PDT)
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
Subject: [PATCH v2 14/15] riscv/mm: optimize mprotect for Svnapot mappings
Date: Thu, 16 Jul 2026 20:41:49 +0800
Message-Id: <8b79ddc3311e1dc32b150b7efbaed5a187ee5ccd.1784201104.git.cuiyunhui@bytedance.com>
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

Svnapot represents a naturally aligned range as a block of base PTEs, but
generic mprotect() still processes a full block one base PTE at a time.
For a full-block permission change, that repeatedly clears and reinstalls
the same logical mapping and then has to reconstruct the folded Svnapot
block afterwards, making the operation unnecessarily expensive.

Use the batched protection transaction hooks to handle a full Svnapot
block as one operation. The fast path is restricted to user mappings
where hardware Svnapot is supported, the range is exactly one aligned
Svnapot block, and every sub-PTE is consistent with the block PTE. The
generic per-PTE fallback remains in place for partial, unaligned, special,
non-user, or otherwise inconsistent mappings.

libMicro mprotect median latency improves on the full-block cases:

  mprot_tw4m   (-l 4m   -w -t -f /dev/zero): 40.4 us -> 4.3 us
  mprot_tw128k (-l 128k -w -t -f /dev/zero): about 15-16% faster

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h |  8 ++++
 arch/riscv/mm/contpte.c          | 76 ++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 3727c148fa0fc..b546e6614c558 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -619,6 +619,14 @@ int napotpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				       unsigned long address, pte_t *ptep);
 int napotpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 				    unsigned long address, pte_t *ptep);
+#define modify_prot_start_ptes modify_prot_start_ptes
+pte_t modify_prot_start_ptes(struct vm_area_struct *vma,
+			     unsigned long addr, pte_t *ptep,
+			     unsigned int nr);
+#define modify_prot_commit_ptes modify_prot_commit_ptes
+void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *ptep, pte_t old_pte, pte_t pte,
+			     unsigned int nr);
 #endif
 
 #ifdef CONFIG_ARCH_HAS_PTE_PROTNONE
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 8289f39d6e188..6a1156629d115 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -190,6 +190,82 @@ napotpte_is_batch_consistent(pte_t pte, pte_t batch_pte, fpb_t flags)
 	       pte_val(batch_pte);
 }
 
+static bool napotpte_can_modify_prot_block(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep,
+					   unsigned int nr, pte_t *raw_pte)
+{
+	pte_t raw, pte;
+	unsigned int i;
+
+	if (!napot_hw_supported() || !mm_is_user(mm))
+		return false;
+
+	if (nr != napotpte_pte_num())
+		return false;
+
+	if (addr != napot_align_addr(addr) || ptep != napot_align_ptep(ptep))
+		return false;
+
+	raw = READ_ONCE(*ptep);
+	if (!pte_present_napot(raw) || pte_special(raw))
+		return false;
+
+	for (i = 0; i < nr; i++) {
+		pte = READ_ONCE(ptep[i]);
+		if (!napotpte_is_consistent(pte, raw))
+			return false;
+	}
+
+	*raw_pte = raw;
+	return true;
+}
+
+pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *ptep, unsigned int nr)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long ptent_addr;
+	pte_t raw, pte, ptent;
+	unsigned int i;
+
+	if (napotpte_can_modify_prot_block(mm, addr, ptep, nr, &raw)) {
+		pte = pte_mknonnapot(raw, addr);
+
+		for (i = 0; i < nr; i++) {
+			ptent_addr = addr + i * PAGE_SIZE;
+			ptent = __ptep_get_and_clear_noptc(ptep + i);
+			page_table_check_pte_clear(mm, ptent_addr,
+						   pte_mknonnapot(ptent, ptent_addr));
+			if (pte_dirty(ptent))
+				pte = riscv_pte_mkhwdirty(pte);
+			if (pte_young(ptent))
+				pte = pte_mkyoung(pte);
+		}
+
+		return pte;
+	}
+
+	pte = __ptep_modify_prot_start(vma, addr, ptep);
+	while (--nr) {
+		ptep++;
+		addr += PAGE_SIZE;
+		ptent = __ptep_modify_prot_start(vma, addr, ptep);
+		if (pte_dirty(ptent))
+			pte = pte_mkdirty(pte);
+		if (pte_young(ptent))
+			pte = pte_mkyoung(pte);
+	}
+
+	return pte;
+}
+
+void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned long addr,
+			     pte_t *ptep, pte_t old_pte, pte_t pte,
+			     unsigned int nr)
+{
+	set_ptes(vma->vm_mm, addr, ptep, pte, nr);
+}
+
 static inline pte_t
 napotpte_normalize_batch_pte(pte_t *ptep, pte_t orig_pte, fpb_t flags)
 {
-- 
2.39.5

