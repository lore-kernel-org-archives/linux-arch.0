Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618554;
	b=O8QOedE0iMA1SsJRvAhSItn3PA2TlsWFzOtzHemRAl6CyIHgVTnkXupMGkh/Kkzn1lT7
	 gdvZKk4K3NFZebrbv1f9jLR2wwUSw2o38kzxqqKsUY85LDjydyXC6pQkYlxycMBzcB7mn
	 5aeHMJgYnhhfXXcSTlvRGKGMFiQ/ZSD2JZqLvdCfiZckLxGgt8+4DHbBaglasWL0eRAK5
	 UnuRFIXIKJj/Ly7tdcRAY9xMPpIe71FVwODi6/gik4ijOgRdkbGqTJZloGV47Ld3CKaPY
	 DBE467B/V2CVPcohTbSBEzbDAhILQGfKXQLOOtKMgpgKMwDVS14xIRng3KWgHg8iq8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618554;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=HLNvHrR0Fpj6ftr47GYXDwUrEMv6CUTbezLhLSAnnFs=;
	b=r0sDtbAdzjh2aBSY524l9XBWzrgXSVKQTqDzHDLkNVr8vzOXbqHmPtWhrx9BRfo+NnFt
	 hCfnXWGXi49i5+IUOh49YUqrWSetOT0r56zf0LcBW6pdzvtKTIL4n/KXRAqyL4s6aZNF/
	 PVDjWHJsnb7i5FFoICxr48xJ3+XDhvVWC4q9vqlKCKlS0SNeN93rMzgDVbzFp0nxNmEW7
	 lPeduFxXiTgfXXXr/Am6ha8x71V8GZggPGnkalGwXMi2K8rTXU8uRf+9NIolSuCCrsjtf
	 fpiUT0mGuXGCnJjpIYiHjkc3TwidoY3cOkpKt/OtVRNcuDdqa+YDMl54q+Xx54TKFwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NGzAi2YU;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4CF60A380D;
	Mon,  2 Nov 2026 11:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B4CF60A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NGzAi2YU
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 092802A68;
	Mon,  2 Nov 2026 03:22:30 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00DBA3F632;
	Mon,  2 Nov 2026 03:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618553; bh=QYmfwdLe215hLGuFdCj5safJ8gxdq3zlW1ht1LiurFo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGzAi2YUuhqkVXhnAdJL2xqwg1sWWuNnmUOJc6WYMvcZsOaHYodWzzAQDylogAHGF
	 sAlnvTGEoaWaY/k2K8WvP84MmxrLyH3UL6M62DxDMZKwAFnAf1wnmUlSt9sVt9I0mu
	 Q2N9zAaDmNiAxl2O123nlIpmLVp78QCa6wl12pEo=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:22 +0000
Subject: [PATCH RESEND v2 09/21] loongarch: kvm: remove stack copy address
 of pXd in pXd_offset()
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
Message-Id: <20261102-dummy_ptxp3-v2-9-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2052; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=QYmfwdLe215hLGuFdCj5safJ8gxdq3zlW1ht1LiurFo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIzqxNaFzhvjoxpWT/tFvwVycvQLXxje++RP
 KuCMEyxm3SJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyMwAKCRBt1cPRWsUx
 MwUIDACW8rDfN4PXoaycRrecOSJ5P2sV/Skn8cOJ9F/ArQxVMCOkJHu/jozzrN/5ZWRoyfVV6qI
 hDxzX47bfW4GqsHO5E1uaj6xJ9OnTVdhFE4l/Z+UE2LIN2XI1Bin4FtP4AUH6tjSrIcQmyrNuOY
 XpIxrn+T3hDCqyoo51zdCIbgMvWpEbTre5IJV1a6Mqp1c9cAMKvBQOnCovyb5XsRcbIXCK8GBUL
 2aP3pPNFUvXRH3QTlxhUPhWul1wCFo4bQXDbwm3jT1xU3N3aXNrX3vH+jBPPeM7le+WT+nLhcpw
 JPwBBCr35AoUF9s0nSKAF8CEAIqpWUI4RFhNipztYZBEkGzzdx93KCdMunXOhPaOscVKbSwRRW1
 mKOv00ylFBZKNhssbxn6+dLKmk1it/0MZ4POP9C9XuNAa2KUbJdt9fNpzJ29FeV5L8d5guM5A+f
 InDzrZ916vWbbdE91pO/GFYPPVhW3wBYZ+/6ONFGYaYRLD9E0AY3bJ6iH3q3dxINcdz1c=
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
index 64fddd9f0ada1..ab0a06b73e8d3 100644
--- a/arch/loongarch/kvm/mmu.c
+++ b/arch/loongarch/kvm/mmu.c
@@ -679,10 +679,10 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
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
@@ -708,19 +708,23 @@ static int host_pfn_mapping_level(struct kvm *kvm, gfn_t gfn,
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

