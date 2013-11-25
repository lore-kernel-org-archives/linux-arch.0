Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:39846 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624Ab3KYIzp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 03:55:45 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 17/24] m32r: Use Kbuild logic to provide <asm/types.h>
Date: Mon, 25 Nov 2013 09:55:27 +0100
Message-ID: <1385369734-24893-18-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Hirokazu Takata <takata@linux-m32r.org>, linux-m32r@ml.linux-m32r.org
Message-ID: <20131125085527.1jsA8Igxba202_NnloCyXkC7LayzA3tMA0eg0wWh_V0@z>

The extra definition for BITS_PER_LONG is also indirectly provided
by <asm-generic/types.h>, via <asm-generic/int-ll64.h> and
<asm/bitsperlong.h>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-m32r@ml.linux-m32r.org
---
 arch/m32r/include/asm/Kbuild  |    1 +
 arch/m32r/include/asm/types.h |   12 ------------
 2 files changed, 1 insertion(+), 12 deletions(-)
 delete mode 100644 arch/m32r/include/asm/types.h

diff --git a/arch/m32r/include/asm/Kbuild b/arch/m32r/include/asm/Kbuild
index e03862db9b75..e1138b819fcc 100644
--- a/arch/m32r/include/asm/Kbuild
+++ b/arch/m32r/include/asm/Kbuild
@@ -5,3 +5,4 @@ generic-y += module.h
 generic-y += sections.h
 generic-y += trace_clock.h
 generic-y += preempt.h
+generic-y += types.h
diff --git a/arch/m32r/include/asm/types.h b/arch/m32r/include/asm/types.h
deleted file mode 100644
index 04a44c6ee34d..000000000000
--- a/arch/m32r/include/asm/types.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef _ASM_M32R_TYPES_H
-#define _ASM_M32R_TYPES_H
-
-#include <uapi/asm/types.h>
-
-/*
- * These aren't exported outside the kernel to avoid name space clashes
- */
-
-#define BITS_PER_LONG 32
-
-#endif /* _ASM_M32R_TYPES_H */
-- 
1.7.9.5

