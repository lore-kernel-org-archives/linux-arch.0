Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33722 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbeIJJoh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:37 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 5/8] make generic INIT_C_CC a bit more generic
Date: Mon, 10 Sep 2018 05:52:24 +0100
Message-ID: <20180910045227.9895-5-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045224.xan8_k7nznUL2oJm8wfCGxMokzfa-D5GZarfyVdZ_jg@z>

From: Al Viro <viro@zeniv.linux.org.uk>

turn it into an array initializer; then mips variant folds into
it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/termios.h  |  9 ---------
 include/linux/termios_internal.h | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/termios.h b/arch/mips/include/asm/termios.h
index dbb62330b7a4..12bc56857bf1 100644
--- a/arch/mips/include/asm/termios.h
+++ b/arch/mips/include/asm/termios.h
@@ -12,13 +12,4 @@
 #include <linux/uaccess.h>
 #include <uapi/asm/termios.h>
 
-/*
- *	intr=^C		quit=^\		erase=del	kill=^U
- *	vmin=\1		vtime=\0	eol2=\0		swtc=\0
- *	start=^Q	stop=^S		susp=^Z		vdsusp=
- *	reprint=^R	discard=^U	werase=^W	lnext=^V
- *	eof=^D		eol=\0
- */
-#define INIT_C_CC "\003\034\177\025\1\0\0\0\021\023\032\0\022\017\027\026\004\0"
-
 #endif /* _ASM_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index a77fd8df783e..d25b9a9c2faf 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -12,7 +12,20 @@
 	reprint=^R	discard=^U	werase=^W	lnext=^V
 	eol2=\0
 */
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#define INIT_C_CC {		\
+	[VINTR] = 'C'-0x40,	\
+	[VQUIT] = '\\'-0x40,	\
+	[VERASE] = '\177',	\
+	[VKILL] = 'U'-0x40,	\
+	[VEOF] = 'D'-0x40,	\
+	[VSTART] = 'Q'-0x40,	\
+	[VSTOP] = 'S'-0x40,	\
+	[VSUSP] = 'Z'-0x40,	\
+	[VREPRINT] = 'R'-0x40,	\
+	[VDISCARD] = 'O'-0x40,	\
+	[VWERASE] = 'W'-0x40,	\
+	[VLNEXT] = 'V'-0x40,	\
+	[VMIN] = 1 }
 #endif
 
 #ifndef user_termio_to_kernel_termios
-- 
2.11.0
