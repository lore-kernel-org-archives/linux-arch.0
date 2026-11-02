Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618618;
	b=RPXZd8TU6kqAfx35uozyPwcmxnjOrzG8/93+nRyZyHtUkoBvl5DxLlkrUMfCppE9+DVe
	 WREbeG4sG2Y0kBB7CU/DOwiIGtagA7tOYa6Ka3svJLVhw29cCPP4UDJEL35Q++eV2P7YW
	 H/x5DzTQcZk9MKqihwR7B1gOtEutK/oNmFqfm1cEAbrlP4NUf8J7JIxQcmpt3gFu83bAS
	 d+bac3Kbkpdv6D3phBO7+iwc50KtcqE+VOpL7q3qp+TCJ+hwA8NsJkn7cfBxIM0HRWd2z
	 9FLtR65KWQsL5DfMfaXH71YM9eyUD/VVN3n0QjKDpMsKJtbFkg+5oduzgfZoEZLxBRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=r03SVNisaJd6Dqlau4jEcL3AHt7KSVLlnibo546VQzE=;
	b=qyuxbwzyXutJZIGBEa/OhpMkb04TZmeLrdLvMOhWi8j9Vhu1WXWUOCZTQyJAxlAAG8kR
	 HAMkOn6nSUIbjyGJ6wXSyer5y19nlkaDC6Uy68VMfFJXN00DG6Pa4YtqwGulukKwKiJ08
	 DT4qdexIGHlFZYlDxToeEmqw9m/1UEizhARHgbJfADR8L+PhE7yRGkE9s5YUlusHJmqh7
	 ai7CR9K0756BZ+44Yu4kCwYZ8eMSY1HNGy4uiaot7qbiXwfh8fBb/H5lktVSgTQ2IeIVV
	 zZ3h2Ereduv9db1C+KMyRX3pLSi7v+MnDkA+Kc4XZF36gaXhaKZhZ/LiZ1888vq7GiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CwVB6rMt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4F160A3E69;
	Mon,  2 Nov 2026 11:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE4F160A3E69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=CwVB6rMt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E922972;
	Mon,  2 Nov 2026 03:23:33 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D9D3F632;
	Mon,  2 Nov 2026 03:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618616; bh=dSuJLJ9ohCs7txtQHt7hy5Mg9PfzhT9ZTRhsbp3QTUc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CwVB6rMtqNmeYtlR1b5rAD+CAIj3PVpzx0TNgbS2AaT+wfXypUwT+nr1RgaU6prdn
	 wx4ZJ1+P1Z8sgtto7zgnVVCGSAO8z5+AsUmYsLGA7Kqq+a/3e/x2vbXgYudKhQUhQe
	 xL4k/FXvf0s66pNjWZaBxEuK7WqFmVa+wKQzwSMk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:32 +0000
Subject: [PATCH RESEND v2 19/21] mm/pgtable: disallow calling
 (pgd|p4d|pud)_page, pgd_page_vaddr() and (p4d|pud)_pgtable with dummy
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
Message-Id: <20261102-dummy_ptxp3-v2-19-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=VRD/vI2+dr2wFISWOiD6XpoJffv8Fhm2BOtCv803wXw=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI4L8kv/rf2UKz5TAtyDoaFDZOJqCmrvBcnK
 CELM1gmsnqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyOAAKCRBt1cPRWsUx
 M8DMC/9r3/0o/7ps/8n84d+IlLJLH4xeS8PCLDRucy3Gl/HwXz9m4hNon0sr2opEa7GLxc8/Xd6
 lu2bhmjWEtNjPAuwRQrn7FukyWajBKqHxpnX9+5qRzo6RvT0BiWe5Am7M0higB9P/Zp8MV8buCG
 hcJyBrJJdosfOfcCiCbHQzma2OvD0vo50RF8MqSVBrCTg6nAL1L+o1jzMOVuCAoZwuhpp01kEwo
 QwhxO6qbkCBvGotbr1kqvT5Wv+azNDF5d+LJYIxv2XPpMosFNzqd7GRl90tJmUHOOm/HMjzwoPy
 40p2WwzfGv3BMTPz63vusUm69j9Kc+8pWxCWc3V9ws1ch6wSdb3Xcx7wYuBtaPaZsr2u44OBdQL
 CoMUSFbcqH0C+fhJ8ElXCjrOmegadJe+eDzLZy12gsz5y4KyyBDlzmcPpapzk+xCI6f1x68sbE6
 eUa2ZCWtJTGxSjrChh3GXnLvZ9I1j9cw7wUPNlgAZQg7bqYuJ9moJVh2af0tDVYZlzNq8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

These helpers silently fallback to the folded helpers. With e.g., pdgp_get()
returning dummy values, pgd_page_vaddr(pgdp_get(pgdp)) will now behave
differently than pgd_page_vaddr(*pgdp).

Disallow calling (pgd|p4d|pud)_page() entirely, and catch when passing a
dummy value to pgd_page_vaddr() and (p4d|pud)_pgtable.
This will catch most abuse of dummy pXdp value at compile time --
so far there were none, and it better stay that way.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Co-developed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/asm-generic/pgtable-nop4d.h | 8 ++++++--
 include/asm-generic/pgtable-nopmd.h | 8 ++++++--
 include/asm-generic/pgtable-nopud.h | 8 ++++++--
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 2d86325235da5..d2dccf7542da5 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -70,8 +70,12 @@ static __always_inline p4d_t *__p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd,
 #define p4d_val(x)				(pgd_val((x).pgd))
 #define __p4d(x)				((p4d_t) { __pgd(x) })
 
-#define pgd_page(pgd)				(p4d_page((p4d_t){ pgd }))
-#define pgd_page_vaddr(pgd)			((unsigned long)(p4d_pgtable((p4d_t){ pgd })))
+#define pgd_page(pgd)				({ BUILD_BUG(); (struct page *)NULL; })
+#define pgd_page_vaddr(pgd)						\
+({ 									\
+	pgd_check_dummy(pgd);						\
+	(unsigned long)p4d_pgtable((p4d_t) { pgd });			\
+})
 
 /*
  * allocating and freeing a p4d is trivial: the 1-entry p4d is
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index bd40d3a5743ff..2afbf2d8659dc 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -79,8 +79,12 @@ static __always_inline pmd_t *__pmd_offset_lockless(pud_t *pudp, pud_t pud,
 #define pmd_val(x)				(pud_val((x).pud))
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
-#define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_pgtable(pud)			((pmd_t *)(pmd_page_vaddr((pmd_t){ pud })))
+#define pud_page(pud)				({ BUILD_BUG(); (struct page *)NULL; })
+#define pud_pgtable(pud)						\
+({									\
+	pud_check_dummy(pud);						\
+	((pmd_t *)(pmd_page_vaddr((pmd_t) { pud })));			\
+})
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index 7475d0bd0f2e0..3264673c0c386 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -77,8 +77,12 @@ static __always_inline pud_t *__pud_offset_lockless(p4d_t *p4dp, p4d_t p4d,
 #define pud_val(x)				(p4d_val((x).p4d))
 #define __pud(x)				((pud_t) { __p4d(x) })
 
-#define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_pgtable(p4d)			((pud_t *)(pud_pgtable((pud_t){ p4d })))
+#define p4d_page(p4d)				({ BUILD_BUG(); (struct page *)NULL; })
+#define p4d_pgtable(p4d)						\
+({									\
+	p4d_check_dummy(p4d);						\
+	((pud_t *)(pud_pgtable((pud_t) { p4d })));			\
+})
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is

-- 
2.43.0

