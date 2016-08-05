From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/5] kbuild: add arch specific post-module-link pass
Date: Fri,  5 Aug 2016 22:12:01 +1000
Message-ID: <1470399123-8455-4-git-send-email-npiggin@gmail.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>
List-Id: linux-arch.vger.kernel.org

Add an option for architectures to pass over modules after they are
linked. powerpc will use this to fix up alternate instruction patch
relocations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/kbuild/makefiles.txt | 6 ++++++
 Makefile                           | 1 +
 scripts/Makefile.modpost           | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 13f888a..f6c065b 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -952,6 +952,12 @@ When kbuild executes, the following steps are followed (roughly):
 	$(KBUILD_ARFLAGS) set by the top level Makefile to "D" (deterministic
 	mode) if this option is supported by $(AR).
 
+    KBUILD_MODPOST_TOOL   Arch-specific command to run after module link
+
+        $(KBUILD_MODPOST_TOOL) is used to add an arch-specific pass over
+        modules after their final link. E.g., powerpc uses this to adjust
+        relative branches of "alternate code patching" sections.
+
     ARCH_CPPFLAGS, ARCH_AFLAGS, ARCH_CFLAGS   Overrides the kbuild defaults
 
 	These variables are appended to the KBUILD_CPPFLAGS,
diff --git a/Makefile b/Makefile
index d5ef31a..99ab8eb 100644
--- a/Makefile
+++ b/Makefile
@@ -421,6 +421,7 @@ export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
 export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
 export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
 export KBUILD_ARFLAGS
+export KBUILD_MODPOST_TOOL
 
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 1366a94..19f8481 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -121,8 +121,16 @@ quiet_cmd_ld_ko_o = LD [M]  $@
                              $(KBUILD_LDFLAGS_MODULE) $(LDFLAGS_MODULE) \
                              -o $@ $(filter-out FORCE,$^)
 
+ifdef KBUILD_MODPOST_TOOL
+quiet_cmd_arch_modpost = ARCH    $@
+      cmd_arch_modpost = $(KBUILD_MODPOST_TOOL) $@
+endif
+
 $(modules): %.ko :%.o %.mod.o FORCE
 	$(call if_changed,ld_ko_o)
+ifdef KBUILD_MODPOST_TOOL
+	$(call if_changed,arch_modpost)
+endif
 
 targets += $(modules)
 
-- 
2.8.1

