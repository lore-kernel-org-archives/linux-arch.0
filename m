Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:45744 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfH3DoM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 23:44:12 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Date: Fri, 30 Aug 2019 12:43:04 +0900
Message-ID: <20190830034304.24259-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
Message-ID: <20190830034304.qDDKkCJ4ocBYqQHg_wg-017ZGA6a5p54iyKVsVAKpx0@z>

Commit 9012d011660e ("compiler: allow all arches to enable
CONFIG_OPTIMIZE_INLINING") allowed all architectures to enable
this option. A couple of build errors were reported by randconfig,
but all of them have been ironed out.

Towards the goal of removing CONFIG_OPTIMIZE_INLINING entirely
(and it will simplify the 'inline' macro in compiler_types.h),
this commit changes it to always-on option. Going forward, the
compiler will always be allowed to not inline functions marked
'inline'.

This is not a problem for x86 since it has been long used by
arch/x86/configs/{x86_64,i386}_defconfig.

I am keeping the config option just in case any problem crops up for
other architectures.

The code clean-up will be done after confirming this is solid.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 lib/Kconfig.debug | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..e25493811df8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -327,7 +327,7 @@ config HEADERS_CHECK
 	  relevant for userspace, say 'Y'.
 
 config OPTIMIZE_INLINING
-	bool "Allow compiler to uninline functions marked 'inline'"
+	def_bool y
 	help
 	  This option determines if the kernel forces gcc to inline the functions
 	  developers have marked 'inline'. Doing so takes away freedom from gcc to
@@ -338,8 +338,6 @@ config OPTIMIZE_INLINING
 	  decision will become the default in the future. Until then this option
 	  is there to test gcc for this.
 
-	  If unsure, say N.
-
 config DEBUG_SECTION_MISMATCH
 	bool "Enable full Section mismatch analysis"
 	help
-- 
2.17.1
