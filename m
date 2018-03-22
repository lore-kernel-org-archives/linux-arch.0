From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 34/45] ipc: add shmget syscall wrapper
Date: Thu, 22 Mar 2018 10:00:48 +0100
Message-ID: <20180322090059.19361-35-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_shmget() wrapper to avoid in-kernel calls to this syscall.
The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_shmget().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/shm.c     | 7 ++++++-
 ipc/syscall.c | 4 ++--
 ipc/util.h    | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865e9171..9f3cdb259a51 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -656,7 +656,7 @@ static inline int shm_more_checks(struct kern_ipc_perm *ipcp,
 	return 0;
 }
 
-SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
+long ksys_shmget(key_t key, size_t size, int shmflg)
 {
 	struct ipc_namespace *ns;
 	static const struct ipc_ops shm_ops = {
@@ -675,6 +675,11 @@ SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
 	return ipcget(ns, &shm_ids(ns), &shm_ops, &shm_params);
 }
 
+SYSCALL_DEFINE3(shmget, key_t, key, size_t, size, int, shmflg)
+{
+	return ksys_shmget(key, size, shmflg);
+}
+
 static inline unsigned long copy_shmid_to_user(void __user *buf, struct shmid64_ds *in, int version)
 {
 	switch (version) {
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 355c4a644bbf..60bceb19b6f0 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -92,7 +92,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 	case SHMDT:
 		return sys_shmdt((char __user *)ptr);
 	case SHMGET:
-		return sys_shmget(first, second, third);
+		return ksys_shmget(first, second, third);
 	case SHMCTL:
 		return sys_shmctl(first, second,
 				   (struct shmid_ds __user *) ptr);
@@ -180,7 +180,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 	case SHMDT:
 		return sys_shmdt(compat_ptr(ptr));
 	case SHMGET:
-		return sys_shmget(first, (unsigned)second, third);
+		return ksys_shmget(first, (unsigned int)second, third);
 	case SHMCTL:
 		return compat_sys_shmctl(first, second, compat_ptr(ptr));
 	}
diff --git a/ipc/util.h b/ipc/util.h
index b35c0dfe3bc3..51002c0b2a21 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -243,6 +243,7 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
+long ksys_shmget(key_t key, size_t size, int shmflg);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 #ifdef CONFIG_COMPAT
-- 
2.16.2
