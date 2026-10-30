Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349508;
	b=CpXNFUlzuRnIY9gB3OX683Hzpzae4zaY5duymb8JkVcgn8qplRDb4v2RwkxfoemjaKVo
	 2Ox6G8n0D3ZhaOKk+6w+0FCv/5RFGxcon0N/1dubwCSmMwFBJPrcmeKTp2n3wBQIzt1Q+
	 /Si3O5UDF462bZBAJuw4j+Qr+fg+uc0dnRmawwbzA469zQn+Si54iBWMjyPW+C7hYg2T3
	 6WKAc1jf83lJ1iJAgAciOHM3gW/uQPIJI4HCdbzAdSFHFBLWLRQ2PizU6I9Ucm7BFFkaW
	 mJl/bOoIj9aJJP5FrCGpM12o25quHZwOk0CMeHFa3LpyU6P+RpBdfwwMPHYtEy54Gxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
	b=NHGQizFTHfmeDFoC1A9LodnljNwmOhBTupBZL0hmtaD/pbsMGQ4mQ4Y6afFjDvS/JDrj
	 k3KAWIeMPe+ScVhCFr/BmPaBQGTza4+wP89J1n6lR1C8fT9o8Y2GHZ+cvJVe8WXE7+coT
	 dctKand/UyTFCPNW53rWigyosPLF0qR0dv9ExV/wVXFqARDccynnwH8BZ/zpZ180QgcSr
	 qlD5tbrE/Q3tHUndKCL5OFl/JmEoYeXRxQe9KXbZU8ydCjXCLaQjCltgTVo9N9zo2ogTM
	 TUkqEYW+ZIKExbr+w98NZ9/GCQ7j80nv3pXaLrvA45kqq5gOLJAIxtY7EoSsjXeburg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHH6tm9e;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656360A262E
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 08:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A656360A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=lHH6tm9e
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso286480a91.0
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349507; x=1793954307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
        b=lHH6tm9eFLhBmHpmdTsOkTK3m0JIEPEobyAy6uFj3sElhv15/krfzc86zEF2LGl09l
         gANlXa9+ttvNpFVE8BCo/X34y5GeAZHgYcshWRwb+tLEjO9u7xUJponHyaycOlvphmA/
         CNY/pQCj9auwT+9XNiX7L5KsJkoqEKjUVQuBq8L8t6MReuJnqehrSrKxGqsUz45vytRW
         6s2huHzN3py+tWUMsxojPDdwmCxyIiDi6O2DbC6mzwPhvXhQMQmOnjRBbL3ZSxb+67Mf
         IL1BSOy6qndNztXXGEyBjCrGUximKMiGuRC5myYgtlauUDaCp5YKeJOseTmSgMVE7HNz
         Kk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349507; x=1793954307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNSWkSKbXy4yqbi1F/NqpsveYsUGyKJhJ7RGmrJoCBE=;
        b=xi3PhWgLdOB6ETgXJ0Qxa6ZN6lO6ONaPw6ezGFeVh80D48NwGaMP/5mRvfaGZ5gjLb
         Rm79V3r+C8ffHGNnYvhi2J1lYPt1n8xciRA+kki7spy3nQfuyAR6sxclgdHXst3S8LG6
         eQVyx88/84yWkdxo+rNp5lgp+T5kOQHc/RR5lkwLRqfnJycAz7apIFwwORpJMcs0sPN6
         kTOmBYIh8bdtYdAD7zc1fyJUewnya/4FxydI0zz6Oe7C8g5bOsQFX4rvqTlp9I6YFwDE
         7Gb70uENwwhnb1l6LOJ59WdpvjWN+rRXOG5/yrNhL0zW/vsJ96+qAKHOG6xZrEnjo0H2
         3pfw==
X-Forwarded-Encrypted: i=1; AKwUvByEQ+GntPYWULuSfE1aEa1yEjI87a937Cl+sHE3CSy3HcrTktPa9x4sl4oVOulPE3T29MAO0imElF6b@vger.kernel.org
X-Gm-Message-State: AFq9FYLFEUzdsUs2ww+suDmCFdjnddEEPO1s/iXlMKpiPVLrGOcIEjIP
	9o5XXDgGX98zjNd2OF5o72iExeDnoWwe94Q5ctU4LhyCbMnagVPph5axRvbD3agUuAEPj1sGWWI
	2kNegdow=
X-Gm-Gg: AYBFou1xNKa1X1dmf1J+ODZntt2L/jw6BC6QwJsTAq4V21TSVG4CuELvp9ZIh6dIV+s
	Grrdk4dDWY/W3GJvFWDmGpjliabA6c2FmBD+Rprc4rihYMYgv+F55iZxmIWbWxePOkrels8TqCq
	5rGMOB+dCBDA3UyCSvZrU04sBTM0f2xiSXgXuqDZvpau2hjjM02Fw+ScKfuXtspTQolmRby2RYh
	ZEqLJxk6C6zbnV+ggU9Y8WiLWmfJcbGE6idAuk0L4EsMbbU80AaJnLAtpz4z6RkhkhYSG+RSC0N
	MZ2Jpsau0X4jra88xXzZeKhgWJ4MyEtjWOsRQnd4dGPCL5wUuHTOftPXa4vONWk5t+rJvZChCqu
	wMz/3MwdOnMR9fx4v+KPtrivAJQnt7BgGTcLybiZiQpXR1Y8ZkOXaCX3IZGagM3wk0B7GzZpid3
	2VxokeadETn61mtfCTAp8hNVzmbZBJSsX8F37onv5XmKtJEIdE4cGkEG2IaG+EJ6a8Nl12+ZAHM
	pg5hU5dYrOc3Vq+Fyv5QlEtQv/IiDDDiGlQ8E8m5QkWnwlE17qFiiNDpkHqGrt+drsgG7M2Ytbs
	oGsSdDOlZIfF5Md/K/UzbEAZhcnrZbC8+N6D8cj3kbaJDhcsnFA=
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id 98e67ed59e1d1-3ae8979969fmr1091626a91.38.1793349506870;
        Fri, 30 Oct 2026 01:38:26 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:26 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 2/2] mm: remove redundant pagetable_dtor() calls
