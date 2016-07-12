From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] arm64: localise Image objcopy flags
Date: Tue, 12 Jul 2016 16:28:01 +0100
Message-ID: <1468337282-14527-2-git-send-email-mark.rutland@arm.com>
References: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60169 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbcGLP2S (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Jul 2016 11:28:18 -0400
In-Reply-To: <1468337282-14527-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, catalin.marinas@arm.com, keescook@chromium.org, labbott@redhat.com, linux@armlinux.org.uk, mark.rutland@arm.com, will.deacon@arm.com

We currently define OBJCOPYFLAGS in the top-level arm64 Makefile, and
thus these flags will be passed to all uses of objcopy, kernel-wide, for
which they are not explicitly overridden. The flags we set are intended
for converting vmlinux (and ELF) into Image (a raw binary), and thus the
flags chosen are problematic for some other uses which do not expect a
raw binary result, e.g. the upcoming lkdtm rodata test:

  http://www.openwall.com/lists/kernel-hardening/2016/06/08/2

This patch localises the objcopy flags such that they are only used for
the vmlinux -> Image conversion.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Makefile      | 1 -
 arch/arm64/boot/Makefile | 2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 7085e32..af6d2d2 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -12,7 +12,6 @@
 
 LDFLAGS_vmlinux	:=-p --no-undefined -X
 CPPFLAGS_vmlinux.lds = -DTEXT_OFFSET=$(TEXT_OFFSET)
-OBJCOPYFLAGS	:=-O binary -R .note -R .note.gnu.build-id -R .comment -S
 GZFLAGS		:=-9
 
 ifneq ($(CONFIG_RELOCATABLE),)
diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
index 305c552..1f012c5 100644
--- a/arch/arm64/boot/Makefile
+++ b/arch/arm64/boot/Makefile
@@ -14,6 +14,8 @@
 # Based on the ia64 boot/Makefile.
 #
 
+OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
+
 targets := Image Image.gz
 
 $(obj)/Image: vmlinux FORCE
-- 
1.9.1
