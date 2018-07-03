Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:46643 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753643AbeGCBYk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Jul 2018 21:24:40 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/3] arm64: add endianness option to LDFLAGS instead of LD
Date: Tue,  3 Jul 2018 10:22:00 +0900
Message-ID: <1530580921-23340-3-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
Message-ID: <20180703012200.IS_wwxB-RDtTu77D8KUglNptxYBcGyw2wOYb8PAsIIE@z>

With the recent syntax extension, Kconfig is now able to evaluate the
compiler / toolchain capability.

However, accumulating flags to 'LD' is not compatible with the way
it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
between Makefile and Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4527226..8f73da3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -60,15 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__AARCH64EB__
 AS		+= -EB
-LD		+= -EB
-LDFLAGS		+= -maarch64linuxb
+LDFLAGS		+= -EB -maarch64linuxb
 UTS_MACHINE	:= aarch64_be
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__AARCH64EL__
 AS		+= -EL
-LD		+= -EL
-LDFLAGS		+= -maarch64linux
+LDFLAGS		+= -EL -maarch64linux
 UTS_MACHINE	:= aarch64
 endif
 
-- 
2.7.4
