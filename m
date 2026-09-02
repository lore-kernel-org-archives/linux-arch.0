Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672A247798B;
	Wed,  2 Sep 2026 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350292; cv=none; b=RJeDN2pXdamfXydtViSXDhMOiObLCtx+OHsvV0iuMtR4tPn8/B0UOixuxFsqGKIGa9bBFc3LX3a5UyC9zz1M5cdGXcdwCboi/WNn6Zszf4CaMs4cfS8Uvv501HKD7Swb4Nkt79ucnr0FccObIvtu3Rcxa3vxBzHRYaB8gWotNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350292; c=relaxed/simple;
	bh=JAI8HuvMrB06U9pngwcLmVHYlvLOsBAW7o0q3zLItzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QzN/anzdTjsv504sAgD8Rlpq+QEhNeWwnt08NSIXUVEEzfVuQ8BaLX4J4OO4mVtOc8a5RKQU7EN6q2xWHUqY1wItsDqvvXOCenyJuq5WOVx4R0H1YqckJp+GNuZ6FiHxasOWGow/w9kIW7L5PawV+3a/OB8iHItaoTw79Mm1GBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Br0kvwiZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Br0kvwiZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 831ED1684;
	Wed,  2 Sep 2026 04:58:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09BE23F85F;
	Wed,  2 Sep 2026 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350286; bh=JAI8HuvMrB06U9pngwcLmVHYlvLOsBAW7o0q3zLItzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Br0kvwiZKirBYwtP8GSbqaahPr9eXVJSF3G6/g+zhRfz9rudpPonCKSJx1zZiDP5I
	 seMnZ0FIMrBMphvLYpfrg+MO5sigrisjQEeqGAmO+6ELBvPgtEKno0usZoDWmbAedz
	 z1OTeZdg4q9ETpJggfEcDWTY/b5vPm9214of8Xyc=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:14 +0100
Subject: [PATCH RFC v3 12/21] mm/pgtable: redefine PGTABLE_LEVEL enum with
 ascend order from PGD
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-12-5d8f5b17c25c@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=JAI8HuvMrB06U9pngwcLmVHYlvLOsBAW7o0q3zLItzs=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7nq1z+UGkBh+k3plBTwHn84nfJGlTH4HLv6
 PSsOOGZ/OqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO5wAKCRBt1cPRWsUx
 M4WQC/4j5E65SCGx3a5/ZzEhrT7FR7As2mIMS9VAlDcEK/fUO+neWKP+3tAec53rUxb4zzYZKQr
 g3mrmjGqQfOQWFk0eMRy2UiUFM9sGnzM+aPCUjoMiPSlvR4ZloQz6B11DzS/1vcE9hCDnTfjvtK
 qVQP7mnCLKp6tqIu24k7YyT7/1M5TwLF9MckxKXher2kNgQyHoOU0A++ZAo8AnP5mdlzo5T2a0H
 yqfNYTL2jA0+vAPusTvh552PMoTvcNMpL10IwhehGblQh3b2mr3AWKiPaiII+C/tvF8CX1S0hYO
 Lsv/z7b/+GbqLVyVEZPDMeZ76r21qIJjSuSzlY3XmUdMaIXYuG5Zh2EeZh0142nK7VIzSEQXJdl
 1WqI52sg40psqB++3zm3uJk2vkt3ViK3XEvLCey+cs9cs3THb4NBf8ha4nuPMmOFiw6Bt6yHWOk
 PpTMxtIHG90CMyP8nQCuRgq1kKwGXaA+MSt7L4chgHdCIlEnjwejGwdNLXoe7Bqj4d0Sc=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The PGTABLE_LEVEL enum values appear to be ordered in the opposite direction
from their intended usage.

Intuitively, higher page table levels should have smaller enum values,
but PTE is currently assigned 0.

For consistency and cleanup, reverse the enum value ordering.

Since there is no current user relies on these numbers to be ascending from
PTE->PGD, so it can be changed to be ascending from PGD->PTE, in the
direction of the page table walk.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/linux/pgtable.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index e3c8ab96941c..3186096a6e13 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2288,11 +2288,11 @@ static inline bool arch_has_pfn_modify_check(void)
 typedef unsigned int pgtbl_mod_mask;
 
 enum pgtable_level {
-	PGTABLE_LEVEL_PTE = 0,
-	PGTABLE_LEVEL_PMD,
-	PGTABLE_LEVEL_PUD,
+	PGTABLE_LEVEL_PGD = 0,
 	PGTABLE_LEVEL_P4D,
-	PGTABLE_LEVEL_PGD,
+	PGTABLE_LEVEL_PUD,
+	PGTABLE_LEVEL_PMD,
+	PGTABLE_LEVEL_PTE,
 };
 
 static inline const char *pgtable_level_to_str(enum pgtable_level level)

-- 
2.43.0

