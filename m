From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 35/45] ipc: add shmdt syscall wrapper
Date: Thu, 22 Mar 2018 10:00:49 +0100
Message-ID: <20180322090059.19361-36-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Provide ksys_shmdt() wrapper to avoid in-kernel calls to this syscall.
The ksys_ prefix denotes that this function is meant as a drop-in
replacement for the syscall. In particular, it uses the same calling
convention as sys_shmdt().

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
index 9f3cdb259a51..e5838e3328dc 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1481,7 +1481,7 @@ COMPAT_SYSCALL_DEFINE3(shmat, int, shmid, compat_uptr_t, shmaddr, int, shmflg)
  * detach and kill segment if marked destroyed.
  * The work is done in shm_close.
  */
-SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
+long ksys_shmdt(char __user *shmaddr)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -1588,6 +1588,11 @@ SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
 	return retval;
 }
 
+SYSCALL_DEFINE1(shmdt, char __user *, shmaddr)
+{
+	return ksys_shmdt(shmaddr);
+}
+
 #ifdef CONFIG_PROC_FS
 static int sysvipc_shm_proc_show(struct seq_file *s, void *it)
 {
diff --git a/ipc/syscall.c b/ipc/syscall.c
index 60bceb19b6f0..b3aa71564815 100644
--- a/ipc/syscall.c
+++ b/ipc/syscall.c
@@ -90,7 +90,7 @@ SYSCALL_DEFINE6(ipc, unsigned int, call, int, first, unsigned long, second,
 			return -EINVAL;
 		}
 	case SHMDT:
-		return sys_shmdt((char __user *)ptr);
+		return ksys_shmdt((char __user *)ptr);
 	case SHMGET:
 		return ksys_shmget(first, second, third);
 	case SHMCTL:
@@ -178,7 +178,7 @@ COMPAT_SYSCALL_DEFINE6(ipc, u32, call, int, first, int, second,
 		return put_user(raddr, (compat_ulong_t __user *)compat_ptr(third));
 	}
 	case SHMDT:
-		return sys_shmdt(compat_ptr(ptr));
+		return ksys_shmdt(compat_ptr(ptr));
 	case SHMGET:
 		return ksys_shmget(first, (unsigned int)second, third);
 	case SHMCTL:
diff --git a/ipc/util.h b/ipc/util.h
index 51002c0b2a21..7770bcad1168 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -244,6 +244,7 @@ long ksys_semget(key_t key, int nsems, int semflg);
 long ksys_semctl(int semid, int semnum, int cmd, unsigned long arg);
 long ksys_msgget(key_t key, int msgflg);
 long ksys_shmget(key_t key, size_t size, int shmflg);
+long ksys_shmdt(char __user *shmaddr);
 
 /* for CONFIG_ARCH_WANT_OLD_COMPAT_IPC */
 #ifdef CONFIG_COMPAT
-- 
2.16.2
