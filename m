Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDA243CEF8;
	Mon, 13 Jul 2026 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951267; cv=none; b=CncKnZL12gAPEa4ZW0MATvP+p2CC6ayMtJxHq/sOtQpG8IJ2tTP3MesLSNH+DP87YbAjT09ZuXLk3f8cPi20h9tNk6uAJjR+4NtGEStqfk053uIYdf79IFtOqDTsVqhnU7xfTyjIHqTKF6t7t88fdz48Ag//Tu08UfiJySnk7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951267; c=relaxed/simple;
	bh=3LP3kSBkF9WZ5FN+GThlw2ZrRbb/NM3CavuBMu2UCX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQPh0d0Jbmhl7GhfW+6TxmBymiwGQo1ye9xl7dnUqPLjsAxWtLfAhZlsd+Or4ez+Iuqd6VsU9bhrzRqChRSH2qwCcQSqCx2SQzp6BScXVY80HtMaAH9+WAFU4b9zxyXV9vmtcky8aHcBbZIFgLRD4MJhXwuE/O2U73ICJ9u8u2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jQFofxhr; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jQFofxhr"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01BDE1FC7;
	Mon, 13 Jul 2026 07:01:01 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0FC353FAF5;
	Mon, 13 Jul 2026 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951265; bh=3LP3kSBkF9WZ5FN+GThlw2ZrRbb/NM3CavuBMu2UCX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQFofxhrlY9xhPCZ1KjOb60Oo8vAAMeW3u9/kR3kEqBO6OD+WGUbi6FH+GoBuTLyI
	 oSdIVLUVAjxaEDlOi7+HOeEkX3qQLhK46xPY7D5gKofzHDHQHSoEVb/gRv4q0kvsfj
	 z/WGz+7bjb/oyahedBcZbasHVxrEPI9iv40gFe5k=
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
Subject: [RFC PATCH 22/34] x86: mm: use proper set_pXd() for generic compile-time folded patable in one_md_table_init()
Date: Mon, 13 Jul 2026 14:56:01 +0100
Message-ID: <20260713135614.1618183-23-yeoreum.yun@arm.com>
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
when it is used improperly, ensuring that the actual first-level
set_pXd() function is used instead.

Therefore, replace set_pgd() with set_pud() to setup first-level pgtable
in case of X86_PAE.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/init_32.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index 0908c44d51e6f..690afa27a631b 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -70,19 +70,17 @@ static pmd_t * __init one_md_table_init(pgd_t *pgd)
 	pud_t *pud;
 	pmd_t *pmd_table;
 
+	p4d = p4d_offset(pgd, 0);
+	pud = pud_offset(p4d, 0);
 #ifdef CONFIG_X86_PAE
-	if (!(pgd_val(*pgd) & _PAGE_PRESENT)) {
+	if (!(pud_val(*pud) & _PAGE_PRESENT)) {
 		pmd_table = (pmd_t *)alloc_low_page();
-		set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
-		p4d = p4d_offset(pgd, 0);
-		pud = pud_offset(p4d, 0);
+		set_pud(pud, __pud(__pa(pmd_table) | _PAGE_PRESENT));
 		BUG_ON(pmd_table != pmd_offset(pud, 0));
 
 		return pmd_table;
 	}
 #endif
-	p4d = p4d_offset(pgd, 0);
-	pud = pud_offset(p4d, 0);
 	pmd_table = pmd_offset(pud, 0);
 
 	return pmd_table;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

