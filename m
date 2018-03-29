From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 033/109] ipc: add msgget syscall wrapper
Date: Thu, 29 Mar 2018 13:23:10 +0200
Message-ID: <20180329112426.23043-34-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_msgget() wrapper to avoid in-kernel calls to this syscall.
The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_msgget().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/msg.c     | 7 ++++++-
 ipc/syscall.c | 4 ++--
 ipc/util.h    | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 0dcc6699dc53..64e8276be164 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -263,7 +263,7 @@ static inline int msg_security(struct kern_ipc_perm *ipcp, int msgflg)
 	return security_msg_queue_associate(msq, msgflg);
 }
 
-SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
+long ksys_msgget(key_t key, int msgflg)
 {
 	struct ipc_namespace *ns;
 	static const struct ipc_ops msg_ops = {
@@ -280,6 +280,11 @@ SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
 	return ipcget(ns, &msg_ids(ns), &msg_ops, &msg_params);
 }
 
+SYSCALL_DEFINE2(msgget, key_t, key, int, msgflg)
+{
+	return ksys_msgget(key, msgflg);
+}
+
 static inline unsigned long
 copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
 {
diff --git a/ipc/syscall.c b/ipc/syscall.c
index a536cca37661..355c4a644bbf 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -68,7 +68,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 					   second, fifth, third);
 		}
 	case MSGGET:
-		return sys_msgget((key_t) first, second);
+		return ksys_msgget((key_t) first, second);
 	case MSGCTL:
 		return sys_msgctl(first, second, (struct msqid_ds __user *)ptr);
 
@@ -161,7 +161,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		return compat_sys_msgrcv(first, ptr, second, fifth, third);
 	}
 	case MSGGET:
-		return sys_msgget(first, second);
+		return ksys_msgget(first, second);
 	case MSGCTL:
 		return compat_sys_msgctl(first, second, compat_ptr(ptr));
 
diff --git a/ipc/util.h b/ipc/util.h
index 1f1109b83437..b35c0dfe3bc3 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -242,6 +242,7 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     const struct timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
+long ksys_msgget(key_t key, int msgflg);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 #ifdef CONFIG_COMPAT
-- 
2.16.3
