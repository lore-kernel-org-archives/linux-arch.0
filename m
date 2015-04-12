From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] xtensa: Fix execdomain removal
Date: Sat, 11 Apr 2015 19:19:51 -0700
Message-ID: <1428805191-27089-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57982 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbbDLCUC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Apr 2015 22:20:02 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yh7VB-001jeK-OC
	for linux-arch@vger.kernel.org; Sun, 12 Apr 2015 02:20:01 +0000
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

The removal of exexdomain changes pointer offsets into the thread_info
structure.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies on top of Richard's execdomain removal patches.
Tested with xtensa qemu session.

 arch/xtensa/include/asm/thread_info.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/include/asm/thread_info.h b/arch/xtensa/include/asm/thread_info.h
index d120278073b5..b3680a4738cd 100644
--- a/arch/xtensa/include/asm/thread_info.h
+++ b/arch/xtensa/include/asm/thread_info.h
@@ -64,12 +64,11 @@ struct thread_info {
 
 /* offsets into the thread_info struct for assembly code access */
 #define TI_TASK		 0x00000000
-#define TI_EXEC_DOMAIN	 0x00000004
-#define TI_FLAGS	 0x00000008
-#define TI_STATUS	 0x0000000C
-#define TI_CPU		 0x00000010
-#define TI_PRE_COUNT	 0x00000014
-#define TI_ADDR_LIMIT	 0x00000018
+#define TI_FLAGS	 0x00000004
+#define TI_STATUS	 0x00000008
+#define TI_CPU		 0x0000000C
+#define TI_PRE_COUNT	 0x00000010
+#define TI_ADDR_LIMIT	 0x00000014
 
 #endif
 
-- 
2.1.0
