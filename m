From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] asm-generic: allow generic unaligned access if the arch supports it
Date: Thu, 27 Mar 2014 18:46:27 +0100
Message-ID: <1395942387-14177-1-git-send-email-ard.biesheuvel@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:60339 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585AbaC0RqI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Mar 2014 13:46:08 -0400
Received: by mail-wi0-f178.google.com with SMTP id bs8so3418993wib.5
        for <linux-arch@vger.kernel.org>; Thu, 27 Mar 2014 10:46:07 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, linux-arch@vger.kernel.org
Cc: robherring2@gmail.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Switch the default unaligned access method to 'hardware implemented'
if HAVE_EFFICIENT_UNALIGNED_ACCESS is set.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/asm-generic/unaligned.h | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index 03cf5936bad6..1ac097279db1 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -4,22 +4,27 @@
 /*
  * This is the most generic implementation of unaligned accesses
  * and should work almost anywhere.
- *
- * If an architecture can handle unaligned accesses in hardware,
- * it may want to use the linux/unaligned/access_ok.h implementation
- * instead.
  */
 #include <asm/byteorder.h>
 
+/* Set by the arch if it can handle unaligned accesses in hardware. */
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+# include <linux/unaligned/access_ok.h>
+#endif
+
 #if defined(__LITTLE_ENDIAN)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/be_byteshift.h>
+# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#  include <linux/unaligned/le_struct.h>
+#  include <linux/unaligned/be_byteshift.h>
+# endif
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
 # define put_unaligned	__put_unaligned_le
 #elif defined(__BIG_ENDIAN)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/le_byteshift.h>
+# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+#  include <linux/unaligned/be_struct.h>
+#  include <linux/unaligned/le_byteshift.h>
+# endif
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
 # define put_unaligned	__put_unaligned_be
-- 
1.8.3.2
