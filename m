Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30278246762;
	Mon, 13 Jul 2026 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951229; cv=none; b=cO51tqk2x/G9/rcp3oUrRoAxqGvFOjHNbpcOa6D9Rg8ben2SmKnX7P7tVB0YeiMmhbt1Sdn7lE9dLYbIIbbWJbAm5GvSkwLaCs3Z0xqrmfrYVPVUtZYaLp6SnwR9mpd5skoRZk0HKp1mWqIMYeOov+FYK8QpnZpmzkxXskLMM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951229; c=relaxed/simple;
	bh=LTSOz6r8IXywEsuWgl9722tiR9WcqjiHFXGXDRX3spM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xcb1GhkqlIwbJQZ3JH7vvlxi/wxDhNlE2F/fsidahuRls7d7Ox4AzxnbsbIm4R0UjNQL3CenSQUKksMYHtwT90J3bpmv4oTjG4aONmfByO/5nwfnGp0x8pf9jQiC00Ho6nIZOzZXKC2IhhERanUmkjnLNdNPrcip7m5byJSfLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pGt+wVwX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pGt+wVwX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F1DC2103;
	Mon, 13 Jul 2026 07:00:23 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 651783F7B4;
	Mon, 13 Jul 2026 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951227; bh=LTSOz6r8IXywEsuWgl9722tiR9WcqjiHFXGXDRX3spM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pGt+wVwXPP9bqbNiSoGoTQf7vUj9+h+rjcGEu7v6x9h5jUGGL61je/MuOfCB0IGbL
	 MCwtdgvHi9xbeiGHPrEgzoOWMgwuAwIORymTP+QSMvNXbWLSJ5lnVb/8rcQcLGe2HS
	 V32gOsFvzZEGe9nESYJjvb3kHILH3HN1uCBfzjGg=
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
Subject: [RFC PATCH 19/34] x86: power: use proper set_pXd() for generic compile-time folded patable in resume_one_md_table_init()
Date: Mon, 13 Jul 2026 14:55:58 +0100
Message-ID: <20260713135614.1618183-20-yeoreum.yun@arm.com>
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

Therefore, replace set_pgd() with set_pud() to setup first-level pgtable
in case of X86_PAE.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/power/hibernate_32.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
index 223d5bca29b86..ab5a203b45cb3 100644
--- a/arch/x86/power/hibernate_32.c
+++ b/arch/x86/power/hibernate_32.c
@@ -29,8 +29,7 @@ pgd_t *resume_pg_dir;
  */
 static pmd_t *resume_one_md_table_init(pgd_t *pgd)
 {
-	p4d_t *p4d;
-	pud_t *pud;
+	pud_t *pud = pud_offset(p4d_offset(pgd, 0), 0);
 	pmd_t *pmd_table;
 
 #ifdef CONFIG_X86_PAE
@@ -38,14 +37,10 @@ static pmd_t *resume_one_md_table_init(pgd_t *pgd)
 	if (!pmd_table)
 		return NULL;
 
-	set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
-	p4d = p4d_offset(pgd, 0);
-	pud = pud_offset(p4d, 0);
+	set_pud(pud, __pud(__pa(pmd_table) | _PAGE_PRESENT));
 
 	BUG_ON(pmd_table != pmd_offset(pud, 0));
 #else
-	p4d = p4d_offset(pgd, 0);
-	pud = pud_offset(p4d, 0);
 	pmd_table = pmd_offset(pud, 0);
 #endif
 
@@ -134,11 +129,12 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
 {
 #ifdef CONFIG_X86_PAE
 	int i;
+	pud_t *pud = pud_offset(p4d_offset(pg_dir, 0), 0);
 
 	/* Init entries of the first-level page table to the zero page */
 	for (i = 0; i < PTRS_PER_PGD; i++)
-		set_pgd(pg_dir + i,
-			__pgd(__pa(empty_zero_page) | _PAGE_PRESENT));
+		set_pud(pud + i,
+			__pud(__pa(empty_zero_page) | _PAGE_PRESENT));
 #endif
 }
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

