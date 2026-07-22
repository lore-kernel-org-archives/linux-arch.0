Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B615376A0A;
	Wed, 22 Jul 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734343; cv=none; b=htkc7mVB/jSsnbmsLg6rMxOOUXTav8JSLHoxvYKZI1tW6TGaACQGc+zQjBbu4AuaPS6/ln/loocLae8aySpFrmCVSk7g3MjkwsURWEi8U2UNTSNyAuSwXqDjOsaANqmi8rzcSITPa8r0aGXrTjKJyaTXON4iJH+i0asq80P5ARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734343; c=relaxed/simple;
	bh=wsOvhQKZEG00wg1jKdkAFaJFjNazItDwe0xYFjnlbxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYikANhWMV2CQkDmb1aMy+cGOPdmZpW4mmOcs5cW70PbThfBLI7SmnkczgJkf9UWlduBa8KPE/XuR1Jmh4GsiTGl6z6qL5GJjPN/0ArBviRjzYBFkeh2+eiTzZsCL3qBOKqiRobHsco9G2QQa6xlLZ/YaYJCRDv2M5TWOHke32w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pVLe2oqL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pVLe2oqL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA06A1691;
	Wed, 22 Jul 2026 08:32:16 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E103D3F66F;
	Wed, 22 Jul 2026 08:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734340; bh=wsOvhQKZEG00wg1jKdkAFaJFjNazItDwe0xYFjnlbxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pVLe2oqLj/GMbp2ufH9X7mDJQq2xQl+JLsb4rdHdEG8P4q6+zwtBTz6kqejK9a4vE
	 42w+M5uZ5nMb5hwWCHtS4s7q+ErSCs2KQQJDkfsn5+wpqdIMcK1OZYCZCB3cZAW4nq
	 AggYvPNSBbaQWNfM1T4fRg3yIp8YqGdn0GMHuuGY=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:22 +0100
Subject: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using generic
 compile-time folded pagetable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=wsOvhQKZEG00wg1jKdkAFaJFjNazItDwe0xYFjnlbxQ=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIWIdSyNNx0bAaN04aBwgqBSXTMZTpRKvbWw
 OqEgUkq1DqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiFgAKCRBt1cPRWsUx
 M81eC/94aLur5BJub0U5CeumeSspcUbgF2bv6HfdAEYOdi5ZwYiF40PGZxxjAsv/yQlK5UzHDss
 aPkHeJPk8MkK0qc7gd9qgXRevhd2r3SbCV54lAhtxc3a8MyMlApf+nVtp6WMlSqBdjVBghBQYVu
 m4undaF9OwHTn2K6K/oaocwtD+K/DrwVWCi+WofWjdNbz59AZtNKXjUsQqR0sgDROPY7hcFFkTu
 7JAqrngJ/Rkxa+ZTG1nr+VR0zoMGs9k12vLpTWZlxxB6mcDEbvHDicaHyuykmke3jENeOsJTl+3
 HDxSBdyN3Dalc3OL8zAIHav1Idp6Xmu9CL9mfOQg2LeRY3RaajCzKL5rATAEhSKLyGuhW5cJDZR
 69AEYlBnca2Wzl++N47dEOUGO/uXt3c71udqBZTA+I2so2zK3Gu6esbNhxoBe0uOYGsizKiyDEp
 LYPnBnpmu5SBzQ7DL3uDq15sZsUy9WU/F2HnuSrSJnVeaf08gu/ZXr0DZAzMMkUt7bZIA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

We want to rework how set_pXd() behaves for generic compile-time folded
page tables by disallowing its use and triggering a compile-time error
when it is used improperly, ensuring that the actual first-level set_pXd()
function is used instead.

The behaviour of pXd_page() will change with generic compile-time folded
page tables by disallowing its use and triggering a compile-time error
when it's used improperly, ensuring that the actual.

To prepare fot that, skip collapse_pud_page() and populate_pud() according
to CONFIG_PGTABLE_LEVELS.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/pat/set_memory.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 078689aa7206..91b33a265a43 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1346,7 +1346,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
 	pmd_t *pmd, first;
 	int i;
 
-	if (!direct_gbpages)
+	if (CONFIG_PGTABLE_LEVELS == 2 || !direct_gbpages)
 		return 0;
 
 	addr &= PUD_MASK;
@@ -1730,7 +1730,8 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 	/*
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
-	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
+	while (CONFIG_PGTABLE_LEVELS > 3 && boot_cpu_has(X86_FEATURE_GBPAGES) &&
+	       end - start >= PUD_SIZE) {
 		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
 				   canon_pgprot(pud_pgprot))));
 

-- 
2.43.0

