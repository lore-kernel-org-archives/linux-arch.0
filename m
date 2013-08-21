From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 7/8] unicore32: Do not use SUBARCH
Date: Wed, 21 Aug 2013 10:19:31 +0200
Message-ID: <1377073172-3662-8-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-arch@vger.kernel.org
Cc: mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-Id: linux-arch.vger.kernel.org

Forces the user to specify CROSS_COMPILE at compile time instead
of automatically selecting more or less randomly a cross compiler

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/unicore32/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/unicore32/Makefile b/arch/unicore32/Makefile
index b6f5c4c..fae00c8 100644
--- a/arch/unicore32/Makefile
+++ b/arch/unicore32/Makefile
@@ -10,11 +10,6 @@
 #
 # Copyright (C) 2002~2010 by Guan Xue-tao
 #
-ifneq ($(SUBARCH),$(ARCH))
-	ifeq ($(CROSS_COMPILE),)
-		CROSS_COMPILE := $(call cc-cross-prefix, unicore32-linux-)
-	endif
-endif
 
 LDFLAGS_vmlinux		:= -p --no-undefined -X
 
-- 
1.8.1.4
