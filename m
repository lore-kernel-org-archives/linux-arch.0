Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A442DA52;
	Mon, 13 Jul 2026 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951292; cv=none; b=ScIkspAadzBjeK7Vm5klm6pDYDJU3mVml4sp87/4H19WSO20K3GkJ67q25IKNsD04SVGMJ/g7fpXX5koVFK9eRBP2RqCUydsWv1TwlmUw9PbkVZ07H/8aso/PFy2vjchyybynN+AWlGiWBAW07+AIgH9e73A2wonAtZ1Bwb9loY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951292; c=relaxed/simple;
	bh=rrBwQUNghxkMeytXEUNPpto8wZMFntDlW0SzsHEzoAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5QyHeDPQAuQVrI2lqxGI6Lvh/FDRdsap3pzYKpVYoDR4U+bHuKuunXRqtkQWGxF1olNCHtiiUJEsYoxLq6WgIIEvwnQROGol93elAM8TPVWN27hR3TpqKt1XtEP26Wf+I1nGXeDldmMPMwlWGMiE0XBCecYlWo56y+AzNWgAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IVRIV9T1; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IVRIV9T1"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A01A2050;
	Mon, 13 Jul 2026 07:01:26 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25E193F7B4;
	Mon, 13 Jul 2026 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951290; bh=rrBwQUNghxkMeytXEUNPpto8wZMFntDlW0SzsHEzoAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IVRIV9T1flpA0gOrme1V1eRRplwrh4TOVZQ26715JQXP4QS1CmEmFLuEQckZtZvv4
	 4p+gq0ht2Chb+NH1sjxzNiEzIZeyEPeVbwJ1KM74ZeocLv5XHo0v7Uh1Lze0qxAo+P
	 JXkmUcVeya83Vz4L/uprN4mXjJ5dFsFizk8SHMNA=
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
Subject: [RFC PATCH 24/34] x86: mm: call try_to_free_pmd_page() when CONFIG_PGTABLE_LEVELS > 2
Date: Mon, 13 Jul 2026 14:56:03 +0100
Message-ID: <20260713135614.1618183-25-yeoreum.yun@arm.com>
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
error when it is used improperly, ensuring that the actual
first-level pXd_pgtable() function is used instead.

The try_to_free_pmd_page() wouldn't need to call when
CONFIG_PGTABLE_LEVELS=2. therefore call it when CONFIG_PGTABLE_LEVELS > 2.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/pat/set_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index cffb1cef869cc..2137174b733ae 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1452,7 +1452,7 @@ static bool unmap_pte_range(pmd_t *pmd, unsigned long start, unsigned long end)
 static void __unmap_pmd_range(pud_t *pud, pmd_t *pmd,
 			      unsigned long start, unsigned long end)
 {
-	if (unmap_pte_range(pmd, start, end))
+	if (unmap_pte_range(pmd, start, end) && CONFIG_PGTABLE_LEVELS > 2)
 		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
@@ -1496,7 +1496,7 @@ static void unmap_pmd_range(pud_t *pud, unsigned long start, unsigned long end)
 	/*
 	 * Try again to free the PMD page if haven't succeeded above.
 	 */
-	if (!pud_none(*pud))
+	if (!pud_none(*pud) && CONFIG_PGTABLE_LEVELS > 2)
 		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

