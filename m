Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfBSGWL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 Feb 2019 01:22:11 -0500
From: guoren@kernel.org
Subject: [PATCH] csky: Fixup vdsp&fpu issues in kernel
Date: Tue, 19 Feb 2019 14:22:04 +0800
Message-ID: <1550557324-6354-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, ren_guo@c-sky.com
Message-ID: <20190219062204.kFnWXUqYSxIqX_4-bKGdE02fDPivZJ3azVaOQVPdgsU@z>

From: Guo Ren <ren_guo@c-sky.com>

This fixup is continue to commit 35ff802af1c4 (csky: fixup remove
vdsp implement for kernel.) and in that patch I didn't finish the
job. We must forbid gcc to generate any vdsp & fpu instructions
and remove vdsp asm in memmove.S.

eg: For GCC it's -mcpu=ck860 and For AS it's -Wa,-mcpu=ck860fv

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/Makefile        | 2 +-
 arch/csky/abiv2/memmove.S | 6 +-----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 3607a6e..6b87f6c 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -36,7 +36,7 @@ endif
 
 ifneq ($(CSKYABI),)
 MCPU_STR = $(CPUTYPE)$(FPUEXT)$(VDSPEXT)$(TEEEXT)
-KBUILD_CFLAGS += -mcpu=$(MCPU_STR)
+KBUILD_CFLAGS += -mcpu=$(CPUTYPE) -Wa,-mcpu=$(MCPU_STR)
 KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(MCPU_STR)\"
 KBUILD_CFLAGS += -msoft-float -mdiv
 KBUILD_CFLAGS += -fno-tree-vectorize
diff --git a/arch/csky/abiv2/memmove.S b/arch/csky/abiv2/memmove.S
index b0c42ec..5721e73 100644
--- a/arch/csky/abiv2/memmove.S
+++ b/arch/csky/abiv2/memmove.S
@@ -35,11 +35,7 @@ ENTRY(memmove)
 .L_len_larger_16bytes:
 	subi	r1, 16
 	subi	r0, 16
-#if defined(__CSKY_VDSPV2__)
-	vldx.8	vr0, (r1), r19
-	PRE_BNEZAD (r18)
-	vstx.8	vr0, (r0), r19
-#elif defined(__CK860__)
+#if defined(__CK860__)
 	ldw	r3, (r1, 12)
 	stw	r3, (r0, 12)
 	ldw	r3, (r1, 8)
-- 
2.7.4
