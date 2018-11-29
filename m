From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v2 22/28] arm64: Add vDSO compat support
Date: Thu, 29 Nov 2018 17:05:24 +0000
Message-ID: <20181129170530.37789-23-vincenzo.frascino@arm.com>
References: <20181129170530.37789-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129170530.37789-1-vincenzo.frascino@arm.com>
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

This patch adds vDSO compat support to the arm64 building system.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Kconfig         |  1 +
 arch/arm64/Makefile        | 21 +++++++++++++++++++--
 arch/arm64/kernel/Makefile |  6 +++++-
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2c7d447401b5..79829ddf7cc9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -103,6 +103,7 @@ config ARM64
 	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_COMPAT_VDSO
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_ACPI_APEI if (ACPI && EFI)
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6cb9fc7e9382..814d2b0ac017 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -49,9 +49,23 @@ $(warning Detected assembler with broken .inst; disassembly will be unreliable)
   endif
 endif
 
-KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst)
+ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
+  CROSS_COMPILE_ARM32 ?= $(CONFIG_CROSS_COMPILE_COMPAT_VDSO:"%"=%)
+
+  ifeq ($(CROSS_COMPILE_ARM32),)
+    $(warning CROSS_COMPILE_ARM32 not defined or empty, the compat vDSO will not be built)
+  else ifeq ($(shell which $(CROSS_COMPILE_ARM32)gcc 2> /dev/null),)
+    $(error $(CROSS_COMPILE_ARM32)gcc not found, check CROSS_COMPILE_ARM32)
+  else
+    export CROSS_COMPILE_ARM32
+    export CONFIG_COMPAT_VDSO := y
+    compat_vdso := -DCONFIG_COMPAT_VDSO=1
+  endif
+endif
+
+KBUILD_CFLAGS	+= -mgeneral-regs-only $(lseinstr) $(brokengasinst) $(compat_vdso)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
-KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst)
+KBUILD_AFLAGS	+= $(lseinstr) $(brokengasinst) $(compat_vdso)
 
 KBUILD_CFLAGS	+= $(call cc-option,-mabi=lp64)
 KBUILD_AFLAGS	+= $(call cc-option,-mabi=lp64)
@@ -144,6 +158,9 @@ ifeq ($(KBUILD_EXTMOD),)
 prepare: vdso_prepare
 vdso_prepare: prepare0
 	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
+	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
+		$(build)=arch/arm64/kernel/vdso32  \
+		include/generated/vdso32-offsets.h)
 endif
 
 define archhelp
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2fcba6b87829..29234a70d168 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -28,7 +28,10 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 	$(call if_changed,objcopy)
 
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o			\
-					   sigreturn32.o sys_compat.o
+					   sys_compat.o
+ifneq ($(CONFIG_COMPAT_VDSO), y)
+arm64-obj-$(CONFIG_COMPAT)		+= sigreturn32.o
+endif
 arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
@@ -60,6 +63,7 @@ arm64-obj-$(CONFIG_ARM_SDE_INTERFACE)	+= sdei.o
 arm64-obj-$(CONFIG_ARM64_SSBD)		+= ssbd.o
 
 obj-y					+= $(arm64-obj-y) vdso/ probes/
+obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
 obj-m					+= $(arm64-obj-m)
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
-- 
2.19.2
