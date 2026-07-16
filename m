Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189AE42048B
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205846; cv=none; b=c4BmqQCtKki3GPuj6vkjqSoOTL9q3sc39F9XwnW9Mz66bGfXwVbKpidCuzaH5pRVuGDevDu2thaJ5roeYMr1HwIUGkffRKgdL3FLwqNAkMrCpgw92kdSUynOrDd0NKeHiix7DHaTDKAXDlOvb8RAHry1UoU+ee81pAsgQrHn/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205846; c=relaxed/simple;
	bh=1jB7gIqPJlL2X3fTP78amNRlL24ELpsJZv6OaAlT5aE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BBXSYcmjPCs47jtBrX74BO8wQfrmHtAgwp8UDDrK9eHTM1Gy4CT0JulUVw0u3M+5f/R3us2mWC0f++dr6g/5LmLgflUHvgbdXmzA6qjRxrlAz9ipNfQmkN9TIkhruDKxXW57a6bVtbT+wKx2tSFFy8ZWcdSaP6x8pMDrCj5qlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eo10wiwM; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eo10wiwM"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ca7bea5e5b3so4804559a12.1
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205844; x=1784810644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVEhlrHEVqIN0Ar3D+s2eFCiOScwlS1S3mz2hTaXKkY=;
        b=eo10wiwMJQKMiTLy6l++isI9WnaIKsrmIMX98HY/aWNRTseylUp9wXtVLd48pDhNVv
         w8Prp7kvIZcZAwIkecfTumAPfcs9aF5hn/PVmZIL9gXKvpO5wgwoVZG7GdshGTRAVXxv
         zl1KJ13PB5ybYnl9+YYLN6JmdfLRPq7XvZMSBFUvgHiIs2Uub+7PhboAACzDXZ78iz3k
         59NCleD1Im9lQyKT1IpSC9aFZE/8vf090gL1weV2QdydCYdAp51EDhNb/HRXDUpC5Ukc
         052I1oev5G6ieXJ/r+oosCFIZ8lQfQgo2KfkidFSMZ9Ene/usGtZIv4E4m6a5aZARB4K
         F/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205844; x=1784810644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVEhlrHEVqIN0Ar3D+s2eFCiOScwlS1S3mz2hTaXKkY=;
        b=Idg9BOx3LN7MbvNgYWHixJxhRrFMJPBcbyYqrrAeXeGb2CxCr/nre3ypsS80Equt2s
         Z+Wy7Og9EFxCapli3oHsOqxoueNQq2CtX2GoIIQrM3hHJ33w8POY3MdJV1aZOZ518ptJ
         hz/OeOoVtVmjfiVL1hwzW1vwlapTKe9ZNKCe0slLcK7Afp19/tcuSfR9YuCZ6Z+3LSMP
         UtfX71o9hA4a2D+98PgciB8L7Ntb3mukTHcJulBGwiRT+kipIEPaREkbxj7cAJkLgQCm
         6f4kkzJ54RKxIkG0+MUvahLoYu6YemSYUA2zL0hRvAMFrfsVf0pqRGOF8Y8i7gC+optG
         x1vg==
X-Gm-Message-State: AOJu0YwDKEUMZIO4KLP/go/YcHskvZvJg0uNKtnp+GBT+1EDF5a+eqN/
	HXto2P0T7rZ/BEGZ1CfV/26IIangezneL8ALC+rT5+0CMT8M62dS3a2QY7D8KqmPOrs=
X-Gm-Gg: AfdE7cmNX+jKyejbQe1nfvBcisqMlOiqowJqEF/6V29yh2I9xlmuk5o6+yR71nSYxzf
	aM7whaoWEP80UUqmwHmWFmqMNfOzgmkIRZPMl07iEDNBcYpcqmWbFYrs5ImVXiVU3NOyzZRZ6bH
	48S39UR9rGFwmKWQkiLgR1JwesYSsJW3sHW+T6/vyzpS6zjMccKYzv1oiybu8iWmkIUKE5Nb2z3
	FfgN2nsnzf+8aWW088wNb0gDBvApL/C774MPmNLjL/6WOghV4ILjqQrfWyOzu79iX1KZpdKQ61r
	ECsKVMhXQgZ3mOKtwtZq87jk7S/NuV5q2C6PAh47XthFoPeF49XWDTl1DJVbny/LuLv9/YmSqBb
	f1hGv4+QvdcMG4ubnZMwoRtAhQPqQEpNF0mnP9/h6/1EBru8QobWT0teXUJmpFole9OG4wEeHOs
	ZwcbuynDZ9imsAldLzuKG1gD4=
