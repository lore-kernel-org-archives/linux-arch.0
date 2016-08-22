From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v05 71/72] uapi term*.h: glibc termios.h header file compatibility fixes
Date: Mon, 22 Aug 2016 20:33:28 +0200
Message-ID: <1471890809-4383-72-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Fixes these userspace compile errors and warnings when glibc termios.h
is included before linux/termios.h:

asm-generic/termbits.h:11:8: error: redefinition of ‘struct termios’
asm-generic/termios.h:14:8: error: redefinition of ‘struct winsize’
asm-generic/termios.h:22:8: error: redefinition of ‘struct termio’

Not fixing multiple NCSS definitions since I don't know which one would be
correct so this warning remains:

asm-generic/termbits.h:10:0: warning: "NCCS" redefined
 #define NCCS 19
 ^
bits/termios.h:27:0: note: this is the location of the previous definition
 #define NCCS 32
 ^

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/termbits.h |  3 +++
 include/uapi/asm-generic/termios.h  |  5 +++++
 include/uapi/linux/libc-compat.h    | 28 ++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/uapi/asm-generic/termbits.h b/include/uapi/asm-generic/termbits.h
index 232b478..314bfef 100644
--- a/include/uapi/asm-generic/termbits.h
+++ b/include/uapi/asm-generic/termbits.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_GENERIC_TERMBITS_H
 #define __ASM_GENERIC_TERMBITS_H
 
+#include <linux/libc-compat.h>
 #include <linux/posix_types.h>
 
 typedef unsigned char	cc_t;
@@ -8,6 +9,7 @@ typedef unsigned int	speed_t;
 typedef unsigned int	tcflag_t;
 
 #define NCCS 19
+#if __UAPI_DEF_TERMIOS
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
 	tcflag_t c_oflag;		/* output mode flags */
@@ -16,6 +18,7 @@ struct termios {
 	cc_t c_line;			/* line discipline */
 	cc_t c_cc[NCCS];		/* control characters */
 };
+#endif /* __UAPI_DEF_TERMIOS */
 
 struct termios2 {
 	tcflag_t c_iflag;		/* input mode flags */
diff --git a/include/uapi/asm-generic/termios.h b/include/uapi/asm-generic/termios.h
index 0881760..3428999 100644
--- a/include/uapi/asm-generic/termios.h
+++ b/include/uapi/asm-generic/termios.h
@@ -8,17 +8,21 @@
  * New architectures should not provide their own version.
  */
 
+#include <linux/libc-compat.h>
 #include <asm/termbits.h>
 #include <asm/ioctls.h>
 
+#if __UAPI_DEF_WINSIZE
 struct winsize {
 	unsigned short ws_row;
 	unsigned short ws_col;
 	unsigned short ws_xpixel;
 	unsigned short ws_ypixel;
 };
+#endif /* __UAPI_DEF_WINSIZE */
 
 #define NCC 8
+#if __UAPI_DEF_TERMIO
 struct termio {
 	unsigned short c_iflag;		/* input mode flags */
 	unsigned short c_oflag;		/* output mode flags */
@@ -27,6 +31,7 @@ struct termio {
 	unsigned char c_line;		/* line discipline */
 	unsigned char c_cc[NCC];	/* control characters */
 };
+#endif /* __UAPI_DEF_TERMIO */
 
 /* modem lines */
 #define TIOCM_LE	0x001
diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index cb25f16..07a3462 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -230,6 +230,13 @@
 
 #endif /* defined(_NETROSE_ROSE_H) */
 
+/* Coordinate with glibc pty.h */
+#if defined(_PTY_H)
+#define __UAPI_DEF_TERMIOS	0
+#else /* defined(_PTY_H) */
+#define __UAPI_DEF_TERMIOS	1
+#endif /* defined(_PTY_H) */
+
 /* Coordinate with glibc time.h */
 #if defined(_TIME_H)
 #define __UAPI_DEF_TIMESPEC		0
@@ -245,6 +252,15 @@
 
 #endif /* defined(_TIME_H) */
 
+/* Definitions for sys/ioctl.h */
+#if defined(_SYS_IOCTL_H)
+#define __UAPI_DEF_TERMIO		0
+#define __UAPI_DEF_WINSIZE		0
+#else /* defined(_SYS_IOCTL_H) */
+#define __UAPI_DEF_TERMIO		1
+#define __UAPI_DEF_WINSIZE		1
+#endif /* defined(_SYS_IOCTL_H) */
+
 /* Definitions for sys/uio.h */
 #if defined(_SYS_UIO_H)
 #define __UAPI_DEF_IOVEC		0
@@ -265,6 +281,13 @@
 
 #endif /* defined(_SYS_TIME_H) */
 
+/* Coordinate with glibc termios.h */
+#if defined(_TERMIOS_H)
+#define __UAPI_DEF_TERMIOS	0
+#else /* defined(_TERMIOS_H) */
+#define __UAPI_DEF_TERMIOS	1
+#endif /* defined(_TERMIOS_H) */
+
 /* Definitions for xattr.h */
 #if defined(_SYS_XATTR_H)
 #define __UAPI_DEF_XATTR		0
@@ -282,6 +305,11 @@
 #define __UAPI_DEF_F_DUPFD_CLOEXEC		1
 #define __UAPI_DEF_O_ACCMODE_RDONLY_WRONLY_RDWR	1
 
+/* Definitions for asm-generic/termbits.h and asm-generic/termios.h */
+#define __UAPI_DEF_TERMIO		1
+#define __UAPI_DEF_TERMIOS		1
+#define __UAPI_DEF_WINSIZE		1
+
 /* Definitions for ax25.h */
 #define __UAPI_DEF_SIOCAX25GETUID_TO_SIOCAX25DELFWD	1
 #define __UAPI_DEF_SIOCAX25GETINFO			1
-- 
2.8.1
