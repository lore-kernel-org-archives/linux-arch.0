Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605F48595C;
	Mon, 21 Sep 2026 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988259; cv=none; b=LJ86imoJYZoZR6HejVpIjM2rl7sdrbVBW9otcGkq8hFza5JnZUQYtr3wdOGleD/yUsaK0uMSY8QeajpmMpfrhyKhOHdrfxCTqUORA1mp6zBzKyoQNUNPTo7+E1kvlH8rHog+A96/yb0MqBj3DWdrKy4l7Pzx1jzWJKy9Glvzr98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988259; c=relaxed/simple;
	bh=tenWdx/UAPDDmgqvhn1jTW0rtV2ElcnA6e+1jtwaJs8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KL6ks1UjQhjh/Ukh/oaCZCuieJhAj7DsgLYFteUhxKUBsjtbvUI9anZuaLnfBzCid7fqCtSRDqVLZMQBVwOLU0Ch1usFQB0QTLUdm5nO7OC7hkK3Kv10bxS3ILSVGO7oUMyPOQYCk3qoLyUxo+Kr7xrpQlEV37s2HgfaG3KolqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r3qQ0wEn; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r3qQ0wEn"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 293551570;
	Mon, 21 Sep 2026 03:57:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DC153F86C;
	Mon, 21 Sep 2026 03:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988256; bh=tenWdx/UAPDDmgqvhn1jTW0rtV2ElcnA6e+1jtwaJs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r3qQ0wEnceoNCSAemMvOXk/eg6xJzFlkI2IyMBaatbiz4/x7s7q8hXTaO0Vl8MDQ4
	 rS0/4H24aYxcUvmqdedXNG5j5+laQn70ovdDLv2Urbd3WHUzthrh0Kec8w0w+ul6hy
	 3zGTSf1mygcnWXtKW69QPNHlW0tU/7g+HwsoV8R8=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:31 +0100
Subject: [PATCH 09/21] loongarch: kvm: remove stack copy address of pXd in
 pXd_offset()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-9-cd40cf68242e@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=tenWdx/UAPDDmgqvhn1jTW0rtV2ElcnA6e+1jtwaJs8=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1PJaEMk0o9SRiHZSjHIfm+GrA188fN+4hRU
 6wJUgjEtAaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENTwAKCRBt1cPRWsUx
 M8LxC/9j9lKenvxhbWb1SDdCXY3s7kZnCDH1casxpL2CIqsMn1jRkSXlvvWc0FK7/ooO4WCtNPY
 isddhbQdba3tQ14ARwFYleVeWNNmiT05JGvjASoPg50ySoGJaDe19OE4hZWOghnmxjkdc86g7jL
 gcCOPOwe9mQY4LNYG8oZF9///bcv3szPoREYgWxSzP1vxiY0prT9Dyfrv3zTgfStuBUY4ntnptW
 G6zFnDbNPzkifb/jVOuDI1ksUJyOcnJzCCWQh8wAul/S21IO6AC6udNQZCpR4UHngkTh0e7kUgq
 arNAcFyIjLTCw2utF3PQlxLJylHPboWGN6Qby0dJF/WPvfwiMZ5ZqM7rzEP8W0iKnUglDk7bkpP
 V87UdgAwIoTi1oSvrjliTDJV5yEBgdqYWHvSXN54WMH8yzs8AO3xWzAryfmg1jwsGVfcCNvBtRA
 5hUpniFYmqdNtZll1Rh6ljx/ikMnaZyFYSHYscH16HGIFR1qU5Wck0IPfXF0jYchNE1jQ=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that,  rework host_pfn_mapping_level() to avoid
use of a stack copy of a pXd and pass it as argument to pXd_offset() so that
the folded entries value is ignored.

Replace direct uses of stack-based pXd values with pXd_offset_lockless().
And there should be no functional change.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/loongarch/kvm/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index e104897aa5328..837b40bb694f4 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -669,10 +669,10 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	int level = 0;
 	unsigned long hva;
 	unsigned long flags;
-	pgd_t pgd;
-	p4d_t p4d;
-	pud_t pud;
-	pmd_t pmd;
+	pgd_t *pgdp, pgd;
+	p4d_t *p4dp, p4d;
+	pud_t *pudp, pud;
+	pmd_t *pmdp, pmd;
 
 	/*
 	 * Note, using the already-retrieved memslot and __gfn_to_hva_memslot()
@@ -698,19 +698,23 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
 	 * value) and then p*d_offset() walks into the target huge page instead
 	 * of the old page table (sees the new value).
 	 */
-	pgd = pgdp_get(pgd_offset(kvm->mm, hva));
+	pgdp = pgd_offset(kvm->mm, hva);
+	pgd = pgdp_get(pgdp);
 	if (pgd_none(pgd))
 		goto out;
 
-	p4d = p4dp_get(p4d_offset(&pgd, hva));
+	p4dp = p4d_offset_lockless(pgdp, pgd, hva);
+	p4d = p4dp_get(p4dp);
 	if (p4d_none(p4d) || !p4d_present(p4d))
 		goto out;
 
-	pud = pudp_get(pud_offset(&p4d, hva));
+	pudp = pud_offset_lockless(p4dp, p4d, hva);
+	pud = pudp_get(pudp);
 	if (pud_none(pud) || !pud_present(pud))
 		goto out;
 
-	pmd = pmdp_get(pmd_offset(&pud, hva));
+	pmdp = pmd_offset_lockless(pudp, pud, hva);
+	pmd = pmdp_get(pmdp);
 	if (pmd_none(pmd) || !pmd_present(pmd))
 		goto out;
 

-- 
2.43.0

