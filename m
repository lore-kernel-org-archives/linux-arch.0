Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1679 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751646Ab3HUI0f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Aug 2013 04:26:35 -0400
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/8] sh: Do not use SUBARCH
Date: Wed, 21 Aug 2013 10:19:29 +0200
Message-ID: <1377073172-3662-6-git-send-email-richard@nod.at>
In-Reply-To: <1377073172-3662-1-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
Message-ID: <20130821081929.tIggQYtuuYnTR3OajqbRDviHWLwLdoRT9-fJLpCGkF8@z>

Forces the user to specify CROSS_COMPILE at compile time instead
of automatically selecting more or less randomly a cross compiler.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/sh/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index aed701c..8772d11 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -9,11 +9,6 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
 #
-ifneq ($(SUBARCH),$(ARCH))
-  ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, $(UTS_MACHINE)-linux-  $(UTS_MACHINE)-linux-gnu-  $(UTS_MACHINE)-unknown-linux-gnu-)
-  endif
-endif
 
 isa-y					:= any
 isa-$(CONFIG_SH_DSP)			:= sh
-- 
1.8.1.4

