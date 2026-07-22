Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A136B93C;
	Wed, 22 Jul 2026 15:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734375; cv=none; b=OWqY2DGwnyHh3HxWn4rQUx8xzqYB+Ta4lt3Y2kMm/A7JZg7L2cwELrPaJXjv0BrFrmBo2L/dM2uQXTO7EJ6DuiNgeGbuFrLWC6P5kq/UucKZCFkQYgNC1lhahw0fqx3a96GfYVshPtlLOa1PfSsrwq9evh19N4FNWNYYwjdyU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734375; c=relaxed/simple;
	bh=32SOK5uh9E5GblRgaV7XM5xO+tgYklgQI1N792ThLp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jxf1CorgDK6vUsxKTN24wweEAMQNtenuyWLfzkCxLeux5HOZILQlnu3SRod6E529p1aLMXmWgikH7rGJSJeMQ2K6ZIrVPfxdUPmyf/e2CFV2+3KShy2rmf/niLZdd9fJpLoR28/sRtdkfdd7MHG1GHYuCiJbfWM0Pd3IyojXkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Z9iQmzRI; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Z9iQmzRI"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDC5168F;
	Wed, 22 Jul 2026 08:32:45 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6AB133F66F;
	Wed, 22 Jul 2026 08:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734369; bh=32SOK5uh9E5GblRgaV7XM5xO+tgYklgQI1N792ThLp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z9iQmzRIV9pJnoh2hiGVa9ykrtfqzzjDRhpsVG7HB9mUxK1Ydq79kvbnesR5P85vg
	 l5qCgCFo61s2z6vCbkE9bR3zFUgYTlJwz83TKSEc0aENmhFNGRIAQ3EbNpHzJLxnGS
	 JEq4PENZLBxO5Ajnd4KcJxsDCzfyRWplfYCjcNpI=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:26 +0100
Subject: [PATCH RFC v2 18/20] mm/pgtable: disallow calling folded
 set_pgd/set_p4d/set_pud with dummy
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-18-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
In-Reply-To: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2943; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=72r/KAfsnxC0TtxtNsnKFwa+EPFsf1mj7ooxl5Dvfk4=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIYpRCL2kb+SSUvVch8xReBRMPEyqCZIVn8X
 b/zh0aeNKWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiGAAKCRBt1cPRWsUx
 M+pbC/9CtkmpOcQ9F4GGyLnOuiLOEo5b2ROwD1I5zPd1cPHGuVTNUZXHqOLTTLv+feYvEaRNS3Z
 IURhne2r5mprDEF78/YPTYMXnMHtqv2lrbabG6OVkp8cC54ISx13HX75MGXoTZnKz4kVIuTHDQN
 iy95ZvXGHln787hkEX1cila15mNcOBZRLTpB5wTUPuo2xeaQxEUwN5tBg578CXt3rFT2Z0kTDDm
 aDJnKlAyUDoc9zOFK7KHnYUvXU2myPODDiuJXp3rWmAZjMBvarSdGTkbAww6NLEBebM7kGyl4KN
 AF460tD32ygD8fYb2KRxPuECIt8Kw0VVf2M0wcJmMfOIHiUFl8FXcatscWKDuEqDy6vFa7+cPcJ
 yw9ypwNhnSgFVejzmjhJqtSzTppFlH0iH4p0RQNUGe+i1lo+NCeNyetGLAdAbcNug3p+7MvZoaN
 f+L0PmWXEePXWK4caevkf2aHZEHRkD4ToFUz3RuAB9s9Do544YGwAjEdmnP5hpsMi6da4=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Make all code compile-out any calls to set_pgd/set_p4d/set_pud for
folded page tables. So let's make the compiler complain if these helpers
are abused with dummy.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/pgtable-nop4d.h | 11 ++++++-----
 include/asm-generic/pgtable-nopmd.h | 10 +++++-----
 include/asm-generic/pgtable-nopud.h | 12 +++++++-----
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 05c3acc0884b..19f5a6eda76c 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -28,11 +28,12 @@ static inline bool pgd_leaf(pgd_t pgd)		{ return false; }
 
 #define pgd_populate(mm, pgd, p4d)		do { } while (0)
 #define pgd_populate_safe(mm, pgd, p4d)		do { } while (0)
-/*
- * (p4ds are folded into pgds so this doesn't get actually called,
- * but the define is needed for a generic inline function.)
- */
-#define set_pgd(pgdptr, pgdval)	set_p4d((p4d_t *)(pgdptr), (p4d_t) { pgdval })
+
+#define set_pgd(pgdptr, pgdval)						\
+({									\
+	pgd_check_dummy(pgdval);					\
+	set_p4d((p4d_t *)(pgdptr), (p4d_t) { pgdval });			\
+})
 
 static __always_inline pgd_t pgdp_get(pgd_t *p4dp)
 {
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index aa4902f63c0e..61852eb4b150 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -38,11 +38,11 @@ static inline void pud_clear(pud_t *pud)	{ }
 
 #define pud_populate(mm, pmd, pte)		do { } while (0)
 
-/*
- * (pmds are folded into puds so this doesn't get actually called,
- * but the define is needed for a generic inline function.)
- */
-#define set_pud(pudptr, pudval)			set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval })
+#define set_pud(pudptr, pudval)						\
+({									\
+	pud_check_dummy(pudval);					\
+	set_pmd((pmd_t *)(pudptr), (pmd_t) { pudval });			\
+})
 
 static __always_inline pud_t pudp_get(pud_t *pudp)
 {
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index 3264673c0c38..5ee8f1852cd8 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -35,11 +35,13 @@ static inline bool p4d_leaf(p4d_t p4d)		{ return false; }
 
 #define p4d_populate(mm, p4d, pud)		do { } while (0)
 #define p4d_populate_safe(mm, p4d, pud)		do { } while (0)
-/*
- * (puds are folded into p4ds so this doesn't get actually called,
- * but the define is needed for a generic inline function.)
- */
-#define set_p4d(p4dptr, p4dval)	set_pud((pud_t *)(p4dptr), (pud_t) { p4dval })
+
+#define set_p4d(p4dptr, p4dval)						\
+({									\
+	p4d_check_dummy(p4dval);					\
+	set_pud((pud_t *)(p4dptr), (pud_t) { p4dval });			\
+})
+
 
 static __always_inline p4d_t p4dp_get(p4d_t *p4dp)
 {

-- 
2.43.0

