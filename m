From: Mikko Rapeli <mikko.rapeli@iki.fi>
Subject: [PATCH v05 65/72] uapi fcntl.h: glibc fcntl.h header file compatibility fixes
Date: Mon, 22 Aug 2016 20:33:22 +0200
Message-ID: <1471890809-4383-66-git-send-email-mikko.rapeli@iki.fi>
References: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471890809-4383-1-git-send-email-mikko.rapeli@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Mikko Rapeli <mikko.rapeli@iki.fi>, Arnd Bergmann <arnd@arndb.de>, Jeff Layton <jlayton@poochiereds.net>, "J. Bruce Fields" <bfields@fieldses.org>, "David S. Miller" <davem@davemloft.net>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Fixes these userspace compile warnings and error when glibc fcntl.h is
included before linux/fcntl.h:

asm-generic/fcntl.h:18:0: warning: "O_ACCMODE" redefined
asm-generic/fcntl.h:19:0: warning: "O_RDONLY" redefined
asm-generic/fcntl.h:20:0: warning: "O_WRONLY" redefined
asm-generic/fcntl.h:21:0: warning: "O_RDWR" redefined
asm-generic/fcntl.h:195:8: error: redefinition of ‘struct flock’
linux/fcntl.h:16:0: warning: "F_DUPFD_CLOEXEC" redefined

Signed-off-by: Mikko Rapeli <mikko.rapeli@iki.fi>
---
 include/uapi/asm-generic/fcntl.h |  6 ++++++
 include/uapi/linux/fcntl.h       |  3 +++
 include/uapi/linux/libc-compat.h | 20 ++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index e063eff..3b429ce 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H
 
+#include <linux/libc-compat.h>
 #include <linux/types.h>
 
 /*
@@ -15,10 +16,13 @@
  * When introducing new O_* bits, please check its uniqueness in fcntl_init().
  */
 
+#if __UAPI_DEF_O_ACCMODE_RDONLY_WRONLY_RDWR
 #define O_ACCMODE	00000003
 #define O_RDONLY	00000000
 #define O_WRONLY	00000001
 #define O_RDWR		00000002
+#endif /* __UAPI_DEF_O_ACCMODE_RDONLY_WRONLY_RDWR */
+
 #ifndef O_CREAT
 #define O_CREAT		00000100	/* not fcntl */
 #endif
@@ -192,6 +196,7 @@ struct f_owner_ex {
 #define __ARCH_FLOCK_PAD
 #endif
 
+#if __UAPI_DEF_FLOCK
 struct flock {
 	short	l_type;
 	short	l_whence;
@@ -200,6 +205,7 @@ struct flock {
 	__kernel_pid_t	l_pid;
 	__ARCH_FLOCK_PAD
 };
+#endif /* __UAPI_DEF_FLOCK */
 #endif
 
 #ifndef HAVE_ARCH_STRUCT_FLOCK64
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index beed138..279bcfb 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -1,6 +1,7 @@
 #ifndef _UAPI_LINUX_FCNTL_H
 #define _UAPI_LINUX_FCNTL_H
 
+#include <linux/libc-compat.h>
 #include <asm/fcntl.h>
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
@@ -13,7 +14,9 @@
 #define F_CANCELLK	(F_LINUX_SPECIFIC_BASE + 5)
 
 /* Create a file descriptor with FD_CLOEXEC set. */
+#if __UAPI_DEF_F_DUPFD_CLOEXEC
 #define F_DUPFD_CLOEXEC	(F_LINUX_SPECIFIC_BASE + 6)
+#endif /* __UAPI_DEF_F_DUPFD_CLOEXEC */
 
 /*
  * Request nofications on a directory.
diff --git a/include/uapi/linux/libc-compat.h b/include/uapi/linux/libc-compat.h
index 44b8a6b..40190a4 100644
--- a/include/uapi/linux/libc-compat.h
+++ b/include/uapi/linux/libc-compat.h
@@ -51,6 +51,21 @@
 /* We have included glibc headers... */
 #if defined(__GLIBC__)
 
+/* Coordinate with glibc fcntl.h header. */
+#if defined(_FCNTL_H)
+
+#define __UAPI_DEF_FLOCK			0
+#define __UAPI_DEF_F_DUPFD_CLOEXEC		0
+#define __UAPI_DEF_O_ACCMODE_RDONLY_WRONLY_RDWR	0
+
+#else /* defined(_FCNTL_H) */
+
+#define __UAPI_DEF_FLOCK			1
+#define __UAPI_DEF_F_DUPFD_CLOEXEC		1
+#define __UAPI_DEF_O_ACCMODE_RDONLY_WRONLY_RDWR	1
+
+#endif /* defined(_FCNTL_H) */
+
 /* Coordinate with glibc net/if.h header. */
 #if defined(_NET_IF_H) && defined(__USE_MISC)
 
@@ -170,6 +185,11 @@
  * that we need. */
 #else /* !defined(__GLIBC__) */
 
+/* Definitions for asm-generic/fcntl.h */
+#define __UAPI_DEF_FLOCK			1
+#define __UAPI_DEF_F_DUPFD_CLOEXEC		1
+#define __UAPI_DEF_O_ACCMODE_RDONLY_WRONLY_RDWR	1
+
 /* Definitions for if.h */
 #define __UAPI_DEF_IF_IFCONF 1
 #define __UAPI_DEF_IF_IFMAP 1
-- 
2.8.1
