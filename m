From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 39/45] ipc: add msgsnd syscall/compat_syscall wrappers
Date: Thu, 22 Mar 2018 10:00:53 +0100
Message-ID: <20180322090059.19361-40-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_msgsnd() and compat_ksys_msgsnd() wrappers to avoid in-kernel
calls to these syscalls. The ksys_ prefix denotes that these functions are
meant as a drop-in replacement for the syscalls. In particular, they use
the same calling convention as sys_msgsnd() and compat_sys_msgsnd().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/msg.c     | 20 ++++++++++++++++----
 ipc/syscall.c |  4 ++--
 ipc/util.h    |  4 ++++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index abc5826270a6..9de48065c1ac 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -867,8 +867,8 @@ static long do_msgsnd(int msqid, long mtype, void __user *mtext,
 	return err;
 }
 
-SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
-		int, msgflg)
+long ksys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+		 int msgflg)
 {
 	long mtype;
 
@@ -877,6 +877,12 @@ SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
 	return do_msgsnd(msqid, mtype, msgp->mtext, msgsz, msgflg);
 }
 
+SYSCALL_DEFINE4(msgsnd, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
+		int, msgflg)
+{
+	return ksys_msgsnd(msqid, msgp, msgsz, msgflg);
+}
+
 #ifdef CONFIG_COMPAT
 
 struct compat_msgbuf {
@@ -884,8 +890,8 @@ struct compat_msgbuf {
 	char mtext[1];
 };
 
-COMPAT_SYSCALL_DEFINE4(msgsnd, int, msqid, compat_uptr_t, msgp,
-		       compat_ssize_t, msgsz, int, msgflg)
+long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
+		       compat_ssize_t msgsz, int msgflg)
 {
 	struct compat_msgbuf __user *up = compat_ptr(msgp);
 	compat_long_t mtype;
@@ -894,6 +900,12 @@ COMPAT_SYSCALL_DEFINE4(msgsnd, int, msqid, compat_uptr_t, msgp,
 		return -EFAULT;
 	return do_msgsnd(msqid, mtype, up->mtext, (ssize_t)msgsz, msgflg);
 }
+
+COMPAT_SYSCALL_DEFINE4(msgsnd, int, msqid, compat_uptr_t, msgp,
+		       compat_ssize_t, msgsz, int, msgflg)
+{
+	return compat_ksys_msgsnd(msqid, msgp, msgsz, msgflg);
+}
 #endif
 
 static inline int convert_mode(long *msgtyp, int msgflg)
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 0228c7afd882..77a883ef2eca 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -46,7 +46,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 	}
 
 	case MSGSND:
-		return sys_msgsnd(first, (struct msgbuf __user *) ptr,
+		return ksys_msgsnd(first, (struct msgbuf __user *) ptr,
 				  second, third);
 	case MSGRCV:
 		switch (version) {
@@ -142,7 +142,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		return compat_ksys_semctl(first, second, third, pad);
 
 	case MSGSND:
-		return compat_sys_msgsnd(first, ptr, second, third);
+		return compat_ksys_msgsnd(first, ptr, second, third);
 
 	case MSGRCV: {
 		void __user *uptr = compat_ptr(ptr);
diff --git a/ipc/util.h b/ipc/util.h
index c16aceb1bdec..51853dc2f340 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -246,6 +246,8 @@ long ksys_msgget(key_t key, int msgflg);
 long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
 long ksys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
 		 long msgtyp, int msgflg);
+long ksys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+		 int msgflg);
 long ksys_shmget(key_t key, size_t size, int shmflg);
 long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
@@ -259,6 +261,8 @@ long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
 long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
 			compat_long_t msgtyp, int msgflg);
+long compat_ksys_msgsnd(int msqid, compat_uptr_t msgp,
+		       compat_ssize_t msgsz, int msgflg);
 long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr);
 #endif /* CONFIG_COMPAT */
 
-- 
2.16.2
