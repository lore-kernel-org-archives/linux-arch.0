From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/3] kbuild: add arch specific post-link Makefile
Date: Wed, 24 Aug 2016 22:29:21 +1000
Message-ID: <1472041761-14414-4-git-send-email-npiggin@gmail.com>
References: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1472041761-14414-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>, linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

Allow architectures to create arch/xxx/Makefile.postlink with targets
for vmlinux, modules.ko, and clean, which will be invoked after final
linking of vmlinux and modules.

powerpc will use this to check vmlinux linker relocations for sanity,
and may use it to fix up alternate instruction patch branch addresses.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
Since v1,
- Switched to a more flexible arch makefile invocation.
- Provide a powerpc patch to use it to help existing build issue
  (rather than only justification being out-of-tree patch).

Since v2
- Depend on existence of Makefile.modpost, rather than config option.
- Add a clean target
- Move post-vmlinux invocation into Makefile rather than link-vmlinux.sh
- Arch postlink must always be done after final link, not on an if_changed
  basis, because the vmlinux itself is not a dependency.

 Documentation/kbuild/makefiles.txt | 16 ++++++++++++++++
 Makefile                           | 10 +++++++---
 arch/Kconfig                       |  7 +++++++
 scripts/Makefile.modpost           | 14 +++++++++-----
 4 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 13f888a..16841a7 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -41,6 +41,7 @@ This document describes the Linux kernel Makefiles.
 	   --- 6.8 Custom kbuild commands
 	   --- 6.9 Preprocessing linker scripts
 	   --- 6.10 Generic header files
+	   --- 6.11 Post-link pass
 
 	=== 7 Kbuild syntax for exported headers
 		--- 7.1 header-y
@@ -1236,6 +1237,21 @@ When kbuild executes, the following steps are followed (roughly):
 	to list the file in the Kbuild file.
 	See "7.4 generic-y" for further info on syntax etc.
 
+--- 6.11 Post-link pass
+
+	If the file arch/xxx/Makefile.postlink exists, this makefile
+	will be invoked for post-link objects (vmlinux and modules.ko)
+	for architectures to run post-link passes on. Must also handle
+	the clean target.
+
+	This pass runs after kallsyms generation. If the architecture
+	needs to modify symbol locations, rather than manipulate the
+	kallsyms, it may be easier to add another postlink target for
+	.tmp_vmlinux? targets to be called from link-vmlinux.sh.
+
+	For example, powerpc uses this to check relocation sanity of
+	the linked vmlinux file.
+
 === 7 Kbuild syntax for exported headers
 
 The kernel includes a set of headers that is exported to userspace.
diff --git a/Makefile b/Makefile
index b29c6c0..9c6992f 100644
--- a/Makefile
+++ b/Makefile
@@ -967,9 +967,12 @@ endif
 include/generated/autoksyms.h: FORCE
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh true
 
-# Final link of vmlinux
-      cmd_link-vmlinux = $(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux)
-quiet_cmd_link-vmlinux = LINK    $@
+ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
+
+# Final link of vmlinux with optional arch pass after final link
+    cmd_link-vmlinux =                                                 \
+	$(CONFIG_SHELL) $< $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) ;       \
+	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 vmlinux: scripts/link-vmlinux.sh vmlinux_prereq $(vmlinux-deps) FORCE
 	+$(call if_changed,link-vmlinux)
@@ -1268,6 +1271,7 @@ $(clean-dirs):
 
 vmlinuxclean:
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/link-vmlinux.sh clean
+	$(Q)$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) clean)
 
 clean: archclean vmlinuxclean
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 94138e5..c8a1677 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -424,6 +424,13 @@ config CC_STACKPROTECTOR_STRONG
 
 endchoice
 
+config BUILD_ARCH_POSTLINK
+	bool
+	help
+	  Select this if the architecture wants to have a Makefile invoked
+	  on modules and vmlinux after they are linked. The architecture
+	  must provide arch/?/Makefile.postlink
+
 config THIN_ARCHIVES
 	bool
 	help
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 1366a94..16923ba 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -115,14 +115,18 @@ $(modules:.ko=.mod.o): %.mod.o: %.mod.c FORCE
 
 targets += $(modules:.ko=.mod.o)
 
-# Step 6), final link of the modules
+ARCH_POSTLINK := $(wildcard $(srctree)/arch/$(SRCARCH)/Makefile.postlink)
+
+# Step 6), final link of the modules with optional arch pass after final link
 quiet_cmd_ld_ko_o = LD [M]  $@
-      cmd_ld_ko_o = $(LD) -r $(LDFLAGS)                                 \
-                             $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) \
-                             -o $@ $(filter-out FORCE,$^)
+      cmd_ld_ko_o =                                                     \
+	$(LD) -r $(LDFLAGS)                                             \
+                 $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE)             \
+                 -o $@ $(filter-out FORCE,$^) ;                         \
+	$(if $(ARCH_POSTLINK), $(MAKE) -f $(ARCH_POSTLINK) $@, true)
 
 $(modules): %.ko :%.o %.mod.o FORCE
-	$(call if_changed,ld_ko_o)
+	+$(call if_changed,ld_ko_o)
 
 targets += $(modules)
 
-- 
2.8.1

