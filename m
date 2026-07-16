Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C841F37B
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205865; cv=none; b=pdWsNygSvvwT2lUidn/pkn+LI+WWQt5XeyKqwQQx2srVTpNseaIz00FAnumTQ4ok6+bb3fUBb97jmnxYEZIpbMvozBfWC/OiAInrMDjpRAIXWo5+UNbpWfpHtcHGK9SFs0a+6EvQZcsYDbfBQDH8GiILLfBRqDH0qN+IJidGxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205865; c=relaxed/simple;
	bh=rftdHtLNV98O/408NnTvtHdmuZ/zkcn7vT2O02oj0qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NVst4jS7lcszRCbOg9SNESJf79Cn1C9S+saAZjgpFgXL0M8dt/3pkrVpzvL4aZTJLxXbUp/tGejjtxjhoR3eYAHcvmoYVCu4zmSwHpjG0eY5F3ceNhoRX8tha1K4xM7xDO5GNeknEeblXpw09KCs4LQwyAm+t3bYwnjMuYuk7bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=St7eDzRl; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="St7eDzRl"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8487b7b3fc7so2994773b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205863; x=1784810663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MW3VkNC58mnWKcn8BtrFop2mUDTlw3bfVwg/aYM+yrM=;
        b=St7eDzRlxPTWCxHLHWoBJomIpw2Aw3SH5gTQBQlCcxnQd4tuAszGXCMIZDPuSq4VbB
         LkL5Y7Wzu2Tmvl54F6R9RdKK3SHWkuxSxiuEaZoTouaqTni1jlHo9cDKTwRnvaDkVgSA
         qnwyncSsWLdJsm1InJCJ9cBGs5XNR9HjzIqUNReUUweHUYEb995UrPL8kZCJxom3ocSW
         u9LOmPUwngXgZADEAMCOD7PT+wtybezb37fKnHAR5zDLVV3eBpRsFDmS5jM5BLeIAY2v
         kFLeZx7WZEubSA8oog8n1GUMtv0gjDuQNqKrVXuAQmI+krN7QhPNrQk/PJz0P299kqpI
         laJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205863; x=1784810663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MW3VkNC58mnWKcn8BtrFop2mUDTlw3bfVwg/aYM+yrM=;
        b=hRPP34YUtufCYUtIyQUqEYNhUu05x2Ig9wCXJXcJMC1i4jtWtu2Wjh6/v68rS/MDpG
         +nE0+fVVAe97C/az7f3d1fVmkaQ9i80ytWXYDqEffPEkTZ66h2QdlUFSj+0eBJP/UwJX
         FxKDLx6pItqclsTfDGZad4rC6vHuOAR+L0YR6pF/9mXHUEnlQCrJcoeAyBaOdxxh5/ND
         xoxsGWTu3L12cIpBSSmSItbq8z8bx3AcdiC2rtSTMUC6dclwyZ6XEWbcrN95jV32KLdZ
         Smzt3ikWumCUtN3mFF0KUspc6RunMt9mXyRqNmnO67ByIVP4m/DGn5RIHL/EwlBLcrE2
         Hg2w==
X-Gm-Message-State: AOJu0Yw+9NXfiZ0i6SdPLBN5VU5g8bH0jI7WSrVL4xT5RIA70tHqhboM
	MpC0Vdmsndgjbgeb0NL0bL9N4Xg5A9CDqvrrPusKNGJn/4RzawXgJwCaXVzLXrkyUb4=
