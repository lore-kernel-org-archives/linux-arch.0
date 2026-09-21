Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675A486E69;
	Mon, 21 Sep 2026 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988266; cv=none; b=unT1wzjdcbJ+tOZxRbpbMM5qg+Pa8d8XcUFqQaO5AnlLhm232PDhxzb57nUkv3aloiOPrbGnK0KvrdqJUm2ZqqEts4+aumOi0wgQStIv2ge4CQ9+xUEF0pG2W/CdFaIdgACX2G+0B9WmbumZd0ZYd38FHxAhHFUtgR7B72Lmx44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988266; c=relaxed/simple;
	bh=KiXQHGuhfMlh69+vDPC8O/k2WRfNJbgSm7Gu8QYG2aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JLc3Lv4vABtAuksXz/i4l+KE7oEJO8mGp5jVPMrHYB/dV0nLdd+0+fsJQFzxIfK5RrkZdUE2JH3yYIxk9grmEppJ9wW5SI9Z+89kbA851excbJj8884BbincOZpDE1nqNMFd5/gs86h7oRaqoz05vlXHAFR9XTcii+jnHgQFPso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=acOOrhxG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="acOOrhxG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBDEA1D13;
	Mon, 21 Sep 2026 03:57:40 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 091B03F86C;
	Mon, 21 Sep 2026 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988264; bh=KiXQHGuhfMlh69+vDPC8O/k2WRfNJbgSm7Gu8QYG2aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=acOOrhxGt24gm0TRAbQDXTQ9bBBp3Bj56XEBgnVOotqP+qiG7YJVhkcGW+xrwcb2a
	 USmOAWcGi1YbzXXz+GFEN3it02D0/yYErePOTiGnto1f4lTnlkzD119S+FRZwhYPnm
	 tRzn3ffsctlJfSwSOqlNejAXL1s2WdK0ogZ6I3bk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:32 +0100
Subject: [PATCH 10/21] riscv: kvm: remove stack copy address of pXd in
 pXd_offset()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-10-cd40cf68242e@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=KiXQHGuhfMlh69+vDPC8O/k2WRfNJbgSm7Gu8QYG2aY=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1P/lW6m6B1mTpRP6bpmebttNlScQQ9pFLGp
 +TLi5+fe6mJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENTwAKCRBt1cPRWsUx
 MzRxDACbWH4JATwoeni8FvpOIlAtj13UB3cW+c35hpt9oGzmcDZ+kjukMqctT6h2L2N5pHpsDgV
 vmayApcPPlarU6k8ZQpvBb7KJ1cYGUNPU474TxmX2vBVITXF3mbHMgRoEbIqhbltrGT8uBoVyCo
 KgDVi+KDgkbOrzeKUfL6m7D9VLVgLaNDamzt7DvVVqiCTUJRUSmv5DxuOqilRyUUWgRg66cEh0f
 fNgaSTYxDBBBOqd6xi9vA+7R/D8gaYslxHah31gen9zR/KRiSCVO8oSWE7qao685EtRbhlF8C/w
 3me3Bkz4+kVb6rnCMuV0mt4yG2kuNCmzvgORQC8TBdutWp1pmcamhxcvxqCjL3WpVuFoo+iztFK
 qrF8TVoPbY7wwUVBdeD8kZ/Lg3FUZf4niWpEI3+/yEQZqeiImeTuLoEd2uelVxIt79PiLiF5ED/
 4IEDN1fi5/NH35mcjNFuUFg9VZ1c9qX2muen0gS+XMIvV6EzYFJk5Fv4kXIUQGEyvngIk=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, rework get_hva_mapping_size() to avoid
use of a stack copy of a pXd and pass it as argument to pXd_offset() so that
the folded entries value is ignored.

Replace direct uses of stack-based pXd values with pXd_offset_lockless()
and there should be no functional change.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/riscv/kvm/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 5c5c77f98bf0f..b97224e14fc16 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -450,10 +450,10 @@ static int get_hva_mapping_size(struct kvm *kvm,
 {
 	int size = PAGE_SIZE;
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
 	 * Disable IRQs to prevent concurrent tear down of host page tables,
@@ -469,15 +469,18 @@ static int get_hva_mapping_size(struct kvm *kvm,
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
 
@@ -486,7 +489,8 @@ static int get_hva_mapping_size(struct kvm *kvm,
 		goto out;
 	}
 
-	pmd = pmdp_get(pmd_offset(&pud, hva));
+	pmdp = pmd_offset_lockless(pudp, pud, hva);
+	pmd = pmdp_get(pmdp);
 	if (pmd_none(pmd) || !pmd_present(pmd))
 		goto out;
 

-- 
2.43.0

