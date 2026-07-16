Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F3641F370
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205773; cv=none; b=Tazmazs1Coewqn4IGHPIF1mK+ru2Df7Adf2PRutAZk7mf0fKRxHjxtFXj/B7Ppl0htmc3TMDtwuptMJdrsHDNhW0NJJv7mTV57Z1cnd3ziWiAl6zEcFlBjI6mRdzYN0xHtkjidLoMrHf5xWOuWgzcH0GqgkDmWU+TwW8vw3TFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205773; c=relaxed/simple;
	bh=jmB8ZxaP9KZ9H5hjyIDQqs433spDH1VvQeRVLO+7GUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kT23ztah2w5zCAx/dmSlbuF6T23P8hsoEfwlV1E7VKasqGRa/dmBsm9BN6FtUfdx5oiZfMtoz87FyHlV5uLuvRosq9T+0j/ajztiNbO7Zy08T9cnzZdYMXBB89+Rk9bx4l+QvxNby5BUVVeRuUopo52hy+O1IDBRr2NsccJpQV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=P9+z8fHh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="P9+z8fHh"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so2847863a12.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205771; x=1784810571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ldlfwiuLgMW2soE43Rq8OVhlEemN/KhXMrXMzIbx114=;
        b=P9+z8fHh1N/OKq9OL7RTrKa97dgUNt51cIK+ukj8LHEsIGohEQgvmrSj+qckvzk5Lm
         /lMgeCUdDFDFHHT0wxp2mjdO6NgcQC3ctH4AmfUKoxB+UuQo0r3Mx2A+pIRjaqrllyKj
         q0v7KRT/weXliMYhn/PiOjPesRRpJw0+Z6lkr+fQqPf0Fmm3442uQadFfJndNAo6VESD
         ojx2zg749LzadpGbNP7NoOQAMoKM0OD8xetnorJ92lZmfIIoEgEg+8+BtPhsgg+TIqWd
         pJFBEF5MdisH0Gx8J7PKq9F/UINF0nXRXgWAZRX64m8hD2A8UDB6zcQC6hKyoiw5EF8a
         zV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205771; x=1784810571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ldlfwiuLgMW2soE43Rq8OVhlEemN/KhXMrXMzIbx114=;
        b=lm5w7uyVcdXZjOlZu6QyKEyZQ69Q4EGWrZ72u1fPiytMmaT0DABnRMoed6ZlRRxo2t
         77b9pgmZ2dwb4nLctOHDQp6+ttjGLylUN0galwRmtvAswHDBXS5HdHoElTyqy2lAVeJd
         0zMnmVYM8boC3FiwmU2dHCVHfvXlBBSkcWOv2O/DvdGZqTC/sry8PdpQ0eUbzopYcgKS
         AYDOtHuUfdOiQlDjUmpbDNJ7tcneAEP7xnFcADZaG/XrGJDF63LaVuBwN3SxSDpqokp+
         DTYTZ6ciu5RMJM83jEL9yKGAxJxLLWOhHD6k0y1xSxVQ4mBCGuvy8MYOLf/HOqQUFw07
         OwLQ==
X-Gm-Message-State: AOJu0YzAOls8qT/IoLmoy0ffhtWMu0Hu+S1h3Xqno1YYDEEEOk3cPlIi
	R4+tdxlIT5ZkvTrZRFNEMFYMBbHxAiieGBCRBzqDkzVGpSny8t9Cda+FCmhQvUEt9F8=
