Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53398 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfCSPQN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Mar 2019 11:16:13 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 4/5] arm64: compat: Add KUSER_HELPERS config option
Date: Tue, 19 Mar 2019 15:15:41 +0000
Message-ID: <20190319151542.19557-5-vincenzo.frascino@arm.com>
In-Reply-To: <20190319151542.19557-1-vincenzo.frascino@arm.com>
References: <20190319151542.19557-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jann Horn <jannh@google.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190319151541.uwLnd188RrYJQ2nqWrIsoVnNpJiAJ0VJOtTG6ELtvdg@z>

When kuser helpers are enabled the kernel maps the relative code at
a fixed address (0xffff0000). Making configurable the option to disable
them means that the kernel can remove this mapping and any access to
this memory area results in a sigfault.

Add a KUSER_HELPERS config option that can be used to disable the
mapping when it is turned off.

This option can be turned off if and only if the applications are
designed specifically for the platform and they do not make use of the
kuser helpers code.

Note: kuser helpers is disabled by default with 64K pages.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig          | 31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile  |  3 ++-
 arch/arm64/kernel/kuser32.S |  7 +++----
 arch/arm64/kernel/vdso.c    | 15 +++++++++++++++
 4 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 117b2541ef3d..492874ca1b80 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1495,6 +1495,37 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable kuser helpers page for compatibility with 32 bit applications."
+	depends on COMPAT
+	depends on !ARM64_64K_PAGES
+	default y
+	help
+	  Warning: disabling this option may break user programs.
+
+	  Provide kuser helpers to compat tasks. The kernel provides
+	  helper code to userspace in read only form at a fixed location
+	  to allow userspace to be independent of the CPU type fitted to
+	  the system. This permits binaries to be run on ARMv4 through
+	  to ARMv8 without modification.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
+	  However, the fixed address nature of these helpers can be used
+	  by ROP (return orientated programming) authors when creating
+	  exploits.
+
+	  If all of the binaries and libraries which run on your platform
+	  are built specifically for your platform, and make no use of
+	  these helpers, then you can turn this option off to hinder
+	  such exploits. However, in that case, if a binary or library
+	  relying on those helpers is run, it will not function correctly.
+
+	  Note: kuser helpers is disabled by default with 64K pages.
+
+	  Say N here only if you are absolutely certain that you do not
+	  need these helpers; otherwise, the safe option is to say Y.
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
index 90663068998a..f545043c7997 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -74,6 +74,7 @@ static const struct vm_special_mapping aarch32_vdso_spec[2] = {
 	},
 };
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_alloc_kuser_vdso_page(void)
 {
 	extern char __kuser_helper_start[], __kuser_helper_end[];
@@ -95,6 +96,12 @@ static int aarch32_alloc_kuser_vdso_page(void)
 
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
@@ -126,6 +133,7 @@ static int __init aarch32_alloc_vdso_pages(void)
 }
 arch_initcall(aarch32_alloc_vdso_pages);
 
+#ifdef CONFIG_KUSER_HELPERS
 static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 {
 	void *ret;
@@ -138,6 +146,13 @@ static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
 
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
2.21.0
