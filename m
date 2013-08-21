Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1684 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751498Ab3HUI0g (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Aug 2013 04:26:36 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/8] mips: Do not use SUBARCH
Date: Wed, 21 Aug 2013 10:19:30 +0200
Message-ID: <1377073172-3662-7-git-send-email-richard@nod.at>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
Message-ID: <20130821081930.rZf5DxbJxlsbMhr8GabrForSlINn8F1avvQG7aGxKhE@z>

Forces the user to specify CROSS_COMPILE at compile time instead
of automatically selecting more or less randomly a cross compiler.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/mips/Makefile | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 37f9ef3..514fea6 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -42,12 +42,6 @@ tool-archpref		= $(64bit-tool-archpref)
 UTS_MACHINE		:= mips64
 endif
 
-ifneq ($(SUBARCH),$(ARCH))
-  ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
-  endif
-endif
-
 ifdef CONFIG_FUNCTION_GRAPH_TRACER
   ifndef KBUILD_MCOUNT_RA_ADDRESS
     ifeq ($(call cc-option-yn,-mmcount-ra-address), y)
-- 
1.8.1.4

