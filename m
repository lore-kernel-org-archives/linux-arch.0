Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50289 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823AbXCHNki (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2007 08:40:38 -0500
Date: Thu, 8 Mar 2007 14:44:45 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] tty: Turn on arbitary baud rate ioctls for i386 platform
Message-ID: <20070308144445.31a4e3c4@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Adds the needed TCGETS2/TCSETS2 ioctl calls, structures, defines and the
like. Tested against the test suite and passes. Other platforms should need
roughly the same change.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/include/asm-i386/ioctls.h linux-2.6.21-rc2-mm2/include/asm-i386/ioctls.h
--- linux.vanilla-2.6.21-rc2-mm2/include/asm-i386/ioctls.h	2007-03-06 23:06:31.000000000 +0000
+++ linux-2.6.21-rc2-mm2/include/asm-i386/ioctls.h	2007-03-08 13:24:39.816743656 +0000
@@ -47,6 +47,10 @@
 #define TIOCSBRK	0x5427  /* BSD compatibility */
 #define TIOCCBRK	0x5428  /* BSD compatibility */
 #define TIOCGSID	0x5429  /* Return the session ID of FD */
+#define TCGETS2		_IOR('T',0x2A, struct termios2)
+#define TCSETS2		_IOW('T',0x2B, struct termios2)
+#define TCSETSW2	_IOW('T',0x2C, struct termios2)
+#define TCSETSF2	_IOW('T',0x2D, struct termios2)
 #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
 #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/include/asm-i386/termbits.h linux-2.6.21-rc2-mm2/include/asm-i386/termbits.h
--- linux.vanilla-2.6.21-rc2-mm2/include/asm-i386/termbits.h	2007-03-06 23:06:31.000000000 +0000
+++ linux-2.6.21-rc2-mm2/include/asm-i386/termbits.h	2007-03-07 15:45:32.000000000 +0000
@@ -17,6 +17,17 @@
 	cc_t c_cc[NCCS];		/* control characters */
 };
 
+struct termios2 {
+	tcflag_t c_iflag;		/* input mode flags */
+	tcflag_t c_oflag;		/* output mode flags */
+	tcflag_t c_cflag;		/* control mode flags */
+	tcflag_t c_lflag;		/* local mode flags */
+	cc_t c_line;			/* line discipline */
+	cc_t c_cc[NCCS];		/* control characters */
+	speed_t c_ispeed;		/* input speed */
+	speed_t c_ospeed;		/* output speed */
+};
+
 struct ktermios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -129,6 +140,7 @@
 #define HUPCL	0002000
 #define CLOCAL	0004000
 #define CBAUDEX 0010000
+#define   BOTHER  0010000
 #define    B57600 0010001
 #define   B115200 0010002
 #define   B230400 0010003
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc2-mm2/include/asm-i386/termios.h linux-2.6.21-rc2-mm2/include/asm-i386/termios.h
--- linux.vanilla-2.6.21-rc2-mm2/include/asm-i386/termios.h	2007-03-06 23:06:31.000000000 +0000
+++ linux-2.6.21-rc2-mm2/include/asm-i386/termios.h	2007-03-06 17:00:58.000000000 +0000
@@ -81,8 +81,10 @@
 	copy_to_user((termio)->c_cc, (termios)->c_cc, NCC); \
 })
 
-#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios))
-#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios))
+#define user_termios_to_kernel_termios(k, u) copy_from_user(k, u, sizeof(struct termios2))
+#define kernel_termios_to_user_termios(u, k) copy_to_user(u, k, sizeof(struct termios2))
+#define user_termios_to_kernel_termios_1(k, u) copy_from_user(k, u, sizeof(struct termios))
+#define kernel_termios_to_user_termios_1(u, k) copy_to_user(u, k, sizeof(struct termios))
 
 #endif	/* __KERNEL__ */
 
