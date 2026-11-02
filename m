Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618580;
	b=VGvvUJRAtWuUD8avo1wNoFcGMeROoDIq6BAg9H/QgpOmRzfLf4HVh0WIBSLStE0eT7aY
	 XJ6toqGFBk3CQfM3v/KazhbksKrLbV/yDaiHBNH8neiF82dvSiC6I0glLjqSrwwoyHvnW
	 D6YxyIqP7Ntqv8CzDJacaG6YC/V7am4qtFRLLpONjdZ00t8Oe880zTrfNkQXw9CxDSvi/
	 nSQTd9CBuh+rs3AYQBiIgolOLKaZZww4gDiFRKcT6lXpvCWcHdGUwoxdoYKGBJ8Q3SUtK
	 oP7uQWfBsnTvskDyAd4PoAdbnSUWEOraoelAU8jYq0COooDRJhsMuEYuWC7MFgyWHMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618580;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=3lY+1ZzPRqoScYAMKyAN5RN/YFCIvuobO8x0DYvXDjE=;
	b=PIaGjord72fYfPXZH+IeVgMX62Qj1i8XQaQoV+/9gOan+30HKg4YQD9drgw8OtBitcDP
	 Ya+VdgcSRlgEjG5A9zlZPJ9iL5F3SSq6OytBPU73VGJ4lMlMz9+xogapXuJxWyM4gkcM7
	 /0nB+khJqt01jeFNb9u3iDeeV2B4Q7JYGgamA6oqFFfhUF75sEYEnHUc5owEvaMgEE+wX
	 4W/cqYfgsR57y8qMRmgUYSXLrPnJLdaxkVxixeGYhSccRRer7zKBzSQCv1h6GHwbedzpe
	 Xnr2TUnR1hwaUFjX+PINH/U+mgkNt2Dbn3k0PQAjzrMULHDzoW4eZoKheJqcrSr+4bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OL6q65xC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CAC606B380;
	Mon,  2 Nov 2026 11:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CAC606B380
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=OL6q65xC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C05B22972;
	Mon,  2 Nov 2026 03:22:55 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B2FB3F632;
	Mon,  2 Nov 2026 03:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618578; bh=bEX3sSqEnQKAQjL0B+MI6TFOYIMgpmFaiG2QcWnZ5UQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OL6q65xCnF2Tz4ITltDKgFLNBYVVrj82d5jxdji1GVBZb75n9gPi0z1tfCET6eB7u
	 4s4rCEiwCIn3qlysbR++0NoFqJK82k/WXfZq11aTvIy0cVuMV3M4EHp2+WOGymGRhI
	 8T0sz25bKGSqnXOGGxivwKApdCmjhFNLN3gptB4o=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:26 +0000
Subject: [PATCH RESEND v2 13/21] x86/mm: Introduce helper for checking
 direct map 1G page support
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dummy_ptxp3-v2-13-78840b2ec73c@arm.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
In-Reply-To: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>, 
 Sohil Mehta <sohil.mehta@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5614; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=ArnDgja24P54ewtxWlKChMWDZmg5SmpxwVJZIltWfVo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI1RIbrWXEKJzjwjPKklaXB5ULDRFe5CQCSy
 l3tJmaWOOyJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyNQAKCRBt1cPRWsUx
 M5ZHC/4tf/XkQKbv2sSjxw7u2qbrKs9afdYINdi0Ck9j09hNi8AocMbGW9v/Vi9jdTVJhqvjeM+
 0sYVgbLZ7S1NsxmWc+vOyzpYCgCWM8FI1l7ZGEf/tFHGBxVsXiPh2p0/5rAlHtJmpZBBY45cONO
 yJ0kAXibS0A3hvLaJbkw6PSC3kLvxObC5zVc/nyVKFvByL2NL/jYQbYUtgZ/G8X7idCTR5++VqV
 5FCMJ61PnZtwooqTgFZaz96tdLnXBgid9Tx5+ZQ1lySgDzMx2h5UE9MRTNLZOgaPd/QARaBHgER
 9GeJyNqO+4m2xPCIhjFa9rk63IaIQ3oNhZxMaZFbnq8TlJ4mud1USfX8U/LQk8IVQw02LEOokQJ
 IVbwwNYeY+sXQc0PostpjU9MZCnD10kjbGu0XjEb1ifkhYYkn8eIiQNghYQZ0Aie5KTCSuT2hLO
 SuYDXUuJF3Zd1utQ8h1lmnOikT85YsrZp+E5Rb1mpROYDHK+aMhG5EmJyA/gSFehyrnws=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: Dave Hansen <dave.hansen@linux.intel.com>

There is an existing variable (direct_gbpages) that says whether the
kernel can and should use 1G pages in the direct map. It is driven
by a bunch of other machinery. At least:

 1. Hardware support for 1G pages
 2. Kconfig support for 1G direct mappings
 3. Kernel command line overrides

