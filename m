Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39661 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbeJ3UxJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Oct 2018 16:53:09 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V2 2/2] csky: use common dtb build rules
Date: Tue, 30 Oct 2018 19:59:27 +0800
Message-Id: <caa1cb6121ed7f1e0e4617811561267cb97dc2e5.1540900718.git.ren_guo@c-sky.com>
In-Reply-To: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540900718.git.ren_guo@c-sky.com>
References: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540900718.git.ren_guo@c-sky.com>
In-Reply-To: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540900718.git.ren_guo@c-sky.com>
References: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540900718.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: robh@kernel.org, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>

Remove the Kbuild rules in arch/csky and use common dtb build rules.

This modification is based on:

commit 37c8a5fafa3b ("kbuild: consolidate Devicetree dtb build rules")

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Makefile | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 91f7222..c639fc1 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -69,20 +69,11 @@ core-y += $(boot)/dts/
 
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
-- 
2.7.4
