Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:58144 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753007AbYDJToN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 10 Apr 2008 15:44:13 -0400
Received: by wa-out-1112.google.com with SMTP id m16so100402waf.23
        for <linux-arch@vger.kernel.org>; Thu, 10 Apr 2008 12:44:12 -0700 (PDT)
Subject: [PATCH 3/8] kernel: move arches that use the no-builtin-memcpy
	implementation
From: Harvey Harrison <harvey.harrison@gmail.com>
Content-Type: text/plain
Date: Thu, 10 Apr 2008 12:44:07 -0700
Message-ID: <1207856647.22001.27.camel@brick>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, Chris Zankel <chris@zankel.net>
Message-ID: <20080410194407.3MBLqiStcYlbBVZXxH2fZLs8MDxNECuB-ksNLqEVDDs@z>

h8300, m32r, xtensa use this implementation.

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
---
 include/asm-h8300/unaligned.h  |   11 +----------
 include/asm-m32r/unaligned.h   |   15 +--------------
 include/asm-xtensa/unaligned.h |   12 +-----------
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/include/asm-h8300/unaligned.h b/include/asm-h8300/unaligned.h
index ffb67f4..e8ff49d 100644
--- a/include/asm-h8300/unaligned.h
+++ b/include/asm-h8300/unaligned.h
@@ -1,15 +1,6 @@
 #ifndef __H8300_UNALIGNED_H
 #define __H8300_UNALIGNED_H
 
-
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <linux/unaligned/no_builtin_memcpy.h>
 
 #endif
diff --git a/include/asm-m32r/unaligned.h b/include/asm-m32r/unaligned.h
index fccc180..5a4c931 100644
--- a/include/asm-m32r/unaligned.h
+++ b/include/asm-m32r/unaligned.h
@@ -1,19 +1,6 @@
 #ifndef _ASM_M32R_UNALIGNED_H
 #define _ASM_M32R_UNALIGNED_H
 
-/*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents.
- */
-
-#include <asm/string.h>
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <linux/unaligned/no_builtin_memcpy.h>
 
 #endif /* _ASM_M32R_UNALIGNED_H */
diff --git a/include/asm-xtensa/unaligned.h b/include/asm-xtensa/unaligned.h
index 2822089..45eb203 100644
--- a/include/asm-xtensa/unaligned.h
+++ b/include/asm-xtensa/unaligned.h
@@ -13,16 +13,6 @@
 #ifndef _XTENSA_UNALIGNED_H
 #define _XTENSA_UNALIGNED_H
 
-#include <linux/string.h>
-
-/* Use memmove here, so gcc does not insert a __builtin_memcpy. */
-
-#define get_unaligned(ptr) \
-  ({ __typeof__(*(ptr)) __tmp; memmove(&__tmp, (ptr), sizeof(*(ptr))); __tmp; })
-
-#define put_unaligned(val, ptr)				\
-  ({ __typeof__(*(ptr)) __tmp = (val);			\
-     memmove((ptr), &__tmp, sizeof(*(ptr)));		\
-     (void)0; })
+#include <linux/unaligned/no_builtin_memcpy.h>
 
 #endif	/* _XTENSA_UNALIGNED_H */
-- 
1.5.5.144.g3e42


