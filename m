From: dirk.brandewie@gmail.com
Subject: [PATCH 3/4] of/powerpc: Use generic rule to build dtb's
Date: Wed, 22 Dec 2010 11:57:28 -0800
Message-ID: <1293047849-26078-4-git-send-email-dirk.brandewie@gmail.com>
References: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293047849-26078-1-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, mmarek@suse.cz, dirk.brandewie@gmail.com, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Modify arch/powerpc/boot/Makefile to use dtc command in
scripts/Makefile.lib

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/powerpc/boot/Makefile |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index fae8192..96deec6 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -35,7 +35,7 @@ endif
 
 BOOTCFLAGS	+= -I$(obj) -I$(srctree)/$(obj)
 
-DTS_FLAGS	?= -p 1024
+DTC_FLAGS	?= -p 1024
 
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
@@ -332,10 +332,8 @@ $(obj)/treeImage.%: vmlinux $(obj)/%.dtb $(wrapperbits)
 	$(call if_changed,wrap,treeboot-$*,,$(obj)/$*.dtb)
 
 # Rule to build device tree blobs
-DTC = $(objtree)/scripts/dtc/dtc
-
-$(obj)/%.dtb: $(dtstree)/%.dts
-	$(DTC) -O dtb -o $(obj)/$*.dtb -b 0 $(DTS_FLAGS) $(dtstree)/$*.dts
+$(obj)/%.dtb: $(src)/dts/%.dts
+	$(call cmd,dtc)
 
 # If there isn't a platform selected then just strip the vmlinux.
 ifeq (,$(image-y))
-- 
1.7.2.3
