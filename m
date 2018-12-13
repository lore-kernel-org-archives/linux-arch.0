Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbeLMQ7J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Dec 2018 11:59:09 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 07/24] arm64: compat: Refactor aarch32_alloc_vdso_pages()
Date: Thu, 13 Dec 2018 16:57:29 +0000
Message-ID: <20181213165746.56930-8-vincenzo.frascino@arm.com>
In-Reply-To: <20181213165746.56930-1-vincenzo.frascino@arm.com>
References: <20181213165746.56930-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>
Message-ID: <20181213165729.LpOpErx2PiVrxA3j7PPSM2YLWxMhx39VXVUjh3E9JkA@z>

aarch32_alloc_vdso_pages() needs to the refactored to make it
easier to disable kuser helpers.

This patch divides the function in aarch32_alloc_kuser_vdso_page() and
aarch32_alloc_sigreturn_vdso_page().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 49 ++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 5df7aeef324a..d438e65299a2 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -75,40 +75,55 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
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
 
+	flush_icache_range(vdso_page, vdso_page + PAGE_SIZE);
+
+	aarch32_vdso_pages[0] = virt_to_page(vdso_page);
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
+	flush_icache_range(vdso_page, vdso_page + PAGE_SIZE);
 
-	aarch32_vdso_pages[0] = virt_to_page(vdso_pages[0]);
-	aarch32_vdso_pages[1] = virt_to_page(vdso_pages[1]);
+	aarch32_vdso_pages[1] = virt_to_page(vdso_page);
 
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
2.19.2