X-Received: by 2002:a05:6a20:4308:b0:3ba:cd5b:3dc8 with SMTP id adf61e73a8af0-3c36c1f1e9dmr7530059637.31.1784205844222;
        Thu, 16 Jul 2026 05:44:04 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.43.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:03 -0700 (PDT)
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
Subject: [PATCH v2 09/15] riscv/mm: avoid Svnapot consistency checks in ptep_get()
Date: Thu, 16 Jul 2026 20:41:44 +0800
Message-Id: <687dadf430c49a840e24976e37ba09f991bc3222.1784201104.git.cuiyunhui@bytedance.com>
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

napotpte_ptep_get() builds the returned logical sub-PTE from the
initial PTE observed at the target address. Neighbouring entries in the
NAPOT block are only scanned to gather accessed and dirty state, so they
cannot contribute PFN, permission, present or writable state to the
returned PTE.

Drop the range consistency checks from this ptep_get() path. Callers
that rely on the block-wide A/D view are expected to hold the PTL. There
are generic lockless ptep_get() users, such as userfaultfd_must_wait()
and HMM walks after pte_offset_map(), but those paths use the present,
marker, write and PFN state and do not consume the gathered A/D bits.

Keep the consistency checks in napotpte_ptep_get_lockless(). That API
must return a self-consistent PTE snapshot to lockless walkers and fault
retry paths. napotpte_is_consistent() verifies that every scanned entry
still belongs to the same NAPOT mapping, ignoring A/D bits, and retries
if a concurrent unfold, rewrite or refold tears the range while A/D
state is being gathered.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h |  3 +++
 arch/riscv/mm/contpte.c          | 19 +++++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e4b9c05014c00..dd56c20a817bb 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -930,6 +930,9 @@ static __always_inline void napotpte_try_unfold(struct mm_struct *mm,
 /*
  * Public PTE helpers may transparently handle Svnapot-encoded mappings.
  * NAPOT-aware arch users should stick to the private/raw __pte* helpers.
+ * Callers relying on the block-wide A/D view from ptep_get() are
+ * expected to hold the PTL. Lockless callers that require a
+ * self-consistent Svnapot range must use ptep_get_lockless().
  */
 #define ptep_get ptep_get
 static inline pte_t ptep_get(pte_t *ptep)
diff --git a/arch/riscv/mm/contpte.c b/arch/riscv/mm/contpte.c
index 70f9a0668b50c..0f66426b0ecfd 100644
--- a/arch/riscv/mm/contpte.c
+++ b/arch/riscv/mm/contpte.c
@@ -294,6 +294,13 @@ EXPORT_SYMBOL(__napotpte_try_unfold);
 
 pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte)
 {
+	/*
+	 * Gather access/dirty bits from the whole NAPOT range for the
+	 * ptep_get() view. The returned sub-PTE is built from orig_pte;
+	 * neighbouring entries only contribute A/D state. Lockless callers
+	 * requiring a self-consistent range must use ptep_get_lockless().
+	 */
+
 	pte_t pte, cur;
 	pte_t *start;
 	unsigned int i, nr;
@@ -307,14 +314,10 @@ pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte)
 
 	for (i = 0; i < nr; i++) {
 		cur = READ_ONCE(start[i]);
-		if (!napotpte_is_consistent(cur, orig_pte))
-			return napotpte_subpte(ptep, orig_pte);
 		if (pte_dirty(cur)) {
 			pte = riscv_pte_mkhwdirty(pte);
 			for (; i < nr; i++) {
 				cur = READ_ONCE(start[i]);
-				if (!napotpte_is_consistent(cur, orig_pte))
-					return napotpte_subpte(ptep, orig_pte);
 				if (pte_young(cur)) {
 					pte = pte_mkyoung(pte);
 					break;
@@ -328,8 +331,6 @@ pte_t napotpte_ptep_get(pte_t *ptep, pte_t orig_pte)
 			i++;
 			for (; i < nr; i++) {
 				cur = READ_ONCE(start[i]);
-				if (!napotpte_is_consistent(cur, orig_pte))
-					return napotpte_subpte(ptep, orig_pte);
 				if (pte_dirty(cur)) {
 					pte = riscv_pte_mkhwdirty(pte);
 					break;
@@ -345,6 +346,12 @@ EXPORT_SYMBOL(napotpte_ptep_get);
 
 pte_t napotpte_ptep_get_lockless(pte_t *orig_ptep)
 {
+	/*
+	 * ptep_get_lockless() must return a self-consistent PTE without the
+	 * PTL. Recheck that the whole NAPOT range still describes the same
+	 * mapping, ignoring A/D bits, and retry if a concurrent update tears
+	 * the range while A/D state is being gathered.
+	 */
 	pte_t orig_pte, pte;
 	pte_t *ptep;
 	unsigned int i, nr;
-- 
2.39.5

