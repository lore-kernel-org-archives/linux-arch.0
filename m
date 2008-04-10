From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/8] kernel: move arches that use the no-builtin-memcpy
	implementation
Date: Thu, 10 Apr 2008 12:44:07 -0700
Message-ID: <1207856647.22001.27.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Hirokazu Takata <takata-TMSiXQfHlQjsTix1lMzHGQ@public.gmane.org>, Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>

h8300, m32r, xtensa use this implementation.

Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
