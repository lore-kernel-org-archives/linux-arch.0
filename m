From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/8] m68k: Do not use SUBARCH
Date: Wed, 21 Aug 2013 10:19:28 +0200
Message-ID: <1377073172-3662-5-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-Id: linux-arch.vger.kernel.org

Forces the user to specify CROSS_COMPILE at compile time instead
of automatically selecting more or less randomly a cross compiler.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/m68k/Makefile | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index 7f7830f..3bd6355 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -16,13 +16,6 @@
 
 KBUILD_DEFCONFIG := multi_defconfig
 
-ifneq ($(SUBARCH),$(ARCH))
-	ifeq ($(CROSS_COMPILE),)
-		CROSS_COMPILE := $(call cc-cross-prefix, \
-			m68k-linux-gnu- m68k-linux- m68k-unknown-linux-gnu-)
-	endif
-endif
-
 #
 #	Enable processor type. Ordering of these is important - we want to
 #	use the minimum processor type of the range we support. The logic
-- 
1.8.1.4
