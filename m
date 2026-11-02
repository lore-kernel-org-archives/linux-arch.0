Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618612;
	b=1HftajZv4Zx0Fd4CJdL1g4CNgS7+W/p6POl62AS1XMwlTPIFmmZM5k+YbVLs2hXpAl3q
	 oPzK0Bn4wtWfYPcM44RNxVroDmfJXx1D0eFtTUh8eyrYUvS3UlhR/Dlux7x4hbhRtSjMi
	 4dGy6e41weDfsR4aNcc0Ogia5DcdHpOByVwAlm2VMvJqu+ogsOaz11ibxSfTV16oOMw5T
	 wpzgyFGgTfhTOtMVeCtOo+KZMs8WpEgjkFpovUNWnUjxRMc01Rfkp5YWpjlYOAU2YN3SX
	 ckDB1S9FQ0yEkkcUVD/p2dBNBtw2la6D/CfWPoc2B7nKVpBzpNAEILolbktejS4VNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618612;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=IeiusvcN//HYTYvtTON+UwfbtKPYQ1WsySCM+ju+JhY=;
	b=LDjUnVAlh/VG4W0buTciXnhathaznU53DYhSdR8+EFbaZmMSJPhmKLuGMlHABqAotNGe
	 uT5RLa78Nt9HBuj1LXCFjZ+o+xNqy53XHnxmTmSd5hQP+49FlJgybr4SH1zqkyXskzFHy
	 HKVyMca8lSLUBt/NriyF4m1pZoYgGQvg8ToSP9ZunDBeUrHUg5aeA9lUVKd3ONi0O6veG
	 mgRiUgyjnWGy73SeyBf0Bd5+07ftBkpqawbcPI/MqXDFzcWopi8kJYLT2tuyZ4Bs3m2nT
	 LfnV2POqjptsdgLuQpGW2gsRpw4//CZTx/jxnq+a8FbO0PCa/dK6eJbyyJHfeoE840g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L5j3S2qm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8860A2613;
	Mon,  2 Nov 2026 11:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC8860A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=L5j3S2qm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79DD42A31;
	Mon,  2 Nov 2026 03:23:27 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89B4C3F632;
	Mon,  2 Nov 2026 03:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618610; bh=9p0dJer5accV7E9pXDd7DTUz4Dg0mJc0MW7cEdf4VMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L5j3S2qm8erUkEnuGpQ+xZoox86f9aM0Yh+vfWn9rT6rT3HYiCekGcPdgKtV/eHGU
	 cOzdKjfWTtmrj2Yem7njZ9d/jGjmN11KDgzoGy2hRRBQ/O0+Lj5Zuab/DFFScOf59K
	 4X4dWPJh/ihgTTm3pK0IjJ/JoVR7h8Xos6Wr3vBo=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:31 +0000
Subject: [PATCH RESEND v2 18/21] mm/pgtable: catch abuse of folded dummy
 pgd_t/p4d_t/pud_t
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
Message-Id: <20261102-dummy_ptxp3-v2-18-78840b2ec73c@arm.com>
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
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5536; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=RaNq1OzclUEkYVVkonyr81I//WUCo0pQ53h1961FIzo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI35LQrwLJTJ6JHFqKa5WNjGsjc9SCCBxZ91
 V5ViWPS3ImJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyNwAKCRBt1cPRWsUx
 M5CXDAC5wcFzP5HHs/20OLo/fEv0r+XaQDjC0DAJwcDl0jfQa5A9j234lqJcFQ2J3UF5aj4jVZu
 sJe0FGfp6mVD4y/ZdJeadQTJG7x1t6cxs1VGc83wL1G2NdN8NdBoAP/23a+KrO9hojG2crw1zYL
 NH41zJ6inULqk0Asfw/J56fwREX6K4F1nLJtPYEG0xHwUyzRwjcKPZjgVrim6gRiPDFwl77zT1O
 BNcM/4sON+rTiP1b0OpoP14EccvL7OJTp1JfCll/KJJhbQZwz27DVDNfzVMaYlHiFjrGlE7AFSI
 Z3TqFvckPUPKqoY1QqjnCxoiLaVuX7/WWlCKdmj08IOVAohulKhFiI/GNdhN6RO+JCtKNNuwE3T
 oVyP2vI/YF3KVazeRdNDp8yHcZg6ZR3ZYTDyWbtlojKD1zkvrm59hNA/XTxs1Us/8BWMvAe45tF
 P0TXfrBvEC9mSeI50hhAF8Kdgc8z5fNItEOx7/JZB/e8FiFZCY+RGyoyOH/SvHTY+ufFc=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Catch and prevent all abuse with dummy values on the stack
similar to:

	pud_t pud = pudp_get(pudp);
	pmd_t *pmdp = pud_offset(&pud, addr);

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

