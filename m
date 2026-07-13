Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC83CFF44;
	Mon, 13 Jul 2026 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951254; cv=none; b=OEfRAR+2cR2CkMHFo6fHS5wEn7cDwE5VHuA6bcDH0yWc3G5Dr5ennU5zGVBHnRr5/hby+AJ3Gf6mnVbMc2Bpu3MnoKfNEjz3p363Q+KZxpPPsplvzZqdZk9Hcaf6vWMyTYmXE50wyy2lpVPzAo5gnDJmWsXPuQZtaLwSioWzYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951254; c=relaxed/simple;
	bh=zdjn+EW1ROhTZfts/8Ej8q/66MoM0Wrm75ll8cq/xrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOqUG9o+ix2VtuvW4wbGCG290E6/6vVi+KGbAxIYsi5JmsTXUmhOohrluGshX1aRP3YyDL7m8zvtT+S4t/+b0GiMiaHV8fY2cseINnJ5I4y25q75z/7hzLKTG58a+k83/+Jn8/voq4uDS174+o8NChQXHHoy+kHIE41xXX690iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WVe8Kgnz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WVe8Kgnz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 971C51FC7;
	Mon, 13 Jul 2026 07:00:48 -0700 (PDT)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7F9D83F7B4;
	Mon, 13 Jul 2026 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783951252; bh=zdjn+EW1ROhTZfts/8Ej8q/66MoM0Wrm75ll8cq/xrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVe8KgnzPlTqjaFSNOJggiBlZUKA4QzXTglCdSnJ8z0qtfTC+2NauNkQ9xF6xK0T8
	 Q6suiP8pQXc7vC+GC4uQ3umZoj/pzGbV50HTuH8+YBS6SgTUORLDFjNvq2Ef8jXD0U
	 YvN50Q+z9X5WyBym+Du0GGc3K2jSEmPZ/vnr64EM=
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
Subject: [RFC PATCH 21/34] x86: platform: use proper set_pXd() for generic compile-time folded patable in setup_olpc_ofw_pgd()
Date: Mon, 13 Jul 2026 14:56:00 +0100
Message-ID: <20260713135614.1618183-22-yeoreum.yun@arm.com>
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

Therefore, replace set_pgd() with set_pmd() when CONFIG_PGTABLE_LEVELS=2.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/platform/olpc/olpc_ofw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc_ofw.c b/arch/x86/platform/olpc/olpc_ofw.c
index 6bab0f0aa8f3e..d709534d48373 100644
--- a/arch/x86/platform/olpc/olpc_ofw.c
+++ b/arch/x86/platform/olpc/olpc_ofw.c
@@ -25,6 +25,8 @@ void __init setup_olpc_ofw_pgd(void)
 {
 	pgd_t *base, *ofw_pde;
 
+	BUILD_BUG_ON(CONFIG_PGTABLE_LEVELS != 2);
+
 	if (!olpc_ofw_cif)
 		return;
 
@@ -38,7 +40,8 @@ void __init setup_olpc_ofw_pgd(void)
 	ofw_pde = &base[OLPC_OFW_PDE_NR];
 
 	/* install OFW's PDE permanently into the kernel's pgtable */
-	set_pgd(&swapper_pg_dir[OLPC_OFW_PDE_NR], *ofw_pde);
+	set_pmd((pmd_t *)&swapper_pg_dir[OLPC_OFW_PDE_NR],
+		*(pmd_t *)ofw_pde);
 	/* implicit optimization barrier here due to uninline function return */
 
 	early_iounmap(base, sizeof(olpc_ofw_pgd) * PTRS_PER_PGD);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

