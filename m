Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A6541F5D8
	for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205855; cv=none; b=AzR9mUo5OjiXxIvgubrBkDISkruqfMJ9kAYz9EKu6L5NO3/ZOAzw3QSl6bhF0WUN/12bzz+IvyVQtvNeMlAkZTz1iqv+s6DXumoFTzmLm0CRNn1vrgcYdRyv9uIjVgrAwEJQI1WGbun/JTM13fsu5UdoYe0vVuoCWtA/2vhXYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205855; c=relaxed/simple;
	bh=4deY2p8H6GZ6zm5fDTusItQoJGUZoIhd5ZPqjCZKV8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqUmDuxSuj4XiSWxORWEGiDSajeJkmX27HlbeT8A5ssBo96BGKBGgqrDQqpEV0BSWuaj7mvIzvWCcoXQUeJf9Kc9ab/soBDdPOyJaCDdgz9VLnAM9UHHXafy+/3NVKp5aa8R312vrZ4JzHqppfGpBpuOTsFdMqA1CHv7T4mxEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZAj+7QOj; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZAj+7QOj"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2852274b3a.3
        for <linux-arch@vger.kernel.org>; Thu, 16 Jul 2026 05:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784205854; x=1784810654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqzuyyB7zI40Qj8rdd4/j/Hz77YcBH2L+r/0EHWbI6M=;
        b=ZAj+7QOjASlsckuQXpHLU0FAunWhMybQoKD5W1AGa50FQayUMJnImiyviiMSbReByf
         va4QGfRhrqAk25/wcSzdNnk7Uh+wRnkJmRmorSkk3ZueuR5PhG4jW5y5CLMzyErWfUCe
         PV3JOuaWu6DLe1gZvFlvl2NcWkbb2atm7j7MfDmn56Ndaz6yPyc4P3Buux7GIlpsjUz1
         O9OcZzo5ZEGSFis8y/e4dj8Edgugo5P3zZOn62SIZPiC5lk0LQU85KcX58BXc361Qf7H
         n5qvwflHbCKVpNF1yk7nWMc5X5VbqNH7sSb1x+IXZ4m8L7mNy8+vS2S33zqMuWOk0PaE
         6fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205854; x=1784810654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqzuyyB7zI40Qj8rdd4/j/Hz77YcBH2L+r/0EHWbI6M=;
        b=mvPBiw7wzrg2mgV5lrL+BAFnS4nUik7eFo3sBNSwgGBVjFnv6Qq5HObwDvl6XTqXTK
         aXwFgJC6JH9ZcFQJnn6z9nzDKcgvkPuCG/ERlcROqtKxxWAjegKeL6wRG9mWbK268po0
         Wuu8UKdmqt/JiBB4oSghhtom0nL62lSYmYHBKtafMWywbpXCW3phAUiGy2jiyu2xr+Qs
         LF3AEsA28X2HRv00BHpqRZCZNyHK55B+T0NshPbO9kKewMNYGvMRJCTuA62duAoZ275r
         PczUFlPR9y+GbuzHA7XG3mk0TuJ6sthlcLiSqBLgF5re86pY3b/MOGUkgBRU5wR01uUu
         P/sQ==
X-Gm-Message-State: AOJu0YzycrQGyyiZJq59w3DRoD2QpIrQKShthLTUC83msZApk/0WhR6l
	kKMsEeHIY6EpcyDBHkfk2aoxXgcff4+NMZzB9zxYiQ5KoBmwCklCSkbWIuLOxYMr27M=
