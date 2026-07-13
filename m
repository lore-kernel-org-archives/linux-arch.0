Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3FF3CFF44;
	Mon, 13 Jul 2026 14:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951329; cv=none; b=ENs9vYUvtNgXFzEEZ0wgYPf/xl4GoadKITyUO5Bh0lCr4F8XA0SBTPWZv7Ffq+U9q8VqzetCeCMfllL6Lay9FYDhjClXppcco4DG1vi303rhYT3zJUlwvhO4K4rliPkpgODKpo8xGCLgqtBf1ZFf9JQCE6ZBAjPiv6MTemAN/FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951329; c=relaxed/simple;
	bh=ROB8+gk0/dcoXkR4gcvO5thlCnhrFywn7RQWaf7FRNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fIQ0DFaSLIE7vsGqPHmrEvjfV9kMppz631QvCUnjRik7Rw0qzs1gAO5aqdREd6KU7Bzya2Sq+Wje1ZWLn2Jg4Kq9xmme3tfffMRfYsBq+VnHDbjU+zv4/E++BRcNZsbINh75ZY7lmYwEREv83T3q09Tzdy7szPwgsicEd1GmDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ASMMRSEE; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ASMMRSEE"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B917F2050;
	Mon, 13 Jul 2026 07:02:03 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA4093F7B4;
	Mon, 13 Jul 2026 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951328; bh=ROB8+gk0/dcoXkR4gcvO5thlCnhrFywn7RQWaf7FRNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ASMMRSEElZbqH3kcSv3cgBHwRCD0y7h1wgH3UWFgn/baB5FeIwo7Xk+LbUkFullBo
	 ek3GdG2jwdbkGcS6tjY0I29itz5ZOSbh5hHu9lh1E6V9LwiKw1W6kVKW+GJRoc6YC2
	 dPS2W1hLic9wNvgpjDdvMv047vveZPnluRUq3ZWI=
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
Subject: [RFC PATCH 27/34] m68k: mm: remove usage of pgd_page_vaddr() for CONFIG_PGTABLE_LEVELS=3
Date: Mon, 13 Jul 2026 14:56:06 +0100
Message-ID: <20260713135614.1618183-28-yeoreum.yun@arm.com>
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

We want to rework how pgd_page_vaddr() behaves for generic compile-time
folded page tables by disallowing its use and triggering a compile-time
error when it is used improperly, ensuring that the actual first-level
pXd_pgtable() function is used instead.

For this, change usage of pgd_page_vaddr() to pud_pgtable() for
the functions used when PGTABLE_LEVELS=3.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/m68k/mm/init.c     | 2 +-
 arch/m68k/mm/motorola.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 3b88c0dd1616d..d8351c210f58d 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -95,7 +95,7 @@ static inline void init_pointer_tables(void)
 		if (!pud_present(*pud))
 			continue;
 
-		pmd_dir = (pmd_t *)pgd_page_vaddr(kernel_pg_dir[i]);
+		pmd_dir = pud_pgtable(*pud);
 		init_pointer_table(pmd_dir, TABLE_PMD);
 
 		for (j = 0; j < PTRS_PER_PMD; j++) {
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index b30aa69a73a6a..03235d0618ef0 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -273,7 +273,7 @@ static pmd_t * __init kernel_ptr_table(void)
 
 			if (!pud_present(*pud))
 				continue;
-			pmd = pgd_page_vaddr(kernel_pg_dir[i]);
+			pmd = (unsigned long)pud_pgtable(*pud);
 			if (pmd > last)
 				last = pmd;
 		}
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

