From: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 09/24] ia64: types: use <asm-generic/int-*.h> for the ia64 architecture
Date: Thu, 24 Apr 2008 16:05:25 -0700
Message-ID: <1209078352-7593-19-git-send-email-hpa@zytor.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
 <1209078352-7593-2-git-send-email-hpa@zytor.com>
 <1209078352-7593-3-git-send-email-hpa@zytor.com>
 <1209078352-7593-4-git-send-email-hpa@zytor.com>
 <1209078352-7593-5-git-send-email-hpa@zytor.com>
 <1209078352-7593-6-git-send-email-hpa@zytor.com>
 <1209078352-7593-7-git-send-email-hpa@zytor.com>
 <1209078352-7593-8-git-send-email-hpa@zytor.com>
 <1209078352-7593-9-git-send-email-hpa@zytor.com>
 <1209078352-7593-10-git-send-email-hpa@zytor.com>
 <1209078352-7593-11-git-send-email-hpa@zytor.com>
 <1209078352-7593-12-git-send-email-hpa@zytor.com>
 <1209078352-7593-13-git-send-email-hpa@zytor.com>
 <1209078352-7593-14-git-send-email-hpa@zytor.com>
 <1209078352-7593-15-git-send-email-hpa@zytor.com>
 <1209078352-7593-16-git-send-email-hpa@zytor.com>
 <1209078352-7593-17-git-send-email-hpa@zytor.com>
 <1209078352-7593-18-git-send-email-hpa@zytor.com>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209078352-7593-18-git-send-email-hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>

This modifies <asm-ia64/types.h> to use the <asm-generic/int-*.h>
generic include files.

Signed-off-by: H. Peter Anvin <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>
---
 include/asm-ia64/types.h |   31 ++-----------------------------
 1 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/include/asm-ia64/types.h b/include/asm-ia64/types.h
index 902850d..e36b371 100644
--- a/include/asm-ia64/types.h
+++ b/include/asm-ia64/types.h
@@ -13,6 +13,8 @@
  *	David Mosberger-Tang <davidm-sDzT885Ts8HQT0dZR+AlfA@public.gmane.org>, Hewlett-Packard Co
  */
 
+#include <asm-generic/int-l64.h>
+
 #ifdef __ASSEMBLY__
 # define __IA64_UL(x)		(x)
 # define __IA64_UL_CONST(x)	x
@@ -28,39 +30,10 @@
 typedef unsigned int umode_t;
 
 /*
- * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
- * header files exported to user space
- */
-
-typedef __signed__ char __s8;
-typedef unsigned char __u8;
-
-typedef __signed__ short __s16;
-typedef unsigned short __u16;
-
-typedef __signed__ int __s32;
-typedef unsigned int __u32;
-
-typedef __signed__ long __s64;
-typedef unsigned long __u64;
-
-/*
  * These aren't exported outside the kernel to avoid name space clashes
  */
 # ifdef __KERNEL__
 
-typedef __s8 s8;
-typedef __u8 u8;
-
-typedef __s16 s16;
-typedef __u16 u16;
-
-typedef __s32 s32;
-typedef __u32 u32;
-
-typedef __s64 s64;
-typedef __u64 u64;
-
 #define BITS_PER_LONG 64
 
 /* DMA addresses are 64-bits wide, in general.  */
-- 
1.5.4.1