X-Gm-Gg: AfdE7cn9yAj/RubEsNRMac/JsHKe/ZURtbevEXBYhfxWoKruPPZnFTd0QHiZW4esMD8
	X9kCa8qLggXU4S4Qv5dfj0v1BeWF3U9QhVZIRKbqzFdYt59FZm6RHC+aI7GBIHsVzLIJOHIKVyB
	6I5/ir4hG+45tGAkqf6RK9H8NSiZ5fYowZSSdFgcpt5IkRMZkPc9cS43L7jG+U1YF5TAMrQk2Ef
	99FpJY8bDJhEiWa2w3BzKLKYj0GJ0bVE3YNbzI5sCyri7a2p3t1dYCFTLe/JV6o06ht6qWom9FO
	bBZKDtZgS5CN0gVQIzLKQQmuYK1X13GQ4DB0mdoLeQXn4FAbspDb+UIimxcpZoCt+YO6iU/CvFu
	AUfnUr1bzq10vK8GQ3ujv4oy460Ub0SznebJt/haAqmRCWn6xPLTdYOXsPf2T+OQDTz1nQK4Vrx
	0GtEcbXAgL6cto8F5GDSaEsXU=
X-Received: by 2002:a05:6a00:21d2:b0:845:c6fc:2821 with SMTP id d2e1a72fcca58-84889604f51mr19555102b3a.22.1784205853705;
        Thu, 16 Jul 2026 05:44:13 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([2408:8606:1800:501::2:f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb258eeaba2sm1730793a12.12.2026.07.16.05.44.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 05:44:12 -0700 (PDT)
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
Subject: [PATCH v2 10/15] mm/gup: add fast-GUP specific lockless PTE helpers
Date: Thu, 16 Jul 2026 20:41:45 +0800
Message-Id: <138d74aa9863ae8ff445e16a2798d062895b75bc.1784201104.git.cuiyunhui@bytedance.com>
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

fast-GUP snapshots a PTE without holding the PTL, pins the page, and
then revalidates that the PTE did not change. Keep both reads under the
same lockless PTE semantics by defaulting the fast-GUP revalidation to
ptep_get_lockless().

Introduce fast-GUP specific PTE snapshot and revalidation helpers. The
default implementation preserves the existing ptep_get_lockless()
semantics, while allowing architectures to override the helpers when the
public lockless getter provides extra semantics that fast-GUP does not
consume.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 include/linux/pgtable.h | 18 ++++++++++++++++++
 mm/gup.c                |  6 ++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index da14328093a86..62943fcbf7046 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -813,6 +813,24 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 }
 #endif
 
+#ifndef gup_ptep_get_lockless
+static inline pte_t gup_ptep_get_lockless(pte_t *ptep, pte_t *rawp)
+{
+	pte_t pte = ptep_get_lockless(ptep);
+
+	*rawp = pte;
+
+	return pte;
+}
+#endif
+
+#ifndef gup_ptep_revalidate
+static inline bool gup_ptep_revalidate(pte_t *ptep, pte_t raw_pte)
+{
+	return pte_val(raw_pte) == pte_val(ptep_get_lockless(ptep));
+}
+#endif
+
 #ifndef pmdp_get_lockless
 static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
 {
diff --git a/mm/gup.c b/mm/gup.c
index 99902c15703b0..72fb147193e55 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2842,10 +2842,12 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 	if (!ptep)
 		return 0;
 	do {
-		pte_t pte = ptep_get_lockless(ptep);
+		pte_t raw_pte, pte;
 		struct page *page;
 		struct folio *folio;
 
+		pte = gup_ptep_get_lockless(ptep, &raw_pte);
+
 		/*
 		 * Always fallback to ordinary GUP on PROT_NONE-mapped pages:
 		 * pte_access_permitted() better should reject these pages
@@ -2871,7 +2873,7 @@ static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
 			goto pte_unmap;
 
 		if (unlikely(pmd_val(pmd) != pmd_val(pmdp_get_lockless(pmdp))) ||
-		    unlikely(pte_val(pte) != pte_val(ptep_get_lockless(ptep)))) {
+		    unlikely(!gup_ptep_revalidate(ptep, raw_pte))) {
 			gup_put_folio(folio, 1, flags);
 			goto pte_unmap;
 		}
-- 
2.39.5

