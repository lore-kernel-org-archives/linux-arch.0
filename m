Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618592;
	b=Gi+5cMjYA/UaGIqV4jB6Ib5kPulGnSEvgUJJU0mOoLgZiWbQGHFTdI43ay3Kr6/8DsX5
	 jngLmxC0Hxv8bv/2dnorpAg3HnnwqbNGUrw1HPIyB1412z/WbwIP7gPSXZb0ffhD4JazF
	 6Hv9v+j8OTCbiPc0qJNaydnmaoMHDJsncfzSknDInvsO6RhDvteJFFncO8uLxyawLmhQJ
	 e9w5qLoVmiTccGWyx6JxZuXa0lSj4Dw8kkhAgRORcsh9tnUanhgC9BYNyhuBMIutVlojh
	 mTaFwxgtObPsLogfXvYMyGbuw+pj70JLgWH8XT351GGd5Nn2vCZS1o3nXYPWbnMIMEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618592;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vD0t3P4YZyVqhT6ml/GIwYbaOKBZr/6svGx4h3XrrSs=;
	b=zE0hkRDOOB3mhNiVerS7OIBrzof9uDmpcf+/DwhG0AwI1sCnEL+E+UqckSzQiHKmk07x
	 94KKbQb70Kcx0+zhEQmUjyQqwvJBIbMLQ+rcDZm/TW7RUNYCCiwGwbtWizacBMKTkDvwq
	 avonJAWAWYhWEeWFXFN81znf8ORN+wIB1xFj6Ym4VYnYv8BNpfsjJGq2SgBeQNIffyW37
	 VOg0Ft8aIo+0fKmLmDMdCgk4Fb2FxyUkAR6AW0pfyhPN7LhQ0h1IwTvILb7/SxZS/XzUD
	 oeZJ6zeDE849NmjbKx2xqegp7jgK3cTpMQFkts1ZpmPSxNUJ4iB6orQmlZ9VTEhRh2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=s3VQGmGS;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB9760A260E;
	Mon,  2 Nov 2026 11:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EB9760A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=s3VQGmGS
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 967762972;
	Mon,  2 Nov 2026 03:23:08 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9393F632;
	Mon,  2 Nov 2026 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618591; bh=ObU14gVurwRSCSStZTYINkZuQOqrowSMvXaNGghdZu0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s3VQGmGSFtCFwjtay8s4nbDojFMYzMaLVbCeQdcpPV1HNgNaORCKmDpIS0w9cWEt5
	 k2nsjLkC4akHLis92DY08iQdz/CbZUP9bBXBOpvuSHsIe8nqoGpoezGyEgPlE6yr2d
	 HS7E0Rq1Nd3osETVyGojSrQmm+VyuCL111GZ6D38=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:28 +0000
Subject: [PATCH RESEND v2 15/21] x86: mm: carve out the generic
 compile-time folded pgtable case in effective_prot()
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dummy_ptxp3-v2-15-78840b2ec73c@arm.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
In-Reply-To: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4850; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ObU14gVurwRSCSStZTYINkZuQOqrowSMvXaNGghdZu0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI21a3e3zjd8W2uW8CRkndVxlUB/t8qZHEA4
 Wo+rp9btw+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyNgAKCRBt1cPRWsUx
 M3c2DADaK9APAB6iyN04UeG0okpA48pg0nK7q2fvyOWzmvboP05U+SvnXs+PPyp4dxqxM2WdGEg
 u6LTFtD3xNtAExQLnDq4ijA5aWcQ7yQAFiY2f2VeRcJqSGjDqkXDCtMKnY2RIOI5fYE69n5eAzv
 3aCrKENELb5xtq2Y7NJLuYjHHSiy8iIraa49yK6So1R0xmnYNBvkOxwaLUjYIUFOStv9J191xgg
 mfDHR5QylIGmtyDOtmCQZV7pJY/+tF0VPlFmuGUGQFu1095XMIHCwFQyzeqp3HI8L/WM3uT/CLj
 hFcZ3U7P8Q0dxKwC6ztmWUMfGjeTe1bezOmIRIwMjY+AR2mMiVRiQlIDtiCI1s/hDlJOYWwS+mJ
 vVTfqk62NMFi9m4mee9kz7qrvY3B5OJO4to7ow8YsyyWThvx+23PaxMNoYczZ3NmYDJ3H/eU7MB
 8EmN3el/Or1kGz8YIcK9MtfiZ9DhbXql0+uRTRI0NsEPtSjsoGaUc2WNCZEzlAbHalD0s=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, rework effective_prot() to ignore any
