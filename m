From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 6/6] powerpc: use the new post-link pass to check relocations
Date: Thu, 11 Aug 2016 20:16:20 +1000
Message-ID: <1470910580-18458-7-git-send-email-npiggin@gmail.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

Currently powerpc has to introduce a dependency on its default
build target zImage in order to run a relocation check pass
over the linked vmlinux. This is deficient because the check
is not run if the plain vmlinux target is built, or if one of
the other boot targets is built.

Switch to using the kbuild post-link pass in order to run this
check. In future powerpc will use this to do more complicated
operations, but initially using it for something simple is a
good first step.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig           |  1 +
 arch/powerpc/Makefile          | 11 -----------
 arch/powerpc/Makefile.postlink | 31 +++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/Makefile.postlink

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 927d2ab..74be094 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -85,6 +85,7 @@ config ARCH_HAS_DMA_SET_COHERENT_MASK
 config PPC
 	bool
 	default y
+	select BUILD_ARCH_POSTLINK
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select BINFMT_ELF
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 04a1332..e7e0f5e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -270,17 +270,6 @@ PHONY += $(BOOT_TARGETS1) $(BOOT_TARGETS2)
 
 boot := arch/$(ARCH)/boot
 
-ifeq ($(CONFIG_RELOCATABLE),y)
-quiet_cmd_relocs_check = CALL    $<
-      cmd_relocs_check = $(CONFIG_SHELL) $< "$(OBJDUMP)" "$(obj)/vmlinux"
-
-PHONY += relocs_check
-relocs_check: arch/powerpc/relocs_check.sh vmlinux
-	$(call cmd,relocs_check)
-
-zImage: relocs_check
-endif
-
 $(BOOT_TARGETS1): vmlinux
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 $(BOOT_TARGETS2): vmlinux
diff --git a/arch/powerpc/Makefile.postlink b/arch/powerpc/Makefile.postlink
new file mode 100644
index 0000000..67a0864
--- /dev/null
+++ b/arch/powerpc/Makefile.postlink
@@ -0,0 +1,31 @@
+# ===========================================================================
+# Post-link powerpc pass
+# ===========================================================================
+#
+# 1. Check that vmlinux relocations look sane
+
+PHONY := __archpost
+__archpost:
+
+include include/config/auto.conf
+include scripts/Kbuild.include
+
+quiet_cmd_relocs_check = CHKREL  $@
+      cmd_relocs_check = $(CONFIG_SHELL) arch/powerpc/relocs_check.sh "$(OBJDUMP)" "$@"
+
+# Prevent complainints about nothing to be done
+vmlinux: FORCE
+	@echo -n
+ifeq ($(CONFIG_RELOCATABLE),y)
+	$(call if_changed,relocs_check)
+endif
+
+%.ko: FORCE
+	@echo -n
+
+
+PHONY += FORCE
+
+FORCE:
+
+.PHONY: $(PHONY)
-- 
2.8.1

