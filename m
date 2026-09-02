Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313DB481FCF;
	Wed,  2 Sep 2026 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350257; cv=none; b=LrRBamQITnRi3O5QdhDFi7bLXy/jM6j5QbptCo2VxaJDty+GByjG1YWhlZn1yA64usaIsjX+HRtscFuEXREVKgT3wq3z9xkW9CIofnrtCDQvrbVUl8bVNklYupcoDeaiLI1NYi0pZKbaOEmz3kOeEmqDQBK8tOqvWp5iWtumUzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350257; c=relaxed/simple;
	bh=AEzoNqJWVGEbFZMm+Tu7vEHKp4NF/8YTbhQnUKsI3m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sohv0TeDywwQUqllP8ovp0K1u3tjPjvsF/edPhknDfC8Y7SXxEPWblYbm8oOVcCayaR8hCklBZA9uez5/ZuhtlCZCDun+FtLfdrxS0ljPpYyCsJoiKuZIA6fwPcgGDJ5V+P/FXFH7DmwfwRLomIgBsJHtHgbUrmxDwESRkQtwBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rDhX00MP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rDhX00MP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F23C61682;
	Wed,  2 Sep 2026 04:57:16 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A6603F85F;
	Wed,  2 Sep 2026 04:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350240; bh=AEzoNqJWVGEbFZMm+Tu7vEHKp4NF/8YTbhQnUKsI3m4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rDhX00MPIeeIR4/aNEALnSD180H0Rq4w476QmcrQalugOcR068b6Ssx4dUNN+D+7M
	 NTCmQ7okmA3nur8IK/sSj2IT8efBSr5H5MBtXxSIGdE/mWPzf/LtQtpk5//WWhwMpl
	 QDzgztTq9IwHHlxrFQT2hNqr1xsq+hTgnATXvCsM=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:08 +0100
Subject: [PATCH RFC v3 06/21] mm/pgtable: define (pgd|p4d|pud)_leaf() for
 folded page tables
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-6-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
In-Reply-To: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2645; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=YBS0Wsk+xkEZqH0tYrGlw8G+wUvAR+VIvzuFsaQMCdU=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7kbsa357ogNAOMBFKPrS36nRaOAW3NnTvXN
 g1Fn0QQqKWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO5AAKCRBt1cPRWsUx
 MzDoC/9z4m8r6ojRFiRZMEOkVvdnc4vvf7uPxKhHnjXcv6Cg2C8vEkuYn9TPkuh9PTW9ENWRhzb
 yJiujsYNPfHUzu16XkVVMy03PnWyfefbhdbj6XnqppUsLXXGgnYGXwjKKguXzhGP9VZl0Xvizcc
 xs3I8jR/vRFlKh/JJxcQv+mTbY4iTYZg9PurZ/0XgJhnJ8xvns/Qv4R9fdQpKLYxo2p5gJOMlQU
 9bVt+T4JpLNiZvDYEVumcxzuFxzeQkKUGxhZ7Y3/OCO4OuGo1rE5jpU9q+IgA7ojcbXZ+gaaOjt
 cpY1tD4oA5vYqZ0r5tgWm9CnO6QEkhy7W89kmB54q27+Po92E71tEXZSOAMS6zs/IBgIIu9bF9g
 8tyrLcGNPySE/WE3c6HD5TBY6cn2nDM3GlvOEwlYAs3SLBpDTj/XOYK5rgt/2dP5snbu273q/s1
 1YrNxbGBvCWvC32W1ZWq6nQkFR/ucefGCfdA5vSU79pVeB9Z0XlfeqezSFZiqsSHq5cr4=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

Define (pgd|p4d|pud)_leaf(), hard-coding it to "false". Note
that it's missed to define pud_leaf() before, allowing architectures to
unknowingly overwrite it.

Still use static inline functions (type checking), and while at it, just
use "bool" as a return value.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/pgtable-nop4d.h | 3 +++
 include/asm-generic/pgtable-nopmd.h | 3 ++-
 include/asm-generic/pgtable-nopud.h | 3 +++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 1cf739ee38aa..c6a5a43899b5 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -22,6 +22,9 @@ static inline int pgd_none(pgd_t pgd)		{ return 0; }
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 static inline void pgd_clear(pgd_t *pgd)	{ }
+static inline bool pgd_leaf(pgd_t pgd)		{ return false; }
+#define pgd_leaf pgd_leaf
+#define p4d_ERROR(p4d)				(pgd_ERROR((p4d).pgd))
 
 #define pgd_populate(mm, pgd, p4d)		do { } while (0)
 #define pgd_populate_safe(mm, pgd, p4d)		do { } while (0)
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index ff4235cf84d7..4e5aaf253b6a 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -31,7 +31,8 @@ static inline int pud_none(pud_t pud)		{ return 0; }
 static inline int pud_bad(pud_t pud)		{ return 0; }
 static inline int pud_present(pud_t pud)	{ return 1; }
 static inline int pud_user(pud_t pud)		{ return 0; }
-static inline int pud_leaf(pud_t pud)		{ return 0; }
+static inline bool pud_leaf(pud_t pud)		{ return false; }
+#define pud_leaf pud_leaf
 static inline void pud_clear(pud_t *pud)	{ }
 
 #define pud_populate(mm, pmd, pte)		do { } while (0)
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eedee8e3ad68..6c9bca78047c 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -29,6 +29,9 @@ static inline int p4d_none(p4d_t p4d)		{ return 0; }
 static inline int p4d_bad(p4d_t p4d)		{ return 0; }
 static inline int p4d_present(p4d_t p4d)	{ return 1; }
 static inline void p4d_clear(p4d_t *p4d)	{ }
+static inline bool p4d_leaf(p4d_t p4d)		{ return false; }
+#define p4d_leaf p4d_leaf
+#define pud_ERROR(pud)				(p4d_ERROR((pud).p4d))
 
 #define p4d_populate(mm, p4d, pud)		do { } while (0)
 #define p4d_populate_safe(mm, p4d, pud)		do { } while (0)

-- 
2.43.0

