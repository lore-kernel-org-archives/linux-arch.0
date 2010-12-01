From: dirk.brandewie@gmail.com
Subject: [PATCH 4/4] microblaze/of: Use generic rule to build dtb's
Date: Wed,  1 Dec 2010 11:41:35 -0800
Message-ID: <166d47e864aa8a41b2aa0f9ebc42d9b60afba21f.1291231792.git.dirk.brandewie@gmail.com>
References: <cover.1289943240.git.dirk.brandewie@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45342 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756576Ab0LATmm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Dec 2010 14:42:42 -0500
In-Reply-To: <cover.1289943240.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1291231792.git.dirk.brandewie@gmail.com>
References: <cover.1291231792.git.dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-serial@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, mmarek@suse.cz, Dirk Brandewie <dirk.brandewie@gmail.com>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Modify arch/powerpc/boot/Makefile to use dtc command in
scripts/Makefile.lib

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/microblaze/boot/Makefile |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index be01d78..52430e5 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -10,9 +10,6 @@ targets := linux.bin linux.bin.gz simpleImage.%
 
 OBJCOPYFLAGS := -O binary
 
-# Where the DTS files live
-dtstree         := $(srctree)/$(src)/dts
-
 # Ensure system.dtb exists
 $(obj)/linked_dtb.o: $(obj)/system.dtb
 
@@ -51,14 +48,11 @@ $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,strip)
 	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
 
-# Rule to build device tree blobs
-DTC = $(objtree)/scripts/dtc/dtc
 
 # Rule to build device tree blobs
-quiet_cmd_dtc = DTC     $@
-	cmd_dtc = $(DTC) -O dtb -o $(obj)/$*.dtb -b 0 -p 1024 $(dtstree)/$*.dts
+DTC_FLAGS := -p 1024
 
-$(obj)/%.dtb: $(dtstree)/%.dts FORCE
+$(obj)/%.dtb: $(src)/dts/%.dts FORCE
 	$(call if_changed,dtc)
 
 clean-files += *.dtb simpleImage.*.unstrip linux.bin.ub
-- 
1.7.2.3
