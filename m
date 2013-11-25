Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:39850 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab3KYIzp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 03:55:45 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 19/24] sh: Replace <uapi/asm/types.h> by <asm-generic/int-ll64.h>
Date: Mon, 25 Nov 2013 09:55:29 +0100
Message-ID: <1385369734-24893-20-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org
Message-ID: <20131125085529.sIC99ivHbmghhzb_9fZmXSoOjA4QK60PUVfr3yS9060@z>

As arch/sh/include/uapi/asm/types.h doesn't exist, sh doesn't provide
any sh-specific uapi definitions, and it can just include
<asm-generic/int-ll64.h>, like most other architectures.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/types.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/types.h b/arch/sh/include/asm/types.h
index 6a31053fa5e3..062324be5cd6 100644
--- a/arch/sh/include/asm/types.h
+++ b/arch/sh/include/asm/types.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_SH_TYPES_H
 #define __ASM_SH_TYPES_H
 
-#include <uapi/asm/types.h>
+#include <asm-generic/int-ll64.h>
 
 /*
  * These aren't exported outside the kernel to avoid name space clashes
-- 
1.7.9.5

