From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 3/6] kbuild: add arch specific post-link pass
Date: Thu, 11 Aug 2016 20:16:17 +1000
Message-ID: <1470910580-18458-4-git-send-email-npiggin@gmail.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36713 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcHKKRG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Aug 2016 06:17:06 -0400
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

Add an option for architectures to pass over modules after they are
linked. powerpc will use this to check linker relocations for sanity,
and possibly to fix up alternate instruction patch relocations.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1,
- Switched to a more flexible arch makefile invocation.
- Provide a powerpc patch to use it to help existing build issue
  (rather than only justification being out-of-tree patch).

 Documentation/kbuild/makefiles.txt | 10 ++++++++++
 arch/Kconfig                       |  7 +++++++
 scripts/Makefile.modpost           |  3 +++
 scripts/link-vmlinux.sh            |  4 ++++
 4 files changed, 24 insertions(+)

diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
index 385a5ef..8581e38 100644
--- a/Documentation/kbuild/makefiles.txt
+++ b/Documentation/kbuild/makefiles.txt
@@ -41,6 +41,7 @@ This document describes the Linux kernel Makefiles.
 	   --- 6.8 Custom kbuild commands
 	   --- 6.9 Preprocessing linker scripts
 	   --- 6.10 Generic header files
+	   --- 6.11 Post-link pass
 
 	=== 7 Kbuild syntax for exported headers
 		--- 7.1 header-y
@@ -1237,6 +1238,15 @@ When kbuild executes, the following steps are followed (roughly):
 	to list the file in the Kbuild file.
 	See "7.4 generic-y" for further info on syntax etc.
 
+--- 6.11 Post-link pass
+
+	CONFIG_BUILD_ARCH_POSTLINK can be selected in order to have
+	arch/?/Makefile.postlink invoked on vmlinux and module.ko
+	files after final link.
+
+	For example, powerpc uses this to check relocations on the
+	linked vmlinux file.
+
 === 7 Kbuild syntax for exported headers
 
 The kernel includes a set of headers that is exported to userspace.
diff --git a/arch/Kconfig b/arch/Kconfig
index fc3f9e1..3a36ea8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -461,6 +461,13 @@ config CC_STACKPROTECTOR_STRONG
 
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
index 1366a94..1acaa20 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -123,6 +123,9 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 
 $(modules): %.ko :%.o %.mod.o FORCE
 	$(call if_changed,ld_ko_o)
+ifdef CONFIG_BUILD_ARCH_POSTLINK
+	$(Q)$(MAKE) -f $(srctree)/arch/$(SRCARCH)/Makefile.postlink $@
+endif
 
 targets += $(modules)
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index f742c65..ec84b33 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -279,6 +279,10 @@ fi
 info LD vmlinux
 vmlinux_link "${kallsymso}" vmlinux
 
+if [ -n "${CONFIG_BUILD_ARCH_POSTLINK}" ]; then
+	${MAKE} -f ${srctree}/arch/${SRCARCH}/Makefile.postlink vmlinux
+fi
+
 if [ -n "${CONFIG_BUILDTIME_EXTABLE_SORT}" ]; then
 	info SORTEX vmlinux
 	sortextable vmlinux
-- 
2.8.1
