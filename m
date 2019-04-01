Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32908 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfDALUk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 07:20:40 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 3/4] arm64: compat: Refactor aarch32_alloc_vdso_pages()
Date: Mon,  1 Apr 2019 12:20:24 +0100
Message-ID: <20190401112025.40807-4-vincenzo.frascino@arm.com>
In-Reply-To: <20190401112025.40807-1-vincenzo.frascino@arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190401112024.UDmQI6lgO-rI68By_eP9ViPkc9ATEDg_bEZ8DBc-PDM@z>

aarch32_alloc_vdso_pages() needs to the refactored to make it
easier to disable kuser helpers.

Divide the function in aarch32_alloc_kuser_vdso_page() and
aarch32_alloc_sigreturn_vdso_page().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 49 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 9556ad2036ef..afbbdccbf05b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -74,40 +74,55 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
 	},
 };
 
-static int __init aarch32_alloc_vdso_pages(void)
+static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
-	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
-
 	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
-	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
-	unsigned long vdso_pages[2];
-
-	vdso_pages[0] = get_zeroed_page(GFP_ATOMIC);
-	if (!vdso_pages[0])
-		return -ENOMEM;
+	unsigned long vdso_page;
 
-	vdso_pages[1] = get_zeroed_page(GFP_ATOMIC);
-	if (!vdso_pages[1])
+	vdso_page = get_zeroed_page(GFP_ATOMIC);
+	if (!vdso_page)
 		return -ENOMEM;
 
 	/* kuser helpers */
-	memcpy((void *)(vdso_pages[0] + 0x1000 - kuser_sz),
+	memcpy((void *)(vdso_page + 0x1000 - kuser_sz),
 	       __kuser_helper_start,
 	       kuser_sz);
 
+	aarch32_vdso_pages[0] = virt_to_page(vdso_page);
+
+	flush_dcache_page(aarch32_vdso_pages[0]);
+
+	return 0;
+}
+
+static int aarch32_alloc_sigreturn_vdso_page(void)
+{
+	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
+	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
+	unsigned long vdso_page;
+
+	vdso_page = get_zeroed_page(GFP_ATOMIC);
+	if (!vdso_page)
+		return -ENOMEM;
+
 	/* sigreturn code */
-	memcpy((void *)vdso_pages[1],
+	memcpy((void *)vdso_page,
 	       __aarch32_sigret_code_start,
 	       sigret_sz);
 
-	flush_icache_range(vdso_pages[0], vdso_pages[0] + PAGE_SIZE);
-	flush_icache_range(vdso_pages[1], vdso_pages[1] + PAGE_SIZE);
+	aarch32_vdso_pages[1] = virt_to_page(vdso_page);
 
-	aarch32_vdso_pages[0] = virt_to_page(vdso_pages[0]);
-	aarch32_vdso_pages[1] = virt_to_page(vdso_pages[1]);
+	flush_dcache_page(aarch32_vdso_pages[1]);
 
 	return 0;
+
+}
+
+static int __init aarch32_alloc_vdso_pages(void)
+{
+	return aarch32_alloc_kuser_vdso_page() &
+	       aarch32_alloc_sigreturn_vdso_page();
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
-- 
2.21.0
