From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] arm: localise objcopy flags
Date: Tue, 12 Jul 2016 16:28:02 +0100
Message-ID: <1468337282-14527-3-git-send-email-mark.rutland@arm.com>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60175 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754483AbcGLP2U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Jul 2016 11:28:20 -0400
In-Reply-To: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, catalin.marinas@arm.com, keescook@chromium.org, labbott@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, will.deacon@arm.com

We currently define OBJCOPYFLAGS in the top-level arm Makefile, and thus
these flags will be passed to all uses of objcopy, kernel-wide, for
which they are not explicitly overridden. The flags we set are intended
for converting a few ELF files into raw binaries, and thus the flags
chosen are problematic for some other uses which do not expect a raw
binary result, e.g. the upcoming lkdtm rodata test:

  http://www.openwall.com/lists/kernel-hardening/2016/06/08/2

This patch localises the objcopy flags such that they are only used for
the cases we require them for today.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/Makefile      | 1 -
 arch/arm/boot/Makefile | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 274e8a6..2ef60d3 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -23,7 +23,6 @@ ifeq ($(CONFIG_ARM_MODULE_PLTS),y)
 LDFLAGS_MODULE	+= -T $(srctree)/arch/arm/kernel/module.lds
 endif
 
-OBJCOPYFLAGS	:=-O binary -R .comment -S
 GZFLAGS		:=-9
 #KBUILD_CFLAGS	+=-pipe
 
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index 5be33a2..706efd6 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -11,6 +11,8 @@
 # Copyright (C) 1995-2002 Russell King
 #
 
+OBJCOPYFLAGS	:=-O binary -R .comment -S
+
 ifneq ($(MACHINE),)
 include $(MACHINE)/Makefile.boot
 endif
-- 
1.9.1
