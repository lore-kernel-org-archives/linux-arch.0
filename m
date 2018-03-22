From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 32/45] ipc: add semctl syscall/compat_syscall wrappers
Date: Thu, 22 Mar 2018 10:00:46 +0100
Message-ID: <20180322090059.19361-33-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_semctl() and compat_ksys_semctl() wrappers to avoid in-kernel
calls to these syscalls. The ksys_ prefix denotes that these functions are
meant as a drop-in replacement for the syscalls. In particular, they use
the same calling convention as sys_semctl() and compat_sys_semctl().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/sem.c     | 14 ++++++++++++--
 ipc/syscall.c |  4 ++--
 ipc/util.h    |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 2e5f7ec7a7db..1cf56279a84c 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1581,7 +1581,7 @@ static int semctl_down(struct ipc_namespace *ns, int semid,
 	return err;
 }
 
-SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
+long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg)
 {
 	int version;
 	struct ipc_namespace *ns;
@@ -1635,6 +1635,11 @@ SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
 	}
 }
 
+SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, unsigned long, arg)
+{
+	return ksys_semctl(semid, semnum, cmd, arg);
+}
+
 #ifdef CONFIG_COMPAT
 
 struct compat_semid_ds {
@@ -1683,7 +1688,7 @@ static int copy_compat_semid_to_user(void __user *buf, struct semid64_ds *in,
 	}
 }
 
-COMPAT_SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, int, arg)
+long compat_ksys_semctl(int semid, int semnum, int cmd, int arg)
 {
 	void __user *p = compat_ptr(arg);
 	struct ipc_namespace *ns;
@@ -1727,6 +1732,11 @@ COMPAT_SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, int, arg)
 		return -EINVAL;
 	}
 }
+
+COMPAT_SYSCALL_DEFINE4(semctl, int, semid, int, semnum, int, cmd, int, arg)
+{
+	return compat_ksys_semctl(semid, semnum, cmd, arg);
+}
 #endif
 
 /* If the task doesn't already have a undo_list, then allocate one
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 21fcdf0b4836..a536cca37661 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -42,7 +42,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 			return -EINVAL;
 		if (get_user(arg, (unsigned long __user *) ptr))
 			return -EFAULT;
-		return sys_semctl(first, second, third, arg);
+		return ksys_semctl(first, second, third, arg);
 	}
 
 	case MSGSND:
@@ -138,7 +138,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 			return -EINVAL;
 		if (get_user(pad, (u32 __user *) compat_ptr(ptr)))
 			return -EFAULT;
-		return compat_sys_semctl(first, second, third, pad);
+		return compat_ksys_semctl(first, second, third, pad);
 
 	case MSGSND:
 		return compat_sys_msgsnd(first, ptr, second, third);
diff --git a/ipc/util.h b/ipc/util.h
index 0f07056e5a73..1f1109b83437 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -241,12 +241,14 @@ long ksys_semtimedop(int semid, struct sembuf __user *tsops,
 		     unsigned int nsops,
 		     const struct timespec __user *timeout);
 long ksys_semget(key_t key, int nsems, int semflg);
+long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 #ifdef CONFIG_COMPAT
 long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
+long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
 #endif /* CONFIG_COMPAT */
 
 #endif
-- 
2.16.2
