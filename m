Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE413D8B1;
	Mon, 13 Jul 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951367; cv=none; b=J9RBB/+TTaVcs7/QB/FMWcMBpdBZ2Lc/LbmED4hWZ1rQk4/miGDPALBdNDcqK+EXE90sYyav2Wyiy0bd1bB5Tv+8VfxHDMiinYiK6lshrmL+TZ2GFelPR+U2FHiHG/SsPpjIcGRVaD6OLwjLQ3uoYM0rYnzEm3x6egdFWdao9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951367; c=relaxed/simple;
	bh=bIKoPb0bNMxSfp09kSEpc6GfFg6xieua9pE2L9NCvH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DP1rrEqsGfqkRLDNKujYR/PsxR+mAIeaplLgMMWw9lAV+h0sDxj5xfy8gorudkijhVrqMo3uuioy9NXLAht1g2N5WtCt0LWO7jCRV4/zYAjsXj9lUC8FWLqv03ACQUlsid85jgVUPX0UIB+OzT5e/8d638qxRsOoMsF6BG2V0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WULz4y4Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WULz4y4Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7FD2308;
	Mon, 13 Jul 2026 07:02:41 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6F3783F7B4;
	Mon, 13 Jul 2026 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951365; bh=bIKoPb0bNMxSfp09kSEpc6GfFg6xieua9pE2L9NCvH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WULz4y4YGBEo8OxYiDQxjd3ysksN4y37aXjVMj1APMpW6oYyyzlT2yQ9xycWe8eq1
	 JbXFkQQYvjUOrSyYV49ZYubVKBtMB+ARWadXw+OMlzoS2V4DZrO9+UJT10fnE4iycW
	 mu1W2yH62wJX/KyaBePfncLl5wroe1c443crwqTc=
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
Subject: [RFC PATCH 30/34] mm/pgtable: disallow calling folded (pgd|p4d|pud)_page, pgd_page_vaddr() and (p4d|pud)_pgtable
Date: Mon, 13 Jul 2026 14:56:09 +0100
Message-ID: <20260713135614.1618183-31-yeoreum.yun@arm.com>
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

These helpers that silently fallback to the folded level
are dangerous, especially with some upcoming changes.

We made all code compile-out any calls to these helpers. So let's make the
compiler complain if these helpers are abused in wrong context.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 include/asm-generic/pgtable-nop4d.h | 4 ++--
 include/asm-generic/pgtable-nopmd.h | 4 ++--
 include/asm-generic/pgtable-nopud.h | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 0f3b56deaa165..25c26a587b512 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -46,8 +46,8 @@ static inline p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd,
 #define p4d_val(x)				(pgd_val((x).pgd))
 #define __p4d(x)				((p4d_t) { __pgd(x) })
 
-#define pgd_page(pgd)				(p4d_page((p4d_t){ pgd }))
-#define pgd_page_vaddr(pgd)			((unsigned long)(p4d_pgtable((p4d_t){ pgd })))
+#define pgd_page(pgd)				({ BUILD_BUG(); (struct page *)NULL; })
+#define pgd_page_vaddr(pgd)			({ BUILD_BUG(); 0UL; })
 
 /*
  * allocating and freeing a p4d is trivial: the 1-entry p4d is
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 9d854211a55a5..75650fa9111cd 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -56,8 +56,8 @@ static inline pmd_t *pmd_offset_lockless(pud_t *pudp, pud_t pud,
 #define pmd_val(x)				(pud_val((x).pud))
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
-#define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_pgtable(pud)			((pmd_t *)(pmd_page_vaddr((pmd_t){ pud })))
+#define pud_page(pud)				({ BUILD_BUG(); (struct page *)NULL; })
+#define pud_pgtable(pud)			({ BUILD_BUG(); NULL; })
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index aa8a6ce139e47..b592fff18887a 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -54,8 +54,8 @@ static inline pud_t *pud_offset_lockless(p4d_t *p4dp, p4d_t p4d,
 #define pud_val(x)				(p4d_val((x).p4d))
 #define __pud(x)				((pud_t) { __p4d(x) })
 
-#define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_pgtable(p4d)			((pud_t *)(pud_pgtable((pud_t){ p4d })))
+#define p4d_page(p4d)				({ BUILD_BUG(); (struct page *)NULL; })
+#define p4d_pgtable(p4d)			({ BUILD_BUG(); NULL; })
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