X-Gm-Gg: AfdE7ckGrZaezu14HKPrtR4kkbWDoHi21hO4mg9TuwoGRCSY2QRnW3hZxUWtpuCOvkt
	XOQVNGvTgJ5cPeO1pZt1lHrLWa2Pm8a/KKazrYbIzpO+YStTVX/rWFDsq49wKD6fax3sF1LQQ/H
	IvdqUaTIIp+H9oH9ryUap0nK/+btKFVBEFa2ATUy60vN/kq5Jb5gmE9SCTxFXtG2Cnl/9m4FDN9
	RBbypSEauRfvz6N5EotIvVZLCVYm9iOpG3WNsgRQ2lmUrDYIl2LQq9tpw+mHhdNdux/wPS80TRx
	CO5GAQN6ng/w0f5VM75MPKYwRe3VoKw7IENSvrZdKFnuEs2zcoWTWg5CN/0CvXTKdooqWAKvOVg
	yi8h1CVLRp13L8vv14Sw6XKeopzQaakzwZ2sBzMGtWapWY2ux9/8H6cM8nLr4xNZQXp/MAEfXGy
	NVVrF4dltyiR1J1ebCPeTUT4kkQdcxBX4aYA==
X-Received: by 2002:a05:6a21:10b:b0:3bf:b1d3:393e with SMTP id adf61e73a8af0-3c110009b76mr25226010637.2.1784205770620;
        Thu, 16 Jul 2026 05:42:50 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.42.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:42:50 -0700 (PDT)
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
Subject: [PATCH v2 01/15] riscv: introduce raw PTE helpers
Date: Thu, 16 Jul 2026 20:41:36 +0800
Message-Id: <2bde82cde4c262d35663d386e8a16455c76ec3e6.1784201104.git.cuiyunhui@bytedance.com>
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

Svnapot needs RISC-V to distinguish between two PTE views: the raw encoded
entries used by architecture code, and the logical per-page PTE view that
will later be exposed to generic MM paths.

Split the low-level RISC-V PTE operations from the public helpers so the
raw helpers can keep operating on the hardware encoding, while follow-up
changes build the Svnapot-aware public view on top.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 129 +++++++++++++++++++++++++++----
 1 file changed, 114 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a810655ce8f9b..8ca5da9534967 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -9,6 +9,7 @@
 #include <linux/mmzone.h>
 #include <linux/sizes.h>
 
+#include <asm/cmpxchg.h>
 #include <asm/pgtable-bits.h>
 
 #ifndef CONFIG_MMU
@@ -628,11 +629,13 @@ static inline int pte_same(pte_t pte_a, pte_t pte_b)
  * a page table are directly modified.  Thus, the following hook is
  * made available.
  */
-static inline void set_pte(pte_t *ptep, pte_t pteval)
+static inline void __set_pte(pte_t *ptep, pte_t pteval)
 {
 	WRITE_ONCE(*ptep, pteval);
 }
 
+#define __set_pte __set_pte
+
 void flush_icache_pte(struct mm_struct *mm, pte_t pte);
 
 static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
@@ -640,13 +643,13 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 	if (pte_present(pteval) && pte_exec(pteval))
 		flush_icache_pte(mm, pteval);
 
-	set_pte(ptep, pteval);
+	__set_pte(ptep, pteval);
 }
 
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pteval, unsigned int nr)
+static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval, unsigned int nr)
 {
 	page_table_check_ptes_set(mm, addr, ptep, pteval, nr);
 
@@ -658,24 +661,85 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
 	}
 }
-#define set_ptes set_ptes
 
-static inline void pte_clear(struct mm_struct *mm,
-	unsigned long addr, pte_t *ptep)
+#define __set_ptes __set_ptes
+
+static inline void __pte_clear(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep)
 {
 	__set_pte_at(mm, ptep, __pte(0));
 }
 
