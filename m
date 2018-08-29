From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH net-next 3/3] net: socket: implement 64-bit timestamps
Date: Wed, 29 Aug 2018 15:11:23 +0200
Message-ID: <20180829131123.3866959-1-arnd@arndb.de>
References: <20180829130308.3504560-1-arnd@arndb.de>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829130308.3504560-1-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, y2038@lists.linaro.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, viro@zeniv.linux.org.uk, tglx@linutronix.de, edumazet@google.com, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

The 'timeval' and 'timespec' data structures used for socket timestamps
are going to be redefined in user space based on 64-bit time_t in future
versions of the C library to deal with the y2038 overflow problem,
which breaks the ABI definition.

Unlike many modern ioctl commands, SIOCGSTAMP and SIOCGSTAMPNS do not
use the _IOR() macro to encode the size of the transferred data, so it
remains ambiguous whether the application uses the old or new layout.

The best workaround I could find is rather ugly: we redefine the command
code based on the size of the respective data structure with a ternary
operator. This lets it get evaluated as late as possible, hopefully after
that structure is visible to the caller. We cannot use an #ifdef here,
because inux/sockios.h might have been included before any libc header
that could determine the size of time_t.

The ioctl implementation now interprets the new command codes as always
referring to the 64-bit structure on all architectures, while the old
architecture specific command code still refers to the old architecture
specific layout. The new command number is only used when they are
actually different.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/uapi/asm/sockios.h  |  4 ++--
 arch/mips/include/uapi/asm/sockios.h   |  4 ++--
 arch/sh/include/uapi/asm/sockios.h     |  5 +++--
 arch/xtensa/include/uapi/asm/sockios.h |  4 ++--
 include/uapi/asm-generic/sockios.h     |  4 ++--
 include/uapi/linux/sockios.h           | 21 +++++++++++++++++++++
 net/socket.c                           | 22 +++++++++++++++++-----
 7 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/sockios.h b/arch/alpha/include/uapi/asm/sockios.h
index ba287e4b01bf..af92bc27c3be 100644
--- a/arch/alpha/include/uapi/asm/sockios.h
+++ b/arch/alpha/include/uapi/asm/sockios.h
@@ -11,7 +11,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif /* _ASM_ALPHA_SOCKIOS_H */
diff --git a/arch/mips/include/uapi/asm/sockios.h b/arch/mips/include/uapi/asm/sockios.h
index 5b40a88593fa..66f60234f290 100644
--- a/arch/mips/include/uapi/asm/sockios.h
+++ b/arch/mips/include/uapi/asm/sockios.h
@@ -21,7 +21,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif /* _ASM_SOCKIOS_H */
diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
index 17313d2c3527..ef18a668456d 100644
--- a/arch/sh/include/uapi/asm/sockios.h
+++ b/arch/sh/include/uapi/asm/sockios.h
@@ -10,6 +10,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	_IOR('s', 100, struct timeval) /* Get stamp (timeval) */
-#define SIOCGSTAMPNS	_IOR('s', 101, struct timespec) /* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	_IOR('s', 100, struct timeval) /* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD _IOR('s', 101, struct timespec) /* Get stamp (timespec) */
+
 #endif /* __ASM_SH_SOCKIOS_H */
diff --git a/arch/xtensa/include/uapi/asm/sockios.h b/arch/xtensa/include/uapi/asm/sockios.h
index fb8ac3607189..1a1f58f4b75a 100644
--- a/arch/xtensa/include/uapi/asm/sockios.h
+++ b/arch/xtensa/include/uapi/asm/sockios.h
@@ -26,7 +26,7 @@
 #define SIOCSPGRP	_IOW('s', 8, pid_t)
 #define SIOCGPGRP	_IOR('s', 9, pid_t)
 
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif	/* _XTENSA_SOCKIOS_H */
diff --git a/include/uapi/asm-generic/sockios.h b/include/uapi/asm-generic/sockios.h
index 64f658c7cec2..44fa3ed70483 100644
--- a/include/uapi/asm-generic/sockios.h
+++ b/include/uapi/asm-generic/sockios.h
@@ -8,7 +8,7 @@
 #define FIOGETOWN	0x8903
 #define SIOCGPGRP	0x8904
 #define SIOCATMARK	0x8905
