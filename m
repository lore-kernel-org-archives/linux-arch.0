Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77449365C;
	Mon, 21 Sep 2026 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988329; cv=none; b=fsKkrbv0f1iCj5H0VQlILQEVyoeDycrvyJoX5DfOvbLYn5pndwl17hTwvE6UrEnEYdXlRYTumO1TZhKjzIzTXkQEpjPBqvWUA8V8BgaOWvwzH3Lgtd7HTOl8WQyIS5HSsztVzZadBGe2Z7GRubbqperN576HQ1T0vrcFQ1M1JzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988329; c=relaxed/simple;
	bh=wV1Rko2jO3CBq2XkkZPZAq0K5FwAUXTua1cF3CtPA0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQCMwSSRfoSi7RI9zj1SiQvyWIF9ui23YQ+KXL6RngpHbG7Sya4ygiC1qJKWJP/TDOgjMHVmj3rp8c73scIVFDUNy57uAb98aeFFagCyqOxcR19F8cGLmTmBF/fizNTRclSFb0DfsmQEwYphYpV5h8a2U4AwZ9L7k9mFBFNhVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=M69yt9JN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="M69yt9JN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34A151D13;
	Mon, 21 Sep 2026 03:58:41 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97C853F86C;
	Mon, 21 Sep 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988324; bh=wV1Rko2jO3CBq2XkkZPZAq0K5FwAUXTua1cF3CtPA0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M69yt9JNZZOu07m2eMUXUE7kOouVrZ1x/HOoeFBr+noA27ltzymcz/8DIQ6+nWmeA
	 Kl3YQM/RF8UVLyxHtt3QuNclLtl3PDdDABqDQoBAZLOMcsdrQA4rXueqGUmFuELMoB
	 9zMg9PMSynQbdAYiXfxLlCV+wg7YHxMgGrf3BDy8=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:40 +0100
Subject: [PATCH 18/21] mm/pgtable: catch abuse of folded dummy
 pgd_t/p4d_t/pud_t
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-18-cd40cf68242e@arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
In-Reply-To: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
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
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5536; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=l+aFtD+gf169DFuCaai5cwdW0dtCP9VrudnD5mceiXU=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1TVJ8WMEBMvMxpLmee8FhBXqTgwIAqkv6F1
 pZhimntkJuJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENUwAKCRBt1cPRWsUx
 M4WLC/sEXXfDYkutq+XAp2eq4pnDsW6DCLQnTbXxUpR54sRfzZL7IThTi7dm/8TREnCeAjQzxSb
 kIEls9cerKZbqCqvoo1jxqfAow3waQ7/FpfR3e0QBaKEGCVcOXbUkfZZWme1N1fIZs/5+T1FMM/
 Wmno7S+8Qmijp4q76nSESjDriWdGU45ti1Gddg0VHaL4Ge1gjs2m8fjk8fQ2zm44AYbJF6QQype
 07q+r9nZBtf283PQwCq+ujgtbmj0quciFUubtzKIEftdItMvCx4D6aFGlWt+xl7NNnjVXMIoIZM
 gt3foVK/bmLXFR9La90KMSAFxgXzS9YScthuZoL/8m5YdttG8nj+VUuQLBgZrXRgXiYwY74HCui
 x4bKpVVRItDotIL4T6torQgNsStmEkdDf8yASZ0OxkhEpIjSDLWHoD83ROEl9Vi5hatDNf6ua9t
 S2qYUC7sUdkPljmrhJZ3t7h+vrNE+C81GHrh7eq0o3aM1EqMeCg95MTIGsPmP+lkqMc+c=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Catch and prevent all abuse with dummy values on the stack
similar to:

	pud_t pud = pudp_get(pudp);
	pmd_t *pmdp = pud_offset(*pud, addr);

While this approach relies on the compiler propagating constants, it
should catch most of the issues in practice. It would have caught all
the issues were found through manual inspection.

To avoid build issues particularly on x86, where pgd_val() might not be
around in some inclusion paths, perform the new checks from wrapper
macros.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/pgtable-nop4d.h | 23 ++++++++++++++++++-----
 include/asm-generic/pgtable-nopmd.h | 24 ++++++++++++++++++------
 include/asm-generic/pgtable-nopud.h | 24 ++++++++++++++++++------
 3 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index acd62ee233536..2d86325235da5 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -34,7 +34,7 @@ static inline bool pgd_leaf(pgd_t pgd)		{ return false; }
  */
 #define set_pgd(pgdptr, pgdval)	set_p4d((p4d_t *)(pgdptr), (p4d_t) { pgdval })
 
-static inline pgd_t pgdp_get(pgd_t *pgdp)
+static __always_inline pgd_t pgdp_get(pgd_t *pgdp)
 {
 	pgd_t dummy = { 0 };
 
@@ -42,17 +42,30 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
 }
 #define pgdp_get pgdp_get
 
