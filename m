Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3ED143802E;
	Mon, 13 Jul 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951179; cv=none; b=JsBE6v4iJKd+PAjF4EghSXWKIXyIYkTuVuob3WxOCQBFqckNCaXPmYz5AbwBJvsWNQNcWte4Auj3aot+ABMGp3Z7qnkyjRBa7H/76653H03OLIfK+VIOqinG4RLyy5DKz6jOzaWg1y02r0kAgXTG/fyH9oa/p70c6gOqQtlg3PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951179; c=relaxed/simple;
	bh=gV2pTsCUztgOvGxrgAt605ARjz7dmzmHzQM9Otey+5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iH9HteEZJEZKSCxe8cfmMFdxxpUGIkCEQk3GPDmgM4w+3+WyP3x2Htr7qWadmfMVMrUc2lNheQ7fmb92Xu7APqOVdbych+4aFCN0XtyayWHK8RYclX1rnO+UUzLmm0mg3A51CzcitPJ+6JYREMr5xl6lwKSlA5nMntXhJGDLEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=hFiwKMoL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="hFiwKMoL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F7D41DB5;
	Mon, 13 Jul 2026 06:59:33 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DF8B3F7B4;
	Mon, 13 Jul 2026 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951177; bh=gV2pTsCUztgOvGxrgAt605ARjz7dmzmHzQM9Otey+5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFiwKMoLlCD3BN8OR1BVTk7TGKyMljN5sZjMGiN8FhmafTvDOgG4tq4iifBz0LBGe
	 TEPym80+aPKYKhJUwzOJNb9VKhhRTPH621Ljc/q0DnJmnSnhinhKUbtdb6iKpO4mVN
	 n11BCRxPznqUlnDr4I57hyRYBDnCMWFwyszMYrfQ=
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-csky@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org
Cc: david@kernel.org,
	linux@armlinux.org.uk,
	akpm@linux-foundation.org,
	ankur.a.arora@oracle.com,
	rppt@kernel.org,
	linmag7@gmail.com,
	chleroy@kernel.org,
	klarasmodin@gmail.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	kas@kernel.org,
	zhangtianyang@loongson.cn,
	wangyuli@aosc.io,
	tsbogend@alpha.franken.de,
	ljs@kernel.org,
	jgg@ziepe.ca,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	ryan.roberts@arm.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	baolin.wang@linux.alibaba.com,
	tj@kernel.org,
	kevin.brodsky@arm.com,
	anup@brainfault.org,
	atish.patra@linux.dev,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	andreyknvl@gmail.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	anshuman.khandual@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	ardb@kernel.org,
	guoren@kernel.org,
	yang.li85200@gmail.com,
	viro@zeniv.linux.org.uk,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	wangruikang@iscas.ac.cn,
	junhui.liu@pigmoral.tech,
	muchun.song@linux.dev,
	vishal.moola@gmail.com,
	namcao@linutronix.de,
	pavel@kernel.org,
	djbw@kernel.org,
	yu-cheng.yu@intel.com,
	baolu.lu@linux.intel.com,
	Jonathan.Cameron@huawei.com,
	coxu@redhat.com,
	andreas@gaisler.com,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	geert@linux-m68k.org,
	shorne@gmail.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [RFC PATCH 15/34] mips: mm: use proper set_pXd() for generic compile-time folded patable in vmalloc_fault path
Date: Mon, 13 Jul 2026 14:55:54 +0100
Message-ID: <20260713135614.1618183-16-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713135614.1618183-1-yeoreum.yun@arm.com>
References: <20260713135614.1618183-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to rework how set_pXd() behaves for generic comiple-time folded
page tables by disallowing its use and triggering a compile-time error
when it is used improperly, ensuring that the actual first-level
set_pXd() function is used instead.

Therefore, call the proper set_pXd() in case of generic compile-time
folded pgtable to handle vmalloc_fault case with pXd_present() and
drop pgd_present() and set_pgd() usage since mips doesn't support
5 page-table levels.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/mips/mm/fault.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 37fedeaca2e9a..4ad281a3bf97a 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -289,28 +289,31 @@ static void __do_page_fault(struct pt_regs *regs, unsigned long write,
 		pmd_t *pmd, *pmd_k;
 		pte_t *pte_k;
 
+		BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS > 4);
+
 		pgd = (pgd_t *) pgd_current[raw_smp_processor_id()] + offset;
 		pgd_k = init_mm.pgd + offset;
 
-		if (!pgd_present(*pgd_k))
-			goto no_context;
-		set_pgd(pgd, *pgd_k);
-
 		p4d = p4d_offset(pgd, address);
 		p4d_k = p4d_offset(pgd_k, address);
 		if (!p4d_present(*p4d_k))
 			goto no_context;
+		if (CONFIG_PGTABLE_LEVELS == 4)
+			set_p4d(p4d, *p4d_k);
 
 		pud = pud_offset(p4d, address);
 		pud_k = pud_offset(p4d_k, address);
 		if (!pud_present(*pud_k))
 			goto no_context;
+		if (CONFIG_PGTABLE_LEVELS == 3)
+			set_pud(pud, *pud_k);
 
 		pmd = pmd_offset(pud, address);
 		pmd_k = pmd_offset(pud_k, address);
 		if (!pmd_present(*pmd_k))
 			goto no_context;
-		set_pmd(pmd, *pmd_k);
+		if (CONFIG_PGTABLE_LEVELS == 2)
+			set_pmd(pmd, *pmd_k);
 
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

