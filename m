Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:33718 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeIJJoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Sep 2018 05:44:38 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 4/8] make users of INIT_C_CC pull linux/termios_internal.h
Date: Mon, 10 Sep 2018 05:52:23 +0100
Message-ID: <20180910045227.9895-4-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk>
 <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Message-ID: <20180910045223.Lr4_qWXWsque1G6IrZZV5mOBvQjFMmS2e7aAJY3Pz08@z>

From: Al Viro <viro@zeniv.linux.org.uk>

... and move the default definition in there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/include/asm/termios.h   |  9 ---------
 arch/parisc/include/asm/termios.h |  9 ---------
 arch/s390/include/asm/termios.h   |  9 ---------
 drivers/tty/hvc/hvcs.c            |  1 +
 drivers/tty/tty_io.c              |  1 +
 drivers/tty/vcc.c                 |  1 +
 include/asm-generic/termios.h     |  8 --------
 include/linux/termios_internal.h  | 10 ++++++++++
 8 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/arch/ia64/include/asm/termios.h b/arch/ia64/include/asm/termios.h
index 66ca23c03f3c..1cef02701401 100644
--- a/arch/ia64/include/asm/termios.h
+++ b/arch/ia64/include/asm/termios.h
@@ -10,13 +10,4 @@
 
 #include <uapi/asm/termios.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
 #endif /* _ASM_IA64_TERMIOS_H */
diff --git a/arch/parisc/include/asm/termios.h b/arch/parisc/include/asm/termios.h
index 2f5153be531f..1850a90befb3 100644
--- a/arch/parisc/include/asm/termios.h
+++ b/arch/parisc/include/asm/termios.h
@@ -4,13 +4,4 @@
 
 #include <uapi/asm/termios.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
 #endif	/* _PARISC_TERMIOS_H */
diff --git a/arch/s390/include/asm/termios.h b/arch/s390/include/asm/termios.h
index 7ee16b5dcb6f..0e26fe97b0d4 100644
--- a/arch/s390/include/asm/termios.h
+++ b/arch/s390/include/asm/termios.h
@@ -9,13 +9,4 @@
 
 #include <uapi/asm/termios.h>
 
-
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
 #endif	/* _S390_TERMIOS_H */
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b3ca3c..f6be8f999026 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -69,6 +69,7 @@
 #include <asm/hvconsole.h>
 #include <asm/hvcserver.h>
 #include <linux/uaccess.h>
+#include <linux/termios_internal.h>
 #include <asm/vio.h>
 
 /*
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3fe4d3..9da2bd81e97e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -97,6 +97,7 @@
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/ratelimit.h>
+#include <linux/termios_internal.h>
 
 #include <linux/uaccess.h>
 
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 58b454c34560..f674306be121 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -10,6 +10,7 @@
 #include <linux/sysfs.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/termios_internal.h>
 #include <asm/vio.h>
 #include <asm/ldc.h>
 
diff --git a/include/asm-generic/termios.h b/include/asm-generic/termios.h
index 3ffed3886ff2..da3b0fe25442 100644
--- a/include/asm-generic/termios.h
+++ b/include/asm-generic/termios.h
@@ -6,12 +6,4 @@
 #include <linux/uaccess.h>
 #include <uapi/asm-generic/termios.h>
 
-/*	intr=^C		quit=^\		erase=del	kill=^U
-	eof=^D		vtime=\0	vmin=\1		sxtc=\0
-	start=^Q	stop=^S		susp=^Z		eol=\0
-	reprint=^R	discard=^U	werase=^W	lnext=^V
-	eol2=\0
-*/
-#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
-
 #endif /* _ASM_GENERIC_TERMIOS_H */
diff --git a/include/linux/termios_internal.h b/include/linux/termios_internal.h
index 894f565ffc5f..a77fd8df783e 100644
--- a/include/linux/termios_internal.h
+++ b/include/linux/termios_internal.h
@@ -5,6 +5,16 @@
 #include <linux/uaccess.h>
 #include <asm/termios.h>
 
+#ifndef INIT_C_CC
+/*	intr=^C		quit=^\		erase=del	kill=^U
+	eof=^D		vtime=\0	vmin=\1		sxtc=\0
+	start=^Q	stop=^S		susp=^Z		eol=\0
+	reprint=^R	discard=^U	werase=^W	lnext=^V
+	eol2=\0
+*/
+#define INIT_C_CC "\003\034\177\025\004\0\1\0\021\023\032\0\022\017\027\026\0"
+#endif
+
 #ifndef user_termio_to_kernel_termios
 /*
  * Translate a "termio" structure into a "termios". Ugh.
-- 
2.11.0
