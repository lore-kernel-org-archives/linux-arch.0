From: Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC PATCH 14/28] lkl: plug in the build system
Date: Tue,  3 Nov 2015 22:20:45 +0200
Message-ID: <1446582059-17355-15-git-send-email-octavian.purdila@intel.com>
References: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446582059-17355-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, thehajime@gmail.com, Octavian Purdila <octavian.purdila@intel.com>
List-Id: linux-arch.vger.kernel.org

Basic Makefiles for building LKL. Add a new architecture specific
target for installing the resulting library files and headers.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 arch/lkl/Makefile        | 35 +++++++++++++++++++++++++++++++++++
 arch/lkl/kernel/Makefile |  3 +++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/lkl/Makefile
 create mode 100644 arch/lkl/kernel/Makefile

diff --git a/arch/lkl/Makefile b/arch/lkl/Makefile
new file mode 100644
index 0000000..7545830
--- /dev/null
+++ b/arch/lkl/Makefile
@@ -0,0 +1,35 @@
+include arch/lkl/auto.conf
+
+KBUILD_CFLAGS += -fno-builtin
+
+ifeq ($(OUTPUT_FORMAT),elf64-x86-64)
+KBUILD_CFLAGS += -fPIC
+endif
+
+LDFLAGS_vmlinux += -r
+LKL_ENTRY_POINTS := lkl_start_kernel lkl_sys_halt lkl_syscall lkl_trigger_irq \
+	lkl_get_free_irq lkl_put_irq
+
+core-y += arch/lkl/kernel/
+
+all: lkl.o
+
+lkl.o: vmlinux
+	$(OBJCOPY) $(foreach sym,$(LKL_ENTRY_POINTS),-G$(prefix)$(sym)) vmlinux lkl.o
+
+install: lkl.o __headers
+	@echo "  INSTALL\t$(INSTALL_PATH)/lib/lkl.o"
+	@cp lkl.o $(INSTALL_PATH)/lib/
+	@arch/lkl/scripts/headers_install.py \
+		$(subst -j,-j$(shell nproc),$(findstring -j,$(MAKEFLAGS))) \
+		$(INSTALL_PATH)/include
+
+archclean:
+	$(Q)$(MAKE) $(clean)=$(boot)
+
+define archhelp
+  echo '  install	- Install library and headers to INSTALL_PATH/{lib,include}'
+endef
+
+
+
diff --git a/arch/lkl/kernel/Makefile b/arch/lkl/kernel/Makefile
new file mode 100644
index 0000000..47036c0
--- /dev/null
+++ b/arch/lkl/kernel/Makefile
@@ -0,0 +1,3 @@
+extra-y := vmlinux.lds
+
+obj-y = setup.o threads.o irq.o time.o syscalls.o misc.o mem.o console.o
-- 
2.1.0
