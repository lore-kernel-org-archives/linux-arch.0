Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:43716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbfG2Mym (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 29 Jul 2019 08:54:42 -0400
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] arm64: vdso: Fix Makefile regression
Date: Mon, 29 Jul 2019 13:54:21 +0100
Message-ID: <20190729125421.32482-1-vincenzo.frascino@arm.com>
In-Reply-To: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
References: <CAGnkfhyT=2kPsiUy-V=aCA_s-C4BXgD++hAZ9ii1h0p94mMVQA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, tglx@linutronix.de, salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com, linux@rasmusvillemoes.dk, sthotton@marvell.com, andre.przywara@arm.com, luto@kernel.org, Matteo Croce <mcroce@redhat.com>
Message-ID: <20190729125421.gQlSl6yjHBnrvCuCMvok2GVI7_SC-UCHAbni27jgEf0@z>

Using an old .config in combination with "make oldconfig" can cause
an incorrect detection of the compat compiler:

$ grep CROSS_COMPILE_COMPAT .config
CONFIG_CROSS_COMPILE_COMPAT_VDSO=""

$ make oldconfig && make
arch/arm64/Makefile:58: gcc not found, check CROSS_COMPILE_COMPAT.
Stop.

Accordingly to the section 7.2 of the GNU Make manual "Syntax of
Conditionals", "When the value results from complex expansions of
variables and functions, expansions you would consider empty may
actually contain whitespace characters and thus are not seen as
empty. However, you can use the strip function to avoid interpreting
whitespace as a non-empty value."

Fix the issue adding strip to the CROSS_COMPILE_COMPAT string
evaluation.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index bb1f1dbb34e8..61de992bbea3 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -52,7 +52,7 @@ ifeq ($(CONFIG_GENERIC_COMPAT_VDSO), y)
 
   ifeq ($(CONFIG_CC_IS_CLANG), y)
     $(warning CROSS_COMPILE_COMPAT is clang, the compat vDSO will not be built)
-  else ifeq ($(CROSS_COMPILE_COMPAT),)
+  else ifeq ($(strip $(CROSS_COMPILE_COMPAT)),)
     $(warning CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built)
   else ifeq ($(shell which $(CROSS_COMPILE_COMPAT)gcc 2> /dev/null),)
     $(error $(CROSS_COMPILE_COMPAT)gcc not found, check CROSS_COMPILE_COMPAT)
-- 
2.22.0
