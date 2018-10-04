From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 1/5] asm-generic, termios: add alias constants from MIPS
Date: Thu,  4 Oct 2018 15:29:49 -0700
Message-ID: <20181004222953.2229-2-hpa@zytor.com>
References: <20181004222953.2229-1-hpa@zytor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004222953.2229-1-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-serial@vger.kernel.org
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-arch.vger.kernel.org

Some architectures, in this case MIPS, need a couple of legacy alias
constants for bits. There really is no reason why we can't define them
generically for all architectures.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
linux-kernel@vger.kernel.org (open list)
---
 include/uapi/asm-generic/termbits.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 2fbaf9ae89dd..96ae175eec5b 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -8,7 +8,10 @@ typedef unsigned char	cc_t;
 typedef unsigned int	speed_t;
 typedef unsigned int	tcflag_t;
 
-#define NCCS 19
+#ifndef NCCS
+# define NCCS 19
+#endif
+
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -49,6 +52,7 @@ struct ktermios {
 #define VTIME 5
 #define VMIN 6
 #define VSWTC 7
+#define VSWTCH VSWTC
 #define VSTART 8
 #define VSTOP 9
 #define VSUSP 10
@@ -173,6 +177,7 @@ struct ktermios {
 #define ECHONL	0000100
 #define NOFLSH	0000200
 #define TOSTOP	0000400
+#define ITOSTOP TOSTOP
 #define ECHOCTL	0001000
 #define ECHOPRT	0002000
 #define ECHOKE	0004000
-- 
2.14.4
