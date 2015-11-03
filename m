From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 27/28] lkl: add support for Windows hosts
Date: Tue,  3 Nov 2015 22:20:58 +0200
Message-ID: <1446582059-17355-28-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

This patch allows LKL to be compiled for windows hosts with the mingw
toolchain. Note that patches [1] that fix weak symbols linking are
required to successfully compile LKL with mingw.

The patch disables the modpost pass over vmlinux since modpost only
works with ELF objects.

It also adds and workaround to an #include_next <stdard.h> error which
is apparently caused by using -nosdtinc.

[1] https://sourceware.org/ml/binutils/2015-10/msg00234.html

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/Kconfig                 |  1 +
 arch/lkl/Makefile                |  4 ++++
 arch/lkl/include/system/stdarg.h |  1 +
 include/linux/compiler-gcc.h     |  4 ++++
 scripts/Makefile                 |  2 ++
 scripts/link-vmlinux.sh          | 12 +++++++-----
 6 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 arch/lkl/include/system/stdarg.h

diff --git a/arch/lkl/Kconfig b/arch/lkl/Kconfig
index 064960b..567533b 100644
--- a/arch/lkl/Kconfig
+++ b/arch/lkl/Kconfig
@@ -18,6 +18,7 @@ config LKL
        select ARCH_WANT_FRAME_POINTERS
        select PHYS_ADDR_T_64BIT if 64BIT
        select 64BIT if OUTPUT_FORMAT = "elf64-x86-64"
+       select HAVE_UNDERSCORE_SYMBOL_PREFIX if OUTPUT_FORMAT = "pe-i386"
 
 config OUTPUTFORMAT
        string
diff --git a/arch/lkl/Makefile b/arch/lkl/Makefile
index 7545830..51ad096 100644
--- a/arch/lkl/Makefile
+++ b/arch/lkl/Makefile
@@ -4,6 +4,10 @@ KBUILD_CFLAGS += -fno-builtin
 
 ifeq ($(OUTPUT_FORMAT),elf64-x86-64)
 KBUILD_CFLAGS += -fPIC
+else ifeq ($(OUTPUT_FORMAT),pe-i386)
+prefix=_
+# workaround for #include_next<stdarg.h> errors
+LINUXINCLUDE := -isystem arch/lkl/include/system $(LINUXINCLUDE)
 endif
 
 LDFLAGS_vmlinux += -r
diff --git a/arch/lkl/include/system/stdarg.h b/arch/lkl/include/system/stdarg.h
new file mode 100644
index 0000000..db463c5
--- /dev/null
+++ b/arch/lkl/include/system/stdarg.h
@@ -0,0 +1 @@
+/* empty file to avoid #include_next<stdarg.h> error */
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 8efb40e..87ddae7 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -116,7 +116,11 @@
  */
 #define __pure			__attribute__((pure))
 #define __aligned(x)		__attribute__((aligned(x)))
+#ifdef __MINGW32__
+#define __printf(a, b)		__attribute__((format(gnu_printf, a, b)))
+#else
 #define __printf(a, b)		__attribute__((format(printf, a, b)))
+#endif
 #define __scanf(a, b)		__attribute__((format(scanf, a, b)))
 #define __attribute_const__	__attribute__((__const__))
 #define __maybe_unused		__attribute__((unused))
diff --git a/scripts/Makefile b/scripts/Makefile
index 1b26617..3036a7b 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -37,7 +37,9 @@ build_docproc: $(obj)/docproc
 	@:
 
 subdir-$(CONFIG_MODVERSIONS) += genksyms
+ifeq ($(findstring elf,$(if $(CONFIG_OUTPUT_FORMAT),$(CONFIG_OUTPUT_FORMAT),elf)),elf)
 subdir-y                     += mod
+endif
 subdir-$(CONFIG_SECURITY_SELINUX) += selinux
 subdir-$(CONFIG_DTC)         += dtc
 subdir-$(CONFIG_GDB_SCRIPTS) += gdb
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1a10d8a..f9e7586 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -161,12 +161,14 @@ case "${KCONFIG_CONFIG}" in
 	. "./${KCONFIG_CONFIG}"
 esac
 
-#link vmlinux.o
-info LD vmlinux.o
-modpost_link vmlinux.o
+if [ -e scripts/mod/modpost ]; then
+    #link vmlinux.o
+    info LD vmlinux.o
+    modpost_link vmlinux.o
 
-# modpost vmlinux.o to check for section mismatches
-${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
+    # modpost vmlinux.o to check for section mismatches
+    ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
+fi
 
 # Update version
 info GEN .version
-- 
2.1.0
