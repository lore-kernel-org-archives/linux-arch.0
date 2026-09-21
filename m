Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4164486620;
	Mon, 21 Sep 2026 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988206; cv=none; b=ptg0ONNrVk0rf7pB+5pDQ0ZMITji6NZCJuPnUzNU76/cfI7JE/h8tN6CRYyga9KpRKU3V/Nzp80nR2xAwlN9crP2wY9N7EQ2HMLiMDmnicW7xu83c4uF8sPXMApexlIttMH9gGPjvF6hNQPpKeY72NM8tLQRW3Nel2O+/IH5e20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988206; c=relaxed/simple;
	bh=MWIk55sq3Xl5IhFPSCZgQqnLya5ldzX0H6ZlzYM7l/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQ+Jo558uL3i0mTrMfhfQITLE/Sg9FGKqelS93I8AKfcKaGZ+GUhU9cWlnfyt+qJxdp9CfQhZqmI3WKY1f8whQnnAr0ZDvYmAgdccSnT62FsD/azTEARg2TNeBELRP0Gg7ERFJ9/oDYGBJ0900f/GLtPZEbZ3DzKfF4icYJjd24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jmExSGw2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jmExSGw2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EC071D70;
	Mon, 21 Sep 2026 03:56:40 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC3F63F86C;
	Mon, 21 Sep 2026 03:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988204; bh=MWIk55sq3Xl5IhFPSCZgQqnLya5ldzX0H6ZlzYM7l/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jmExSGw2LCoPoWhLv7wl3mcvZhvvMu/EFGtYz/YIjBdIYLmZ8xYhg+Bt8Lk13zyPM
	 uN6j9Bi3PcRRphGGPrmscaNUQ1hMTG6ePRq5Ad874ubG9TqkzhXg+MtwYO6s/uX21/
	 w+FObAyJbBmnpGp1xy4Af27ePeH4jFFQJWayxXdA=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:24 +0100
Subject: [PATCH 02/21] ARM: mm: make 2-level pgd_t a scalar
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-2-cd40cf68242e@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=4Z0osGAP3S0civxPu6dKKFX1qsd70Ol0fauRungSauY=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1LPMd3bY5l97IcQgb37uybVOO0YHrmaWze2
 pZkKGx8ILSJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENSwAKCRBt1cPRWsUx
 Mwi2C/95zvtyR94wqriOwlZeIlIVdVW5IF05ARsQWsZciGmadMujO3xVKbNNHmP7n4X6txHc9Bt
 1yPnW09kbOfe7xYWAPC4nw7e/Hz3E9vAZKgyIA+coj/w3E4SPS7GTyJ73zHuaoDvwAQEISXVRPW
 Pc2D0qopExouM3mWXINlfYnSOrYBHF4n6Li9Svio9m9EvcuV7NFR6d7+63k62CpNiUtK+tbIl0T
 RjaODkF1exxt6WziJl3rlm/T5QqRmjtA7pQyQ0EsNsVW91e7QgyT12RizaKDjYq/R7+ybfAinCt
 vRf66DRuwomc5tDPxoUIYUjiLa+sJLJr8TY0hv+mQ1Q4/4hMCPHnlYAGZShYe9PiTNmx6Mebzaw
 Uf8pO5f6ifwoPDZYfnwsLX3DPUMkDWnDejDdUiskVvMfbwCSuyIZeeDy3cP8ZxoJbVzyOdfp5Ok
 0ZzHyHaELLDw/lpY50IvDiCohQ0OsFlKpDv5F9Z6evbkrsXVyMpScSsKxaQVtexaZTtl0=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

As pgd_t is returned from a function like pgdp_get(), pgd_t shouldn't
be an array.

So, just use an u64, and extract the right 32bit value in pgd_val().

Leave the STRICT_MM_TYPECHECKS case alone for now.

As an alternative, the STRICT_MM_TYPECHECKS approach could be used here
as well, but using an u64 looks conceptually cleaner, even though
pgd_val() gets a bit more involved.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/arm/include/asm/pgtable-2level-types.h | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level-types.h b/arch/arm/include/asm/pgtable-2level-types.h
index 650e793f41429..805044ea315b7 100644
--- a/arch/arm/include/asm/pgtable-2level-types.h
+++ b/arch/arm/include/asm/pgtable-2level-types.h
@@ -25,7 +25,7 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 
 #define pte_val(x)      ((x).pte)
 #define pmd_val(x)      ((x).pmd)
-#define pgd_val(x)	((x).pgd[0])
+#define pgd_val(x)      ((x).pgd[0])
 #define pgprot_val(x)   ((x).pgprot)
 
 #define __pte(x)        ((pte_t) { (x) } )
@@ -36,14 +36,28 @@ typedef struct { pteval_t pgprot; } pgprot_t;
 /*
  * .. while these make it easier on the compiler
  */
+typedef u64 pgdval_t;
+
 typedef pteval_t pte_t;
 typedef pmdval_t pmd_t;
-typedef pmdval_t pgd_t[2];
+typedef pgdval_t pgd_t;
 typedef pteval_t pgprot_t;
 
 #define pte_val(x)      (x)
 #define pmd_val(x)      (x)
-#define pgd_val(x)	((x)[0])
+
+static inline pmdval_t pgd_val(pgd_t pgd)
+{
+	/*
+	 * A PGD entry actually corresponds to two PMD entries in the PMD table.
+	 * Both PMD entries point to PTE tables residing in the same physical page,
+	 * but at different offsets. See include/asm/pgtable-2level.h for details.
+	 *
+	 * Historically, pgd_val() has returned the lower of the two PMD entries.
+	 */
+	return (*(pmdval_t (*)[2])&pgd)[0];
+}
+
 #define pgprot_val(x)   (x)
 
 #define __pte(x)        (x)

-- 
2.43.0

