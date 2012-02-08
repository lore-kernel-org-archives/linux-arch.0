Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44007 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750953Ab2BHFJl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Feb 2012 00:09:41 -0500
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 02/21] posix_types: Make it possible to override __kernel_fsid_t
Date: Tue,  7 Feb 2012 21:08:46 -0800
Message-ID: <1328677745-20121-3-git-send-email-hpa@zytor.com>
In-Reply-To: <1328677745-20121-1-git-send-email-hpa@zytor.com>
References: <1328677745-20121-1-git-send-email-hpa@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120208050846.rZtnG3so_HDjiuo6l6zMrMlBw6uDd7xl-NU6a4_2dTg@z>

From: "H. Peter Anvin" <hpa@zytor.com>

__kernel_fsid_t has members of type "long" on at least one
architecture (MIPS32), so make it possible to override the definition.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/posix_types.h |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/posix_types.h b/include/asm-generic/posix_types.h
index ac83f6b..ac21760 100644
--- a/include/asm-generic/posix_types.h
+++ b/include/asm-generic/posix_types.h
@@ -73,6 +73,12 @@ typedef long		__kernel_ptrdiff_t;
 #endif
 #endif
 
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#endif
+
 /*
  * anything below here should be completely generic
  */
@@ -86,10 +92,6 @@ typedef char *		__kernel_caddr_t;
 typedef unsigned short	__kernel_uid16_t;
 typedef unsigned short	__kernel_gid16_t;
 
-typedef struct {
-	int	val[2];
-} __kernel_fsid_t;
-
 #ifdef __KERNEL__
 
 #undef __FD_SET
-- 
1.7.6.5

