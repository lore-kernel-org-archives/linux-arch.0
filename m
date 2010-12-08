Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34985 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab0LHPBu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2010 10:01:50 -0500
From: dirk.brandewie@gmail.com
Subject: [PATCH 3/4] of/powerpc: Use generic rule to build dtb's
Date: Wed,  8 Dec 2010 07:01:15 -0800
Message-ID: <42e3c9b9f90431caef87e0b16a24273ce18bc3e5.1291820034.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1291820033.git.dirk.brandewie@gmail.com>
References: <cover.1291820033.git.dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, mmarek@suse.cz, Dirk Brandewie <dirk.brandewie@gmail.com>
Message-ID: <20101208150115.XxE9bdO3WoHQ8axJFVQvYZ5xhHc3OU1lLp-Y41GqIj8@z>

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

