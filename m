From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 10/27] arm64: compat: Refactor aarch32_alloc_vdso_pages()
Date: Fri,  9 Nov 2018 12:37:13 +0000
Message-ID: <20181109123730.8743-11-vincenzo.frascino@arm.com>
References: <20181109123730.8743-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181109123730.8743-1-vincenzo.frascino@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Mark Salyzyn <salyzyn@android.com>, Paul Burton <paul.burton@mips.com>, Thomas Gleixner <tglx@linutronix.de>, Peter Collingbourne <pcc@google.com>
List-Id: linux-arch.vger.kernel.org

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
index 88b674079d07..cee7205eefc5 100644
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
2.19.1
