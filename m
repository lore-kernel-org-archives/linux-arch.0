Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE540B6EE
	for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2026 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791950365; cv=none; b=SIYWWTbRX+bj+Rh5xWIW74ET8oLGAIGoWOUUZtputDwxHBRoGMDF7Wz31pUov9M7kbFGM5/mwdkp8Yy6MfSKlvHnn43W79wcvtzktFxJiQwPG2uD1/YXKA5GRDeQml5y7ZrkHb3hEccG0UbKF78xYJCGZkTvk6JmX+ABUVbTtRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791950365; c=relaxed/simple;
	bh=A40w+35DIpgiCQxJt0/IC2OqyHnzNk9q/eF9E1VEJkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFkXMmGsQASRkmJh6MPnmX2B5OyCXay62lGwKlgIBzl/kSKq++tV4VtkPtqFFWrA+M3dIeNzijic5YM4Zz86UtrSbcNlRiCIq6Y3rnl0jra/Z/3AEt8uNYL6yBJdInb8Pgd8alFye4Y0LwOZSpWGM5FUzxYutY6o/HHoLLG06LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BL3PFH8a; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BL3PFH8a"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso44921a91.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 20:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791950363; x=1792555163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f+FSgGJMK2coGisR/hIoDuCVxcBu6Hr0f49QmgHJmrk=;
        b=BL3PFH8ajdp7Twcl+IfQr5q1xlW9qSiPjhSy3lFYfbK1ou55/7iwYdNLp9lccpAWTP
         iXbRYz1d1cRVJ0xnk98VQvvXZVIqk9qmg4cBw16k4O8xGBCCuYINZAk1jPMbHG53iRFi
         /LwMtICnQlHOnHWEZ13NWvvAYIyT1uJZIy494YsCtDO3xwzv+6uy44J3IbhSt7rM2Zqa
         yMEVpzzPPog6dy/gkbye3cR+0nyrmg7UczbyMpMXOLTKdLR4x9ZvJ9AWlQ/hpnhl4jIk
         wiB4hH6d1YC4yReHX/mI/pHU4uOBzBwIxjGnU8XxcCqe4bQZMDKHSdXU1vc3AvTWqMyp
         GNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791950363; x=1792555163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f+FSgGJMK2coGisR/hIoDuCVxcBu6Hr0f49QmgHJmrk=;
        b=vJK32xHbdl5mC4ZWkwwQoaZkl5J+x6/XRTc4SZbsK5/QcT35E9ZYBR8m0qp7g2Gebr
         Q4eikUcCU24v5912Hx980Yp2Z8BaFWS05o2TSf7yBRZc6orjHyVdLqPxfiFixX1DHxUc
         deBKPykrWDEkP+VaoDLRYpad2vYAKbQeG0+cnoNNSRZE1GGFIKAx7FYipRk+erfNSvA3
         dUk9gDxqhhpjqXQ1u9RHnyJNCP/ou8RJpUmR/KuWaLpbdReCx1GnjK0uQKd/6+3MiudP
         5Vp8FbaQvMnkz/3kT3dUHJGJnbwxWY8v50TX5udY8sWUm2MDll9rCt+EQeAO8Vhv90Po
         IXnQ==
X-Forwarded-Encrypted: i=1; AKwUvBzN9937GCFNk3Pshk6Tf2OqDvolfQhW89oHg6xFrTvZh8HvsF5x0Clc9Z+8hF3GaXc4gHOkWxa+b68h@vger.kernel.org
X-Gm-Message-State: AFq9FYIyPNFaUH8RjzfYK/3+uKcju4WTLY4Xp1M9CnxgUjka6wr20u3V
	rKNj2CSdA+CUSl8ikV5HjCqSvnNc3/5NjmnnM3z8FN1DZa9ePYO5OPBThUr02ZXJdmrBcaaf2xd
	VDAof
X-Gm-Gg: AYBFou11vQfyJOuYIBqE6a3yv5ye8g32CuOK+lk7GimEVrgxyoUlYZYdeqgAAhQRF+Z
	W7thgHyHJXkLBU/gDaJfRGzI5IsMvIWioOLXlS2R6DLHxPabttkcRd4QOEbx8RYQ89Qhx69A8ec
	NzVKA1CkRKURzdKBVssWJ8gTN93EdGx8KyHAGNoBVFMceDMFCd5/fE1eYrfDW9mdEv3VYYued8m
	t4jesUtd0xlqaCNUk4P8xMyn/Q5nztBoU6ZHrmiWNP0CdupxaNVKvdHXKNsSVFIYiNjw7dNP4sL
	F6ItrulWF+ayVbkR2sAO/LCYdnuPwt8zkn8x9XtGWuNagTcCY7Y6zafWNZTS5rnidc8vSOTHfUO
	qQ5yKuZLoJa2Q+pemgT7t8GPtvweT7BixEjdtZ9U/A4pWvFn63TxMhuIAWhxyJfs0KdDwjJIuP2
	mNbS7VnfcKXF9c7p2CMFqTwWkF9HK+GrS8ZG9cHFXCQLBnutRwvpF3hGVQg87bm0Fp5JqmwYNhF
	6GEKUlNYrDfT+arPE/t
X-Received: by 2002:a17:90b:1dd1:b0:3a7:e0f4:2857 with SMTP id 98e67ed59e1d1-3ab3a359dd3mr10523369a91.1.1791950363442;
        Tue, 13 Oct 2026 20:59:23 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24a538sm2492305a91.9.2026.10.13.20.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:59:22 -0700 (PDT)
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
Subject: [PATCH 1/3] mm: generalize kernel PTE table allocation
Date: Wed, 14 Oct 2026 11:59:08 +0800
Message-ID: <20261014035910.687847-2-songmuchun@bytedance.com>
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

Architectures whose empty kernel PTE representation is not all zero must
initialize new kernel PTE tables. LoongArch therefore wraps
__pte_alloc_one_kernel() solely to call kernel_pte_init().

Call the architecture initialization hook from the generic allocator so
LoongArch can use it directly. The default hook is empty, so this does not
change other architectures.

Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/loongarch/include/asm/pgalloc.h | 11 -----------
 include/asm-generic/pgalloc.h        |  6 +++++-
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 248f62d0b590..a3f93a8b58be 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -10,7 +10,6 @@
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
-#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
 #include <asm-generic/pgalloc.h>
 
 static inline void pmd_populate_kernel(struct mm_struct *mm,
@@ -45,16 +44,6 @@ extern void pagetable_init(void);
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	pte_t *pte = __pte_alloc_one_kernel(mm);
-
-	if (pte)
-		kernel_pte_init(pte);
-
-	return pte;
-}
-
 #define __pte_free_tlb(tlb, pte, address)	tlb_remove_ptdesc((tlb), page_ptdesc(pte))
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 051aa1331051..a1de7d246754 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -19,6 +19,7 @@
 static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
 {
 	struct ptdesc *ptdesc = pagetable_alloc_noprof(GFP_PGTABLE_KERNEL, 0);
+	pte_t *pte;
 
 	if (!ptdesc)
 		return NULL;
@@ -29,7 +30,10 @@ static inline pte_t *__pte_alloc_one_kernel_noprof(struct mm_struct *mm)
 
 	ptdesc_set_kernel(ptdesc);
 
-	return ptdesc_address(ptdesc);
+	pte = ptdesc_address(ptdesc);
+	kernel_pte_init(pte);
+
+	return pte;
 }
 #define __pte_alloc_one_kernel(...)	alloc_hooks(__pte_alloc_one_kernel_noprof(__VA_ARGS__))
 
-- 
2.54.0