Date: Fri, 30 Oct 2026 16:38:00 +0800
Message-ID: <20261030083800.599152-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pagetable_free() now runs pagetable_dtor() for constructed page
tables. Calling the destructor immediately before freeing the page table
therefore duplicates the lifecycle handling at each caller.

Remove the redundant calls and let pagetable_free() handle the
destructor. No functional change is intended.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/m68k/include/asm/mcf_pgalloc.h    | 1 -
 arch/powerpc/mm/book3s64/mmu_context.c | 1 -
 arch/powerpc/mm/book3s64/pgtable.c     | 1 -
 arch/powerpc/mm/pgtable-frag.c         | 2 --
 arch/s390/include/asm/pgalloc.h        | 4 ----
 arch/sparc/mm/init_64.c                | 1 -
 arch/x86/mm/pgtable.c                  | 1 -
 7 files changed, 11 deletions(-)

diff --git a/arch/m68k/include/asm/mcf_pgalloc.h b/arch/m68k/include/asm/mcf_pgalloc.h
index 27c3b91ac0b8..f607d239ce16 100644
--- a/arch/m68k/include/asm/mcf_pgalloc.h
+++ b/arch/m68k/include/asm/mcf_pgalloc.h
@@ -62,7 +62,6 @@ static inline void pte_free(struct mm_struct *mm, pgtable_t pgtable)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pgtable);
 
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
index 2fe787e6c2dc..36ce18e625cc 100644
--- a/arch/powerpc/mm/book3s64/mmu_context.c
+++ b/arch/powerpc/mm/book3s64/mmu_context.c
@@ -249,7 +249,6 @@ static void pmd_frag_destroy(void *pmd_frag)
 	count = ((unsigned long)pmd_frag & ~PAGE_MASK) >> PMD_FRAG_SIZE_SHIFT;
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
 	if (atomic_sub_and_test(PMD_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 85ab6723c8f2..4ff471775f2d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -450,7 +450,6 @@ void pmd_fragment_free(unsigned long *pmd)
 
 	BUG_ON(atomic_read(&ptdesc->pt_frag_refcount) <= 0);
 	if (atomic_dec_and_test(&ptdesc->pt_frag_refcount)) {
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
diff --git a/arch/powerpc/mm/pgtable-frag.c b/arch/powerpc/mm/pgtable-frag.c
index ae742564a3d5..2568bb514181 100644
--- a/arch/powerpc/mm/pgtable-frag.c
+++ b/arch/powerpc/mm/pgtable-frag.c
@@ -26,7 +26,6 @@ void pte_frag_destroy(void *pte_frag)
 	/* We allow PTE_FRAG_NR fragments from a PTE page */
 	if (atomic_sub_and_test(PTE_FRAG_NR - count, &ptdesc->pt_frag_refcount)) {
 		folio_clear_active(ptdesc_folio(ptdesc));
-		pagetable_dtor(ptdesc);
 		pagetable_free(ptdesc);
 	}
 }
@@ -110,7 +109,6 @@ static void pte_free_now(struct rcu_head *head)
 	struct ptdesc *ptdesc;
 
 	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
index a5de9e61ea9e..d554c475c61f 100644
--- a/arch/s390/include/asm/pgalloc.h
+++ b/arch/s390/include/asm/pgalloc.h
@@ -66,7 +66,6 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	if (mm_p4d_folded(mm))
 		return;
 
-	pagetable_dtor(virt_to_ptdesc(p4d));
 	crst_table_free(mm, (unsigned long *) p4d);
 }
 
@@ -88,7 +87,6 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 	if (mm_pud_folded(mm))
 		return;
 
-	pagetable_dtor(virt_to_ptdesc(pud));
 	crst_table_free(mm, (unsigned long *) pud);
 }
 
@@ -111,7 +109,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 {
 	if (mm_pmd_folded(mm))
 		return;
-	pagetable_dtor(virt_to_ptdesc(pmd));
 	crst_table_free(mm, (unsigned long *) pmd);
 }
 
@@ -144,7 +141,6 @@ static inline pgd_t *pgd_alloc_noprof(struct mm_struct *mm)
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 {
-	pagetable_dtor(virt_to_ptdesc(pgd));
 	crst_table_free(mm, (unsigned long *) pgd);
 }
 
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 9bbccb5d23a8..9f3cb7883f3f 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2840,7 +2840,6 @@ static void __pte_free(pgtable_t pte)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 81b3bb9a197a..9929d7d55d72 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -156,7 +156,6 @@ static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 		if (pmds[i]) {
 			ptdesc = virt_to_ptdesc(pmds[i]);
 
-			pagetable_dtor(ptdesc);
 			pagetable_free(ptdesc);
 			mm_dec_nr_pmds(mm);
 		}
-- 
2.54.0

