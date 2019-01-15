From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v4 08/24] arm64: compat: Add KUSER_HELPERS config option
Date: Tue, 15 Jan 2019 13:55:23 +0000
Message-ID: <20190115135539.24762-9-vincenzo.frascino@arm.com>
References: <20190115135539.24762-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190115135539.24762-1-vincenzo.frascino@arm.com>
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

When kuser helpers are enabled the kernel maps the relative code at
a fixed address (0xffff0000). Making configurable the option to disable
them means that the kernel can remove this mapping and any access to
this memory area results in a sigfault.

This patch adds a KUSER_HELPERS config option that can be used to
disable the mapping when it is turned off.

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
index 35d2c9d92100..77803c10b3ef 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1466,6 +1466,27 @@ config COMPAT
 
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
index d438e65299a2..7ee3d21350ec 100644
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