folded page tables entries, as it will unconditionally get called by
ptdump core with pXd_val(pXdp_get()), and the value for folded entries
really should be ignored.

For this, introduce mm_first_pgtable_level() to identify the first real
page-table level, move mm_pXd_folded() in !__ASSEMBLER__ and
update effective_prot with higher_prot only when the current entry is not
folded nor the first level.

There should be no functional change.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/dump_pagetables.c |  6 +++--
 include/linux/pgtable.h       | 61 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index a18a61e732c3d..2acbe41eb58f2 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -38,6 +38,7 @@ struct pg_state {
 	bool check_wx;
 	unsigned long wx_pages;
 	struct seq_file *seq;
+	struct mm_struct *mm;
 };
 
 struct addr_marker {
@@ -254,7 +255,7 @@ static void effective_prot(struct ptdump_state *pt_st, enum pgtable_level level,
 	pgprotval_t prot = val & PTE_FLAGS_MASK;
 	pgprotval_t effective;
 
-	if (level > PGTABLE_LEVEL_PGD) {
+	if (level > mm_first_pgtable_level(st->mm)) {
 		pgprotval_t higher_prot = st->prot_levels[level - 1];
 
 		effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
@@ -452,7 +453,8 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
 		.level = -1,
 		.to_dmesg	= dmesg,
 		.check_wx	= checkwx,
-		.seq		= m
+		.seq		= m,
+		.mm		= mm,
 	};
 
 	ptdump_walk_pgd(&st.ptdump, mm, pgd);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a032f95943357..b0d0e32ad6aef 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -392,6 +392,22 @@ static inline void lazy_mmu_mode_pause(void) {}
 static inline void lazy_mmu_mode_resume(void) {}
 #endif
 
+/*
+ * On some architectures it depends on the mm if the p4d/pud or pmd
+ * layer of the page table hierarchy is folded or not.
+ */
+#ifndef mm_p4d_folded
+#define mm_p4d_folded(mm)	__is_defined(__PAGETABLE_P4D_FOLDED)
+#endif
+
+#ifndef mm_pud_folded
+#define mm_pud_folded(mm)	__is_defined(__PAGETABLE_PUD_FOLDED)
+#endif
+
+#ifndef mm_pmd_folded
+#define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
+#endif
+
 #ifndef pte_batch_hint
 /**
  * pte_batch_hint - Number of pages that can be added to batch without scanning.
@@ -2313,6 +2329,36 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
 	}
 }
 
+#ifdef CONFIG_MMU
+/**
+ * mm_first_pgtable_level - return the first non-folded page-table level
+ * @mm: The mm structure.
+ *
+ * With runtime- or compile-time folded page tables, page-table walkers
+ * effectively skip the folded top-level page tables, treating them as
+ * always-present entries pointing to the next lower-level page table.
+ *
+ * Return the first page-table level in @mm that is not folded.
+ *
+ * Return: the first non-folded page-table level.
+ */
+static inline enum pgtable_level mm_first_pgtable_level(struct mm_struct *mm)
+{
+	/*
+	 * "PMD folded" actually means "PMD is folded into PUD", and
+	 * pud_present() etc. are hard-coded to look like present page table
+	 * levels, whereby pmd_present() etc. contain real logic.
+	 */
+	if (mm_pmd_folded(mm))
+		return PGTABLE_LEVEL_PMD;
+	if (mm_pud_folded(mm))
+		return PGTABLE_LEVEL_PUD;
+	if (mm_p4d_folded(mm))
+		return PGTABLE_LEVEL_P4D;
+	return PGTABLE_LEVEL_PGD;
+}
+#endif /* CONFIG_MMU */
+
 void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
 
 #define ptval_to_str(buf, val)								\
@@ -2349,21 +2395,6 @@ void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_
 #ifndef has_transparent_pud_hugepage
 #define has_transparent_pud_hugepage() IS_BUILTIN(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)
 #endif
-/*
- * On some architectures it depends on the mm if the p4d/pud or pmd
- * layer of the page table hierarchy is folded or not.
- */
-#ifndef mm_p4d_folded
-#define mm_p4d_folded(mm)	__is_defined(__PAGETABLE_P4D_FOLDED)
-#endif
-
-#ifndef mm_pud_folded
-#define mm_pud_folded(mm)	__is_defined(__PAGETABLE_PUD_FOLDED)
-#endif
-
-#ifndef mm_pmd_folded
-#define mm_pmd_folded(mm)	__is_defined(__PAGETABLE_PMD_FOLDED)
-#endif
 
 #ifndef p4d_offset_lockless
 #define p4d_offset_lockless(pgdp, pgd, address) p4d_offset(&(pgd), address)

-- 
2.43.0

