Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:18978
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933451AbcJUVJb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Oct 2016 17:09:31 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 09/18] arm64: introduce binfmt_elf32.c
Date: Fri, 21 Oct 2016 23:33:08 +0300
Message-ID: <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ynorov@caviumnetworks.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com
Message-ID: <20161021203308.Rbuk-C7AUp_GW1Ih5Ry28mG1kbxDsAQUZ3mamf0UkvA@z>

As we support more than one compat formats, it looks more reasonable
to not use fs/compat_binfmt.c. Custom binfmt_elf32.c allows to move aarch32
specific definitions there and make code more maintainable and readable.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/Kconfig               |  1 -
 arch/arm64/include/asm/hwcap.h   |  2 --
 arch/arm64/kernel/Makefile       |  2 +-
 arch/arm64/kernel/binfmt_elf32.c | 31 +++++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/kernel/binfmt_elf32.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0cd786e..9efa86a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1003,7 +1003,6 @@ config AARCH32_EL0
 	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
 	select COMPAT
-	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
index 2c7fc5d..99dfd92 100644
--- a/arch/arm64/include/asm/hwcap.h
+++ b/arch/arm64/include/asm/hwcap.h
@@ -47,8 +47,6 @@
 #define ELF_HWCAP		(elf_hwcap)
 
 #ifdef CONFIG_AARCH32_EL0
-#define COMPAT_ELF_HWCAP	(compat_elf_hwcap)
-#define COMPAT_ELF_HWCAP2	(compat_elf_hwcap2)
 extern unsigned int compat_elf_hwcap, compat_elf_hwcap2;
 #endif
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 8a19fda..abe5040 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
-					   sys_compat.o entry32.o
+					   sys_compat.o entry32.o binfmt_elf32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
new file mode 100644
index 0000000..aec1c8a
--- /dev/null
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -0,0 +1,31 @@
+/*
+ * Support for AArch32 Linux ELF binaries.
+ */
+
+/* AArch32 EABI. */
+#define EF_ARM_EABI_MASK		0xff000000
+
+#define compat_start_thread		compat_start_thread
+#define COMPAT_SET_PERSONALITY(ex)		\
+do {						\
+	clear_thread_flag(TIF_32BIT_AARCH64);	\
+	set_thread_flag(TIF_32BIT);		\
+} while (0)
+
+#define COMPAT_ARCH_DLINFO
+#define COMPAT_ELF_HWCAP		(compat_elf_hwcap)
+#define COMPAT_ELF_HWCAP2		(compat_elf_hwcap2)
+
+#ifdef __AARCH64EB__
+#define COMPAT_ELF_PLATFORM		("v8b")
+#else
+#define COMPAT_ELF_PLATFORM		("v8l")
+#endif
+
+#define compat_arch_setup_additional_pages \
+					aarch32_setup_vectors_page
+struct linux_binprm;
+extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
+				      int uses_interp);
+
+#include "../../../fs/compat_binfmt_elf.c"
-- 
2.7.4

