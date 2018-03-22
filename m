From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 36/45] ipc: add shmctl syscall/compat_syscall wrappers
Date: Thu, 22 Mar 2018 10:00:50 +0100
Message-ID: <20180322090059.19361-37-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_shmctl() and compat_ksys_shmctl() wrappers to avoid in-kernel
calls to these syscalls. The ksys_ prefix denotes that these functions are
meant as a drop-in replacement for the syscalls. In particular, they use
the same calling convention as sys_shmctl() and compat_sys_shmctl().

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 ipc/shm.c     | 14 ++++++++++++--
 ipc/syscall.c |  4 ++--
 ipc/util.h    |  2 ++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index e5838e3328dc..0aae3e55bc56 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1045,7 +1045,7 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
 	return err;
 }
 
-SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
+long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf)
 {
 	int err, version;
 	struct ipc_namespace *ns;
@@ -1099,6 +1099,11 @@ SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
 	}
 }
 
+SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, struct shmid_ds __user *, buf)
+{
+	return ksys_shmctl(shmid, cmd, buf);
+}
+
 #ifdef CONFIG_COMPAT
 
 struct compat_shmid_ds {
@@ -1218,7 +1223,7 @@ static int copy_compat_shmid_from_user(struct shmid64_ds *out, void __user *buf,
 	}
 }
 
-COMPAT_SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, void __user *, uptr)
+long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr)
 {
 	struct ipc_namespace *ns;
 	struct shmid64_ds sem64;
@@ -1273,6 +1278,11 @@ COMPAT_SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, void __user *, uptr)
 	}
 	return err;
 }
+
+COMPAT_SYSCALL_DEFINE3(shmctl, int, shmid, int, cmd, void __user *, uptr)
+{
+	return compat_ksys_shmctl(shmid, cmd, uptr);
+}
 #endif
 
 /*
diff --git a/ipc/syscall.c b/ipc/syscall.c
index b3aa71564815..34bbabc9e672 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -94,7 +94,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 	case SHMGET:
 		return ksys_shmget(first, second, third);
 	case SHMCTL:
-		return sys_shmctl(first, second,
+		return ksys_shmctl(first, second,
 				   (struct shmid_ds __user *) ptr);
 	default:
 		return -ENOSYS;
@@ -182,7 +182,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 	case SHMGET:
 		return ksys_shmget(first, (unsigned int)second, third);
 	case SHMCTL:
-		return compat_sys_shmctl(first, second, compat_ptr(ptr));
+		return compat_ksys_shmctl(first, second, compat_ptr(ptr));
 	}
 
 	return -ENOSYS;
diff --git a/ipc/util.h b/ipc/util.h
index 7770bcad1168..16e8b5b8c416 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -245,6 +245,7 @@ long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
 long ksys_shmget(key_t key, size_t size, int shmflg);
 long ksys_shmdt(char __user *shmaddr);
+long ksys_shmctl(int shmid, int cmd, struct shmid_ds __user *buf);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 #ifdef CONFIG_COMPAT
@@ -252,6 +253,7 @@ long compat_ksys_semtimedop(int semid, struct sembuf __user *tsems,
 			    unsigned int nsops,
 			    const struct compat_timespec __user *timeout);
 long compat_ksys_semctl(int semid, int semnum, int cmd, int arg);
+long compat_ksys_shmctl(int shmid, int cmd, void __user *uptr);
 #endif /* CONFIG_COMPAT */
 
 #endif
-- 
2.16.2
