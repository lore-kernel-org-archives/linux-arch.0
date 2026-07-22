Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B6735DD1C;
	Wed, 22 Jul 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734307; cv=none; b=W9dihA8DVAops1AwDXqph7zWE/qB+d0lniNAoUNS/qCACfRHdTu/ccAvEpqwxju2h/BtYlTKaeKSCNZeO9fBbHU217h9AgWLREhGDgkz13g5yzhgtHrWoIjcVDDSkhJMiB3Il+3WuEp73DpUIPFHcAyVkHKmelO2I8FKBziCm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734307; c=relaxed/simple;
	bh=hEzwBV+PsJMZFHQUBE/OtSpPBhTaKSML/8YZA8FQaPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lvku3DvymarZKEhBDOJa+2nDNaTFOlR41tuZfblbSb77lrmEx/A9ZfBBRfzMkcrQxfEsgnQzSAJJGSpaFwL2ixEBi2uxx5z5M/j+gJVN2dbN3CgaYsgO5Y3MmCdZceMlug98CoVcnrqSFfPNVV8inOt0unPNkzL1I0lF3xrvnT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CGzjPkOm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CGzjPkOm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 854831595;
	Wed, 22 Jul 2026 08:31:40 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C595E3F66F;
	Wed, 22 Jul 2026 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734304; bh=hEzwBV+PsJMZFHQUBE/OtSpPBhTaKSML/8YZA8FQaPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CGzjPkOmqAddjbsG8ADR28xqNpwQCbCIVZQ28QPxQ470spehbu7sZXGkzEiyKQCoD
	 9tqpzRwhimPeUsyXWspyAEsWw7rw7IWTxF6vIlo+4hPzHZAP1YgBSnkFAgfGE034hI
	 0u2bUvl46g8HFbNHc47KLB4l2WViWfKtN28DE45Y=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:17 +0100
Subject: [PATCH RFC v2 09/20] loongarch: kvm: remove stack copy address of
 pXd in pXd_offset()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-9-d9e4bad31e0a@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=hEzwBV+PsJMZFHQUBE/OtSpPBhTaKSML/8YZA8FQaPc=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOITNOofyACG8/QiCZei8Ic1hoiiCQXEac7qC
 yPXQ1a1hn+JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiEwAKCRBt1cPRWsUx
 M0cgDADIz8U7Oh583pQ27I014VPnh9IxMAk2ecbKuCG9fQ0cfoJXO7FKXClIOvwmJMb+1doNs7y
 pnLXHfrzcROqjlTIY4MzxF97/uzFMjwMVPLeUTg3f9AgeYTtMCTkukqo2k1FOOjd2GMbivyvbmt
 byvNk66OHNYCC7ny4sUIqRzocrl4arOXlfLn9qTAaE7O/D3E+y2c+HgeDcikVt6fmwNuSLQlnsO
 duGz8XaSPaZAiytq7Knyo+dn/smQ5WZ1rt/0C7kENuI/dP88VtKsJUFqVFndL6Eq7ftgSbN/qAS
 pUgbXo6AEn00FnJ1//leWcvPuf3h+Giag5012lyG/teyPR9hv4ksXdc476DwrNshgkhHWkz6wx+
 Jhh+VYegE8+aQQSZqdgh9xIb+Geg5itZ0BaOoPAOlK5iNx5ZW6dfJhud63h1RIhIrdbAqEL3eSk
 n9h+7AYiZRJHvZzaxeJopt3mxwL/gzUQy8f3AzWEO5OSl9XPu4VNsTuHVFzCatpC3pFkY=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that,  rework host_pfn_mapping_level() to avoid
use of a stack copy of a pXd and pass it as argument to pXd_offset() so that
the folded entries value is ignored.

Replace direct uses of stack-based pXd values with pXd_offset_lockless().
And there should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/loongarch/kvm/mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
index e104897aa532..837b40bb694f 100644
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

