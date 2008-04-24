From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 04/24] avr32: types: use <asm-generic/int-*.h> for the avr32 architecture
Date: Thu, 24 Apr 2008 16:05:15 -0700
Message-ID: <1209078352-7593-9-git-send-email-hpa@zytor.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
 <1209078352-7593-2-git-send-email-hpa@zytor.com>
 <1209078352-7593-3-git-send-email-hpa@zytor.com>
 <1209078352-7593-4-git-send-email-hpa@zytor.com>
 <1209078352-7593-5-git-send-email-hpa@zytor.com>
 <1209078352-7593-6-git-send-email-hpa@zytor.com>
 <1209078352-7593-7-git-send-email-hpa@zytor.com>
 <1209078352-7593-8-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209078352-7593-8-git-send-email-hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>

This modifies <asm-avr32/types.h> to use the <asm-generic/int-*.h>
generic include files.

Signed-off-by: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
---
 include/asm-avr32/types.h |   32 ++------------------------------
 1 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/include/asm-avr32/types.h b/include/asm-avr32/types.h
index 8999a38..9cefda6 100644
--- a/include/asm-avr32/types.h
+++ b/include/asm-avr32/types.h
@@ -8,28 +8,12 @@
 #ifndef __ASM_AVR32_TYPES_H
 #define __ASM_AVR32_TYPES_H
 
+#include <asm-generic/int-ll64.h>
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned short umode_t;
 
-/*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-#if defined(__GNUC__)
-__extension__ typedef __signed__ long long __s64;
-__extension__ typedef unsigned long long __u64;
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -41,18 +25,6 @@ __extension__ typedef unsigned long long __u64;
 
 #ifndef __ASSEMBLY__
 
-typedef signed char s8;
-typedef unsigned char u8;
-
-typedef signed short s16;
-typedef unsigned short u16;
-
-typedef signed int s32;
-typedef unsigned int u32;
-
-typedef signed long long s64;
-typedef unsigned long long u64;
-
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
-- 
1.5.4.1
