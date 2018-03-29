From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 031/109] ipc: add semget syscall wrapper
Date: Thu, 29 Mar 2018 13:23:08 +0200
Message-ID: <20180329112426.23043-32-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_semget() wrapper to avoid in-kernel calls to this syscall.
The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_semget().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/sem.c     | 7 ++++++-
 ipc/syscall.c | 4 ++--
 ipc/util.h    | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index e21ceb8b4af1..2e5f7ec7a7db 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -556,7 +556,7 @@ static inline int sem_more_checks(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
+long ksys_semget(key_t key, int nsems, int semflg)
 {
 	struct ipc_namespace *ns;
 	static const struct ipc_ops sem_ops = {
@@ -578,6 +578,11 @@ SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
 	return ipcget(ns, &sem_ids(ns), &sem_ops, &sem_params);
 }
 
+SYSCALL_DEFINE3(semget, key_t, key, int, nsems, int, semflg)
+{
+	return ksys_semget(key, nsems, semflg);
+}
+
 /**
  * perform_atomic_semop[_slow] - Attempt to perform semaphore
  *                               operations on a given array.
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 84d6a7691baa..21fcdf0b4836 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -35,7 +35,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 				       (const struct timespec __user *)fifth);
 
 	case SEMGET:
-		return sys_semget(first, second, third);
+		return ksys_semget(first, second, third);
 	case SEMCTL: {
 		unsigned long arg;
 		if (!ptr)
@@ -132,7 +132,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		return compat_ksys_semtimedop(first, compat_ptr(ptr), second,
 						compat_ptr(fifth));
 	case SEMGET:
-		return sys_semget(first, second, third);
+		return ksys_semget(first, second, third);
 	case SEMCTL:
 		if (!ptr)
 			return -EINVAL;
diff --git a/ipc/util.h b/ipc/util.h
index 6deadf77547e..0f07056e5a73 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -240,6 +240,7 @@ static inline int compat_ipc_parse_version(int *cmd)
 long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
 		     const struct timespec __user *timeout);
+long ksys_semget(key_t key, int nsems, int semflg);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 #ifdef CONFIG_COMPAT
-- 
2.16.3
