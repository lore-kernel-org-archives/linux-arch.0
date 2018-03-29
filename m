From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 037/109] ipc: add msgctl syscall/compat_syscall wrappers
Date: Thu, 29 Mar 2018 13:23:14 +0200
Message-ID: <20180329112426.23043-38-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_msgctl() and compat_ksys_msgctl() wrappers to avoid in-kernel
calls to these syscalls. The ksys_ prefix denotes that these functions are
meant as a drop-in replacement for the syscalls. In particular, they use
the same calling convention as sys_msgctl() and compat_sys_msgctl().

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/msg.c     | 14 ++++++++++++--
 ipc/syscall.c |  5 +++--
 ipc/util.h    |  2 ++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 64e8276be164..5b026868df07 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -538,7 +538,7 @@ static int msgctl_stat(struct ipc_namespace *ns, int msqid,
 	return err;
 }
 
-SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, struct msqid_ds __user *, buf)
+long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
 {
 	int version;
 	struct ipc_namespace *ns;
@@ -581,6 +581,11 @@ SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, struct msqid_ds __user *, buf)
 	}
 }
 
+SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, struct msqid_ds __user *, buf)
+{
+	return ksys_msgctl(msqid, cmd, buf);
+}
+
 #ifdef CONFIG_COMPAT
 
 struct compat_msqid_ds {
@@ -651,7 +656,7 @@ static int copy_compat_msqid_to_user(void __user *buf, struct msqid64_ds *in,
 	}
 }
 
-COMPAT_SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, void __user *, uptr)
+long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr)
 {
 	struct ipc_namespace *ns;
 	int err;
@@ -692,6 +697,11 @@ COMPAT_SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, void __user *, uptr)
 		return -EINVAL;
 	}
 }
+
+COMPAT_SYSCALL_DEFINE3(msgctl, int, msqid, int, cmd, void __user *, uptr)
+{
+	return compat_ksys_msgctl(msqid, cmd, uptr);
+}
 #endif
 
 static int testmsg(struct msg_msg *msg, long type, int mode)
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 34bbabc9e672..aa29b0802e26 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -70,7 +70,8 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 	case MSGGET:
 		return ksys_msgget((key_t) first, second);
 	case MSGCTL:
-		return sys_msgctl(first, second, (struct msqid_ds __user *)ptr);
+		return ksys_msgctl(first, second,
+				   (struct msqid_ds __user *)ptr);
 
 	case SHMAT:
 		switch (version) {
@@ -163,7 +164,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 	case MSGGET:
 		return ksys_msgget(first, second);
 	case MSGCTL:
-		return compat_sys_msgctl(first, second, compat_ptr(ptr));
+		return compat_ksys_msgctl(first, second, compat_ptr(ptr));
 
 	case SHMAT: {
 		int err;
diff --git a/ipc/util.h b/ipc/util.h
index 16e8b5b8c416..47837b4af3f2 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -243,6 +243,7 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
+long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 long ksys_shmget(key_t key, size_t size, int shmflg);
 long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
@@ -253,6 +254,7 @@ long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
+long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr);
 #endif /* CONFIG_COMPAT */
 
-- 
2.16.3
