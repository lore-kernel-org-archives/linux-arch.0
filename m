From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 21/27] microblaze: use generic swab.h
Date: Mon, 27 Apr 2009 17:18:05 +0200
Message-ID: <4f8f43d8ba5606f043db577c896ab88b8cf21cd7.1241105648.git.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:62905 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932402AbZD3PmG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2009 11:42:06 -0400
In-Reply-To: <cover.1241105648.git.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/include/asm/swab.h |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/arch/microblaze/include/asm/swab.h b/arch/microblaze/include/asm/swab.h
index b375d7b..7847e56 100644
--- a/arch/microblaze/include/asm/swab.h
+++ b/arch/microblaze/include/asm/swab.h
@@ -1,8 +1 @@
-#ifndef _ASM_MICROBLAZE_SWAB_H
-#define _ASM_MICROBLAZE_SWAB_H
-
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__) || defined(__KERNEL__)
-#define __SWAB_64_THRU_32__
-#endif
-
-#endif /* _ASM_MICROBLAZE_SWAB_H */
+#include <asm-generic/swab.h>
-- 
1.5.6.3
