Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbfBVM0B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 07:26:01 -0500
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v5 08/23] arm64: compat: Add KUSER_HELPERS config option
Date: Fri, 22 Feb 2019 12:24:15 +0000
Message-ID: <20190222122430.21180-9-vincenzo.frascino@arm.com>
In-Reply-To: <20190222122430.21180-1-vincenzo.frascino@arm.com>
References: <20190222122430.21180-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <20190222122415.nGrRJSOJRFpzYOf2NppWIM2qif2jf49uWGNOqXTOKUg@z>

When kuser helpers are enabled the kernel maps the relative code at
a fixed address (0xffff0000). Making configurable the option to disable
them means that the kernel can remove this mapping and any access to
this memory area results in a sigfault.

Add a KUSER_HELPERS config option that can be used to disable the
mapping when it is turned off.

This option can be turned off if and only if the applications are
designed specifically for the platform and they do not make use of the
kuser helpers code.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig          | 21 +++++++++++++++++++++
 arch/arm64/kernel/Makefile  |  3 ++-
 arch/arm64/kernel/kuser32.S |  7 +++----
 arch/arm64/kernel/vdso.c    | 15 +++++++++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d898da2e20f5..ed3290494f1c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1465,6 +1465,27 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable kuser helpers page for compatibility with 32 bit applications."
+	depends on COMPAT
+	default y
+	help
+	  Enables kuser helpers to be mapped in a special purpose page at a fixed
+	  address to maintain independence from the type of CPU present in the SoC.
+	  This feature is provided for compatibility reasons in fact allows 32 bit
+	  applications compliant with ARMv4 up to ARMv8 to run without any
+	  modification.
+
+	  Warning: Being always mapped at a fixed address makes it easier to create
+	  exploits based on ROP type of attacks.
+
+	  As a consequence of this, this feature is made configurable but be aware that
+	  it can be turned off if and only if the binaries and the libraries running on
+	  a specific platform are designed to do not make use of these helpers, otherwise
+	  should be left on.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 50f76b88a967..c7bd0794855a 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,8 +27,9 @@ OBJCOPYFLAGS := --prefix-symbols=__efistub_
 $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
-obj-$(CONFIG_COMPAT)			+= sys32.o kuser32.o signal32.o 	\
+obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sigreturn32.o sys_compat.o
+obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o
 obj-$(CONFIG_ARM64_MODULE_PLTS)		+= module-plts.o
diff --git a/arch/arm64/kernel/kuser32.S b/arch/arm64/kernel/kuser32.S
index f19e2b015097..7d38633bf33f 100644
--- a/arch/arm64/kernel/kuser32.S
+++ b/arch/arm64/kernel/kuser32.S
@@ -5,10 +5,9 @@
  * Copyright (C) 2005-2011 Nicolas Pitre <nico@fluxnic.net>
  * Copyright (C) 2012-2018 ARM Ltd.
  *
- * Each segment is 32-byte aligned and will be moved to the top of the high
- * vector page.  New segments (if ever needed) must be added in front of
- * existing ones.  This mechanism should be used only for things that are
- * really small and justified, and not be abused freely.
+ * The kuser helpers below are mapped at a fixed address by
+ * aarch32_setup_additional_pages() ad are provided for compatibility
+ * reasons with 32 bit (aarch32) applications that need them.
  *
  * See Documentation/arm/kernel_user_helpers.txt for formal definitions.
  */
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 4c9476516e2f..523e56658b84 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -75,6 +75,7 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
 	},
 };
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
@@ -96,6 +97,12 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
 	return 0;
 }
+#else
+static int aarch32_alloc_kuser_vdso_page(void)
+{
+	return 0;
+}
+#endif /* CONFIG_KUSER_HELPER */
 
 static int aarch32_alloc_sigreturn_vdso_page(void)
 {
@@ -127,6 +134,7 @@ static int __init aarch32_alloc_vdso_pages(void)
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
@@ -139,6 +147,13 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 
 	return PTR_ERR_OR_ZERO(ret);
 }
+#else
+static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
+{
+	/* kuser helpers not enabled */
+	return 0;
+}
+#endif /* CONFIG_KUSER_HELPERS */
 
 static int aarch32_sigreturn_setup(struct mm_struct *mm)
 {
-- 
2.20.1
