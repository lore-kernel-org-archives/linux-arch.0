Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gerard.telenet-ops.be ([195.130.132.48]:39716 "EHLO
	gerard.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab3KYIzn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2013 03:55:43 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 01/24] uapi: Add missing _UAPI prefix to <asm-generic/types.h> include guard
Date: Mon, 25 Nov 2013 09:55:11 +0100
Message-ID: <1385369734-24893-2-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
References: <1385369734-24893-1-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20131125085511.6fZNj6x7VNRtX0FuHNgtWs2Ii6OKtA4ecFi__ySlNec@z>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 include/uapi/asm-generic/types.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/asm-generic/types.h b/include/uapi/asm-generic/types.h
index a3877926b0d4..e10cd6a87e46 100644
--- a/include/uapi/asm-generic/types.h
+++ b/include/uapi/asm-generic/types.h
@@ -1,8 +1,8 @@
-#ifndef _ASM_GENERIC_TYPES_H
-#define _ASM_GENERIC_TYPES_H
+#ifndef _UAPI_ASM_GENERIC_TYPES_H
+#define _UAPI_ASM_GENERIC_TYPES_H
 /*
  * int-ll64 is used everywhere now.
  */
 #include <asm-generic/int-ll64.h>
 
-#endif /* _ASM_GENERIC_TYPES_H */
+#endif /* _UAPI_ASM_GENERIC_TYPES_H */
-- 
1.7.9.5

