From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH 12/12] sparc32: debride memcpy.S a bit
Date: Fri, 29 Jan 2016 19:18:34 +0000
Message-ID: <1454095114-4128-12-git-send-email-viro@ZenIV.linux.org.uk>
References: <20160129191744.GB17997@ZenIV.linux.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49621 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696AbcA2TSi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Jan 2016 14:18:38 -0500
In-Reply-To: <20160129191744.GB17997@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

unreachable code, unused macros...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/lib/memcpy.S | 79 -------------------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index d3626cd..8913fea 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -59,88 +59,9 @@ x:
 	stb	%t0, [%dst - (offset) - 0x02]; \
 	stb	%t1, [%dst - (offset) - 0x01];
 
-/* Both these macros have to start with exactly the same insn */
-#define RMOVE_BIGCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
-	ldd	[%src - (offset) - 0x20], %t0; \
-	ldd	[%src - (offset) - 0x18], %t2; \
-	ldd	[%src - (offset) - 0x10], %t4; \
-	ldd	[%src - (offset) - 0x08], %t6; \
-	st	%t0, [%dst - (offset) - 0x20]; \
-	st	%t1, [%dst - (offset) - 0x1c]; \
-	st	%t2, [%dst - (offset) - 0x18]; \
-	st	%t3, [%dst - (offset) - 0x14]; \
-	st	%t4, [%dst - (offset) - 0x10]; \
-	st	%t5, [%dst - (offset) - 0x0c]; \
-	st	%t6, [%dst - (offset) - 0x08]; \
-	st	%t7, [%dst - (offset) - 0x04];
-
-#define RMOVE_BIGALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, t7) \
-	ldd	[%src - (offset) - 0x20], %t0; \
-	ldd	[%src - (offset) - 0x18], %t2; \
-	ldd	[%src - (offset) - 0x10], %t4; \
-	ldd	[%src - (offset) - 0x08], %t6; \
-	std	%t0, [%dst - (offset) - 0x20]; \
-	std	%t2, [%dst - (offset) - 0x18]; \
-	std	%t4, [%dst - (offset) - 0x10]; \
-	std	%t6, [%dst - (offset) - 0x08];
-
-#define RMOVE_LASTCHUNK(src, dst, offset, t0, t1, t2, t3) \
-	ldd	[%src + (offset) + 0x00], %t0; \
-	ldd	[%src + (offset) + 0x08], %t2; \
-	st	%t0, [%dst + (offset) + 0x00]; \
-	st	%t1, [%dst + (offset) + 0x04]; \
-	st	%t2, [%dst + (offset) + 0x08]; \
-	st	%t3, [%dst + (offset) + 0x0c];
-
-#define RMOVE_SHORTCHUNK(src, dst, offset, t0, t1) \
-	ldub	[%src + (offset) + 0x00], %t0; \
-	ldub	[%src + (offset) + 0x01], %t1; \
-	stb	%t0, [%dst + (offset) + 0x00]; \
-	stb	%t1, [%dst + (offset) + 0x01];
-
-#define SMOVE_CHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) \
-	ldd	[%src + (offset) + 0x00], %t0; \
-	ldd	[%src + (offset) + 0x08], %t2; \
-	srl	%t0, shir, %t5; \
-	srl	%t1, shir, %t6; \
-	sll	%t0, shil, %t0; \
-	or	%t5, %prev, %t5; \
-	sll	%t1, shil, %prev; \
-	or	%t6, %t0, %t0; \
-	srl	%t2, shir, %t1; \
-	srl	%t3, shir, %t6; \
-	sll	%t2, shil, %t2; \
-	or	%t1, %prev, %t1; \
-	std	%t4, [%dst + (offset) + (offset2) - 0x04]; \
-	std	%t0, [%dst + (offset) + (offset2) + 0x04]; \
-	sll	%t3, shil, %prev; \
-	or	%t6, %t2, %t4;
-
-#define SMOVE_ALIGNCHUNK(src, dst, offset, t0, t1, t2, t3, t4, t5, t6, prev, shil, shir, offset2) \
-	ldd	[%src + (offset) + 0x00], %t0; \
-	ldd	[%src + (offset) + 0x08], %t2; \
-	srl	%t0, shir, %t4;	\
-	srl	%t1, shir, %t5;	\
-	sll	%t0, shil, %t6;	\
-	or	%t4, %prev, %t0; \
-	sll	%t1, shil, %prev; \
-	or	%t5, %t6, %t1; \
-	srl	%t2, shir, %t4;	\
-	srl	%t3, shir, %t5;	\
-	sll	%t2, shil, %t6; \
-	or	%t4, %prev, %t2; \
-	sll	%t3, shil, %prev; \
-	or	%t5, %t6, %t3; \
-	std	%t0, [%dst + (offset) + (offset2) + 0x00]; \
-	std	%t2, [%dst + (offset) + (offset2) + 0x08];
-
 	.text
 	.align	4
 
-0:
-	retl
-	 nop		! Only bcopy returns here and it retuns void...
-
 FUNC(memmove)
 EXPORT_SYMBOL(memmove)
 	cmp		%o0, %o1
-- 
2.1.4
