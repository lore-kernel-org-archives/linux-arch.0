Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D37437475;
	Mon, 13 Jul 2026 13:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951191; cv=none; b=u9b6xpLqum2pQ3xtHcvvDFX8jzYXTpcQYjbfaNdzhrbkP+hz7nKJIY+w6L1igKkKxuYoBMh6ylcAHtPQe18QHubTX/uL2v7gHgsAjblli5nqqgX380FefNXVgQdl65CgN5CifW/NYgDpcEsdgxCN49Dgdy9LvbtmJxNsOl0nteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951191; c=relaxed/simple;
	bh=YqnJQyc9CrzYpyp6gWjknvIiJBuEo4b4nmLN5r/zhR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bimFQ/vWQpggPR1z5CtKfF29DZX19ShZFtPuKtjcg/sc5xMczwoT5JxF3eYmwa4ywFZWesqUBp1+Z06dgh/x+NT98oq+ignuReAjFIvo2p52yc5k1bgCbCPE+gKatMHyZdWesfH8zXaWHR6uqESzgmV8s+6zT7BIqNPQLbAEZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZPr6uIZS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZPr6uIZS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB7A01DB5;
	Mon, 13 Jul 2026 06:59:45 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B08443F7B4;
	Mon, 13 Jul 2026 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951189; bh=YqnJQyc9CrzYpyp6gWjknvIiJBuEo4b4nmLN5r/zhR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPr6uIZSUfuQyR/dBUHjcIk7LcANOKrIDpUnnXvitbMXbT2PO3nSzM8sPM+AmgFSh
	 oEYY6m6leU6Z90DVlRyAPnZWbTAQdvt43qG1RNc/JG10d4j0cTl4zhpHBmeYz/DeiC
	 gY5pxSreFEjqd85ky2RlKPv4w2j6RM2bSTCQi2Ho=
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
Subject: [RFC PATCH 16/34] nios2: mm: use proper set_pXd() for generic compile-time folded patable in vmalloc_fault path
Date: Mon, 13 Jul 2026 14:55:55 +0100
Message-ID: <20260713135614.1618183-17-yeoreum.yun@arm.com>
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

We want to rework how set_pXd() behaves for generic compile-time folded
page tables by disallowing its use and triggering a compile-time error
when it is used improperly, ensuring that the actual first-level set_pXd()
function is used instead.

Since nios2's PGTABLE_LEVELS is 2 always, usage set_pmd() instead of
set_pgd() to handle vmalloc_fault case.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/nios2/mm/fault.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/nios2/mm/fault.c b/arch/nios2/mm/fault.c
index e3fa9c15181df..f67d599115e9e 100644
--- a/arch/nios2/mm/fault.c
+++ b/arch/nios2/mm/fault.c
@@ -227,35 +227,23 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long cause,
 		 * an interrupt in the middle of a task switch..
 		 */
 		int offset = pgd_index(address);
-		pgd_t *pgd, *pgd_k;
-		p4d_t *p4d, *p4d_k;
-		pud_t *pud, *pud_k;
-		pmd_t *pmd, *pmd_k;
-		pte_t *pte_k;
 
-		pgd = pgd_current + offset;
-		pgd_k = init_mm.pgd + offset;
+		BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS != 2);
 
-		if (!pgd_present(*pgd_k))
-			goto no_context;
-		set_pgd(pgd, *pgd_k);
+		pmd_t *pmdp, *pmdp_k, pmd_k;
+		pte_t *ptep_k;
 
-		p4d = p4d_offset(pgd, address);
-		p4d_k = p4d_offset(pgd_k, address);
-		if (!p4d_present(*p4d_k))
-			goto no_context;
-		pud = pud_offset(p4d, address);
-		pud_k = pud_offset(p4d_k, address);
-		if (!pud_present(*pud_k))
-			goto no_context;
-		pmd = pmd_offset(pud, address);
-		pmd_k = pmd_offset(pud_k, address);
-		if (!pmd_present(*pmd_k))
+		pmdp = (pmd_t *)(pgd_current + offset);
+		pmdp_k = (pmd_t *)(init_mm.pgd + offset);
+		pmd_k = *pmdp_k;
+
+		if (!pmd_present(pmd_k))
 			goto no_context;
-		set_pmd(pmd, *pmd_k);
 
-		pte_k = pte_offset_kernel(pmd_k, address);
-		if (!pte_present(*pte_k))
+		set_pmd(pmdp, pmd_k);
+
+		ptep_k = pte_offset_kernel(pmdp_k, address);
+		if (!pte_present(*ptep_k))
 			goto no_context;
 
 		flush_tlb_kernel_page(address);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

