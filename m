Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38110 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758260Ab0KPWmX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Nov 2010 17:42:23 -0500
From: dirk.brandewie@gmail.com
Subject: [PATCH 5/5] of/microblaze: Move build to use generic dts->dtb rule
Date: Tue, 16 Nov 2010 14:41:40 -0800
Message-ID: <7828dfd67fafcc2bb41e5bde40ac2ed7ef429142.1289943240.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1289943240.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: devicetree-discuss@lists.ozlabs.org
Cc: sodaville@linutronix.de, arjan@linux.intel.com, dirk.brandewie@gmail.com, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20101116224140.UIs5HXi8eyxy7sxDXIm2Fc4WPBTN3uzGUz1SC-1wSP4@z>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

This patch changes arch/microblaze/boot/Makefile to use the generic
rule build the device tree blobs in scripts/Makefile.lib

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/microblaze/boot/Makefile |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index be01d78..4fda765 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -10,9 +10,6 @@ targets := linux.bin linux.bin.gz simpleImage.%
 
 OBJCOPYFLAGS := -O binary
 
-# Where the DTS files live
-dtstree         := $(srctree)/$(src)/dts
-
 # Ensure system.dtb exists
 $(obj)/linked_dtb.o: $(obj)/system.dtb
 
@@ -51,14 +48,6 @@ $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,strip)
 	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
-# Rule to build device tree blobs
-DTC = $(objtree)/scripts/dtc/dtc
-
-# Rule to build device tree blobs
-quiet_cmd_dtc = DTC     $@
-	cmd_dtc = $(DTC) -O dtb -o $(obj)/$*.dtb -b 0 -p 1024 $(dtstree)/$*.dts
-
-$(obj)/%.dtb: $(dtstree)/%.dts FORCE
-	$(call if_changed,dtc)
+DTS_FLAGS := -p 1024
 
 clean-files += *.dtb simpleImage.*.unstrip linux.bin.ub
-- 
1.7.2.3

