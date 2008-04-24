Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:42944 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756400AbYDXXK0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2008 19:10:26 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 03/24] arm: types: use <asm-generic/int-*.h> for the arm architecture
Date: Thu, 24 Apr 2008 16:05:12 -0700
Message-ID: <1209078352-7593-6-git-send-email-hpa@zytor.com>
In-Reply-To: <1209078352-7593-5-git-send-email-hpa@zytor.com>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
 <1209078352-7593-2-git-send-email-hpa@zytor.com>
 <1209078352-7593-3-git-send-email-hpa@zytor.com>
 <1209078352-7593-4-git-send-email-hpa@zytor.com>
 <1209078352-7593-5-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Russell King <rmk@arm.linux.org.uk>, Lennert Buytenhek <kernel@wantstofly.org>, Ben Dooks <ben-linux@fluff.org>
Message-ID: <20080424230512.KkxQ-7EhGgeS-2o4Y_xnMMmu7UL92Oy3-qK8rBUelVM@z>

This modifies <asm-arm/types.h> to use the <asm-generic/int-*.h>
generic include files.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 include/asm-arm/types.h |   33 ++-------------------------------
 1 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/include/asm-arm/types.h b/include/asm-arm/types.h
index 3141451..345df01 100644
--- a/include/asm-arm/types.h
+++ b/include/asm-arm/types.h
@@ -1,29 +1,12 @@
 #ifndef __ASM_ARM_TYPES_H
 #define __ASM_ARM_TYPES_H
 
+#include <asm-generic/int-ll64.h>
+
 #ifndef __ASSEMBLY__
 
 typedef unsigned short umode_t;
 
-/*
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
-#if defined(__GNUC__)
-__extension__ typedef __signed__ long long __s64;
-__extension__ typedef unsigned long long __u64;
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -35,18 +18,6 @@ __extension__ typedef unsigned long long __u64;
 
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