-static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
+#define pgd_check_dummy(pgd) BUILD_BUG_ON(__builtin_constant_p(pgd_val(pgd)))
+
+static __always_inline p4d_t *__p4d_offset(pgd_t *pgdp, unsigned long address)
 {
-	return (p4d_t *)pgd;
+	return (p4d_t *)pgdp;
 }
 
-static inline p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd,
+#define p4d_offset(pgdp, address)					\
+({									\
+	pgd_check_dummy(*(pgdp));					\
+	__p4d_offset(pgdp, address);					\
+})
+
+static __always_inline p4d_t *__p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd,
 		unsigned long address)
 {
 	return (p4d_t *)pgdp;
 }
-#define p4d_offset_lockless p4d_offset_lockless
+
+#define p4d_offset_lockless(pgdp, pgd, address)				\
+({									\
+	pgd_check_dummy(*(pgdp));					\
+	__p4d_offset_lockless(pgdp, pgd, address);			\
+})
 
 #define p4d_val(x)				(pgd_val((x).pgd))
 #define __p4d(x)				((p4d_t) { __pgd(x) })
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 9322f07ddf1ef..bd40d3a5743ff 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -43,7 +43,7 @@ static inline void pud_clear(pud_t *pud)	{ }
  */
 #define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
 
-static inline pud_t pudp_get(pud_t *pudp)
+static __always_inline pud_t pudp_get(pud_t *pudp)
 {
 	pud_t dummy = { 0 };
 
@@ -51,18 +51,30 @@ static inline pud_t pudp_get(pud_t *pudp)
 }
 #define pudp_get pudp_get
 
-static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
+#define pud_check_dummy(pud) BUILD_BUG_ON(__builtin_constant_p(pud_val(pud)))
+
+static __always_inline pmd_t *__pmd_offset(pud_t *pudp, unsigned long address)
 {
-	return (pmd_t *)pud;
+	return (pmd_t *)pudp;
 }
-#define pmd_offset pmd_offset
 
-static inline pmd_t *pmd_offset_lockless(pud_t *pudp, pud_t pud,
+#define pmd_offset(pudp, address)					\
+({									\
+	pud_check_dummy(*(pudp));					\
+	__pmd_offset(pudp, address);					\
+})
+
+static __always_inline pmd_t *__pmd_offset_lockless(pud_t *pudp, pud_t pud,
 		unsigned long address)
 {
 	return (pmd_t *)pudp;
 }
-#define pmd_offset_lockless pmd_offset_lockless
+
+#define pmd_offset_lockless(pudp, pud, address)				\
+({									\
+	pud_check_dummy(*(pudp));					\
+	__pmd_offset_lockless(pudp, pud, address);			\
+})
 
 #define pmd_val(x)				(pud_val((x).pud))
 #define __pmd(x)				((pmd_t) { __pud(x) } )
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index 8f01abbb00503..7475d0bd0f2e0 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -41,7 +41,7 @@ static inline bool p4d_leaf(p4d_t p4d)		{ return false; }
  */
 #define set_p4d(p4dptr, p4dval)	set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
 
-static inline p4d_t p4dp_get(p4d_t *p4dp)
+static __always_inline p4d_t p4dp_get(p4d_t *p4dp)
 {
 	p4d_t dummy = { 0 };
 
@@ -49,18 +49,30 @@ static inline p4d_t p4dp_get(p4d_t *p4dp)
 }
 #define p4dp_get p4dp_get
 
-static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
+#define p4d_check_dummy(p4d) BUILD_BUG_ON(__builtin_constant_p(p4d_val(p4d)))
+
+static __always_inline pud_t *__pud_offset(p4d_t *p4dp, unsigned long address)
 {
-	return (pud_t *)p4d;
+	return (pud_t *)p4dp;
 }
-#define pud_offset pud_offset
 
-static inline pud_t *pud_offset_lockless(p4d_t *p4dp, p4d_t p4d,
+#define pud_offset(p4dp, address)					\
+({									\
+	p4d_check_dummy(*(p4dp));					\
+	__pud_offset(p4dp, address);					\
+})
+
+static __always_inline pud_t *__pud_offset_lockless(p4d_t *p4dp, p4d_t p4d,
 		unsigned long address)
 {
 	return (pud_t *)p4dp;
 }
-#define pud_offset_lockless pud_offset_lockless
+
+#define pud_offset_lockless(p4dp, p4d, address)				\
+({									\
+	p4d_check_dummy(*(p4dp));					\
+	__pud_offset_lockless(p4dp, p4d, address);			\
+})
 
 #define pud_val(x)				(p4d_val((x).p4d))
 #define __pud(x)				((pud_t) { __p4d(x) })

-- 
2.43.0