+#define __pte_clear __pte_clear
+
+#define __ptep_get __ptep_get
+static inline pte_t __ptep_get(pte_t *ptep)
+{
+	return READ_ONCE(*ptep);
+}
+
+#define __ptep_get_lockless __ptep_get_lockless
+static inline pte_t __ptep_get_lockless(pte_t *ptep)
+{
+	return __ptep_get(ptep);
+}
+
+static inline void __clear_young_dirty_pte(struct vm_area_struct *vma,
+					   unsigned long addr, pte_t *ptep,
+					   pte_t pte, cydp_t flags)
+{
+	pte_t old_pte;
+
+	do {
+		old_pte = pte;
+
+		if (flags & CYDP_CLEAR_YOUNG)
+			pte = pte_mkold(pte);
+		if (flags & CYDP_CLEAR_DIRTY)
+			pte = pte_mkclean(pte);
+
+		pte_val(pte) = cmpxchg_relaxed(&pte_val(*ptep),
+					       pte_val(old_pte),
+					       pte_val(pte));
+	} while (pte_val(pte) != pte_val(old_pte));
+}
+
+static inline void __clear_young_dirty_ptes(struct vm_area_struct *vma,
+					    unsigned long addr, pte_t *ptep,
+					    unsigned int nr, cydp_t flags)
+{
+	pte_t pte;
+
+	for (;;) {
+		pte = __ptep_get(ptep);
+
+		if (flags == (CYDP_CLEAR_YOUNG | CYDP_CLEAR_DIRTY))
+			__set_pte(ptep, pte_mkclean(pte_mkold(pte)));
+		else
+			__clear_young_dirty_pte(vma, addr, ptep, pte, flags);
+
+		if (--nr == 0)
+			break;
+		ptep++;
+		addr += PAGE_SIZE;
+	}
+}
+
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS	/* defined in mm/pgtable.c */
 extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 				 pte_t *ptep, pte_t entry, int dirty);
+int __ptep_set_access_flags(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep,
+			    pte_t entry, int dirty);
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG	/* defined in mm/pgtable.c */
 bool ptep_test_and_clear_young(struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep);
+			       unsigned long address, pte_t *ptep);
+bool __ptep_test_and_clear_young(struct vm_area_struct *vma,
+				 unsigned long address, pte_t *ptep);
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long address, pte_t *ptep)
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
+					 unsigned long address, pte_t *ptep)
 {
 #ifdef CONFIG_SMP
 	pte_t pte = __pte(xchg(&ptep->pte, 0));
@@ -690,9 +754,24 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
+#define __ptep_get_and_clear __ptep_get_and_clear
+
+static inline pte_t __ptep_clear_flush(struct vm_area_struct *vma,
+				       unsigned long address, pte_t *ptep)
+{
+	pte_t pte = __ptep_get_and_clear(vma->vm_mm, address, ptep);
+
+	if (pte_accessible(vma->vm_mm, pte))
+		flush_tlb_page(vma, address);
+
+	return pte;
+}
+
+#define __ptep_clear_flush __ptep_clear_flush
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long address, pte_t *ptep)
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
 {
 	pte_t read_pte = READ_ONCE(*ptep);
 	/*
@@ -705,9 +784,11 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
+#define __ptep_set_wrprotect __ptep_set_wrprotect
+
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
-static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
-		unsigned long address, pte_t *ptep)
+static inline bool __ptep_clear_flush_young(struct vm_area_struct *vma,
+					    unsigned long address, pte_t *ptep)
 {
 	/*
 	 * This comment is borrowed from x86, but applies equally to RISC-V:
@@ -724,9 +805,27 @@ static inline bool ptep_clear_flush_young(struct vm_area_struct *vma,
 	 * shouldn't really matter because there's no real memory
 	 * pressure for swapout to react to. ]
 	 */
-	return ptep_test_and_clear_young(vma, address, ptep);
+	return __ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define __ptep_clear_flush_young __ptep_clear_flush_young
+
+#define ptep_get __ptep_get
+#define ptep_get_lockless __ptep_get_lockless
+#define set_pte __set_pte
+#define set_ptes __set_ptes
+
+static inline void pte_clear(struct mm_struct *mm,
+			     unsigned long addr, pte_t *ptep)
+{
+	__pte_clear(mm, addr, ptep);
+}
+
+#define ptep_get_and_clear __ptep_get_and_clear
+#define clear_young_dirty_ptes __clear_young_dirty_ptes
+#define ptep_set_wrprotect __ptep_set_wrprotect
+#define ptep_clear_flush_young __ptep_clear_flush_young
+
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
 {
-- 
2.39.5

