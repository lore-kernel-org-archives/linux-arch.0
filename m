From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 030/109] ipc: add semtimedop syscall/compat_syscall wrappers
Date: Thu, 29 Mar 2018 13:23:07 +0200
Message-ID: <20180329112426.23043-31-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_semtimedop() and compat_ksys_semtimedop() wrappers to avoid
in-kernel calls to these syscalls. The ksys_ prefix denotes that these
functions are meant as a drop-in replacement for the syscalls. In
particular, they use the same calling convention as sys_semtimedop() and
compat_sys_semtimedop().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/sem.c     | 23 ++++++++++++++++++-----
 ipc/syscall.c | 17 ++++++++++-------
 ipc/util.h    | 13 +++++++++++++
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index a4af04979fd2..e21ceb8b4af1 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -2120,8 +2120,8 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	return error;
 }
 
-SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
-		unsigned, nsops, const struct timespec __user *, timeout)
+long ksys_semtimedop(int semid, struct sembuf __user *tsops,
+		     unsigned int nsops, const struct timespec __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
@@ -2132,10 +2132,16 @@ SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
 	return do_semtimedop(semid, tsops, nsops, NULL);
 }
 
+SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsops,
+		unsigned int, nsops, const struct timespec __user *, timeout)
+{
+	return ksys_semtimedop(semid, tsops, nsops, timeout);
+}
+
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsems,
-		       unsigned, nsops,
-		       const struct compat_timespec __user *, timeout)
+long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
+			    unsigned int nsops,
+			    const struct compat_timespec __user *timeout)
 {
 	if (timeout) {
 		struct timespec64 ts;
@@ -2145,6 +2151,13 @@ COMPAT_SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsems,
 	}
 	return do_semtimedop(semid, tsems, nsops, NULL);
 }
+
+COMPAT_SYSCALL_DEFINE4(semtimedop, int, semid, struct sembuf __user *, tsems,
+		       unsigned int, nsops,
+		       const struct compat_timespec __user *, timeout)
+{
+	return compat_ksys_semtimedop(semid, tsems, nsops, timeout);
+}
 #endif
 
 SYSCALL_DEFINE3(semop, int, semid, struct sembuf __user *, tsops,
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 3763b4293b74..84d6a7691baa 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -7,6 +7,9 @@
  */
 #include <linux/unistd.h>
 #include <linux/syscalls.h>
+#include <linux/security.h>
+#include <linux/ipc_namespace.h>
+#include "util.h"
 
 #ifdef __ARCH_WANT_SYS_IPC
 #include <linux/errno.h>
@@ -24,12 +27,12 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 
 	switch (call) {
 	case SEMOP:
-		return sys_semtimedop(first, (struct sembuf __user *)ptr,
-				      second, NULL);
+		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
+				       second, NULL);
 	case SEMTIMEDOP:
-		return sys_semtimedop(first, (struct sembuf __user *)ptr,
-				      second,
-				      (const struct timespec __user *)fifth);
+		return ksys_semtimedop(first, (struct sembuf __user *)ptr,
+				       second,
+				       (const struct timespec __user *)fifth);
 
 	case SEMGET:
 		return sys_semget(first, second, third);
@@ -124,9 +127,9 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 	switch (call) {
 	case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		return sys_semtimedop(first, compat_ptr(ptr), second, NULL);
+		return ksys_semtimedop(first, compat_ptr(ptr), second, NULL);
 	case SEMTIMEDOP:
-		return compat_sys_semtimedop(first, compat_ptr(ptr), second,
+		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
 		return sys_semget(first, second, third);
diff --git a/ipc/util.h b/ipc/util.h
index 89b8ec176fc4..6deadf77547e 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -235,4 +235,17 @@ static inline int compat_ipc_parse_version(int *cmd)
 #endif
 }
 #endif
+
+/* for __ARCH_WANT_SYS_IPC */
+long ksys_semtimedop(int semid, struct sembuf __user *tsops,
+		     unsigned int nsops,
+		     const struct timespec __user *timeout);
+
+/* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
+#ifdef CONFIG_COMPAT
+long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
+			    unsigned int nsops,
+			    const struct compat_timespec __user *timeout);
+#endif /* CONFIG_COMPAT */
+
 #endif
-- 
2.16.3
