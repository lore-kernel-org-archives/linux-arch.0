Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51921 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab0LHPBw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Dec 2010 10:01:52 -0500
From: dirk.brandewie@gmail.com
Subject: [PATCH 4/4] microblaze/of: Use generic rule to build dtb's
Date: Wed,  8 Dec 2010 07:01:16 -0800
Message-ID: <c6ab00e5766fc510ef6d7b9420f19b4397d6a5e8.1291820034.git.dirk.brandewie@gmail.com>
In-Reply-To: <cover.1291820033.git.dirk.brandewie@gmail.com>
References: <cover.1291820033.git.dirk.brandewie@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, sodaville@linutronix.de, linuxppc-dev@lists.ozlabs.org, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, mmarek@suse.cz, Dirk Brandewie <dirk.brandewie@gmail.com>
Message-ID: <20101208150116.VFQrLABuGOAa0hGoxp1qtk985XpgcLuKumf-v3UgoPw@z>

From: Dirk Brandewie <dirk.brandewie@gmail.com>

Modify arch/powerpc/boot/Makefile to use dtc command in
scripts/Makefile.lib

Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 arch/microblaze/boot/Makefile |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index be01d78..4c4e58e 100644
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
-	$(call if_changed,dtc)
+$(obj)/%.dtb: $(src)/dts/%.dts FORCE
+	$(call cmd,dtc)
 
 clean-files += *.dtb simpleImage.*.unstrip linux.bin.ub
-- 
1.7.2.3

