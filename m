Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33736 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeIJJoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:38 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 8/8] really consolidate INIT_C_CC definitions
Date: Mon, 10 Sep 2018 05:52:27 +0100
Message-ID: <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045227.nGBWPXK8lCKJL6Bajlxel_P-UkE71nc8vGMBnPwAy7M@z>

From: Al Viro <viro@zeniv.linux.org.uk>

they vary in two respects (renumbering of fields aside):
	* sparc (and nobody else) has dsusp; set to ^Y.
	* original (on i386) has discard set to historical
value (^O), mistaken comment nonwithstanding.  alpha, ppc
and sparc have followed the comment.  Not that we'd ever
handled that thing anyway...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/termios_internal.h   |  8 +-------
 arch/powerpc/include/asm/termios_internal.h |  3 +--
 arch/sparc/include/asm/termios_internal.h   |  8 +-------
 include/linux/termios_internal.h            | 16 ++++++++++++++--
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/include/asm/termios_internal.h b/arch/alpha/include/asm/termios_internal.h
index 6c2a67e65992..07d5c1a6cdf6 100644
--- a/arch/alpha/include/asm/termios_internal.h
+++ b/arch/alpha/include/asm/termios_internal.h
@@ -2,13 +2,7 @@
 #ifndef _ALPHA_TERMIOS_H
 #define _ALPHA_TERMIOS_H
 
-/*	eof=^D		eol=\0		eol2=\0		erase=del
-	werase=^W	kill=^U		reprint=^R	sxtc=\0
-	intr=^C		quit=^\		susp=^Z		<OSF/1 VDSUSP>
-	start=^Q	stop=^S		lnext=^V	discard=^U
-	vmin=\1		vtime=\0
-*/
-#define INIT_C_CC "\004\000\000\177\027\025\022\000\003\034\032\000\021\023\026\025\001\000"
+#define INIT_C_CC_VDISCARD 'U'-0x40
 
 /*
  * Translate a "termio" structure into a "termios". Ugh.
diff --git a/arch/powerpc/include/asm/termios_internal.h b/arch/powerpc/include/asm/termios_internal.h
index b93e889342cf..116b138ea232 100644
--- a/arch/powerpc/include/asm/termios_internal.h
+++ b/arch/powerpc/include/asm/termios_internal.h
@@ -12,7 +12,6 @@
 #ifndef _ASM_POWERPC_TERMIOS_H
 #define _ASM_POWERPC_TERMIOS_H
 
-/*                   ^C  ^\ del  ^U  ^D   1   0   0   0   0  ^W  ^R  ^Z  ^Q  ^S  ^V  ^U  */
-#define INIT_C_CC "\003\034\177\025\004\001\000\000\000\000\027\022\032\021\023\026\025" 
+#define INIT_C_CC_VDISCARD 'U'-0x40
 
 #endif	/* _ASM_POWERPC_TERMIOS_H */
diff --git a/arch/sparc/include/asm/termios_internal.h b/arch/sparc/include/asm/termios_internal.h
index 028c6bd6e0a7..1649a0cecda9 100644
--- a/arch/sparc/include/asm/termios_internal.h
+++ b/arch/sparc/include/asm/termios_internal.h
@@ -13,13 +13,7 @@
 #define _VMIN	4
 #define _VTIME	5
 
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		eol=\0		eol2=\0		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		dsusp=^Y
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	vmin=\1         vtime=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\000\000\000\021\023\032\031\022\025\027\026\001"
+#define INIT_C_CC_VDISCARD 'U'-0x40
 
 /*
  * Translate a "termios" structure into a "termio". Ugh.
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 343f7868713d..549715b18d22 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -8,13 +8,24 @@
 #include <asm/termios_internal.h>
 #endif
 
-#ifndef INIT_C_CC
 /*	intr=^C		quit=^\		erase=del	kill=^U
 	eof=^D		vtime=\0	vmin=\1		sxtc=\0
 	start=^Q	stop=^S		susp=^Z		eol=\0
 	reprint=^R	discard=^U	werase=^W	lnext=^V
 	eol2=\0
+	... except that discard is actually ^O on most of them.
 */
+#ifndef INIT_C_CC_VDISCARD
+#define INIT_C_CC_VDISCARD 'O'-0x40
+#endif
+
+#ifdef VDSUSP
+#define INIT_C_CC_VDSUSP_EXTRA [VDSUSP] = 'Y'-0x40,
+#else
+#define INIT_C_CC_VDSUSP_EXTRA
+#endif
+
+#ifndef INIT_C_CC
 #define INIT_C_CC {		\
 	[VINTR] = 'C'-0x40,	\
 	[VQUIT] = '\\'-0x40,	\
@@ -25,9 +36,10 @@
 	[VSTOP] = 'S'-0x40,	\
 	[VSUSP] = 'Z'-0x40,	\
 	[VREPRINT] = 'R'-0x40,	\
-	[VDISCARD] = 'O'-0x40,	\
+	[VDISCARD] = INIT_C_CC_VDISCARD,	\
 	[VWERASE] = 'W'-0x40,	\
 	[VLNEXT] = 'V'-0x40,	\
+	INIT_C_CC_VDSUSP_EXTRA	\
 	[VMIN] = 1 }
 #endif
 
-- 
2.11.0
