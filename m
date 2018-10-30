Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:56592 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726468AbeJ3RoG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Oct 2018 13:44:06 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH] csky: remove Devicetree dtb Kbuild rules
Date: Tue, 30 Oct 2018 16:51:13 +0800
Message-Id: <1540889473-13871-1-git-send-email-ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robh@kernel.org, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

This modification is based on commit 37c8a5fafa3b to remove the dtb
Kbuild rules in arch/csky and use common dtb build rules. Also remove
the builtin-dtb implementation in arch/csky.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig.debug     | 10 +---------
 arch/csky/Makefile          | 13 +------------
 arch/csky/boot/dts/Makefile |  7 -------
 3 files changed, 2 insertions(+), 28 deletions(-)

diff --git a/arch/csky/Kconfig.debug b/arch/csky/Kconfig.debug
index 48cf6ff..22a162cd 100644
--- a/arch/csky/Kconfig.debug
+++ b/arch/csky/Kconfig.debug
@@ -1,9 +1 @@
-menu "C-SKY Debug Options"
-config CSKY_BUILTIN_DTB
-	string "Use kernel builtin dtb"
-	help
-	  User could define the dtb instead of the one which is passed from
-	  bootloader.
-	  Sometimes for debug, we want to use a built-in dtb and then we needn't
-	  modify bootloader at all.
-endmenu
+# dummy file, do not delete
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 67a4ae1..c639fc1 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -65,26 +65,15 @@ libs-y += arch/csky/lib/ \
 	$(shell $(CC) $(KBUILD_CFLAGS) $(KCFLAGS) -print-libgcc-file-name)
 
 boot := arch/csky/boot
-ifneq '$(CONFIG_CSKY_BUILTIN_DTB)' '""'
 core-y += $(boot)/dts/
-endif
 
 all: zImage
 
-
-dtbs: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts
-
-%.dtb %.dtb.S %.dtb.o: scripts
-	$(Q)$(MAKE) $(build)=$(boot)/dts $(boot)/dts/$@
-
-zImage Image uImage: vmlinux dtbs
+zImage Image uImage: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-	$(Q)$(MAKE) $(clean)=$(boot)/dts
-	rm -rf arch/csky/include/generated
 
 define archhelp
   echo  '* zImage       - Compressed kernel image (arch/$(ARCH)/boot/zImage)'
diff --git a/arch/csky/boot/dts/Makefile b/arch/csky/boot/dts/Makefile
index 305e81a..19a7f02 100644
--- a/arch/csky/boot/dts/Makefile
+++ b/arch/csky/boot/dts/Makefile
@@ -1,13 +1,6 @@
 dtstree	:= $(srctree)/$(src)
 
-ifneq '$(CONFIG_CSKY_BUILTIN_DTB)' '""'
-builtindtb-y := $(patsubst "%",%,$(CONFIG_CSKY_BUILTIN_DTB))
-dtb-y += $(builtindtb-y).dtb
-obj-y += $(builtindtb-y).dtb.o
-.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
-else
 dtb-y := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-endif
 
 always += $(dtb-y)
 clean-files += *.dtb *.dtb.S
-- 
2.7.4