Most code just checks the 'direct_gbpages' variable itself.  But there
are cases where 1G mappings are compile-time disabled (via
X86_DIRECT_GBPAGES) and 'direct_gbpages' is always 0. Unfortunately,
that constraint is invisible to the compiler.

This opacity has been historically functionally harmless; it only
leaves a bit of dead code. But, there are plans to tigthen up the
compile-time checks around folded page table levels. The build will
break if that dead code appears reachable to the compiler. Making
the compile-time config visible to the compiler fixes the build.

Add a helper to replace 'direct_gbpages' checks. Check the Kconfig
option and base CPU support before looking at the variable.

This lets the compiler optimize things better, especially
collapse_pud_page() where most of the function can now be optimized
out when the PUD level is folded.

Notes:

Use boot_cpu_has() instead of cpu_feature_enabled(). There's no
required/disabled features for 1G pages themselves
(X86_DIRECT_GBPAGES is for kernel mappings only) and the
static_cpu_has() infrastructure is just gets in the compiler's way.

This makes 64-bit build marginally larger (20 bytes in one compile)
and 32-bit builds less marginally _smaller_ (~700 bytes).

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: Yeoreum Yun <yeoreum.yun@arm.com>
Link: https://lore.kernel.org/all/20260902-dummy_ptxp3-v3-15-5d8f5b17c25c@arm.com/ [1]
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
 arch/x86/include/asm/pgtable.h     | 14 ++++++++++++++
 arch/x86/kernel/cpu/common.c       |  2 +-
 arch/x86/kernel/machine_kexec_64.c |  2 +-
 arch/x86/mm/init.c                 |  2 +-
 arch/x86/mm/pat/set_memory.c       |  6 +++---
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 000fc6c1ca37c..a277082121878 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1167,6 +1167,20 @@ static inline int pgd_none(pgd_t pgd)
 #ifndef __ASSEMBLER__
 
 extern int direct_gbpages;
+static inline bool direct_gbpages_enabled(void)
+{
+	/* Check the direct map config option: */
+	if (!IS_ENABLED(CONFIG_X86_DIRECT_GBPAGES))
+		return false;
+
+	/* Check the CPU feature: */
+	if (!boot_cpu_has(X86_FEATURE_GBPAGES))
+		return false;
+
+	/* Check the command-line and early setup variable: */
+	return direct_gbpages;
+}
+
 void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 void __init poking_init(void);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 9bd50c68cd7e5..12a51dba16627 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2655,7 +2655,7 @@ void __init arch_cpu_finalize_init(void)
 		 * Right now we don't do that with gbpages because there seems
 		 * very little benefit for that case.
 		 */
-		if (!direct_gbpages)
+		if (!direct_gbpages_enabled())
 			set_memory_4k((unsigned long)__va(0), 1);
 	} else {
 		fpu__init_check_bugs();
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c3f4a389992da..0da0e89f2611a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -257,7 +257,7 @@ static int init_pgtable(struct kimage *image, unsigned long control_page)
 		info.kernpg_flag |= _PAGE_ENC;
 	}
 
-	if (direct_gbpages)
+	if (direct_gbpages_enabled())
 		info.direct_gbpages = true;
 
 	for (i = 0; i < nr_pfn_mapped; i++) {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 079f8c7e9e3cd..f0f4a06584c61 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -251,7 +251,7 @@ static void __init probe_page_size_mask(void)
 		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
 
 	/* Enable 1 GB linear kernel mappings if available: */
-	if (direct_gbpages && boot_cpu_has(X86_FEATURE_GBPAGES)) {
+	if (direct_gbpages_enabled()) {
 		printk(KERN_INFO "Using GB pages for direct mapping\n");
 		page_size_mask |= 1 << PG_LEVEL_1G;
 	} else {
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b1d5c5a0ffb41..f27811e6e00bd 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -130,7 +130,7 @@ void arch_report_meminfo(struct seq_file *m)
 	seq_printf(m, "DirectMap4M:    %8lu kB\n",
 			direct_pages_count[PG_LEVEL_2M] << 12);
 #endif
-	if (direct_gbpages)
+	if (direct_gbpages_enabled())
 		seq_printf(m, "DirectMap1G:    %8lu kB\n",
 			direct_pages_count[PG_LEVEL_1G] << 20);
 }
@@ -1355,7 +1355,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
 	pmd_t *pmd, first;
 	int i;
 
-	if (!direct_gbpages)
+	if (!direct_gbpages_enabled())
 		return 0;
 
 	addr &= PUD_MASK;
@@ -1737,7 +1737,7 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
 	/*
 	 * Map everything starting from the Gb boundary, possibly with 1G pages
 	 */
-	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
+	while (direct_gbpages_enabled() && end - start >= PUD_SIZE) {
 		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
 				   canon_pgprot(pud_pgprot))));
 

-- 
2.43.0

