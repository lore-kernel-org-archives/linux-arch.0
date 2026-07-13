Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55BC390991;
	Mon, 13 Jul 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951343; cv=none; b=nsRr1AGwdVYun2R9vWS915EUES1kbD5Z+kHLDmYvW5KpxH+k01WvkPdLMxREmUEkApj7X3xNobiIeuY/cB3Jkh8wViEXdWgjWdH0DYYrC9omOtnikIJSXGLAhRfIIKYZJfHsmdMoPZ1x32fcPdNaxUIbITJsPk1OOq6q6eNS2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951343; c=relaxed/simple;
	bh=R7X1v/dPRywnjhTJaufMLIEBeJXmfSh2dxcNZPFXmUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaJvrq1KkDrVQWlUdW4eC4vrJs22zh+cUdi+QDUR81R/orBjFqDQ8aARAyESvjceqhkcjYl2ky7GpLSTZuHTwY6DSOWdMujQP6+Es0SuAXZj9buz5OR46B0H3fVTL1kTrmkZwU5Lm3wtXf4QcmUAKI+j4xhZqjasZpN1Sre5dKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WxYMXM3s; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WxYMXM3s"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A08822EE;
	Mon, 13 Jul 2026 07:02:16 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5A7E43F7B4;
	Mon, 13 Jul 2026 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951340; bh=R7X1v/dPRywnjhTJaufMLIEBeJXmfSh2dxcNZPFXmUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WxYMXM3stJVkarl0onHVvx2q0utHhv+ca4Xh1PjXiaHoLZOx2b9/eB8Jxp+JxfTCS
	 JW32l7L8LDJYDVsnGOGM14LrM3Sxq9zRru5MUhFjB6zJ107aeayV33c/AAZj7Y2O0H
	 jsgGeM/V6uNISg+QDgu59hDEB7yZ1lEDilX+MIPI=
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
Subject: [RFC PATCH 28/34] arm: mm: use proper pgtable APIs for generic compile-time folded patable in kasan_init()
Date: Mon, 13 Jul 2026 14:56:07 +0100
Message-ID: <20260713135614.1618183-29-yeoreum.yun@arm.com>
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

We want to rework how set_pXd() and pgd_page_vaddr() behaves for
generic compile-time folded page tables by disallowing its use and
triggering a compile-time error when they're used improperly,
ensuring that the actual first-level pgtable APIs are used instead.

For this, Replace set_pgd() with set_pud() and pgd_page_vaddr() with pud_pgtable()
to setup kasan early patable since it used with LPAE and PGTABLE_LEVEL as 3

Since the first page-level is 3 to get a first page-level properly
introduce new helper pud_off_k() and replace direct dereference of
first page-table entry with pudp_get().

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm/mm/kasan_init.c | 8 +++++---
 include/linux/pgtable.h  | 5 +++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index c6625e808bf85..31fa1b11816c7 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -211,6 +211,7 @@ void __init kasan_init(void)
 {
 	phys_addr_t pa_start, pa_end;
 	u64 i;
+	pud_t *pudp __maybe_unused;
 
 	/*
 	 * We are going to perform proper setup of shadow memory.
@@ -230,11 +231,12 @@ void __init kasan_init(void)
 	/* We need to be in the same PGD or this won't work */
 	BUILD_BUG_ON(pgd_index(KASAN_SHADOW_START) !=
 		     pgd_index(KASAN_SHADOW_END));
+	pudp = pud_off_k(KASAN_SHADOW_START);
 	memcpy(tmp_pmd_table,
-	       (void*)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_START)),
+	       (void*)pud_pgtable(pudp_get(pudp)),
 	       sizeof(tmp_pmd_table));
-	set_pgd(&tmp_pgd_table[pgd_index(KASAN_SHADOW_START)],
-		__pgd(__pa(tmp_pmd_table) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
+	set_pud(&tmp_pgd_table[pgd_index(KASAN_SHADOW_START)],
+		__pmd(__pa(tmp_pmd_table) | PMD_TYPE_TABLE | L_PGD_SWAPPER));
 #endif
 	cpu_switch_mm(tmp_pgd_table, &init_mm);
 	local_flush_tlb_all();
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a8..4962d9764b487 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -155,6 +155,11 @@ static inline pgd_t *pgd_offset_pgd(pgd_t *pgd, unsigned long address)
  */
 #define pgd_offset_k(address)		pgd_offset(&init_mm, (address))
 
+static inline pud_t *pud_off_k(unsigned long va)
+{
+	return pud_offset(p4d_offset(pgd_offset_k(va), va), va);
+}
+
 /*
  * In many cases it is known that a virtual address is mapped at PMD or PTE
  * level, so instead of traversing all the page table levels, we can get a
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

