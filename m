Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41495 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934710AbeEINAU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 09:00:20 -0400
From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 2/4] kbuild: LD_DEAD_CODE_DATA_ELIMINATION no -ffunction-sections/-fdata-sections for module build
Date: Wed,  9 May 2018 22:59:59 +1000
Message-ID: <20180509130001.24276-3-npiggin@gmail.com>
In-Reply-To: <20180509130001.24276-1-npiggin@gmail.com>
References: <20180509130001.24276-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20180509125959.dJ_TSlEI33Gwkrab-paW-ltrgeaoukQvCYJjjZHX2Vk@z>

Modules do not tend to cope with -ffunction-sections, even though they
do not link with -gc-sections. It may be possible for unused symbols to
be trimmed from modules, but in general that would take much more work
in architecture module linker scripts.

For now, enable these only for kernel build.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 619a85ad716b..9dcbfb353f81 100644
--- a/Makefile
+++ b/Makefile
@@ -799,8 +799,8 @@ KBUILD_CFLAGS += $(call cc-option, -fno-inline-functions-called-once)
 endif
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
-KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
-KBUILD_CFLAGS	+= $(call cc-option,-fdata-sections,)
+KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-ffunction-sections,)
+KBUILD_CFLAGS_KERNEL	+= $(call cc-option,-fdata-sections,)
 endif
 
 # arch Makefile may override CC so keep this after arch Makefile is included
-- 
2.17.0