-#define SIOCGSTAMP	0x8906		/* Get stamp (timeval) */
-#define SIOCGSTAMPNS	0x8907		/* Get stamp (timespec) */
+#define SIOCGSTAMP_OLD	0x8906		/* Get stamp (timeval) */
+#define SIOCGSTAMPNS_OLD 0x8907		/* Get stamp (timespec) */
 
 #endif /* __ASM_GENERIC_SOCKIOS_H */
diff --git a/include/uapi/linux/sockios.h b/include/uapi/linux/sockios.h
index d393e9ed3964..7d1bccbbef78 100644
--- a/include/uapi/linux/sockios.h
+++ b/include/uapi/linux/sockios.h
@@ -19,6 +19,7 @@
 #ifndef _LINUX_SOCKIOS_H
 #define _LINUX_SOCKIOS_H
 
+#include <asm/bitsperlong.h>
 #include <asm/sockios.h>
 
 /* Linux-specific socket ioctls */
@@ -27,6 +28,26 @@
 
 #define SOCK_IOC_TYPE	0x89
 
+/*
+ * the timeval/timespec data structure layout is defined by libc,
+ * so we need to cover both possible versions on 32-bit.
+ */
+/* Get stamp (timeval) */
+#define SIOCGSTAMP_NEW	 _IOR(SOCK_IOC_TYPE, 0x06, long long[2])
+/* Get stamp (timespec) */
+#define SIOCGSTAMPNS_NEW _IOR(SOCK_IOC_TYPE, 0x07, long long[2])
+
+#if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
+/* on 64-bit and x32, avoid the ?: operator */
+#define SIOCGSTAMP	SIOCGSTAMP_OLD
+#define SIOCGSTAMPNS	SIOCGSTAMPNS_OLD
+#else
+#define SIOCGSTAMP	((sizeof(struct timeval))  == 8 ? \
+			 SIOCGSTAMP_OLD   : SIOCGSTAMP_NEW)
+#define SIOCGSTAMPNS	((sizeof(struct timespec)) == 8 ? \
+			 SIOCGSTAMPNS_OLD : SIOCGSTAMPNS_NEW)
+#endif
+
 /* Routing table calls. */
 #define SIOCADDRT	0x890B		/* add routing table entry	*/
 #define SIOCDELRT	0x890C		/* delete routing table entry	*/
diff --git a/net/socket.c b/net/socket.c
index 6814e8dc8af1..9762e7d5378b 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1069,14 +1069,24 @@ static long sock_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 
 			err = open_related_ns(&net->ns, get_net_ns);
 			break;
-		case SIOCGSTAMP:
-		case SIOCGSTAMPNS:
+		case SIOCGSTAMP_OLD:
+		case SIOCGSTAMPNS_OLD:
 			if (!sock->ops->gettstamp) {
 				err = -ENOIOCTLCMD;
 				break;
 			}
 			err = sock->ops->gettstamp(sock, argp,
-						   cmd == SIOCGSTAMP, false);
+						   cmd == SIOCGSTAMP_OLD,
+						   !IS_ENABLED(CONFIG_64BIT));
+		case SIOCGSTAMP_NEW:
+		case SIOCGSTAMPNS_NEW:
+			if (!sock->ops->gettstamp) {
+				err = -ENOIOCTLCMD;
+				break;
+			}
+			err = sock->ops->gettstamp(sock, argp,
+						   cmd == SIOCGSTAMP_NEW,
+						   false);
 			break;
 		default:
 			err = sock_do_ioctl(net, sock, cmd, arg);
@@ -3095,8 +3105,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCADDRT:
 	case SIOCDELRT:
 		return routing_ioctl(net, sock, cmd, argp);
-	case SIOCGSTAMP:
-	case SIOCGSTAMPNS:
+	case SIOCGSTAMP_OLD:
+	case SIOCGSTAMPNS_OLD:
 		if (!sock->ops->gettstamp)
 			return -ENOIOCTLCMD;
 		return sock->ops->gettstamp(sock, argp, cmd == SIOCGSTAMP,
@@ -3119,6 +3129,8 @@ static int compat_sock_ioctl_trans(struct file *file, struct socket *sock,
 	case SIOCADDDLCI:
 	case SIOCDELDLCI:
 	case SIOCGSKNS:
+	case SIOCGSTAMP_NEW:
+	case SIOCGSTAMPNS_NEW:
 		return sock_ioctl(file, cmd, arg);
 
 	case SIOCGIFFLAGS:
-- 
2.18.0
