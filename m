Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618535;
	b=o/HP0G+Ju91Ayqa8kgx8t/WYZ9xvZzzW2N5XKy8FcUoYU4bASYaohEXLBxvnjbI6S6E2
	 XxE6I7XjfgXEXtDNtNBJEbJ3hHhiU6pJdtQ6Xz/hLQjAEiQe9iueti4+t9kSqYHUAAQka
	 +bH55Ihv+av1lBWpz8bZG8+dAhd/IUdyvtQ52SRXnCss8wCuaOlYkw90fBRch9N42sJX1
	 8hwMui/qS3JpQBuqY991Pq1QGX3Nbqb7YL4/F70Z1H8eQr2YDNktcfeWDCQZuIKiNYkkl
	 3h0n22DsgZvIAf3ERpCqk8xnDoCnhLtKY4EnSCUbUI+Y01LTEvK3qQ/+ndkhE1whHzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618535;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=1XXfVIkNP4nITGpfyLSUIpM9B8UBbVvkEA7ohODjLRw=;
	b=N4+PealmYTRAikZANnMHtU83w+xRJSUW+BIuJzFBIKCym9T+zDhKzh5lgCPJWZ6u5qE4
	 aofWNClTx0lnWHf5B2Payc4AlP90EhOyoPVWddTnENP72K9blKY9eA+q7KmCsp3Bya0aH
	 hVqtPoNLl+wW369sSYTQtCAR+AKJc7xFLY2UrYOry740eILP9YLZODtcIKGt+RIlY/GUv
	 J3igYmud0GOz9lmeYvTLX+J5eTmE+CPokN3pdP57E803n+Lwo43+grtyFp9ebf2LUQlTF
	 GX/fpfqL0b19BARALIR4BP+ZWi0EgX98HVkT7CZyZx9Wuqeq5gWB+/WeAzYW05zElFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A7rQE586;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8829560A262A;
	Mon,  2 Nov 2026 11:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8829560A262A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=A7rQE586
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C90D9293B;
	Mon,  2 Nov 2026 03:22:10 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D99E73F632;
	Mon,  2 Nov 2026 03:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618533; bh=evfeL7lk1yM+NSCKYrKsUpK8FtfFqKH2c2v1uANMiZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A7rQE586SxmeYhdbuDjgGojrf+yFdXKkVJvIWE3/CkvAh47B/hi7pieq8pgJx6OPd
	 7+IdQ9YxhSeIZpcu39Tq98FmLu1Q3ge8+e61N66fuaQUSiCZLJB7SxbfiAp/g9FEqC
	 pD/C97hYRDBX9CkJO435UP1+7vyxZpzRkF237Vvg=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:19 +0000
Subject: [PATCH RESEND v2 06/21] mm/pgtable: define (pgd|p4d|pud)_leaf()
 for folded page tables
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
Message-Id: <20261102-dummy_ptxp3-v2-6-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=MsUi6fKiy4C8DH1qxUfB7PhJ8/xMmbWjYscC+NJ7HZ8=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIxIVd8yfHE+3CA9LTpZi1gUI+XMCzgs5U2Q
 BHJBi3iXj+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyMQAKCRBt1cPRWsUx
 M/V2C/9ItyCxgxlMh10fHR69tVgw9EuphM40QYD/mSrn4nLbxqXwGeoRCXJD/CQZjbzhVqNLqD8
 4pI+P8VaiZD1ROaf98yDqlm38MdDfJo/nXweMu2XCSuy8bvJOZ5akdNLIqOCNL/Kky/4vAvfA7y
 g/DN2CQi8iHcZmgFZENpatEkLXDT+irkdH/T8momUPL2iU/gMe9+PBe83/sjStUInekkPY+48fS
 tQ4YbgN0JI0jsnh5HfL7yHY0zHyLhvoIlmUPykZRIofr+KodLXQYFHAKOkD2khVIs/r2bFJxKJM
 7EZ9zMN52ptWFsHpkIIDhVoEnRhnj2vRlH6U7Y8kV9ZSGk2CzFCTZuWrT3cGyiZ4sRJ2z/gLRS+
 DXMtq/JtOP08ZaADSQRymmkYRKA9PLkrAtBZXZKwEO/gg81uxE4KT+wj8pXddgbXPnOWNxmpGA0
 MxTCMq+1KtHR5HFt8aTkW7OiLozCLtwsA62FVhYXV48+piX5IjzAgVxuzgBp34DGCh8VI=
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
index 1cf739ee38aa1..c6a5a43899b50 100644
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
index ff4235cf84d77..4e5aaf253b6a5 100644
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
index eedee8e3ad68f..6c9bca78047c4 100644
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

