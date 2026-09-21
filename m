Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EC448E0F0;
	Mon, 21 Sep 2026 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988251; cv=none; b=m9uOjDHaH0FZa5FKbgVlmkcWrcBsH1YHE9QXgxTCSFybChExl/AQksLVHGgYA6z3ZVYLTj0sfnFllLYAFkzVtmYJAerXvwx3/OPE6wB9Ufz6wNer7wzhA5gYX+8JoBXuoXbowOTxCMahYcBfKAYdOTJ6Tbf+cWmNFcH+nT7Umgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988251; c=relaxed/simple;
	bh=ywGIUWe4eG9Fo7o6yUhrB9doRugWRJ87ez63n7dCtOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YdHSymmywU+xZAGK+dpWSB4Dka/CcKTh9Ov5F5x1u/NwcldvDed/gCh54o39Z4PHrAuhdM8fdE+qktenXZkWkpQjVOmEg6wzySC5bpW/l/+kknStsTBs+ob9kCH8RjgB8+O+xFlTbfkj3oHgsNFk1ERhYh8pXPRRTIIRgWyNPAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=TG7hL96k; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TG7hL96k"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912621CE0;
	Mon, 21 Sep 2026 03:57:25 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B11E63F86C;
	Mon, 21 Sep 2026 03:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988249; bh=ywGIUWe4eG9Fo7o6yUhrB9doRugWRJ87ez63n7dCtOo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TG7hL96k21J46PvtLC59HQcHZYmuTxx9rr3LlmBn3clj7nC0IKikp8QCrZXShJiox
	 fJA0U5SPbxEnut2fgoLETk2PoTNcFpOzCPKxMO9mqeqjhO1uEMR7RAtABKtRMHEHQ0
	 b6ZmFs8B7G0JeikmhUafh8z+0+Is/vD6upLImixU=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:30 +0100
Subject: [PATCH 08/21] mm: vmscan: remove stack copy address of pud/pmd
 pass in walk_pud/pmd_range()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-8-cd40cf68242e@arm.com>
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
 linux-openrisc@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1416; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ywGIUWe4eG9Fo7o6yUhrB9doRugWRJ87ez63n7dCtOo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1ONrk530uquKqsKokVTVRoFTxsseBHhNflE
 f+mOH3t5ViJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENTgAKCRBt1cPRWsUx
 M6i5C/4jxR695g+aGeGrIAp5Hq3EK+JsBl4Xkw64Rh+MB3TRHC7oHN9GqMwjA0R8KVzPNX4iDSb
 opQlxOkF6mlSjUJGYxtqS1/XQG7tmGB0boaY6gUG0tIPmXOnfHwRWhoUKxqSVO71aiHCKtMDHx3
 bvrSwgP3w3zc8ggNJdnUy0wQcByFeJFXtAC1548O4Arfhb/ldpChjkVK3Ttsmgib2gqXAlb7o7e
 9kQEaAz1xbJx7+O2HbWqlXUHkPJFlrsGFKRoGNPmv+WuUmj9QEtHRlA1kSF54i0Omq+aH1S2gwL
 2LgEZ9bPoknyuFN6E9vrtpQYA1cCcuMTcUiDtUbwVryNrTwccRxsgqHoeJstzUoQ56opOp8sTAF
 Pb7joEtKSjOyjqcbbb/o2KTzQKHOb0DIdBIOTo6cAmoMHyo+NbTIe28IZaY5snJlAQuUdvNKFNo
 qjJD+aHKgVLGvNKvkeq2VdMiw2jy3gEJ6IWGuxArucd2EPLm46Ivh5Ej3meNBg4nU8tb0=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, replace passing the address of a stack
copy of a pud/pmd to walk_pmd/pte_range() with passing the pud/pmd pointer
directly so that  makes allowing folded entries to be ignored and
check the concurrent access proeprly otherwise pXd_same() would return
always true.

There should be no functional change.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 836f50814ffae..f771443cd78b6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3871,7 +3871,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
 
-		if (!walk_pte_range(&val, addr, next, args))
+		if (!walk_pte_range(pmd + i, addr, next, args))
 			continue;
 
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
@@ -3907,7 +3907,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
 			continue;
 
-		walk_pmd_range(&val, addr, next, args);
+		walk_pmd_range(pud + i, addr, next, args);
 
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;

-- 
2.43.0

