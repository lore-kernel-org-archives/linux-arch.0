Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbfBVM0U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:26:20 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 15/23] arm64: compat: vDSO setup for compat layer
Date: Fri, 22 Feb 2019 12:24:22 +0000
Message-ID: <20190222122430.21180-16-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122422.IQ-iq7Lhj0CaztBE8h6IvvuanJeH8-ToLSxqJ_EmziQ@z>

If CONFIG_GENERIC_COMPAT_VDSO is enabled, compat vDSO are installed in a
compat (32 bit) process instead of sigpage.

Add the necessary code to setup the vDSO required pages.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso.c | 60 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index c217245768ea..55343f8f3593 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -41,10 +41,16 @@
 #include <asm/vdso.h>
 
 extern char vdso_start[], vdso_end[];
+#ifdef CONFIG_COMPAT_VDSO
+extern char vdso32_start[], vdso32_end[];
+#endif /* CONFIG_COMPAT_VDSO */
 
 /* vdso_lookup arch_index */
 enum arch_vdso_type {
 	ARM64_VDSO = 0,
+#ifdef CONFIG_COMPAT_VDSO
+	ARM64_VDSO32 = 1,
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 struct __vdso_lookup_t {
@@ -64,6 +70,13 @@ static struct __vdso_lookup_t vdso_lookup[2] __ro_after_init = {
 		.vdso_code_start = vdso_start,
 		.vdso_code_end = vdso_end,
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "vdso32",
+		.vdso_code_start = vdso32_start,
+		.vdso_code_end = vdso32_end,
+	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 /*
@@ -179,23 +192,45 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 /*
  * Create and map the vectors page for AArch32 tasks.
  */
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	return __vdso_remap(ARM64_VDSO32, sm, new_vma);
+}
+#endif /* CONFIG_COMPAT_VDSO */
+
 /*
  * aarch32_vdso_pages:
  * 0 - kuser helpers
  * 1 - sigreturn code
+ * or (CONFIG_COMPAT_VDSO):
+ * 0 - kuser helpers
+ * 1 - vdso data
+ * 2 - vdso code
  */
 static struct page *aarch32_vdso_pages[2] __ro_after_init;
-static struct vm_special_mapping aarch32_vdso_spec[2] __ro_after_init = {
+static struct vm_special_mapping aarch32_vdso_spec[3] __ro_after_init = {
 	{
 		/* Must be named [vectors] for compatibility with arm. */
 		.name	= "[vectors]",
 		.pages	= &aarch32_vdso_pages[0],
 	},
+#ifdef CONFIG_COMPAT_VDSO
+	{
+		.name = "[vvar]",
+	},
+	{
+		.name = "[vdso]",
+		.mremap = aarch32_vdso_mremap,
+	},
+#else
 	{
 		/* Must be named [sigpage] for compatibility with arm. */
 		.name	= "[sigpage]",
 		.pages	= &aarch32_vdso_pages[1],
 	},
+#endif /* CONFIG_COMPAT_VDSO */
 };
 
 #ifdef CONFIG_KUSER_HELPERS
@@ -227,6 +262,15 @@ static int aarch32_alloc_kuser_vdso_page(void)
 }
 #endif /* CONFIG_KUSER_HELPER */
 
+#ifdef CONFIG_COMPAT_VDSO
+static int aarch32_vdso_init(void)
+{
+	vdso_lookup[ARM64_VDSO32].dm = &aarch32_vdso_spec[1];
+	vdso_lookup[ARM64_VDSO32].cm = &aarch32_vdso_spec[2];
+
+	return __vdso_init(ARM64_VDSO32);
+}
+#else
 static int aarch32_alloc_sigreturn_vdso_page(void)
 {
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
@@ -249,11 +293,16 @@ static int aarch32_alloc_sigreturn_vdso_page(void)
 	return 0;
 
 }
+#endif /* CONFIG_COMPAT_VDSO */
 
 static int __init aarch32_alloc_vdso_pages(void)
 {
 	return aarch32_alloc_kuser_vdso_page() &
+#ifdef CONFIG_COMPAT_VDSO
+	       aarch32_vdso_init();
+#else
 	       aarch32_alloc_sigreturn_vdso_page();
+#endif /* CONFIG_COMPAT_VDSO */
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
@@ -278,6 +327,7 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 }
 #endif /* CONFIG_KUSER_HELPERS */
 
+#ifndef CONFIG_COMPAT_VDSO
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
 	unsigned long addr;
@@ -301,6 +351,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 out:
 	return PTR_ERR_OR_ZERO(ret);
 }
+#endif /* !CONFIG_COMPAT_VDSO */
 
 int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
@@ -314,7 +365,14 @@ int aarch32_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (ret)
 		goto out;
 
+#ifdef CONFIG_COMPAT_VDSO
+	ret = __setup_additional_pages(ARM64_VDSO32,
+				       mm,
+				       bprm,
+				       uses_interp);
+#else
 	ret = aarch32_sigreturn_setup(mm);
+#endif /* CONFIG_COMPAT_VDSO */
 
 out:
 	up_write(&mm->mmap_sem);
-- 
2.20.1