X-Gm-Gg: AfdE7cmUtVqbcFfk0Puzrw7DHlz9oUYI3K1N45mvm5ogr/bRD/sp8REhhF6yQGy8K3q
	ltYSXtevaIQ0ZH5XyiZr4myO/fzFF+4bTVxJ42JN6tGlrXKtay9mKUvh1qAvQQrGkZUqMJuwwL9
	uk5u0BJqs/6uUYu6xonhzo2TwbGxNH5sxt/Io5L2vuhMjYXFD97Ljtkq9dhXXyNvlWStStgdluB
	HNCm7HyDDgmnBWf/skY3tmbfFxOxzXUlcI978t5sgnSORH7jTbQuAPtpkuqTy1qKFWUkg3emt3E
	ZUCMjMsPYpCSE1/2GyJc0SsR/NXZ69xG2BomMLBb2tvcIeJ07D3neMssgzvW1cNXS5NDdZp/Ibl
	6xosMNRkYs63p8G0dA6jpUpageaE1AvThvk8YNPPCS64PHaXQcwXVXYo1eLuuWgg2Jb8fcw75Tj
	JOvhuiX9lDceVb/JRj1n9SCBg=
X-Received: by 2002:a05:6a00:4c98:b0:848:4b27:36ce with SMTP id d2e1a72fcca58-84a673c79a1mr6078389b3a.73.1784205863094;
        Thu, 16 Jul 2026 05:44:23 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:21 -0700 (PDT)
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
Subject: [PATCH v2 11/15] riscv: mm: avoid Svnapot A/D aggregation in fast-GUP
Date: Thu, 16 Jul 2026 20:41:46 +0800
Message-Id: <95699db9c9b90fd1f95310e9d95b000eb8cfc616.1784201104.git.cuiyunhui@bytedance.com>
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

fast-GUP only needs the PTE state for the current virtual address and
revalidates the raw PTE after pinning the page. It does not consume the
block-wide accessed/dirty aggregation provided by the public Svnapot
lockless getter.

Override the fast-GUP PTE helpers to translate a NAPOT PTE into the
current sub-PTE without scanning the whole NAPOT block. Keep the public
ptep_get_lockless() semantics unchanged for other lockless users.

With 64K THP enabled in always mode, fio 4K random direct read
throughput improves by about 10% over the previous implementation on the
same system, from 2.615M to 2.874M IOPS and from 9.97GiB/s to 11.0GiB/s,
while average clat drops from 95.54 usec to 86.97 usec.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h | 20 ++++++++++++++++++++
 arch/riscv/mm/contpte.c          |  9 +++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index dd56c20a817bb..3727c148fa0fc 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -597,6 +597,7 @@ void __napotpte_try_unfold(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, pte_t pte);
 pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte);
 pte_t napotpte_ptep_get_lockless(pte_t *ptep);
+pte_t napotpte_ptep_get_gup_fast(pte_t *ptep, pte_t orig_pte);
 void napotpte_set_ptes(struct mm_struct *mm, unsigned long addr,
 		       pte_t *ptep, pte_t pte, unsigned int nr);
 void napotpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
@@ -956,6 +957,25 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 	return napotpte_ptep_get_lockless(ptep);
 }
 
+#define gup_ptep_get_lockless gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = __ptep_get_lockless(ptep);
+
+	*rawp = pte;
+
+	if (likely(!pte_present_napot(pte)))
+		return pte;
+
+	return napotpte_ptep_get_gup_fast(ptep, pte);
+}
+
+#define gup_ptep_revalidate gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(__ptep_get_lockless(ptep));
+}
+
 #define set_ptes set_ptes
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, pte_t pteval, unsigned int nr)
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 0f66426b0ecfd..b0b8ff0aade3a 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -413,6 +413,15 @@ pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
 }
 EXPORT_SYMBOL(napotpte_ptep_get_lockless);
 
+pte_t napotpte_ptep_get_gup_fast(pte_t *orig_ptep, pte_t orig_pte)
+{
+	if (!napot_hw_supported() || !pte_present_napot(orig_pte))
+		return orig_pte;
+
+	return napotpte_subpte(orig_ptep, orig_pte);
+}
+EXPORT_SYMBOL(napotpte_ptep_get_gup_fast);
+
 unsigned int napotpte_pte_batch_hint_from_pte(pte_t *ptep, pte_t orig_pte,
 					      fpb_t flags)
 {
-- 
2.39.5

