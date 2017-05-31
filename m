From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] asm-generic: simd: allow SIMD in process context with BH disabled
Date: Wed, 31 May 2017 12:57:01 +0000
Message-ID: <20170531125701.20717-1-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:35310 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdEaM5L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 May 2017 08:57:11 -0400
Received: by mail-wm0-f47.google.com with SMTP id b84so118128197wmh.0
        for <linux-arch@vger.kernel.org>; Wed, 31 May 2017 05:57:10 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, dave.martin@arm.com, Jason@zx2c4.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

asm-generic supplies a header asm/simd.h which exports a single function
may_use_simd(), which conveys whether the current context allows the SIMD
register file or instructions to be used.

This header is included by crypto code shared between x86 and ARM/arm64,
and which offloads SIMD processing to process context if required. The
generic asm/simd.h is shared between ARM and arm64 at the moment, while
x86 has its own implementation.

On arm64, we currently mostly ignore may_use_simd(), because arm64 allows
kernel mode NEON in any context. However, this is due to change shortly
when support for SVE is merged, at which point we will introduce an arm64
specific implementation of asm/simd.h as well.

That leaves ARM, which only allows kernel mode NEON in process context,
which makes the current generic implementation of may_use_simd() seem
appropriate. However, given that in_interrupt() will return true when
running in process context with bottom halves disabled, we may end up
falling back to less optimized code unnecessarily, given that kernel
mode NEON is perfectly usable in that case.

So redefine may_use_simd() to disallow SIMD only when running in hardirq
or softirq context.

While we're at it, add some missing header file decorations such as
a license header and include guards.

Reported-by: "Jason A. Donenfeld" <Jason@zx2c4.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/asm-generic/simd.h | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/simd.h b/include/asm-generic/simd.h
index f57eb7b5c23b..a3e5ebe6b2b2 100644
--- a/include/asm-generic/simd.h
+++ b/include/asm-generic/simd.h
@@ -1,14 +1,31 @@
+/*
+ * Copyright (C) 2013 - 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
 
-#include <linux/hardirq.h>
+#ifndef __ASM_SIMD_H
+#define __ASM_SIMD_H
+
+#include <linux/types.h>
+#include <linux/preempt.h>
 
 /*
  * may_use_simd - whether it is allowable at this time to issue SIMD
  *                instructions or access the SIMD register file
  *
  * As architectures typically don't preserve the SIMD register file when
- * taking an interrupt, !in_interrupt() should be a reasonable default.
+ * taking an interrupt, it is reasonable to define the default behavior
+ * of 'may_use_simd()' to be 'SIMD is only allowed when not handling an
+ * IRQ or softIRQ'. Since 'in_interrupt()' will also return true when
+ * running in process context with bottom halves disabled, we have to
+ * spell out that condition as shown.
  */
 static __must_check inline bool may_use_simd(void)
 {
-	return !in_interrupt();
+	return !in_irq() && !in_serving_softirq();
 }
+
+#endif
-- 
2.9.3
