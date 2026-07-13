Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CB438007;
	Mon, 13 Jul 2026 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951117; cv=none; b=bsNqe6O9PLwB4ARqluwTxCoGZGzB/+8wJ+/1oKKEc0fDiebO9OzLrqKDvalo57KLE8LrqgPVjbhXgFyFgTlJ1EjcMIla1ebjp8V2ms62PeoxnkRFs8uetV5hvlg2LMdjgeRYOCKsFiILcIvUEY4Z3sRAIt/OCOvhMMSFLkU4O80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951117; c=relaxed/simple;
	bh=ijbMFumg8P8gGkdSIJoBYbLSyYeD/Vjhz9UbWDLoy8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8kq5PmrVIJikg1FWR84mlMVVbNxxTZSzLQewAjbHx63fh0ZgFCON1RShSI+nSGppccMn6c6CC0alSe1qbpY6mKRcswxK2kL3IN0pkQVbDE6Bj95sM3V538gRVfoB+JlkroPUojCFKHajaxoyPTmupAXseW2RzxN60O6G7xRer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CHlkydzV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CHlkydzV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 626221AC1;
	Mon, 13 Jul 2026 06:58:30 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 722843F7B4;
	Mon, 13 Jul 2026 06:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951114; bh=ijbMFumg8P8gGkdSIJoBYbLSyYeD/Vjhz9UbWDLoy8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHlkydzVCllPoGxzxcQSUErvYXIAGBQ595+NL7G7e1sqPROHhsxJ8MBiTiSYo8eIB
	 Mu0LCgbjUkOW4pofPbQVpr3Y0M6KWgdVpaR90WouabYCqysQ0cuW4q7ADzrIlktriy
	 gEX7NRAFqIzU5fkSuMPNTtCBJn75XvGeTJjmc76Q=
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
Subject: [RFC PATCH 10/34] x86: mm: carve out the generic compile-time folded pgtable case in effective_prot()
Date: Mon, 13 Jul 2026 14:55:49 +0100
Message-ID: <20260713135614.1618183-11-yeoreum.yun@arm.com>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

We want to change how pXdp_get() works with generic compile-time folded
page tables. To prepare for that, rework effective_prot() to ignore any
folded page tables entries, as it will unconditionally get called by
ptdump core with pXd_val(pXdp_get()), and we really should be ignoring
that value for folded entries.

For this, identify the first real page-table level and
update effective_prot only when the current entry is not folded.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2afa7a23340e9..e32848c7f26d4 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -27,6 +27,7 @@
  */
 struct pg_state {
 	struct ptdump_state ptdump;
+	struct mm_struct *mm;
 	int level;
 	pgprotval_t current_prot;
 	pgprotval_t effective_prot;
@@ -253,8 +254,22 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	pgprotval_t prot = val & PTE_FLAGS_MASK;
 	pgprotval_t effective;
+	bool first_level = false;
 
-	if (level > 0) {
+	/* Ignore folded levels ... */
+	if (((level == 0) && mm_p4d_folded(st->mm)) ||
+	    ((level == 1) && mm_pud_folded(st->mm)) ||
+	    ((level == 2) && mm_pmd_folded(st->mm)))
+		return;
+
+	/* ... and make the actual first level remember the protection. */
+	if (((level == 0)) ||
+	    ((level == 1) && mm_p4d_folded(st->mm)) ||
+	    ((level == 2) && mm_pud_folded(st->mm)) ||
+	    ((level == 3) && mm_pmd_folded(st->mm)))
+		first_level = true;
+
+	if (!first_level) {
 		pgprotval_t higher_prot = st->prot_levels[level - 1];
 
 		effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
@@ -449,6 +464,7 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
 			.effective_prot_pgd = effective_prot_pgd,
 			.range		= ptdump_ranges
 		},
+		.mm		= mm,
 		.level = -1,
 		.to_dmesg	= dmesg,
 		.check_wx	= checkwx,
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

