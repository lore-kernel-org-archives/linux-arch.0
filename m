Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36660 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754955AbYDXXGo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Apr 2008 19:06:44 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 13/24] mn10300: types: use <asm-generic/int-*.h> for the mn10300 architecture
Date: Thu, 24 Apr 2008 16:05:32 -0700
Message-ID: <1209078352-7593-26-git-send-email-hpa@zytor.com>
In-Reply-To: <1209078352-7593-25-git-send-email-hpa@zytor.com>
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
 <1209078352-7593-19-git-send-email-hpa@zytor.com>
 <1209078352-7593-20-git-send-email-hpa@zytor.com>
 <1209078352-7593-21-git-send-email-hpa@zytor.com>
 <1209078352-7593-22-git-send-email-hpa@zytor.com>
 <1209078352-7593-23-git-send-email-hpa@zytor.com>
 <1209078352-7593-24-git-send-email-hpa@zytor.com>
 <1209078352-7593-25-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Arch Mailing List <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
Message-ID: <20080424230532.3T8FCr6AdFp0kuz9RuQNOHOXMkwKEVybdn9iwCXvehA@z>

This modifies <asm-mn10300/types.h> to use the <asm-generic/int-*.h>
generic include files.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>
---
 include/asm-mn10300/types.h |   33 ++-------------------------------
 1 files changed, 2 insertions(+), 31 deletions(-)

diff --git a/include/asm-mn10300/types.h b/include/asm-mn10300/types.h
index d40ea76..7b9f010 100644
--- a/include/asm-mn10300/types.h
+++ b/include/asm-mn10300/types.h
@@ -11,29 +11,12 @@
 #ifndef _ASM_TYPES_H
 #define _ASM_TYPES_H
 
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
-#if defined(__GNUC__) && !defined(__STRICT_ANSI__)
-typedef __signed__ long long __s64;
-typedef unsigned long long __u64;
-#endif
-
 #endif /* __ASSEMBLY__ */
 
 /*
@@ -45,18 +28,6 @@ typedef unsigned long long __u64;
 
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

