Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2E1437440;
	Mon, 13 Jul 2026 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951242; cv=none; b=pKtkPQ7/qUFQ/LCqWxpJiWTsaNzf1liSgIYh+81oLXwL6Rq5Y7zRcRoMQMcUIkOox4GCdpy7v4XCK0aqa6jxoM5Xul+Nau794dAmBUTbhDXOENb5CTpb92vtdhfjHOTw4ND7piDvmhcNcnh0WCBtNeSV03niKWctqk/NHygmJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951242; c=relaxed/simple;
	bh=va0q48sXcle/0V8qWAZnWr4Xakv6qUZD5loRZgnhZRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMk08axsCHIUrd4GvXA/QtDvKdmus9hEvbbQRPhy3O/eA05OsjGTLWhhtSSndryniM76u3FzE0itWV34daM/WP+KHhHlejkvoQS342qGDcxPXOyWM1Qyy6DJKsnXrBiEgCuOX0Tw7wxzP15xSuYnQ0uNChllZACTydDc1lFRt/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MOz3M/no; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MOz3M/no"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E365722C7;
	Mon, 13 Jul 2026 07:00:35 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F00E63F7B4;
	Mon, 13 Jul 2026 07:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951240; bh=va0q48sXcle/0V8qWAZnWr4Xakv6qUZD5loRZgnhZRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MOz3M/no7GPM/RnhkzFTAVpZxS2ERKQvlXCwbsNiVRL2yYzWglw+94qjOt1vYID/N
	 vyPd1NMFFKbOMm+vDptBUDLnohT7IckowlWYW8T/UQ7ot7g+j7Fi6uF15Cuk4eUFdO
	 qI5ngs3cD0CTMXkzBMuGvFfPsf6DqKwnnjUpXmno=
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
Subject: [RFC PATCH 20/34] x86: kexec: use proper set_pXd() for generic compile-time folded patable in machine_kexec_page_table_set_one()
Date: Mon, 13 Jul 2026 14:55:59 +0100
Message-ID: <20260713135614.1618183-21-yeoreum.yun@arm.com>
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
 arch/x86/kernel/machine_kexec_32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 1f325304c4a84..a36321ee9f24f 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -84,12 +84,12 @@ static void machine_kexec_page_table_set_one(
 	pud_t *pud;
 
 	pgd += pgd_index(vaddr);
-#ifdef CONFIG_X86_PAE
-	if (!(pgd_val(*pgd) & _PAGE_PRESENT))
-		set_pgd(pgd, __pgd(__pa(pmd) | _PAGE_PRESENT));
-#endif
 	p4d = p4d_offset(pgd, vaddr);
 	pud = pud_offset(p4d, vaddr);
+#ifdef CONFIG_X86_PAE
+	if (!(pud_val(*pud) & _PAGE_PRESENT))
+		set_pud(pud, __pud(__pa(pmd) | _PAGE_PRESENT));
+#endif
 	pmd = pmd_offset(pud, vaddr);
 	if (!(pmd_val(*pmd) & _PAGE_PRESENT))
 		set_pmd(pmd, __pmd(__pa(pte) | _PAGE_TABLE));
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

