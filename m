From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 09/18] arm64: introduce binfmt_elf32.c
Date: Fri, 21 Oct 2016 23:33:08 +0300
Message-ID: <1477081997-4770-10-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org
Cc: szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, ynorov@caviumnetworks.com, philipp.tomsich@theobroma-systems.com, joseph@codesourcery.com, zhouchengming1@huawei.com, Prasun.Kapoor@caviumnetworks.com, agraf@suse.de, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, pinskia@gmail.com, linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org, bamvor.zhangjian@huawei.com, maxim.kuvyrkov@linaro.org, Nathan_Lynch@mentor.com, schwidefsky@de.ibm.com, davem@davemloft.net, christoph.muellner@theobroma-systems.com
List-Id: linux-arch.vger.kernel.org

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
