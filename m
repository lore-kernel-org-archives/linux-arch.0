From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 38/45] ipc: add msgrcv syscall/compat_syscall wrappers
Date: Thu, 22 Mar 2018 10:00:52 +0100
Message-ID: <20180322090059.19361-39-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_msgrcv() and compat_ksys_msgrcv() wrappers to avoid in-kernel
calls to these syscalls. The ksys_ prefix denotes that these functions are
meant as a drop-in replacement for the syscalls. In particular, they use
the same calling convention as sys_msgrcv() and compat_sys_msgrcv().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/msg.c     | 19 ++++++++++++++++---
 ipc/syscall.c |  8 ++++----
 ipc/util.h    |  4 ++++
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index 5b026868df07..abc5826270a6 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -1150,10 +1150,16 @@ static long do_msgrcv(int msqid, void __user *buf, size_t bufsz, long msgtyp, in
 	return bufsz;
 }
 
+long ksys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+		 long msgtyp, int msgflg)
+{
+	return do_msgrcv(msqid, msgp, msgsz, msgtyp, msgflg, do_msg_fill);
+}
+
 SYSCALL_DEFINE5(msgrcv, int, msqid, struct msgbuf __user *, msgp, size_t, msgsz,
 		long, msgtyp, int, msgflg)
 {
-	return do_msgrcv(msqid, msgp, msgsz, msgtyp, msgflg, do_msg_fill);
+	return ksys_msgrcv(msqid, msgp, msgsz, msgtyp, msgflg);
 }
 
 #ifdef CONFIG_COMPAT
@@ -1171,12 +1177,19 @@ static long compat_do_msg_fill(void __user *dest, struct msg_msg *msg, size_t bu
 	return msgsz;
 }
 
-COMPAT_SYSCALL_DEFINE5(msgrcv, int, msqid, compat_uptr_t, msgp,
-		       compat_ssize_t, msgsz, compat_long_t, msgtyp, int, msgflg)
+long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
+			compat_long_t msgtyp, int msgflg)
 {
 	return do_msgrcv(msqid, compat_ptr(msgp), (ssize_t)msgsz, (long)msgtyp,
 			 msgflg, compat_do_msg_fill);
 }
+
+COMPAT_SYSCALL_DEFINE5(msgrcv, int, msqid, compat_uptr_t, msgp,
+		       compat_ssize_t, msgsz, compat_long_t, msgtyp,
+		       int, msgflg)
+{
+	return compat_ksys_msgrcv(msqid, msgp, msgsz, msgtyp, msgflg);
+}
 #endif
 
 int msg_init_ns(struct ipc_namespace *ns)
diff --git a/ipc/syscall.c b/ipc/syscall.c
index aa29b0802e26..0228c7afd882 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -59,11 +59,11 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 					   (struct ipc_kludge __user *) ptr,
 					   sizeof(tmp)))
 				return -EFAULT;
-			return sys_msgrcv(first, tmp.msgp, second,
+			return ksys_msgrcv(first, tmp.msgp, second,
 					   tmp.msgtyp, third);
 		}
 		default:
-			return sys_msgrcv(first,
+			return ksys_msgrcv(first,
 					   (struct msgbuf __user *) ptr,
 					   second, fifth, third);
 		}
@@ -156,10 +156,10 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 				return -EINVAL;
 			if (copy_from_user(&ipck, uptr, sizeof(ipck)))
 				return -EFAULT;
-			return compat_sys_msgrcv(first, ipck.msgp, second,
+			return compat_ksys_msgrcv(first, ipck.msgp, second,
 						 ipck.msgtyp, third);
 		}
-		return compat_sys_msgrcv(first, ptr, second, fifth, third);
+		return compat_ksys_msgrcv(first, ptr, second, fifth, third);
 	}
 	case MSGGET:
 		return ksys_msgget(first, second);
diff --git a/ipc/util.h b/ipc/util.h
index 47837b4af3f2..c16aceb1bdec 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -244,6 +244,8 @@ long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
 long ksys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf);
+long ksys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+		 long msgtyp, int msgflg);
 long ksys_shmget(key_t key, size_t size, int shmflg);
 long ksys_shmdt(char __user *shmaddr);
 long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
@@ -255,6 +257,8 @@ long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    const struct compat_timespec __user *timeout);
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 long compat_ksys_msgctl(int msqid, int cmd, void __user *uptr);
+long compat_ksys_msgrcv(int msqid, compat_uptr_t msgp, compat_ssize_t msgsz,
+			compat_long_t msgtyp, int msgflg);
 long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr);
 #endif /* CONFIG_COMPAT */
 
-- 
2.16.2
