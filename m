Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:60857 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262862AbUCOWxl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2004 17:53:41 -0500
Date: Mon, 15 Mar 2004 14:53:28 -0800
Message-Id: <200403152253.i2FMrSE09813@mail.osdl.org>
Subject: [patch 1/1] generic 32 bit emulation for System-V IPC
From: akpm@osdl.org
To: torvalds@osdl.org
Cc: arnd@arndb.de, linux-arch@vger.kernel.orgarnd@arndb.de
List-ID: <linux-arch.vger.kernel.org>


From: Arnd Bergmann <arnd@arndb.de>

Adds a generic implementation of 32 bit emulation for IPC system calls.  The
code is based on the existing implementations for sparc64, ia64, mips, s390,
ppc and x86_64, which can subsequently be converted to use this.


---

 25-akpm/arch/ia64/Kconfig               |    6 
 25-akpm/arch/ia64/ia32/sys_ia32.c       |  605 --------------------------
 25-akpm/arch/s390/Kconfig               |    5 
 25-akpm/arch/s390/kernel/compat_linux.c |  609 +-------------------------
 25-akpm/arch/x86_64/Kconfig             |    4 
 25-akpm/arch/x86_64/ia32/ipc32.c        |  675 -----------------------------
 25-akpm/include/asm-ia64/compat.h       |   59 ++
 25-akpm/include/asm-s390/compat.h       |   60 ++
 25-akpm/include/asm-x86_64/compat.h     |   59 ++
 25-akpm/include/linux/compat.h          |   12 
 25-akpm/ipc/Makefile                    |    1 
 25-akpm/ipc/compat.c                    |  734 ++++++++++++++++++++++++++++++++
 include/linux/msg.h                     |    0 
 13 files changed, 995 insertions(+), 1834 deletions(-)

diff -puN include/linux/compat.h~compat-generic-ipc-emulation include/linux/compat.h
--- 25/include/linux/compat.h~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/include/linux/compat.h	Mon Mar 15 14:22:46 2004
@@ -10,6 +10,8 @@
 
 #include <linux/stat.h>
 #include <linux/param.h>	/* for HZ */
+#include <linux/sem.h>
+
 #include <asm/compat.h>
 
 #define compat_jiffies_to_clock_t(x)	\
@@ -88,5 +90,15 @@ typedef union compat_sigval {
 	compat_uptr_t	sival_ptr;
 } compat_sigval_t;
 
+long compat_sys_semctl(int first, int second, int third, void __user *uptr);
+long compat_sys_msgsnd(int first, int second, int third, void __user *uptr);
+long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
+		int version, void __user *uptr);
+long compat_sys_msgctl(int first, int second, void __user *uptr);
+long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
+		void __user *uptr);
+long compat_sys_shmctl(int first, int second, void __user *uptr);
+long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
+		unsigned nsems, const struct compat_timespec __user *timeout);
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
diff -puN /dev/null ipc/compat.c
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/ipc/compat.c	Mon Mar 15 14:22:21 2004
@@ -0,0 +1,734 @@
+/*
+ * 32 bit compatibility code for System V IPC
+ *
+ * Copyright (C) 1997,1998	Jakub Jelinek (jj@sunsite.mff.cuni.cz)
+ * Copyright (C) 1997		David S. Miller (davem@caip.rutgers.edu)
+ * Copyright (C) 1999		Arun Sharma <arun.sharma@intel.com>
+ * Copyright (C) 2000		VA Linux Co
+ * Copyright (C) 2000		Don Dugger <n0ano@valinux.com>
+ * Copyright (C) 2000           Hewlett-Packard Co.
+ * Copyright (C) 2000           David Mosberger-Tang <davidm@hpl.hp.com>
+ * Copyright (C) 2000           Gerhard Tonn (ton@de.ibm.com)
+ * Copyright (C) 2000-2002      Andi Kleen, SuSE Labs (x86-64 port)
+ * Copyright (C) 2000		Silicon Graphics, Inc.
+ * Copyright (C) 2001		IBM
+ * Copyright (C) 2004		IBM Deutschland Entwicklung GmbH, IBM Corporation
+ * Copyright (C) 2004		Arnd Bergmann (arnd@arndb.de)
+ *
+ * This code is collected from the versions for sparc64, mips64, s390x, ia64,
+ * ppc64 and x86_64, all of which are based on the original sparc64 version
+ * by Jakub Jelinek.
+ *
+ */
+#include <linux/compat.h>
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/highuid.h>
+#include <linux/init.h>
+#include <linux/msg.h>
+#include <linux/shm.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "util.h"
+
+struct compat_msgbuf {
+	compat_long_t mtype;
+	char mtext[1];
+};
+
+struct compat_ipc_perm {
+	key_t key;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_uid_t cuid;
+	compat_gid_t cgid;
+	compat_mode_t mode;
+	unsigned short seq;
+};
+
+struct compat_semid_ds {
+	struct compat_ipc_perm sem_perm;
+	compat_time_t sem_otime;
+	compat_time_t sem_ctime;
+	compat_uptr_t sem_base;
+	compat_uptr_t sem_pending;
+	compat_uptr_t sem_pending_last;
+	compat_uptr_t undo;
+	unsigned short sem_nsems;
+};
+
+struct compat_msqid_ds {
+	struct compat_ipc_perm msg_perm;
+	compat_uptr_t msg_first;
+	compat_uptr_t msg_last;
+	compat_time_t msg_stime;
+	compat_time_t msg_rtime;
+	compat_time_t msg_ctime;
+	compat_ulong_t msg_lcbytes;
+	compat_ulong_t msg_lqbytes;
+	unsigned short msg_cbytes;
+	unsigned short msg_qnum;
+	unsigned short msg_qbytes;
+	compat_ipc_pid_t msg_lspid;
+	compat_ipc_pid_t msg_lrpid;
+};
+
+struct compat_shmid_ds {
+	struct compat_ipc_perm shm_perm;
+	int shm_segsz;
+	compat_time_t shm_atime;
+	compat_time_t shm_dtime;
+	compat_time_t shm_ctime;
+	compat_ipc_pid_t shm_cpid;
+	compat_ipc_pid_t shm_lpid;
+	unsigned short shm_nattch;
+	unsigned short shm_unused;
+	compat_uptr_t shm_unused2;
+	compat_uptr_t shm_unused3;
+};
+
+struct compat_ipc_kludge {
+	compat_uptr_t msgp;
+	compat_long_t msgtyp;
+};
+
+struct compat_shminfo64 {
+	compat_ulong_t shmmax;
+	compat_ulong_t shmmin;
+	compat_ulong_t shmmni;
+	compat_ulong_t shmseg;
+	compat_ulong_t shmall;
+	compat_ulong_t __unused1;
+	compat_ulong_t __unused2;
+	compat_ulong_t __unused3;
+	compat_ulong_t __unused4;
+};
+
+struct compat_shm_info {
+	compat_int_t used_ids;
+	compat_ulong_t shm_tot, shm_rss, shm_swp;
+	compat_ulong_t swap_attempts, swap_successes;
+};
+
+extern int sem_ctls[];
+#define sc_semopm	(sem_ctls[2])
+#define MAXBUF (64*1024)
+
+static inline int compat_ipc_parse_version(int *cmd)
+{
+	int version = *cmd & IPC_64;
+
+	/* this is tricky: architectures that have support for the old
+	 * ipc structures in 64 bit binaries need to have IPC_64 set
+	 * in cmd, the others need to have it cleared */
+#ifndef ipc_parse_version
+	*cmd |= IPC_64;
+#else
+	*cmd &= ~IPC_64;
+#endif
+	return version;
+}
+
+static inline int __get_compat_ipc64_perm(struct ipc64_perm *p64,
+					  struct compat_ipc64_perm *up64)
+{
+	int err;
+
+	err  = __get_user(p64->uid, &up64->uid);
+	err |= __get_user(p64->gid, &up64->gid);
+	err |= __get_user(p64->mode, &up64->mode);
+	return err;
+}
+
+static inline int __get_compat_ipc_perm(struct ipc64_perm *p,
+					struct compat_ipc_perm *up)
+{
+	int err;
+
+	err  = __get_user(p->uid, &up->uid);
+	err |= __get_user(p->gid, &up->gid);
+	err |= __get_user(p->mode, &up->mode);
+	return err;
+}
+
+static inline int __put_compat_ipc64_perm(struct ipc64_perm *p64,
+					  struct compat_ipc64_perm *up64)
+{
+	int err;
+
+	err  = __put_user(p64->key, &up64->key);
+	err |= __put_user(p64->uid, &up64->uid);
+	err |= __put_user(p64->gid, &up64->gid);
+	err |= __put_user(p64->cuid, &up64->cuid);
+	err |= __put_user(p64->cgid, &up64->cgid);
+	err |= __put_user(p64->mode, &up64->mode);
+	err |= __put_user(p64->seq, &up64->seq);
+	return err;
+}
+
+static inline int __put_compat_ipc_perm(struct ipc64_perm *p,
+					struct compat_ipc_perm *up)
+{
+	int err;
+	compat_uid_t u;
+	compat_gid_t g;
+
+	err  = __put_user(p->key, &up->key);
+	SET_UID(u, p->uid);
+	err |= __put_user(u, &up->uid);
+	SET_GID(g, p->gid);
+	err |= __put_user(g, &up->gid);
+	SET_UID(u, p->cuid);
+	err |= __put_user(u, &up->cuid);
+	SET_GID(g, p->cgid);
+	err |= __put_user(g, &up->cgid);
+	err |= __put_user(p->mode, &up->mode);
+	err |= __put_user(p->seq, &up->seq);
+	return err;
+}
+
+static inline int get_compat_semid64_ds(struct semid64_ds *s64,
+					struct compat_semid64_ds *up64)
+{
+	if (!access_ok (VERIFY_READ, up64, sizeof(*up64)))
+		return -EFAULT;
+	return __get_compat_ipc64_perm(&s64->sem_perm, &up64->sem_perm);
+}
+
+static inline int get_compat_semid_ds(struct semid64_ds *s,
+				      struct compat_semid_ds *up)
+{
+	if (!access_ok (VERIFY_READ, up, sizeof(*up)))
+		return -EFAULT;
+	return __get_compat_ipc_perm(&s->sem_perm, &up->sem_perm);
+}
+
+static inline int put_compat_semid64_ds(struct semid64_ds *s64,
+					struct compat_semid64_ds *up64)
+{
+	int err;
+
+	if (!access_ok (VERIFY_WRITE, up64, sizeof(*up64)))
+		return -EFAULT;
+	err  = __put_compat_ipc64_perm(&s64->sem_perm, &up64->sem_perm);
+	err |= __put_user(s64->sem_otime, &up64->sem_otime);
+	err |= __put_user(s64->sem_ctime, &up64->sem_ctime);
+	err |= __put_user(s64->sem_nsems, &up64->sem_nsems);
+	return err;
+}
+
+static inline int put_compat_semid_ds(struct semid64_ds *s,
+				      struct compat_semid_ds *up)
+{
+	int err;
+
+	if (!access_ok (VERIFY_WRITE, up, sizeof(*up)))
+		err = -EFAULT;
+	err  = __put_compat_ipc_perm(&s->sem_perm, &up->sem_perm);
+	err |= __put_user(s->sem_otime, &up->sem_otime);
+	err |= __put_user(s->sem_ctime, &up->sem_ctime);
+	err |= __put_user(s->sem_nsems, &up->sem_nsems);
+	return err;
+}
+
+static inline int do_semctl(int semid, int semnum, int cmd, union semun arg)
+{
+	mm_segment_t old_fs;
+	int err;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_semctl(semid, semnum, cmd, arg);
+	set_fs(old_fs);
+
+	return err;
+}
+long compat_sys_semctl(int first, int second, int third, void __user *uptr)
+{
+	union semun fourth;
+	u32 pad;
+	int err, err2;
+	struct semid64_ds s64;
+	int version = compat_ipc_parse_version(&third);
+
+	if (!uptr)
+		return -EINVAL;
+	if (get_user(pad, (u32 __user *) uptr))
+		return -EFAULT;
+	if ((third & (~IPC_64)) == SETVAL)
+		fourth.val = (int) pad;
+	else
+		fourth.__pad = compat_ptr(pad);
+	switch (third & (~IPC_64)) {
+	case IPC_INFO:
+	case IPC_RMID:
+	case SEM_INFO:
+	case GETVAL:
+	case GETPID:
+	case GETNCNT:
+	case GETZCNT:
+	case GETALL:
+	case SETVAL:
+	case SETALL:
+		err = sys_semctl(first, second, third, fourth);
+		break;
+
+	case IPC_STAT:
+	case SEM_STAT:
+		fourth.__pad = &s64;
+		err = do_semctl(first, second, third, fourth);
+		if (err < 0)
+			break;
+
+		if (version == IPC_64) {
+			err2 = put_compat_semid64_ds(&s64, compat_ptr(pad));
+		} else {
+			err2 = put_compat_semid_ds(&s64, compat_ptr(pad));
+		}
+		if (err2)
+			err = -EFAULT;
+		break;
+
+	case IPC_SET:
+		if (version == IPC_64) {
+			err = get_compat_semid64_ds(&s64, compat_ptr(pad));
+		} else {
+			err = get_compat_semid_ds(&s64, compat_ptr(pad));
+		}
+		if (err)
+			break;
+
+		fourth.__pad = &s64;
+		err = do_semctl(first, second, third, fourth);
+		break;
+
+	default:
+		err = -EINVAL;
+		break;
+	}
+	return err;
+}
+
+long compat_sys_msgsnd(int first, int second, int third, void __user *uptr)
+{
+	struct msgbuf *p;
+	struct compat_msgbuf __user *up;
+	mm_segment_t old_fs;
+	int err;
+
+	if (first < 0)
+		return -EINVAL;
+	if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
+		return -EINVAL;
+
+	p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
+	if (!p)
+		return -ENOMEM;
+	err = -EFAULT;
+	up = uptr;
+	if (get_user(p->mtype, &up->mtype) ||
+	    copy_from_user(p->mtext, &up->mtext, second))
+		goto out;
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_msgsnd(first, p, second, third);
+	set_fs(old_fs);
+out:
+	kfree(p);
+	return err;
+}
+
+long compat_sys_msgrcv(int first, int second, int msgtyp, int third,
+			   int version, void __user *uptr)
+{
+	struct msgbuf *p;
+	struct compat_msgbuf __user *up;
+	mm_segment_t old_fs;
+	int err;
+
+	if (first < 0)
+		return -EINVAL;
+	if (second < 0 || (second >= MAXBUF - sizeof(struct msgbuf)))
+		return -EINVAL;
+
+	if (!version) {
+		struct compat_ipc_kludge __user *uipck = uptr;
+		struct compat_ipc_kludge ipck;
+
+		err = -EINVAL;
+		if (!uptr)
+			goto out;
+		err = -EFAULT;
+		if (copy_from_user (&ipck, uipck, sizeof(ipck)))
+			goto out;
+		uptr = compat_ptr(ipck.msgp);
+		msgtyp = ipck.msgtyp;
+	}
+	err = -ENOMEM;
+	p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
+	if (!p)
+		goto out;
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_msgrcv(first, p, second, msgtyp, third);
+	set_fs(old_fs);
+	if (err < 0)
+		goto free_then_out;
+	up = uptr;
+	if (put_user(p->mtype, &up->mtype) ||
+	    __copy_to_user(&up->mtext, p->mtext, err))
+		err = -EFAULT;
+free_then_out:
+	kfree(p);
+out:
+	return err;
+}
+
+static inline int get_compat_msqid64(struct msqid64_ds *m64,
+				     struct compat_msqid64_ds __user *up64)
+{
+	int err;
+
+	if (!access_ok(VERIFY_READ, up64, sizeof(*up64)))
+		return -EFAULT;
+	err  = __get_compat_ipc64_perm(&m64->msg_perm, &up64->msg_perm);
+	err |= __get_user(m64->msg_qbytes, &up64->msg_qbytes);
+	return err;
+}
+
+static inline int get_compat_msqid(struct msqid64_ds *m,
+				   struct compat_msqid_ds __user *up)
+{
+	int err;
+
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)))
+		return -EFAULT;
+	err  = __get_compat_ipc_perm(&m->msg_perm, &up->msg_perm);
+	err |= __get_user(m->msg_qbytes, &up->msg_qbytes);
+	return err;
+}
+
+static inline int put_compat_msqid64_ds(struct msqid64_ds *m64,
+				 struct compat_msqid64_ds __user __user *up64)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64)))
+		return -EFAULT;
+	err  = __put_compat_ipc64_perm(&m64->msg_perm, &up64->msg_perm);
+	err |= __put_user(m64->msg_stime, &up64->msg_stime);
+	err |= __put_user(m64->msg_rtime, &up64->msg_rtime);
+	err |= __put_user(m64->msg_ctime, &up64->msg_ctime);
+	err |= __put_user(m64->msg_cbytes, &up64->msg_cbytes);
+	err |= __put_user(m64->msg_qnum, &up64->msg_qnum);
+	err |= __put_user(m64->msg_qbytes, &up64->msg_qbytes);
+	err |= __put_user(m64->msg_lspid, &up64->msg_lspid);
+	err |= __put_user(m64->msg_lrpid, &up64->msg_lrpid);
+	return err;
+}
+
+static inline int put_compat_msqid_ds(struct msqid64_ds *m,
+				      struct compat_msqid_ds __user *up)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)))
+		return -EFAULT;
+	err  = __put_compat_ipc_perm(&m->msg_perm, &up->msg_perm);
+	err |= __put_user(m->msg_stime, &up->msg_stime);
+	err |= __put_user(m->msg_rtime, &up->msg_rtime);
+	err |= __put_user(m->msg_ctime, &up->msg_ctime);
+	err |= __put_user(m->msg_cbytes, &up->msg_cbytes);
+	err |= __put_user(m->msg_qnum, &up->msg_qnum);
+	err |= __put_user(m->msg_qbytes, &up->msg_qbytes);
+	err |= __put_user(m->msg_lspid, &up->msg_lspid);
+	err |= __put_user(m->msg_lrpid, &up->msg_lrpid);
+	return err;
+}
+
+static inline int do_msgctl(int first, int second, void __user *buf)
+{
+	mm_segment_t old_fs;
+	int err;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_msgctl(first, second, buf);
+	set_fs(old_fs);
+
+	return err;
+}
+
+long compat_sys_msgctl(int first, int second, void __user *uptr)
+{
+	int err, err2;
+	struct msqid64_ds m64;
+	int version = compat_ipc_parse_version(&second);
+
+	switch (second & (~IPC_64)) {
+	case IPC_INFO:
+	case IPC_RMID:
+	case MSG_INFO:
+		err = sys_msgctl(first, second, uptr);
+		break;
+
+	case IPC_SET:
+		if (version == IPC_64) {
+			err = get_compat_msqid64(&m64, uptr);
+		} else {
+			err = get_compat_msqid(&m64, uptr);
+		}
+		if (err)
+			break;
+
+		err = do_msgctl(first, second, &m64);
+		break;
+
+	case IPC_STAT:
+	case MSG_STAT:
+		err = do_msgctl(first, second, &m64);
+		if (err < 0)
+			break;
+
+		if (version == IPC_64) {
+			err2 = put_compat_msqid64_ds(&m64, uptr);
+		} else {
+			err2 = put_compat_msqid_ds(&m64, uptr);
+		}
+		if (err2)
+			err = -EFAULT;
+		break;
+
+	default:
+		err = -EINVAL;
+		break;
+	}
+	return err;
+}
+
+long compat_sys_shmat(int first, int second, compat_uptr_t third, int version,
+			void __user *uptr)
+{
+	int err;
+	unsigned long raddr;
+	compat_ulong_t __user *uaddr;
+
+	if (version == 1)
+		return -EINVAL;
+	err = do_shmat(first, uptr, second, &raddr);
+	if (err < 0)
+		return err;
+	uaddr = compat_ptr(third);
+	return put_user(raddr, uaddr);
+}
+
+static inline int get_compat_shmid64_ds(struct shmid64_ds *s64,
+					struct compat_shmid64_ds __user *up64)
+{
+	if (!access_ok(VERIFY_READ, up64, sizeof(*up64)))
+		return -EFAULT;
+	return __get_compat_ipc64_perm(&s64->shm_perm, &up64->shm_perm);
+}
+
+static inline int get_compat_shmid_ds(struct shmid64_ds *s,
+				      struct compat_shmid_ds __user *up)
+{
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)))
+		return -EFAULT;
+	return __get_compat_ipc_perm(&s->shm_perm, &up->shm_perm);
+}
+
+static inline int put_compat_shmid64_ds(struct shmid64_ds *s64,
+					struct compat_shmid64_ds __user *up64)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64)))
+		return -EFAULT;
+	err  = __put_compat_ipc64_perm(&s64->shm_perm, &up64->shm_perm);
+	err |= __put_user(s64->shm_atime, &up64->shm_atime);
+	err |= __put_user(s64->shm_dtime, &up64->shm_dtime);
+	err |= __put_user(s64->shm_ctime, &up64->shm_ctime);
+	err |= __put_user(s64->shm_segsz, &up64->shm_segsz);
+	err |= __put_user(s64->shm_nattch, &up64->shm_nattch);
+	err |= __put_user(s64->shm_cpid, &up64->shm_cpid);
+	err |= __put_user(s64->shm_lpid, &up64->shm_lpid);
+	return err;
+}
+
+static inline int put_compat_shmid_ds(struct shmid64_ds *s,
+				      struct compat_shmid_ds __user *up)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)))
+		return -EFAULT;
+	err  = __put_compat_ipc_perm(&s->shm_perm, &up->shm_perm);
+	err |= __put_user(s->shm_atime, &up->shm_atime);
+	err |= __put_user(s->shm_dtime, &up->shm_dtime);
+	err |= __put_user(s->shm_ctime, &up->shm_ctime);
+	err |= __put_user(s->shm_segsz, &up->shm_segsz);
+	err |= __put_user(s->shm_nattch, &up->shm_nattch);
+	err |= __put_user(s->shm_cpid, &up->shm_cpid);
+	err |= __put_user(s->shm_lpid, &up->shm_lpid);
+	return err;
+}
+
+static inline int put_compat_shminfo64(struct shminfo64 *smi,
+				       struct compat_shminfo64 __user *up64)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64)))
+		return -EFAULT;
+	err  = __put_user(smi->shmmax, &up64->shmmax);
+	err |= __put_user(smi->shmmin, &up64->shmmin);
+	err |= __put_user(smi->shmmni, &up64->shmmni);
+	err |= __put_user(smi->shmseg, &up64->shmseg);
+	err |= __put_user(smi->shmall, &up64->shmall);
+	return err;
+}
+
+static inline int put_compat_shminfo(struct shminfo64 *smi,
+				     struct shminfo __user *up)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)))
+		return -EFAULT;
+	err  = __put_user(smi->shmmax, &up->shmmax);
+	err |= __put_user(smi->shmmin, &up->shmmin);
+	err |= __put_user(smi->shmmni, &up->shmmni);
+	err |= __put_user(smi->shmseg, &up->shmseg);
+	err |= __put_user(smi->shmall, &up->shmall);
+}
+
+static inline int put_compat_shm_info(struct shm_info *si,
+				      struct compat_shm_info __user *uip)
+{
+	int err;
+
+	if (!access_ok(VERIFY_WRITE, uip, sizeof(*uip)))
+		return -EFAULT;
+	err  = __put_user(si->used_ids, &uip->used_ids);
+	err |= __put_user(si->shm_tot, &uip->shm_tot);
+	err |= __put_user(si->shm_rss, &uip->shm_rss);
+	err |= __put_user(si->shm_swp, &uip->shm_swp);
+	err |= __put_user(si->swap_attempts, &uip->swap_attempts);
+	err |= __put_user(si->swap_successes, &uip->swap_successes);
+	return err;
+}
+
+static inline int do_shmctl(int shmid, int cmd, void *buf)
+{
+	mm_segment_t old_fs;
+	int err;
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_shmctl(shmid, cmd, buf);
+	set_fs(old_fs);
+
+	return err;
+}
+
+long compat_sys_shmctl(int first, int second, void __user *uptr)
+{
+	struct shmid64_ds s64;
+	struct shminfo64 smi;
+	struct shm_info si;
+	int err, err2;
+	int version = compat_ipc_parse_version(&second);
+
+	switch (second & (~IPC_64)) {
+	case IPC_RMID:
+	case SHM_LOCK:
+	case SHM_UNLOCK:
+		err = sys_shmctl(first, second, uptr);
+		break;
+
+	case IPC_INFO:
+		err = do_shmctl(first, second, &smi);
+		if (err < 0)
+			break;
+
+		if (version == IPC_64) {
+			err2 = put_compat_shminfo64(&smi, uptr);
+		} else {
+			err2 = put_compat_shminfo(&smi, uptr);
+		}
+		if (err2)
+			err = -EFAULT;
+		break;
+
+
+	case IPC_SET:
+		if (version == IPC_64) {
+			err = get_compat_shmid64_ds(&s64, uptr);
+		} else {
+			err = get_compat_shmid_ds(&s64, uptr);
+		}
+		if (err)
+			break;
+
+		err = do_shmctl(first, second, &s64);
+		break;
+
+	case IPC_STAT:
+	case SHM_STAT:
+		err = do_shmctl(first, second, &s64);
+		if (err < 0)
+			break;
+
+		if (version == IPC_64) {
+			err2 = put_compat_shmid64_ds(&s64, uptr);
+		} else {
+			err2 = put_compat_shmid_ds(&s64, uptr);
+		}
+		if (err2)
+			err = -EFAULT;
+		break;
+
+	case SHM_INFO:
+		err = do_shmctl(first, second, &si);
+		if (err < 0)
+			break;
+		err2 = put_compat_shm_info(&si, uptr);
+		if (err2)
+			err = -EFAULT;
+		break;
+
+	default:
+		err = -EINVAL;
+		break;
+	}
+	return err;
+}
+
+long compat_sys_semtimedop(int semid, struct sembuf __user *tsems,
+		unsigned nsops, const struct compat_timespec __user *timeout)
+{
+	struct timespec ts, __user *ts64;
+
+	/* parameter checking precedence should mirror sys_semtimedop() */
+	if (nsops < 1 || semid < 0)
+		return -EINVAL;
+	if (nsops > sc_semopm)
+		return -E2BIG;
+	if (!access_ok(VERIFY_READ, tsems, nsops * sizeof(struct sembuf)))
+		return -EFAULT;
+	if (!timeout)
+		return sys_semtimedop(semid, tsems, nsops, 0);
+
+	ts64 = compat_alloc_user_space(sizeof(*ts64));
+	if (get_compat_timespec(&ts, timeout))
+		return -EFAULT;
+	if (copy_to_user(ts64, &ts, sizeof(ts)))
+		return -EFAULT;
+
+	return sys_semtimedop(semid, tsems, nsops, ts64);
+}
diff -puN ipc/Makefile~compat-generic-ipc-emulation ipc/Makefile
--- 25/ipc/Makefile~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/ipc/Makefile	Mon Mar 15 14:22:21 2004
@@ -4,4 +4,5 @@
 
 obj-y   := util.o
 
+obj-$(CONFIG_SYSVIPC_COMPAT) += compat.o
 obj-$(CONFIG_SYSVIPC) += msg.o sem.o shm.o
diff -puN arch/s390/Kconfig~compat-generic-ipc-emulation arch/s390/Kconfig
--- 25/arch/s390/Kconfig~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/arch/s390/Kconfig	Mon Mar 15 14:22:21 2004
@@ -143,6 +143,11 @@ config COMPAT
 	depends on S390_SUPPORT
 	default y
 
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
+
 config BINFMT_ELF32
 	tristate "Kernel support for 31 bit ELF binaries"
 	depends on S390_SUPPORT
diff -puN arch/s390/kernel/compat_linux.c~compat-generic-ipc-emulation arch/s390/kernel/compat_linux.c
--- 25/arch/s390/kernel/compat_linux.c~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/arch/s390/kernel/compat_linux.c	Mon Mar 15 14:22:21 2004
@@ -293,541 +293,6 @@ static inline long put_tv32(struct compa
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-struct msgbuf32 { s32 mtype; char mtext[1]; };
-
-struct ipc64_perm_ds32
-{
-        __kernel_key_t          key;
-        __kernel_uid32_t        uid;
-        __kernel_gid32_t        gid;
-        __kernel_uid32_t        cuid;
-        __kernel_gid32_t        cgid;
-        compat_mode_t       mode;
-        unsigned short          __pad1;
-        unsigned short          seq;
-        unsigned short          __pad2;
-        unsigned int            __unused1;
-        unsigned int            __unused2;
-};
-
-struct ipc_perm32
-{
-	key_t    	  key;
-        compat_uid_t  uid;
-        compat_gid_t  gid;
-        compat_uid_t  cuid;
-        compat_gid_t  cgid;
-        compat_mode_t mode;
-        unsigned short  seq;
-};
-
-struct semid_ds32 {
-        struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-        compat_time_t   sem_otime;              /* last semop time */
-        compat_time_t   sem_ctime;              /* last change time */
-        u32 sem_base;              /* ptr to first semaphore in array */
-        u32 sem_pending;          /* pending operations to be processed */
-        u32 sem_pending_last;    /* last pending operation */
-        u32 undo;                  /* undo requests on this array */
-        unsigned short  sem_nsems;              /* no. of semaphores in array */
-};
-
-struct semid64_ds32 {
-	struct ipc64_perm_ds32 sem_perm;
-	unsigned int	  __pad1;
-	compat_time_t   sem_otime;
-	unsigned int	  __pad2;
-	compat_time_t   sem_ctime;
-	u32 sem_nsems;
-	u32 __unused1;
-	u32 __unused2;
-};
-
-struct msqid_ds32
-{
-        struct ipc_perm32 msg_perm;
-        u32 msg_first;
-        u32 msg_last;
-        compat_time_t   msg_stime;
-        compat_time_t   msg_rtime;
-        compat_time_t   msg_ctime;
-        u32 wwait;
-        u32 rwait;
-        unsigned short msg_cbytes;
-        unsigned short msg_qnum;  
-        unsigned short msg_qbytes;
-        compat_ipc_pid_t msg_lspid;
-        compat_ipc_pid_t msg_lrpid;
-};
-
-struct msqid64_ds32 {
-	struct ipc64_perm_ds32 msg_perm;
-	unsigned int   __pad1;
-	compat_time_t msg_stime;
-	unsigned int   __pad2;
-	compat_time_t msg_rtime;
-	unsigned int   __pad3;
-	compat_time_t msg_ctime;
-	unsigned int  msg_cbytes;
-	unsigned int  msg_qnum;
-	unsigned int  msg_qbytes;
-	compat_pid_t msg_lspid;
-	compat_pid_t msg_lrpid;
-	unsigned int  __unused1;
-	unsigned int  __unused2;
-};
-
-
-struct shmid_ds32 {
-	struct ipc_perm32       shm_perm;
-	int                     shm_segsz;
-	compat_time_t         shm_atime;
-	compat_time_t         shm_dtime;
-	compat_time_t         shm_ctime;
-	compat_ipc_pid_t    shm_cpid; 
-	compat_ipc_pid_t    shm_lpid; 
-	unsigned short          shm_nattch;
-};
-
-struct shmid64_ds32 {
-	struct ipc64_perm_ds32	shm_perm;
-	compat_size_t	shm_segsz;
-	compat_time_t  	shm_atime;
-	unsigned int		__unused1;
-	compat_time_t  	shm_dtime;
-	unsigned int		__unused2;
-	compat_time_t  	shm_ctime;
-	unsigned int		__unused3;
-	compat_pid_t	shm_cpid;
-	compat_pid_t	shm_lpid;
-	unsigned int		shm_nattch;
-	unsigned int		__unused4;
-	unsigned int		__unused5;
-};
-
-extern int sem_ctls[];
-#define sc_semopm	(sem_ctls[2])
-#define SEMOPM_FAST	64  /* ~ 372 bytes on stack */
-
-static long
-do_sys32_semtimedop (int semid, struct sembuf *tsops, int nsops,
-		     struct compat_timespec *timeout32)
-{
-	struct sembuf *sops, fast_sops[SEMOPM_FAST];
-	struct timespec t;
-	mm_segment_t oldfs;
-	long ret;
-
-	/* parameter checking precedence should mirror sys_semtimedop() */
-	if (nsops < 1 || semid < 0)
-		return -EINVAL;
-	if (nsops > sc_semopm)
-		return -E2BIG;
-	if (nsops <= SEMOPM_FAST)
-		sops = fast_sops;
-	else {
-		sops = kmalloc(nsops * sizeof(*sops), GFP_KERNEL);
-		if (sops == NULL)
-			return -ENOMEM;
-	}
-	if (copy_from_user(sops, tsops, nsops * sizeof(*tsops)) ||
-	    get_compat_timespec(&t, timeout32))
-		ret = -EFAULT;
-	else {
-		oldfs = get_fs();
-		set_fs(KERNEL_DS);
-		ret = sys_semtimedop(semid, sops, nsops, &t);
-		set_fs(oldfs);
-	}
-	if (sops != fast_sops)
-		kfree(sops);
-	return ret;
-}
-
-#define IPCOP_MASK(__x)	(1UL << (__x))
-static int do_sys32_semctl(int first, int second, int third, void *uptr)
-{
-	union semun fourth;
-	u32 pad;
-	int err = -EINVAL;
-
-	if (!uptr)
-		goto out;
-	err = -EFAULT;
-	if (get_user (pad, (u32 *)uptr))
-		goto out;
-	if(third == SETVAL)
-		fourth.val = (int)pad;
-	else
-		fourth.__pad = (void *)A(pad);
-	if (IPCOP_MASK (third) &
-	    (IPCOP_MASK (IPC_INFO) | IPCOP_MASK (SEM_INFO) | IPCOP_MASK (GETVAL) |
-	     IPCOP_MASK (GETPID) | IPCOP_MASK (GETNCNT) | IPCOP_MASK (GETZCNT) |
-	     IPCOP_MASK (GETALL) | IPCOP_MASK (SETALL) | IPCOP_MASK (IPC_RMID))) {
-		err = sys_semctl (first, second, third, fourth);
-	} else if (third & IPC_64) {
-		struct semid64_ds s;
-		struct semid64_ds32 *usp = (struct semid64_ds32 *)A(pad);
-		mm_segment_t old_fs;
-		int need_back_translation;
-
-		if (third == (IPC_SET|IPC_64)) {
-			err = get_user (s.sem_perm.uid, &usp->sem_perm.uid);
-			err |= __get_user (s.sem_perm.gid, &usp->sem_perm.gid);
-			err |= __get_user (s.sem_perm.mode, &usp->sem_perm.mode);
-			if (err)
-				goto out;
-			fourth.__pad = &s;
-		}
-		need_back_translation =
-			(IPCOP_MASK (third) &
-			 (IPCOP_MASK (SEM_STAT) | IPCOP_MASK (IPC_STAT))) != 0;
-		if (need_back_translation)
-			fourth.__pad = &s;
-		old_fs = get_fs ();
-		set_fs (KERNEL_DS);
-		err = sys_semctl (first, second, third, fourth);
-		set_fs (old_fs);
-		if (need_back_translation) {
-			int err2 = put_user (s.sem_perm.key, &usp->sem_perm.key);
-			err2 |= __put_user (high2lowuid(s.sem_perm.uid), &usp->sem_perm.uid);
-			err2 |= __put_user (high2lowgid(s.sem_perm.gid), &usp->sem_perm.gid);
-			err2 |= __put_user (high2lowuid(s.sem_perm.cuid), &usp->sem_perm.cuid);
-			err2 |= __put_user (high2lowgid(s.sem_perm.cgid), &usp->sem_perm.cgid);
-			err2 |= __put_user (s.sem_perm.mode, &usp->sem_perm.mode);
-			err2 |= __put_user (s.sem_perm.seq, &usp->sem_perm.seq);
-			err2 |= __put_user (s.sem_otime, &usp->sem_otime);
-			err2 |= __put_user (s.sem_ctime, &usp->sem_ctime);
-			err2 |= __put_user (s.sem_nsems, &usp->sem_nsems);
-			if (err2) err = -EFAULT;
-		}
-	} else {
-		struct semid_ds s;
-		struct semid_ds32 *usp = (struct semid_ds32 *)A(pad);
-		mm_segment_t old_fs;
-		int need_back_translation;
-
-		if (third == IPC_SET) {
-			err = get_user (s.sem_perm.uid, &usp->sem_perm.uid);
-			err |= __get_user (s.sem_perm.gid, &usp->sem_perm.gid);
-			err |= __get_user (s.sem_perm.mode, &usp->sem_perm.mode);
-			if (err)
-				goto out;
-			fourth.__pad = &s;
-		}
-		need_back_translation =
-			(IPCOP_MASK (third) &
-			 (IPCOP_MASK (SEM_STAT) | IPCOP_MASK (IPC_STAT))) != 0;
-		if (need_back_translation)
-			fourth.__pad = &s;
-		old_fs = get_fs ();
-		set_fs (KERNEL_DS);
-		err = sys_semctl (first, second, third, fourth);
-		set_fs (old_fs);
-		if (need_back_translation) {
-			int err2 = put_user (s.sem_perm.key, &usp->sem_perm.key);
-			err2 |= __put_user (high2lowuid(s.sem_perm.uid), &usp->sem_perm.uid);
-			err2 |= __put_user (high2lowgid(s.sem_perm.gid), &usp->sem_perm.gid);
-			err2 |= __put_user (high2lowuid(s.sem_perm.cuid), &usp->sem_perm.cuid);
-			err2 |= __put_user (high2lowgid(s.sem_perm.cgid), &usp->sem_perm.cgid);
-			err2 |= __put_user (s.sem_perm.mode, &usp->sem_perm.mode);
-			err2 |= __put_user (s.sem_perm.seq, &usp->sem_perm.seq);
-			err2 |= __put_user (s.sem_otime, &usp->sem_otime);
-			err2 |= __put_user (s.sem_ctime, &usp->sem_ctime);
-			err2 |= __put_user (s.sem_nsems, &usp->sem_nsems);
-			if (err2) err = -EFAULT;
-		}
-	}
-out:
-	return err;
-}
-
-static int do_sys32_msgsnd (int first, int second, int third, void *uptr)
-{
-	struct msgbuf *p = kmalloc (second + sizeof (struct msgbuf), GFP_USER);
-	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
-	mm_segment_t old_fs;
-	int err;
-
-	if (!p)
-		return -ENOMEM;
-
-	err = -EINVAL;
-	if (second > MSGMAX || first < 0 || second < 0)
-		goto out;
-
-	err = -EFAULT;
-	if (!uptr)
-		goto out;
-        if (get_user (p->mtype, &up->mtype) ||
-	    __copy_from_user (p->mtext, &up->mtext, second))
-		goto out;
-	old_fs = get_fs ();
-	set_fs (KERNEL_DS);
-	err = sys_msgsnd (first, p, second, third);
-	set_fs (old_fs);
-out:
-	kfree (p);
-	return err;
-}
-
-static int do_sys32_msgrcv (int first, int second, int msgtyp, int third,
-			    int version, void *uptr)
-{
-	struct msgbuf32 *up;
-	struct msgbuf *p;
-	mm_segment_t old_fs;
-	int err;
-
-	if (first < 0 || second < 0)
-		return -EINVAL;
-
-	if (!version) {
-		struct ipc_kludge_32 *uipck = (struct ipc_kludge_32 *)uptr;
-		struct ipc_kludge_32 ipck;
-
-		err = -EINVAL;
-		if (!uptr)
-			goto out;
-		err = -EFAULT;
-		if (copy_from_user (&ipck, uipck, sizeof (struct ipc_kludge_32)))
-			goto out;
-		uptr = (void *)A(ipck.msgp);
-		msgtyp = ipck.msgtyp;
-	}
-	err = -ENOMEM;
-	p = kmalloc (second + sizeof (struct msgbuf), GFP_USER);
-	if (!p)
-		goto out;
-	old_fs = get_fs ();
-	set_fs (KERNEL_DS);
-	err = sys_msgrcv (first, p, second, msgtyp, third);
-	set_fs (old_fs);
-	if (err < 0)
-		goto free_then_out;
-	up = (struct msgbuf32 *)uptr;
-	if (put_user (p->mtype, &up->mtype) ||
-	    __copy_to_user (&up->mtext, p->mtext, err))
-		err = -EFAULT;
-free_then_out:
-	kfree (p);
-out:
-	return err;
-}
-
-static int do_sys32_msgctl (int first, int second, void *uptr)
-{
-	int err;
-
-	if (IPCOP_MASK (second) &
-	    (IPCOP_MASK (IPC_INFO) | IPCOP_MASK (MSG_INFO) |
-	     IPCOP_MASK (IPC_RMID))) {
-		err = sys_msgctl (first, second, (struct msqid_ds *)uptr);
-	} else if (second & IPC_64) {
-		struct msqid64_ds m;
-		struct msqid64_ds32 *up = (struct msqid64_ds32 *)uptr;
-		mm_segment_t old_fs;
-
-		if (second == (IPC_SET|IPC_64)) {
-			err = get_user (m.msg_perm.uid, &up->msg_perm.uid);
-			err |= __get_user (m.msg_perm.gid, &up->msg_perm.gid);
-			err |= __get_user (m.msg_perm.mode, &up->msg_perm.mode);
-			err |= __get_user (m.msg_qbytes, &up->msg_qbytes);
-			if (err)
-				goto out;
-		}
-		old_fs = get_fs ();
-		set_fs (KERNEL_DS);
-		err = sys_msgctl (first, second, (struct msqid_ds *)&m);
-		set_fs (old_fs);
-		if (IPCOP_MASK (second) &
-		    (IPCOP_MASK (MSG_STAT) | IPCOP_MASK (IPC_STAT))) {
-			int err2 = put_user (m.msg_perm.key, &up->msg_perm.key);
-			err2 |= __put_user (high2lowuid(m.msg_perm.uid), &up->msg_perm.uid);
-			err2 |= __put_user (high2lowgid(m.msg_perm.gid), &up->msg_perm.gid);
-			err2 |= __put_user (high2lowuid(m.msg_perm.cuid), &up->msg_perm.cuid);
-			err2 |= __put_user (high2lowgid(m.msg_perm.cgid), &up->msg_perm.cgid);
-			err2 |= __put_user (m.msg_perm.mode, &up->msg_perm.mode);
-			err2 |= __put_user (m.msg_perm.seq, &up->msg_perm.seq);
-			err2 |= __put_user (m.msg_stime, &up->msg_stime);
-			err2 |= __put_user (m.msg_rtime, &up->msg_rtime);
-			err2 |= __put_user (m.msg_ctime, &up->msg_ctime);
-			err2 |= __put_user (m.msg_cbytes, &up->msg_cbytes);
-			err2 |= __put_user (m.msg_qnum, &up->msg_qnum);
-			err2 |= __put_user (m.msg_qbytes, &up->msg_qbytes);
-			err2 |= __put_user (m.msg_lspid, &up->msg_lspid);
-			err2 |= __put_user (m.msg_lrpid, &up->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		}
-	} else {
-		struct msqid_ds m;
-		struct msqid_ds32 *up = (struct msqid_ds32 *)uptr;
-		mm_segment_t old_fs;
-
-		if (second == IPC_SET) {
-			err = get_user (m.msg_perm.uid, &up->msg_perm.uid);
-			err |= __get_user (m.msg_perm.gid, &up->msg_perm.gid);
-			err |= __get_user (m.msg_perm.mode, &up->msg_perm.mode);
-			err |= __get_user (m.msg_qbytes, &up->msg_qbytes);
-			if (err)
-				goto out;
-		}
-		old_fs = get_fs ();
-		set_fs (KERNEL_DS);
-		err = sys_msgctl (first, second, &m);
-		set_fs (old_fs);
-		if (IPCOP_MASK (second) &
-		    (IPCOP_MASK (MSG_STAT) | IPCOP_MASK (IPC_STAT))) {
-			int err2 = put_user (m.msg_perm.key, &up->msg_perm.key);
-			err2 |= __put_user (high2lowuid(m.msg_perm.uid), &up->msg_perm.uid);
-			err2 |= __put_user (high2lowgid(m.msg_perm.gid), &up->msg_perm.gid);
-			err2 |= __put_user (high2lowuid(m.msg_perm.cuid), &up->msg_perm.cuid);
-			err2 |= __put_user (high2lowgid(m.msg_perm.cgid), &up->msg_perm.cgid);
-			err2 |= __put_user (m.msg_perm.mode, &up->msg_perm.mode);
-			err2 |= __put_user (m.msg_perm.seq, &up->msg_perm.seq);
-			err2 |= __put_user (m.msg_stime, &up->msg_stime);
-			err2 |= __put_user (m.msg_rtime, &up->msg_rtime);
-			err2 |= __put_user (m.msg_ctime, &up->msg_ctime);
-			err2 |= __put_user (m.msg_cbytes, &up->msg_cbytes);
-			err2 |= __put_user (m.msg_qnum, &up->msg_qnum);
-			err2 |= __put_user (m.msg_qbytes, &up->msg_qbytes);
-			err2 |= __put_user (m.msg_lspid, &up->msg_lspid);
-			err2 |= __put_user (m.msg_lrpid, &up->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		}
-	}
-
-out:
-	return err;
-}
-
-static int do_sys32_shmat (int first, int second, int third, int version, void *uptr)
-{
-	unsigned long raddr;
-	u32 *uaddr = (u32 *)A((u32)third);
-	int err = -EINVAL;
-
-	if (version == 1)
-		goto out;
-	err = do_shmat (first, uptr, second, &raddr);
-	if (err)
-		goto out;
-	err = put_user (raddr, uaddr);
-out:
-	return err;
-}
-
-static int do_sys32_shmctl (int first, int second, void *uptr)
-{
-	int err;
-
-	if (IPCOP_MASK (second) &
-	    (IPCOP_MASK (IPC_INFO) | IPCOP_MASK (SHM_LOCK) | IPCOP_MASK (SHM_UNLOCK) |
-	     IPCOP_MASK (IPC_RMID))) {
-		if (second == (IPC_INFO|IPC_64))
-			second = IPC_INFO; /* So that we don't have to translate it */
-		err = sys_shmctl (first, second, (struct shmid_ds *)uptr);
-	} else if ((second & IPC_64) && second != (SHM_INFO|IPC_64)) {
-		struct shmid64_ds s;
-		struct shmid64_ds32 *up = (struct shmid64_ds32 *)uptr;
-		mm_segment_t old_fs;
-
-		if (second == (IPC_SET|IPC_64)) {
-			err = get_user (s.shm_perm.uid, &up->shm_perm.uid);
-			err |= __get_user (s.shm_perm.gid, &up->shm_perm.gid);
-			err |= __get_user (s.shm_perm.mode, &up->shm_perm.mode);
-			if (err)
-				goto out;
-		}
-		old_fs = get_fs ();
-		set_fs (KERNEL_DS);
-		err = sys_shmctl (first, second, (struct shmid_ds *)&s);
-		set_fs (old_fs);
-		if (err < 0)
-			goto out;
-
-		/* Mask it even in this case so it becomes a CSE. */
-		if (IPCOP_MASK (second) &
-		    (IPCOP_MASK (SHM_STAT) | IPCOP_MASK (IPC_STAT))) {
-			int err2 = put_user (s.shm_perm.key, &up->shm_perm.key);
-			err2 |= __put_user (high2lowuid(s.shm_perm.uid), &up->shm_perm.uid);
-			err2 |= __put_user (high2lowgid(s.shm_perm.gid), &up->shm_perm.gid);
-			err2 |= __put_user (high2lowuid(s.shm_perm.cuid), &up->shm_perm.cuid);
-			err2 |= __put_user (high2lowgid(s.shm_perm.cgid), &up->shm_perm.cgid);
-			err2 |= __put_user (s.shm_perm.mode, &up->shm_perm.mode);
-			err2 |= __put_user (s.shm_perm.seq, &up->shm_perm.seq);
-			err2 |= __put_user (s.shm_atime, &up->shm_atime);
-			err2 |= __put_user (s.shm_dtime, &up->shm_dtime);
-			err2 |= __put_user (s.shm_ctime, &up->shm_ctime);
-			err2 |= __put_user (s.shm_segsz, &up->shm_segsz);
-			err2 |= __put_user (s.shm_nattch, &up->shm_nattch);
-			err2 |= __put_user (s.shm_cpid, &up->shm_cpid);
-			err2 |= __put_user (s.shm_lpid, &up->shm_lpid);
-			if (err2)
-				err = -EFAULT;
-		}
-	} else {
-		struct shmid_ds s;
-		struct shmid_ds32 *up = (struct shmid_ds32 *)uptr;
-		mm_segment_t old_fs;
-
-		second &= ~IPC_64;
-		if (second == IPC_SET) {
-			err = get_user (s.shm_perm.uid, &up->shm_perm.uid);
-			err |= __get_user (s.shm_perm.gid, &up->shm_perm.gid);
-			err |= __get_user (s.shm_perm.mode, &up->shm_perm.mode);
-			if (err)
-				goto out;
-		}
-		old_fs = get_fs ();
-		set_fs (KERNEL_DS);
-		err = sys_shmctl (first, second, &s);
-		set_fs (old_fs);
-		if (err < 0)
-			goto out;
-
-		/* Mask it even in this case so it becomes a CSE. */
-		if (second == SHM_INFO) {
-			struct shm_info32 {
-				int used_ids;
-				u32 shm_tot, shm_rss, shm_swp;
-				u32 swap_attempts, swap_successes;
-			} *uip = (struct shm_info32 *)uptr;
-			struct shm_info *kp = (struct shm_info *)&s;
-			int err2 = put_user (kp->used_ids, &uip->used_ids);
-			err2 |= __put_user (kp->shm_tot, &uip->shm_tot);
-			err2 |= __put_user (kp->shm_rss, &uip->shm_rss);
-			err2 |= __put_user (kp->shm_swp, &uip->shm_swp);
-			err2 |= __put_user (kp->swap_attempts, &uip->swap_attempts);
-			err2 |= __put_user (kp->swap_successes, &uip->swap_successes);
-			if (err2)
-				err = -EFAULT;
-		} else if (IPCOP_MASK (second) &
-			   (IPCOP_MASK (SHM_STAT) | IPCOP_MASK (IPC_STAT))) {
-			int err2 = put_user (s.shm_perm.key, &up->shm_perm.key);
-			err2 |= __put_user (high2lowuid(s.shm_perm.uid), &up->shm_perm.uid);
-			err2 |= __put_user (high2lowgid(s.shm_perm.gid), &up->shm_perm.gid);
-			err2 |= __put_user (high2lowuid(s.shm_perm.cuid), &up->shm_perm.cuid);
-			err2 |= __put_user (high2lowgid(s.shm_perm.cgid), &up->shm_perm.cgid);
-			err2 |= __put_user (s.shm_perm.mode, &up->shm_perm.mode);
-			err2 |= __put_user (s.shm_perm.seq, &up->shm_perm.seq);
-			err2 |= __put_user (s.shm_atime, &up->shm_atime);
-			err2 |= __put_user (s.shm_dtime, &up->shm_dtime);
-			err2 |= __put_user (s.shm_ctime, &up->shm_ctime);
-			err2 |= __put_user (s.shm_segsz, &up->shm_segsz);
-			err2 |= __put_user (s.shm_nattch, &up->shm_nattch);
-			err2 |= __put_user (s.shm_cpid, &up->shm_cpid);
-			err2 |= __put_user (s.shm_lpid, &up->shm_lpid);
-			if (err2)
-				err = -EFAULT;
-		}
-	}
-out:
-	return err;
-}
-
 /*
  * sys32_ipc() is the de-multiplexer for the SysV IPC calls in 32bit emulation.
  *
@@ -835,84 +300,64 @@ out:
  */
 asmlinkage int sys32_ipc (u32 call, int first, int second, int third, u32 ptr)
 {
-	int version, err;
+	if(call >> 16) /* hack for backward compatibility */
+		return -EINVAL;
 
-	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
-	if(version)
-		return -EINVAL;
-
 	if (call <= SEMTIMEDOP)
 		switch (call) {
 		case SEMTIMEDOP:
-			if (third) {
-				err = do_sys32_semtimedop(first,
-					(struct sembuf *)AA(ptr),
-					second,
-					(struct compat_timespec *)
-						AA((u32)third));
-				goto out;
-			}
+			if (third)
+				return compat_sys_semtimedop(first,
+						compat_ptr(ptr), second,
+						compat_ptr(third));
 			/* else fall through for normal semop() */
 		case SEMOP:
 			/* struct sembuf is the same on 32 and 64bit :)) */
-			err = sys_semtimedop (first, (struct sembuf *)AA(ptr),
+			return sys_semtimedop (first, compat_ptr(ptr),
 					      second, NULL);
-			goto out;
 		case SEMGET:
-			err = sys_semget (first, second, third);
-			goto out;
+			return sys_semget (first, second, third);
 		case SEMCTL:
-			err = do_sys32_semctl (first, second, third, (void *)AA(ptr));
-			goto out;
+			return compat_sys_semctl (first, second, third,
+						 compat_ptr(ptr));
 		default:
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		};
 	if (call <= MSGCTL) 
 		switch (call) {
 		case MSGSND:
-			err = do_sys32_msgsnd (first, second, third, (void *)AA(ptr));
-			goto out;
+			return compat_sys_msgsnd (first, second, third,
+						compat_ptr(ptr));
 		case MSGRCV:
-			err = do_sys32_msgrcv (first, second, 0, third,
-					       version, (void *)AA(ptr));
-			goto out;
+			return compat_sys_msgrcv (first, second, 0, third,
+					       0, compat_ptr(ptr));
 		case MSGGET:
-			err = sys_msgget ((key_t) first, second);
-			goto out;
+			return sys_msgget ((key_t) first, second);
 		case MSGCTL:
-			err = do_sys32_msgctl (first, second, (void *)AA(ptr));
-			goto out;
+			return compat_sys_msgctl (first, second,
+						compat_ptr(ptr));
 		default:
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 	if (call <= SHMCTL) 
 		switch (call) {
 		case SHMAT:
-			err = do_sys32_shmat (first, second, third,
-					      version, (void *)AA(ptr));
-			goto out;
+			return compat_sys_shmat (first, second, third,
+						0, compat_ptr(ptr));
 		case SHMDT: 
-			err = sys_shmdt ((char *)AA(ptr));
-			goto out;
+			return sys_shmdt(compat_ptr(ptr));
 		case SHMGET:
-			err = sys_shmget (first, second, third);
-			goto out;
+			return sys_shmget(first, second, third);
 		case SHMCTL:
-			err = do_sys32_shmctl (first, second, (void *)AA(ptr));
-			goto out;
+			return compat_sys_shmctl(first, second,
+						compat_ptr(ptr));
 		default:
-			err = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
-	err = -EINVAL;
-
-out:
-	return err;
+	return -EINVAL;
 }
 
 asmlinkage int sys32_truncate64(const char * path, unsigned long high, unsigned long low)
diff -puN include/asm-s390/compat.h~compat-generic-ipc-emulation include/asm-s390/compat.h
--- 25/include/asm-s390/compat.h~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/include/asm-s390/compat.h	Mon Mar 15 14:22:21 2004
@@ -15,6 +15,8 @@ typedef s32		compat_clock_t;
 typedef s32		compat_pid_t;
 typedef u16		compat_uid_t;
 typedef u16		compat_gid_t;
+typedef u32		compat_uid32_t;
+typedef u32		compat_gid32_t;
 typedef u16		compat_mode_t;
 typedef u32		compat_ino_t;
 typedef u16		compat_dev_t;
@@ -25,6 +27,7 @@ typedef u16		compat_ipc_pid_t;
 typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
+typedef s32		compat_key_t;
 typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
@@ -135,4 +138,61 @@ static inline void *compat_alloc_user_sp
 	return (void *) (stack - len);
 }
 
+struct compat_ipc64_perm {
+	compat_key_t key;
+	compat_uid32_t uid;
+	compat_gid32_t gid;
+	compat_uid32_t cuid;
+	compat_gid32_t cgid;
+	compat_mode_t mode;
+	unsigned short __pad1;
+	unsigned short seq;
+	unsigned short __pad2;
+	unsigned int __unused1;
+	unsigned int __unused2;
+};
+
+struct compat_semid64_ds {
+	struct compat_ipc64_perm sem_perm;
+	compat_time_t  sem_otime;
+	compat_ulong_t __pad1;
+	compat_time_t  sem_ctime;
+	compat_ulong_t __pad2;
+	compat_ulong_t sem_nsems;
+	compat_ulong_t __unused1;
+	compat_ulong_t __unused2;
+};
+
+struct compat_msqid64_ds {
+	struct compat_ipc64_perm msg_perm;
+	compat_time_t   msg_stime;
+	compat_ulong_t __pad1;
+	compat_time_t   msg_rtime;
+	compat_ulong_t __pad2;
+	compat_time_t   msg_ctime;
+	compat_ulong_t __pad3;
+	compat_ulong_t msg_cbytes;
+	compat_ulong_t msg_qnum;
+	compat_ulong_t msg_qbytes;
+	compat_pid_t   msg_lspid;
+	compat_pid_t   msg_lrpid;
+	compat_ulong_t __unused1;
+	compat_ulong_t __unused2;
+};
+
+struct compat_shmid64_ds {
+	struct compat_ipc64_perm shm_perm;
+	compat_size_t  shm_segsz;
+	compat_time_t  shm_atime;
+	compat_ulong_t __pad1;
+	compat_time_t  shm_dtime;
+	compat_ulong_t __pad2;
+	compat_time_t  shm_ctime;
+	compat_ulong_t __pad3;
+	compat_pid_t   shm_cpid;
+	compat_pid_t   shm_lpid;
+	compat_ulong_t shm_nattch;
+	compat_ulong_t __unused1;
+	compat_ulong_t __unused2;
+};
 #endif /* _ASM_S390X_COMPAT_H */
diff -puN arch/x86_64/ia32/ipc32.c~compat-generic-ipc-emulation arch/x86_64/ia32/ipc32.c
--- 25/arch/x86_64/ia32/ipc32.c~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/arch/x86_64/ia32/ipc32.c	Mon Mar 15 14:22:21 2004
@@ -1,656 +1,19 @@
 #include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/fs.h> 
-#include <linux/file.h> 
+#include <linux/spinlock.h>
+#include <linux/list.h>
 #include <linux/syscalls.h>
+#include <linux/time.h>
 #include <linux/sem.h>
 #include <linux/msg.h>
-#include <linux/mm.h>
 #include <linux/shm.h>
-#include <linux/slab.h>
 #include <linux/ipc.h>
 #include <linux/compat.h>
-#include <asm/mman.h>
-#include <asm/types.h>
-#include <asm/uaccess.h>
-#include <asm/semaphore.h>
-#include <asm/ipc.h>
-
-#include <asm/ia32.h>
-
-/*
- * sys32_ipc() is the de-multiplexer for the SysV IPC calls in 32bit emulation..
- *
- * This is really horribly ugly.
- */
-
-struct msgbuf32 { 
-	s32 mtype; 
-	char mtext[1]; 
-};
-
-struct ipc_perm32 {
-	int key;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_uid_t cuid;
-	compat_gid_t cgid;
-	unsigned short mode;
-	unsigned short seq;
-};
-
-struct ipc64_perm32 {
-        unsigned key;
-	compat_uid32_t uid;
-	compat_gid32_t gid;
-	compat_uid32_t cuid;
-	compat_gid32_t cgid;
-	unsigned short mode;
-	unsigned short __pad1;
-	unsigned short seq;
-	unsigned short __pad2;
-	unsigned int unused1;
-	unsigned int unused2;
-};
-
-struct semid_ds32 {
-	struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-	compat_time_t sem_otime;              /* last semop time */
-	compat_time_t sem_ctime;              /* last change time */
-	u32 sem_base;              /* ptr to first semaphore in array */
-	u32 sem_pending;          /* pending operations to be processed */
-	u32 sem_pending_last;    /* last pending operation */
-	u32 undo;                  /* undo requests on this array */
-	unsigned short  sem_nsems;              /* no. of semaphores in array */
-};
-
-struct semid64_ds32 {
-	struct ipc64_perm32 sem_perm;
-	compat_time_t sem_otime;
-	unsigned int __unused1;
-	compat_time_t sem_ctime;
-	unsigned int __unused2;
-	unsigned int sem_nsems;
-	unsigned int __unused3;
-	unsigned int __unused4;
-};
-
-struct msqid_ds32 {
-	struct ipc_perm32 msg_perm;
-	u32 msg_first;
-	u32 msg_last;
-	compat_time_t msg_stime;
-	compat_time_t msg_rtime;
-	compat_time_t msg_ctime;
-	u32 wwait;
-	u32 rwait;
-	unsigned short msg_cbytes;
-	unsigned short msg_qnum;
-	unsigned short msg_qbytes;
-	compat_ipc_pid_t msg_lspid;
-	compat_ipc_pid_t msg_lrpid;
-};
-
-struct msqid64_ds32 {
-	struct ipc64_perm32 msg_perm;
-	compat_time_t msg_stime;
-	unsigned int __unused1;
-	compat_time_t msg_rtime;
-	unsigned int __unused2;
-	compat_time_t msg_ctime;
-	unsigned int __unused3;
-	unsigned int msg_cbytes;
-	unsigned int msg_qnum;
-	unsigned int msg_qbytes;
-	compat_pid_t msg_lspid;
-	compat_pid_t msg_lrpid;
-	unsigned int __unused4;
-	unsigned int __unused5;
-};
-
-struct shmid_ds32 {
-	struct ipc_perm32 shm_perm;
-	int shm_segsz;
-	compat_time_t shm_atime;
-	compat_time_t shm_dtime;
-	compat_time_t shm_ctime;
-	compat_ipc_pid_t shm_cpid;
-	compat_ipc_pid_t shm_lpid;
-	unsigned short shm_nattch;
-};
-
-struct shmid64_ds32 {
-	struct ipc64_perm32 shm_perm;
-	compat_size_t shm_segsz;
-	compat_time_t shm_atime;
-	unsigned int __unused1;
-	compat_time_t shm_dtime;
-	unsigned int __unused2;
-	compat_time_t shm_ctime;
-	unsigned int __unused3;
-	compat_pid_t shm_cpid;
-	compat_pid_t shm_lpid;
-	unsigned int shm_nattch;
-	unsigned int __unused4;
-	unsigned int __unused5;
-};
-
-struct shminfo64_32 {
-	unsigned int shmmax;
-	unsigned int shmmin;
-	unsigned int shmmni;
-	unsigned int shmseg;
-	unsigned int shmall;
-	unsigned int __unused1;
-	unsigned int __unused2;
-	unsigned int __unused3;
-	unsigned int __unused4;
-};
-
-struct shm_info32 {
-	int used_ids;
-	u32 shm_tot, shm_rss, shm_swp;
-	u32 swap_attempts, swap_successes;
-};
-
-struct ipc_kludge {
-	u32 msgp;
-	s32 msgtyp;
-};
-
-
-#define A(__x)		((unsigned long)(__x))
-#define AA(__x)		((unsigned long)(__x))
-
-#define SEMOP		 1
-#define SEMGET		 2
-#define SEMCTL		 3
-#define TIMEDSEMOP	 4
-#define MSGSND		11
-#define MSGRCV		12
-#define MSGGET		13
-#define MSGCTL		14
-#define SHMAT		21
-#define SHMDT		22
-#define SHMGET		23
-#define SHMCTL		24
-
-#define IPCOP_MASK(__x)	(1UL << (__x))
-
-static int
-ipc_parse_version32 (int *cmd)
-{
-	if (*cmd & IPC_64) {
-		*cmd ^= IPC_64;
-		return IPC_64;
-	} else {
-		return IPC_OLD;
-	}
-}
-
-static int put_semid(void *user_semid, struct semid64_ds *s, int version)
-{
-	int err2;
-	switch (version) { 
-	case IPC_64: { 
-		struct semid64_ds32 *usp64 = (struct semid64_ds32 *) user_semid;
-		
-		if (!access_ok(VERIFY_WRITE, usp64, sizeof(*usp64))) {
-			err2 = -EFAULT;
-			break;
-		} 
-		err2 = __put_user(s->sem_perm.key, &usp64->sem_perm.key);
-		err2 |= __put_user(s->sem_perm.uid, &usp64->sem_perm.uid);
-		err2 |= __put_user(s->sem_perm.gid, &usp64->sem_perm.gid);
-		err2 |= __put_user(s->sem_perm.cuid, &usp64->sem_perm.cuid);
-		err2 |= __put_user(s->sem_perm.cgid, &usp64->sem_perm.cgid);
-		err2 |= __put_user(s->sem_perm.mode, &usp64->sem_perm.mode);
-		err2 |= __put_user(s->sem_perm.seq, &usp64->sem_perm.seq);
-		err2 |= __put_user(s->sem_otime, &usp64->sem_otime);
-		err2 |= __put_user(s->sem_ctime, &usp64->sem_ctime);
-		err2 |= __put_user(s->sem_nsems, &usp64->sem_nsems);
-		break;
-	}
-	default: {
-		struct semid_ds32 *usp32 = (struct semid_ds32 *) user_semid;
-		
-		if (!access_ok(VERIFY_WRITE, usp32, sizeof(*usp32))) {
-			err2 = -EFAULT;
-			break;
-		} 
-		err2 = __put_user(s->sem_perm.key, &usp32->sem_perm.key);
-		err2 |= __put_user(s->sem_perm.uid, &usp32->sem_perm.uid);
-		err2 |= __put_user(s->sem_perm.gid, &usp32->sem_perm.gid);
-		err2 |= __put_user(s->sem_perm.cuid, &usp32->sem_perm.cuid);
-		err2 |= __put_user(s->sem_perm.cgid, &usp32->sem_perm.cgid);
-		err2 |= __put_user(s->sem_perm.mode, &usp32->sem_perm.mode);
-		err2 |= __put_user(s->sem_perm.seq, &usp32->sem_perm.seq);
-		err2 |= __put_user(s->sem_otime, &usp32->sem_otime);
-		err2 |= __put_user(s->sem_ctime, &usp32->sem_ctime);
-		err2 |= __put_user(s->sem_nsems, &usp32->sem_nsems);
-		break;
-	}
-	}
-	return err2;
-}
-
-static int
-semctl32 (int first, int second, int third, void *uptr)
-{
-	union semun fourth;
-	u32 pad;
-	int err;
-	struct semid64_ds s;
-	mm_segment_t old_fs;
-	int version = ipc_parse_version32(&third);
-
-	if (!uptr)
-		return -EINVAL;
-	if (get_user(pad, (u32 *)uptr))
-		return -EFAULT;
-	if (third == SETVAL)
-		fourth.val = (int)pad;
-	else
-		fourth.__pad = (void *)A(pad);
-	switch (third) {
-	      case IPC_INFO:
-	      case IPC_RMID:
-	      case IPC_SET:
-	      case SEM_INFO:
-	      case GETVAL:
-	      case GETPID:
-	      case GETNCNT:
-	      case GETZCNT:
-	      case GETALL:
-	      case SETVAL:
-	      case SETALL:
-		err = sys_semctl(first, second, third, fourth);
-		break;
-
-	      case IPC_STAT:
-	      case SEM_STAT:
-		fourth.__pad = &s;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_semctl(first, second, third, fourth);
-		set_fs(old_fs);
-		if (!err)
-			err = put_semid((void *)A(pad), &s, version);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	return err;
-}
-
-#define MAXBUF (64*1024)
-
-static int
-do_sys32_msgsnd (int first, int second, int third, void *uptr)
-{
-	struct msgbuf *p;
-	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
-	mm_segment_t old_fs;
-	int err;
-
-	if (second >= MAXBUF-sizeof(struct msgbuf))
-		return -EINVAL;
-	p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
-	if (!p)
-		return -ENOMEM;
-	err = get_user(p->mtype, &up->mtype);
-	err |= (copy_from_user(p->mtext, &up->mtext, second) ? -EFAULT : 0);
-	if (err)
-		goto out;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_msgsnd(first, p, second, third);
-	set_fs(old_fs);
-  out:
-	kfree(p);
-	return err;
-}
-
-static int
-do_sys32_msgrcv (int first, int second, int msgtyp, int third, int version, void *uptr)
-{
-	struct msgbuf32 *up;
-	struct msgbuf *p;
-	mm_segment_t old_fs;
-	int err;
-
-	if (!version) {
-		struct ipc_kludge *uipck = (struct ipc_kludge *)uptr;
-		struct ipc_kludge ipck;
-
-		err = -EINVAL;
-		if (!uptr)
-			goto out;
-		err = -EFAULT;
-		if (copy_from_user(&ipck, uipck, sizeof(struct ipc_kludge)))
-			goto out;
-		uptr = (void *)A(ipck.msgp);
-		msgtyp = ipck.msgtyp;
-	}
-	if (second >= MAXBUF-sizeof(struct msgbuf))
-		return -EINVAL; 
-	err = -ENOMEM;
-	p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
-	if (!p)
-		goto out;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_msgrcv(first, p, second, msgtyp, third);
-	set_fs(old_fs);
-	if (err < 0)
-		goto free_then_out;
-	up = (struct msgbuf32 *)uptr;
-	if (put_user(p->mtype, &up->mtype) || copy_to_user(&up->mtext, p->mtext, err))
-		err = -EFAULT;
-free_then_out:
-	kfree(p);
-out:
-	return err;
-}
-
-
-static int
-msgctl32 (int first, int second, void *uptr)
-{
-	int err = -EINVAL, err2;
-	struct msqid_ds m;
-	struct msqid64_ds m64;
-	struct msqid_ds32 *up32 = (struct msqid_ds32 *)uptr;
-	struct msqid64_ds32 *up64 = (struct msqid64_ds32 *)uptr;
-	mm_segment_t old_fs;
-	int version = ipc_parse_version32(&second);
-
-	switch (second) {
-	      case IPC_INFO:
-	      case IPC_RMID:
-	      case MSG_INFO:
-		err = sys_msgctl(first, second, (struct msqid_ds *)uptr);
-		break;
-
-	      case IPC_SET:
-		if (version == IPC_64) {
-			err = get_user(m.msg_perm.uid, &up64->msg_perm.uid);
-			err |= get_user(m.msg_perm.gid, &up64->msg_perm.gid);
-			err |= get_user(m.msg_perm.mode, &up64->msg_perm.mode);
-			err |= get_user(m.msg_qbytes, &up64->msg_qbytes);
-		} else {
-			err = get_user(m.msg_perm.uid, &up32->msg_perm.uid);
-			err |= get_user(m.msg_perm.gid, &up32->msg_perm.gid);
-			err |= get_user(m.msg_perm.mode, &up32->msg_perm.mode);
-			err |= get_user(m.msg_qbytes, &up32->msg_qbytes);
-		}
-		if (err)
-			break;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second, &m);
-		set_fs(old_fs);
-		break;
-
-	      case IPC_STAT:
-	      case MSG_STAT:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second, (void *) &m64);
-		set_fs(old_fs);
-		if (version == IPC_64) {
-			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(m64.msg_perm.key, &up64->msg_perm.key);
-			err2 |= __put_user(m64.msg_perm.uid, &up64->msg_perm.uid);
-			err2 |= __put_user(m64.msg_perm.gid, &up64->msg_perm.gid);
-			err2 |= __put_user(m64.msg_perm.cuid, &up64->msg_perm.cuid);
-			err2 |= __put_user(m64.msg_perm.cgid, &up64->msg_perm.cgid);
-			err2 |= __put_user(m64.msg_perm.mode, &up64->msg_perm.mode);
-			err2 |= __put_user(m64.msg_perm.seq, &up64->msg_perm.seq);
-			err2 |= __put_user(m64.msg_stime, &up64->msg_stime);
-			err2 |= __put_user(m64.msg_rtime, &up64->msg_rtime);
-			err2 |= __put_user(m64.msg_ctime, &up64->msg_ctime);
-			err2 |= __put_user(m64.msg_cbytes, &up64->msg_cbytes);
-			err2 |= __put_user(m64.msg_qnum, &up64->msg_qnum);
-			err2 |= __put_user(m64.msg_qbytes, &up64->msg_qbytes);
-			err2 |= __put_user(m64.msg_lspid, &up64->msg_lspid);
-			err2 |= __put_user(m64.msg_lrpid, &up64->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		} else {
-			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(m64.msg_perm.key, &up32->msg_perm.key);
-			err2 |= __put_user(m64.msg_perm.uid, &up32->msg_perm.uid);
-			err2 |= __put_user(m64.msg_perm.gid, &up32->msg_perm.gid);
-			err2 |= __put_user(m64.msg_perm.cuid, &up32->msg_perm.cuid);
-			err2 |= __put_user(m64.msg_perm.cgid, &up32->msg_perm.cgid);
-			err2 |= __put_user(m64.msg_perm.mode, &up32->msg_perm.mode);
-			err2 |= __put_user(m64.msg_perm.seq, &up32->msg_perm.seq);
-			err2 |= __put_user(m64.msg_stime, &up32->msg_stime);
-			err2 |= __put_user(m64.msg_rtime, &up32->msg_rtime);
-			err2 |= __put_user(m64.msg_ctime, &up32->msg_ctime);
-			err2 |= __put_user(m64.msg_cbytes, &up32->msg_cbytes);
-			err2 |= __put_user(m64.msg_qnum, &up32->msg_qnum);
-			err2 |= __put_user(m64.msg_qbytes, &up32->msg_qbytes);
-			err2 |= __put_user(m64.msg_lspid, &up32->msg_lspid);
-			err2 |= __put_user(m64.msg_lrpid, &up32->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		}
-		break;
-	}
-	return err;
-}
-
-static int
-shmat32 (int first, int second, int third, int version, void *uptr)
-{
-	unsigned long raddr;
-	u32 *uaddr = (u32 *)A((u32)third);
-	int err;
-
-	if (version == 1)
-		return -EINVAL;	/* iBCS2 emulator entry point: unsupported */
-	err = do_shmat(first, uptr, second, &raddr);
-	if (err)
-		return err;
-	return put_user(raddr, uaddr);
-}
-
-static int put_shmid64(struct shmid64_ds *s64p, void *uptr, int version) 
-{ 
-	int err2; 
-#define s64 (*s64p)
-	if (version == IPC_64) {
-		struct shmid64_ds32 *up64 = (struct shmid64_ds32 *)uptr;
-
-		if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64)))
-			return -EFAULT;
-
-		err2 = __put_user(s64.shm_perm.key, &up64->shm_perm.key);
-		err2 |= __put_user(s64.shm_perm.uid, &up64->shm_perm.uid);
-		err2 |= __put_user(s64.shm_perm.gid, &up64->shm_perm.gid);
-		err2 |= __put_user(s64.shm_perm.cuid, &up64->shm_perm.cuid);
-		err2 |= __put_user(s64.shm_perm.cgid, &up64->shm_perm.cgid);
-		err2 |= __put_user(s64.shm_perm.mode, &up64->shm_perm.mode);
-		err2 |= __put_user(s64.shm_perm.seq, &up64->shm_perm.seq);
-		err2 |= __put_user(s64.shm_atime, &up64->shm_atime);
-		err2 |= __put_user(s64.shm_dtime, &up64->shm_dtime);
-		err2 |= __put_user(s64.shm_ctime, &up64->shm_ctime);
-		err2 |= __put_user(s64.shm_segsz, &up64->shm_segsz);
-		err2 |= __put_user(s64.shm_nattch, &up64->shm_nattch);
-		err2 |= __put_user(s64.shm_cpid, &up64->shm_cpid);
-		err2 |= __put_user(s64.shm_lpid, &up64->shm_lpid);
-	} else {
-		struct shmid_ds32 *up32 = (struct shmid_ds32 *)uptr;
-
-		if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) 
-			return -EFAULT;
-
-		err2 = __put_user(s64.shm_perm.key, &up32->shm_perm.key);
-		err2 |= __put_user(s64.shm_perm.uid, &up32->shm_perm.uid);
-		err2 |= __put_user(s64.shm_perm.gid, &up32->shm_perm.gid);
-		err2 |= __put_user(s64.shm_perm.cuid, &up32->shm_perm.cuid);
-		err2 |= __put_user(s64.shm_perm.cgid, &up32->shm_perm.cgid);
-		err2 |= __put_user(s64.shm_perm.mode, &up32->shm_perm.mode);
-		err2 |= __put_user(s64.shm_perm.seq, &up32->shm_perm.seq);
-		err2 |= __put_user(s64.shm_atime, &up32->shm_atime);
-		err2 |= __put_user(s64.shm_dtime, &up32->shm_dtime);
-		err2 |= __put_user(s64.shm_ctime, &up32->shm_ctime);
-		err2 |= __put_user(s64.shm_segsz, &up32->shm_segsz);
-		err2 |= __put_user(s64.shm_nattch, &up32->shm_nattch);
-		err2 |= __put_user(s64.shm_cpid, &up32->shm_cpid);
-		err2 |= __put_user(s64.shm_lpid, &up32->shm_lpid);
-	}
-#undef s64
-	return err2 ? -EFAULT : 0;
-}
-static int
-shmctl32 (int first, int second, void *uptr)
-{
-	int err = -EFAULT, err2;
-	struct shmid_ds s;
-	struct shmid64_ds s64;
-	mm_segment_t old_fs;
-	struct shm_info32 *uip = (struct shm_info32 *)uptr;
-	struct shm_info si;
-	int version = ipc_parse_version32(&second);
-	struct shminfo64 smi;
-	struct shminfo *usi32 = (struct shminfo *) uptr;
-	struct shminfo64_32 *usi64 = (struct shminfo64_32 *) uptr;
-
-	switch (second) {
-	      case IPC_INFO:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (struct shmid_ds *)&smi);
-		set_fs(old_fs);
-
-		if (version == IPC_64) {
-			if (!access_ok(VERIFY_WRITE, usi64, sizeof(*usi64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(smi.shmmax, &usi64->shmmax);
-			err2 |= __put_user(smi.shmmin, &usi64->shmmin);
-			err2 |= __put_user(smi.shmmni, &usi64->shmmni);
-			err2 |= __put_user(smi.shmseg, &usi64->shmseg);
-			err2 |= __put_user(smi.shmall, &usi64->shmall);
-		} else {
-			if (!access_ok(VERIFY_WRITE, usi32, sizeof(*usi32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(smi.shmmax, &usi32->shmmax);
-			err2 |= __put_user(smi.shmmin, &usi32->shmmin);
-			err2 |= __put_user(smi.shmmni, &usi32->shmmni);
-			err2 |= __put_user(smi.shmseg, &usi32->shmseg);
-			err2 |= __put_user(smi.shmall, &usi32->shmall);
-		}
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	      case IPC_RMID:
-	      case SHM_LOCK:
-	      case SHM_UNLOCK:
-		err = sys_shmctl(first, second, (struct shmid_ds *)uptr);
-		break;
-
-	      case IPC_SET: 
-		if (version == IPC_64) {
-			struct shmid64_ds32 *up64 = (struct shmid64_ds32 *)uptr;
-			err = get_user(s.shm_perm.uid, &up64->shm_perm.uid);
-			err |= get_user(s.shm_perm.gid, &up64->shm_perm.gid);
-			err |= get_user(s.shm_perm.mode, &up64->shm_perm.mode);
-		} else {
-			struct shmid_ds32 *up32 = (struct shmid_ds32 *)uptr;
-			err = get_user(s.shm_perm.uid, &up32->shm_perm.uid);
-			err |= get_user(s.shm_perm.gid, &up32->shm_perm.gid);
-			err |= get_user(s.shm_perm.mode, &up32->shm_perm.mode);
-		}
-		if (err)
-			break;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, &s);
-		set_fs(old_fs);
-		break;
-
-	      case IPC_STAT:
-	      case SHM_STAT:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (void *) &s64);
-		set_fs(old_fs);
-		
-		if (err < 0)
-			break;
-	        err2 = put_shmid64(&s64, uptr, version); 		
-		if (err2) 
-			err = err2;
-		break;
-
-	      case SHM_INFO:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (void *)&si);
-		set_fs(old_fs);
-		if (err < 0)
-			break;
-
-		if (!access_ok(VERIFY_WRITE, uip, sizeof(*uip))) {
-			err = -EFAULT;
-			break;
-		}
-		err2 = __put_user(si.used_ids, &uip->used_ids);
-		err2 |= __put_user(si.shm_tot, &uip->shm_tot);
-		err2 |= __put_user(si.shm_rss, &uip->shm_rss);
-		err2 |= __put_user(si.shm_swp, &uip->shm_swp);
-		err2 |= __put_user(si.swap_attempts, &uip->swap_attempts);
-		err2 |= __put_user(si.swap_successes, &uip->swap_successes);
-		if (err2)
-			err = -EFAULT;
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	return err;
-}
-
-extern int sem_ctls[];
-
-static long semtimedop32(int semid, struct sembuf *sb, 
-			 unsigned nsops, struct compat_timespec *ts32)
-{ 
-	struct timespec ts;
-	mm_segment_t oldfs = get_fs(); 
-	long ret;
-
-	if (nsops > sem_ctls[2]) 
-		return -E2BIG;
-	if (!access_ok(VERIFY_READ, sb, nsops * sizeof(struct sembuf)))
-		return -EFAULT; 
-	if (ts32 && get_compat_timespec(&ts, ts32))
-		return -EFAULT;
-
-	set_fs(KERNEL_DS);  
-	ret = sys_semtimedop(semid, sb, nsops, ts32 ? &ts : NULL);
-	set_fs(oldfs); 
-	return ret;
-}
 
+#include <asm-i386/ipc.h>
 
 asmlinkage long
-sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
+sys32_ipc(u32 call, int first, int second, int third,
+		compat_uptr_t ptr, u32 fifth)
 {
 	int version;
 
@@ -660,35 +23,35 @@ sys32_ipc (u32 call, int first, int seco
 	switch (call) {
 	      case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		return sys_semtimedop(first, (struct sembuf *)AA(ptr), second,
-				      NULL);
-	      case TIMEDSEMOP:
-		return semtimedop32(first, (struct sembuf *)AA(ptr), second,
-				  (struct compat_timespec *)AA(fifth)); 
+		return sys_semtimedop(first, compat_ptr(ptr), second, NULL);
+	      case SEMTIMEDOP:
+		return compat_sys_semtimedop(first, compat_ptr(ptr), second,
+						compat_ptr(fifth));
 	      case SEMGET:
 		return sys_semget(first, second, third);
 	      case SEMCTL:
-		return semctl32(first, second, third, (void *)AA(ptr));
+		return compat_sys_semctl(first, second, third, compat_ptr(ptr));
 
 	      case MSGSND:
-		return do_sys32_msgsnd(first, second, third, (void *)AA(ptr));
+		return compat_sys_msgsnd(first, second, third, compat_ptr(ptr));
 	      case MSGRCV:
-		return do_sys32_msgrcv(first, second, fifth, third, version, (void *)AA(ptr));
+		return compat_sys_msgrcv(first, second, fifth, third,
+					 version, compat_ptr(ptr));
 	      case MSGGET:
 		return sys_msgget((key_t) first, second);
 	      case MSGCTL:
-		return msgctl32(first, second, (void *)AA(ptr));
+		return compat_sys_msgctl(first, second, compat_ptr(ptr));
 
 	      case SHMAT:
-		return shmat32(first, second, third, version, (void *)AA(ptr));
+		return compat_sys_shmat(first, second, third, version,
+					compat_ptr(ptr));
 		break;
 	      case SHMDT:
-		return sys_shmdt((char *)AA(ptr));
+		return sys_shmdt(compat_ptr(ptr));
 	      case SHMGET:
 		return sys_shmget(first, second, third);
 	      case SHMCTL:
-		return shmctl32(first, second, (void *)AA(ptr));
+		return compat_sys_shmctl(first, second, compat_ptr(ptr));
 	}
 	return -ENOSYS;
 }
-
diff -puN arch/x86_64/Kconfig~compat-generic-ipc-emulation arch/x86_64/Kconfig
--- 25/arch/x86_64/Kconfig~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/arch/x86_64/Kconfig	Mon Mar 15 14:22:21 2004
@@ -387,6 +387,10 @@ config COMPAT
 	depends on IA32_EMULATION
 	default y
 
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
 
 config UID16
 	bool
diff -puN include/asm-x86_64/compat.h~compat-generic-ipc-emulation include/asm-x86_64/compat.h
--- 25/include/asm-x86_64/compat.h~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/include/asm-x86_64/compat.h	Mon Mar 15 14:22:21 2004
@@ -29,6 +29,7 @@ typedef s32		compat_daddr_t;
 typedef u32		compat_caddr_t;
 typedef __kernel_fsid_t	compat_fsid_t;
 typedef u32		compat_timer_t;
+typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
@@ -119,6 +120,64 @@ typedef u32               compat_sigset_
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffff
 
+struct compat_ipc64_perm {
+	compat_key_t key;
+	compat_uid32_t uid;
+	compat_gid32_t gid;
+	compat_uid32_t cuid;
+	compat_gid32_t cgid;
+	unsigned short mode;
+	unsigned short __pad1;
+	unsigned short seq;
+	unsigned short __pad2;
+	compat_ulong_t unused1;
+	compat_ulong_t unused2;
+};
+
+struct compat_semid64_ds {
+	struct compat_ipc64_perm sem_perm;
+	compat_time_t  sem_otime;
+	compat_ulong_t __unused1;
+	compat_time_t  sem_ctime;
+	compat_ulong_t __unused2;
+	compat_ulong_t sem_nsems;
+	compat_ulong_t __unused3;
+	compat_ulong_t __unused4;
+};
+
+struct compat_msqid64_ds {
+	struct compat_ipc64_perm msg_perm;
+	compat_time_t  msg_stime;
+	compat_ulong_t __unused1;
+	compat_time_t  msg_rtime;
+	compat_ulong_t __unused2;
+	compat_time_t  msg_ctime;
+	compat_ulong_t __unused3;
+	compat_ulong_t msg_cbytes;
+	compat_ulong_t msg_qnum;
+	compat_ulong_t msg_qbytes;
+	compat_pid_t   msg_lspid;
+	compat_pid_t   msg_lrpid;
+	compat_ulong_t __unused4;
+	compat_ulong_t __unused5;
+};
+
+struct compat_shmid64_ds {
+	struct compat_ipc64_perm shm_perm;
+	compat_size_t  shm_segsz;
+	compat_time_t  shm_atime;
+	compat_ulong_t __unused1;
+	compat_time_t  shm_dtime;
+	compat_ulong_t __unused2;
+	compat_time_t  shm_ctime;
+	compat_ulong_t __unused3;
+	compat_pid_t   shm_cpid;
+	compat_pid_t   shm_lpid;
+	compat_ulong_t shm_nattch;
+	compat_ulong_t __unused4;
+	compat_ulong_t __unused5;
+};
+
 /*
  * A pointer passed in from user mode. This should not
  * be used for syscall parameters, just declare them
diff -puN arch/ia64/ia32/sys_ia32.c~compat-generic-ipc-emulation arch/ia64/ia32/sys_ia32.c
--- 25/arch/ia64/ia32/sys_ia32.c~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/arch/ia64/ia32/sys_ia32.c	Mon Mar 15 14:22:21 2004
@@ -1023,143 +1023,6 @@ sys32_writev (int fd, struct compat_iove
 	return ret;
 }
 
-/*
- * sys32_ipc() is the de-multiplexer for the SysV IPC calls in 32bit emulation..
- *
- * This is really horribly ugly.
- */
-
-struct msgbuf32 { s32 mtype; char mtext[1]; };
-
-struct ipc_perm32 {
-	key_t key;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_uid_t cuid;
-	compat_gid_t cgid;
-	compat_mode_t mode;
-	unsigned short seq;
-};
-
-struct ipc64_perm32 {
-	key_t key;
-	compat_uid32_t uid;
-	compat_gid32_t gid;
-	compat_uid32_t cuid;
-	compat_gid32_t cgid;
-	compat_mode_t mode;
-	unsigned short __pad1;
-	unsigned short seq;
-	unsigned short __pad2;
-	unsigned int unused1;
-	unsigned int unused2;
-};
-
-struct semid_ds32 {
-	struct ipc_perm32 sem_perm;               /* permissions .. see ipc.h */
-	compat_time_t   sem_otime;              /* last semop time */
-	compat_time_t   sem_ctime;              /* last change time */
-	u32 sem_base;              /* ptr to first semaphore in array */
-	u32 sem_pending;          /* pending operations to be processed */
-	u32 sem_pending_last;    /* last pending operation */
-	u32 undo;                  /* undo requests on this array */
-	unsigned short  sem_nsems;              /* no. of semaphores in array */
-};
-
-struct semid64_ds32 {
-	struct ipc64_perm32 sem_perm;
-	compat_time_t   sem_otime;
-	unsigned int __unused1;
-	compat_time_t   sem_ctime;
-	unsigned int __unused2;
-	unsigned int sem_nsems;
-	unsigned int __unused3;
-	unsigned int __unused4;
-};
-
-struct msqid_ds32 {
-	struct ipc_perm32 msg_perm;
-	u32 msg_first;
-	u32 msg_last;
-	compat_time_t   msg_stime;
-	compat_time_t   msg_rtime;
-	compat_time_t   msg_ctime;
-	u32 wwait;
-	u32 rwait;
-	unsigned short msg_cbytes;
-	unsigned short msg_qnum;
-	unsigned short msg_qbytes;
-	compat_ipc_pid_t msg_lspid;
-	compat_ipc_pid_t msg_lrpid;
-};
-
-struct msqid64_ds32 {
-	struct ipc64_perm32 msg_perm;
-	compat_time_t   msg_stime;
-	unsigned int __unused1;
-	compat_time_t   msg_rtime;
-	unsigned int __unused2;
-	compat_time_t   msg_ctime;
-	unsigned int __unused3;
-	unsigned int msg_cbytes;
-	unsigned int msg_qnum;
-	unsigned int msg_qbytes;
-	compat_pid_t msg_lspid;
-	compat_pid_t msg_lrpid;
-	unsigned int __unused4;
-	unsigned int __unused5;
-};
-
-struct shmid_ds32 {
-	struct ipc_perm32 shm_perm;
-	int shm_segsz;
-	compat_time_t   shm_atime;
-	compat_time_t   shm_dtime;
-	compat_time_t   shm_ctime;
-	compat_ipc_pid_t shm_cpid;
-	compat_ipc_pid_t shm_lpid;
-	unsigned short shm_nattch;
-};
-
-struct shmid64_ds32 {
-	struct ipc64_perm32 shm_perm;
-	compat_size_t shm_segsz;
-	compat_time_t   shm_atime;
-	unsigned int __unused1;
-	compat_time_t   shm_dtime;
-	unsigned int __unused2;
-	compat_time_t   shm_ctime;
-	unsigned int __unused3;
-	compat_pid_t shm_cpid;
-	compat_pid_t shm_lpid;
-	unsigned int shm_nattch;
-	unsigned int __unused4;
-	unsigned int __unused5;
-};
-
-struct shminfo64_32 {
-	unsigned int shmmax;
-	unsigned int shmmin;
-	unsigned int shmmni;
-	unsigned int shmseg;
-	unsigned int shmall;
-	unsigned int __unused1;
-	unsigned int __unused2;
-	unsigned int __unused3;
-	unsigned int __unused4;
-};
-
-struct shm_info32 {
-	int used_ids;
-	u32 shm_tot, shm_rss, shm_swp;
-	u32 swap_attempts, swap_successes;
-};
-
-struct ipc_kludge {
-	u32 msgp;
-	s32 msgtyp;
-};
-
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
@@ -1173,454 +1036,6 @@ struct ipc_kludge {
 #define SHMGET		23
 #define SHMCTL		24
 
-#define IPCOP_MASK(__x)	(1UL << (__x))
-
-static int
-ipc_parse_version32 (int *cmd)
-{
-	if (*cmd & IPC_64) {
-		*cmd ^= IPC_64;
-		return IPC_64;
-	} else {
-		return IPC_OLD;
-	}
-}
-
-static int
-semctl32 (int first, int second, int third, void *uptr)
-{
-	union semun fourth;
-	u32 pad;
-	int err = 0, err2;
-	struct semid64_ds s;
-	mm_segment_t old_fs;
-	int version = ipc_parse_version32(&third);
-
-	if (!uptr)
-		return -EINVAL;
-	if (get_user(pad, (u32 *)uptr))
-		return -EFAULT;
-	if (third == SETVAL)
-		fourth.val = (int)pad;
-	else
-		fourth.__pad = (void *)A(pad);
-	switch (third) {
-	      default:
-		err = -EINVAL;
-		break;
-
-	      case IPC_INFO:
-	      case IPC_RMID:
-	      case IPC_SET:
-	      case SEM_INFO:
-	      case GETVAL:
-	      case GETPID:
-	      case GETNCNT:
-	      case GETZCNT:
-	      case GETALL:
-	      case SETVAL:
-	      case SETALL:
-		err = sys_semctl(first, second, third, fourth);
-		break;
-
-	      case IPC_STAT:
-	      case SEM_STAT:
-		fourth.__pad = &s;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_semctl(first, second, third, fourth);
-		set_fs(old_fs);
-
-		if (version == IPC_64) {
-			struct semid64_ds32 *usp64 = (struct semid64_ds32 *) A(pad);
-
-			if (!access_ok(VERIFY_WRITE, usp64, sizeof(*usp64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s.sem_perm.key, &usp64->sem_perm.key);
-			err2 |= __put_user(s.sem_perm.uid, &usp64->sem_perm.uid);
-			err2 |= __put_user(s.sem_perm.gid, &usp64->sem_perm.gid);
-			err2 |= __put_user(s.sem_perm.cuid, &usp64->sem_perm.cuid);
-			err2 |= __put_user(s.sem_perm.cgid, &usp64->sem_perm.cgid);
-			err2 |= __put_user(s.sem_perm.mode, &usp64->sem_perm.mode);
-			err2 |= __put_user(s.sem_perm.seq, &usp64->sem_perm.seq);
-			err2 |= __put_user(s.sem_otime, &usp64->sem_otime);
-			err2 |= __put_user(s.sem_ctime, &usp64->sem_ctime);
-			err2 |= __put_user(s.sem_nsems, &usp64->sem_nsems);
-		} else {
-			struct semid_ds32 *usp32 = (struct semid_ds32 *) A(pad);
-
-			if (!access_ok(VERIFY_WRITE, usp32, sizeof(*usp32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s.sem_perm.key, &usp32->sem_perm.key);
-			err2 |= __put_user(s.sem_perm.uid, &usp32->sem_perm.uid);
-			err2 |= __put_user(s.sem_perm.gid, &usp32->sem_perm.gid);
-			err2 |= __put_user(s.sem_perm.cuid, &usp32->sem_perm.cuid);
-			err2 |= __put_user(s.sem_perm.cgid, &usp32->sem_perm.cgid);
-			err2 |= __put_user(s.sem_perm.mode, &usp32->sem_perm.mode);
-			err2 |= __put_user(s.sem_perm.seq, &usp32->sem_perm.seq);
-			err2 |= __put_user(s.sem_otime, &usp32->sem_otime);
-			err2 |= __put_user(s.sem_ctime, &usp32->sem_ctime);
-			err2 |= __put_user(s.sem_nsems, &usp32->sem_nsems);
-		}
-		if (err2)
-		    err = -EFAULT;
-		break;
-	}
-	return err;
-}
-
-static int
-do_sys32_msgsnd (int first, int second, int third, void *uptr)
-{
-	struct msgbuf *p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
-	struct msgbuf32 *up = (struct msgbuf32 *)uptr;
-	mm_segment_t old_fs;
-	int err;
-
-	if (!p)
-		return -ENOMEM;
-	err = get_user(p->mtype, &up->mtype);
-	err |= copy_from_user(p->mtext, &up->mtext, second);
-	if (err)
-		goto out;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_msgsnd(first, p, second, third);
-	set_fs(old_fs);
-  out:
-	kfree(p);
-	return err;
-}
-
-static int
-do_sys32_msgrcv (int first, int second, int msgtyp, int third, int version, void *uptr)
-{
-	struct msgbuf32 *up;
-	struct msgbuf *p;
-	mm_segment_t old_fs;
-	int err;
-
-	if (!version) {
-		struct ipc_kludge *uipck = (struct ipc_kludge *)uptr;
-		struct ipc_kludge ipck;
-
-		err = -EINVAL;
-		if (!uptr)
-			goto out;
-		err = -EFAULT;
-		if (copy_from_user(&ipck, uipck, sizeof(struct ipc_kludge)))
-			goto out;
-		uptr = (void *)A(ipck.msgp);
-		msgtyp = ipck.msgtyp;
-	}
-	err = -ENOMEM;
-	p = kmalloc(second + sizeof(struct msgbuf), GFP_USER);
-	if (!p)
-		goto out;
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_msgrcv(first, p, second, msgtyp, third);
-	set_fs(old_fs);
-	if (err < 0)
-		goto free_then_out;
-	up = (struct msgbuf32 *)uptr;
-	if (put_user(p->mtype, &up->mtype) || copy_to_user(&up->mtext, p->mtext, err))
-		err = -EFAULT;
-free_then_out:
-	kfree(p);
-out:
-	return err;
-}
-
-static int
-msgctl32 (int first, int second, void *uptr)
-{
-	int err = -EINVAL, err2;
-	struct msqid64_ds m64;
-	struct msqid_ds32 *up32 = (struct msqid_ds32 *)uptr;
-	struct msqid64_ds32 *up64 = (struct msqid64_ds32 *)uptr;
-	mm_segment_t old_fs;
-	int version = ipc_parse_version32(&second);
-
-	switch (second) {
-	      case IPC_INFO:
-	      case IPC_RMID:
-	      case MSG_INFO:
-		err = sys_msgctl(first, second, (struct msqid_ds *)uptr);
-		break;
-
-	      case IPC_SET:
-		if (version == IPC_64) {
-			err = get_user(m64.msg_perm.uid, &up64->msg_perm.uid);
-			err |= get_user(m64.msg_perm.gid, &up64->msg_perm.gid);
-			err |= get_user(m64.msg_perm.mode, &up64->msg_perm.mode);
-			err |= get_user(m64.msg_qbytes, &up64->msg_qbytes);
-		} else {
-			err = get_user(m64.msg_perm.uid, &up32->msg_perm.uid);
-			err |= get_user(m64.msg_perm.gid, &up32->msg_perm.gid);
-			err |= get_user(m64.msg_perm.mode, &up32->msg_perm.mode);
-			err |= get_user(m64.msg_qbytes, &up32->msg_qbytes);
-		}
-		if (err)
-			break;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second, (struct msqid_ds *)&m64);
-		set_fs(old_fs);
-		break;
-
-	      case IPC_STAT:
-	      case MSG_STAT:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_msgctl(first, second, (struct msqid_ds *)&m64);
-		set_fs(old_fs);
-
-		if (version == IPC_64) {
-			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(m64.msg_perm.key, &up64->msg_perm.key);
-			err2 |= __put_user(m64.msg_perm.uid, &up64->msg_perm.uid);
-			err2 |= __put_user(m64.msg_perm.gid, &up64->msg_perm.gid);
-			err2 |= __put_user(m64.msg_perm.cuid, &up64->msg_perm.cuid);
-			err2 |= __put_user(m64.msg_perm.cgid, &up64->msg_perm.cgid);
-			err2 |= __put_user(m64.msg_perm.mode, &up64->msg_perm.mode);
-			err2 |= __put_user(m64.msg_perm.seq, &up64->msg_perm.seq);
-			err2 |= __put_user(m64.msg_stime, &up64->msg_stime);
-			err2 |= __put_user(m64.msg_rtime, &up64->msg_rtime);
-			err2 |= __put_user(m64.msg_ctime, &up64->msg_ctime);
-			err2 |= __put_user(m64.msg_cbytes, &up64->msg_cbytes);
-			err2 |= __put_user(m64.msg_qnum, &up64->msg_qnum);
-			err2 |= __put_user(m64.msg_qbytes, &up64->msg_qbytes);
-			err2 |= __put_user(m64.msg_lspid, &up64->msg_lspid);
-			err2 |= __put_user(m64.msg_lrpid, &up64->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		} else {
-			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(m64.msg_perm.key, &up32->msg_perm.key);
-			err2 |= __put_user(m64.msg_perm.uid, &up32->msg_perm.uid);
-			err2 |= __put_user(m64.msg_perm.gid, &up32->msg_perm.gid);
-			err2 |= __put_user(m64.msg_perm.cuid, &up32->msg_perm.cuid);
-			err2 |= __put_user(m64.msg_perm.cgid, &up32->msg_perm.cgid);
-			err2 |= __put_user(m64.msg_perm.mode, &up32->msg_perm.mode);
-			err2 |= __put_user(m64.msg_perm.seq, &up32->msg_perm.seq);
-			err2 |= __put_user(m64.msg_stime, &up32->msg_stime);
-			err2 |= __put_user(m64.msg_rtime, &up32->msg_rtime);
-			err2 |= __put_user(m64.msg_ctime, &up32->msg_ctime);
-			err2 |= __put_user(m64.msg_cbytes, &up32->msg_cbytes);
-			err2 |= __put_user(m64.msg_qnum, &up32->msg_qnum);
-			err2 |= __put_user(m64.msg_qbytes, &up32->msg_qbytes);
-			err2 |= __put_user(m64.msg_lspid, &up32->msg_lspid);
-			err2 |= __put_user(m64.msg_lrpid, &up32->msg_lrpid);
-			if (err2)
-				err = -EFAULT;
-		}
-		break;
-	}
-	return err;
-}
-
-static int
-shmat32 (int first, int second, int third, int version, void *uptr)
-{
-	unsigned long raddr;
-	u32 *uaddr = (u32 *)A((u32)third);
-	int err;
-
-	if (version == 1)
-		return -EINVAL;	/* iBCS2 emulator entry point: unsupported */
-	err = do_shmat(first, uptr, second, &raddr);
-	if (err)
-		return err;
-	return put_user(raddr, uaddr);
-}
-
-static int
-shmctl32 (int first, int second, void *uptr)
-{
-	int err = -EFAULT, err2;
-
-	struct shmid64_ds s64;
-	struct shmid_ds32 *up32 = (struct shmid_ds32 *)uptr;
-	struct shmid64_ds32 *up64 = (struct shmid64_ds32 *)uptr;
-	mm_segment_t old_fs;
-	struct shm_info32 *uip = (struct shm_info32 *)uptr;
-	struct shm_info si;
-	int version = ipc_parse_version32(&second);
-	struct shminfo64 smi;
-	struct shminfo *usi32 = (struct shminfo *) uptr;
-	struct shminfo64_32 *usi64 = (struct shminfo64_32 *) uptr;
-
-	switch (second) {
-	      case IPC_INFO:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (struct shmid_ds *)&smi);
-		set_fs(old_fs);
-
-		if (version == IPC_64) {
-			if (!access_ok(VERIFY_WRITE, usi64, sizeof(*usi64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(smi.shmmax, &usi64->shmmax);
-			err2 |= __put_user(smi.shmmin, &usi64->shmmin);
-			err2 |= __put_user(smi.shmmni, &usi64->shmmni);
-			err2 |= __put_user(smi.shmseg, &usi64->shmseg);
-			err2 |= __put_user(smi.shmall, &usi64->shmall);
-		} else {
-			if (!access_ok(VERIFY_WRITE, usi32, sizeof(*usi32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(smi.shmmax, &usi32->shmmax);
-			err2 |= __put_user(smi.shmmin, &usi32->shmmin);
-			err2 |= __put_user(smi.shmmni, &usi32->shmmni);
-			err2 |= __put_user(smi.shmseg, &usi32->shmseg);
-			err2 |= __put_user(smi.shmall, &usi32->shmall);
-		}
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	      case IPC_RMID:
-	      case SHM_LOCK:
-	      case SHM_UNLOCK:
-		err = sys_shmctl(first, second, (struct shmid_ds *)uptr);
-		break;
-
-	      case IPC_SET:
-		if (version == IPC_64) {
-			err = get_user(s64.shm_perm.uid, &up64->shm_perm.uid);
-			err |= get_user(s64.shm_perm.gid, &up64->shm_perm.gid);
-			err |= get_user(s64.shm_perm.mode, &up64->shm_perm.mode);
-		} else {
-			err = get_user(s64.shm_perm.uid, &up32->shm_perm.uid);
-			err |= get_user(s64.shm_perm.gid, &up32->shm_perm.gid);
-			err |= get_user(s64.shm_perm.mode, &up32->shm_perm.mode);
-		}
-		if (err)
-			break;
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (struct shmid_ds *)&s64);
-		set_fs(old_fs);
-		break;
-
-	      case IPC_STAT:
-	      case SHM_STAT:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (struct shmid_ds *)&s64);
-		set_fs(old_fs);
-		if (err < 0)
-			break;
-		if (version == IPC_64) {
-			if (!access_ok(VERIFY_WRITE, up64, sizeof(*up64))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s64.shm_perm.key, &up64->shm_perm.key);
-			err2 |= __put_user(s64.shm_perm.uid, &up64->shm_perm.uid);
-			err2 |= __put_user(s64.shm_perm.gid, &up64->shm_perm.gid);
-			err2 |= __put_user(s64.shm_perm.cuid, &up64->shm_perm.cuid);
-			err2 |= __put_user(s64.shm_perm.cgid, &up64->shm_perm.cgid);
-			err2 |= __put_user(s64.shm_perm.mode, &up64->shm_perm.mode);
-			err2 |= __put_user(s64.shm_perm.seq, &up64->shm_perm.seq);
-			err2 |= __put_user(s64.shm_atime, &up64->shm_atime);
-			err2 |= __put_user(s64.shm_dtime, &up64->shm_dtime);
-			err2 |= __put_user(s64.shm_ctime, &up64->shm_ctime);
-			err2 |= __put_user(s64.shm_segsz, &up64->shm_segsz);
-			err2 |= __put_user(s64.shm_nattch, &up64->shm_nattch);
-			err2 |= __put_user(s64.shm_cpid, &up64->shm_cpid);
-			err2 |= __put_user(s64.shm_lpid, &up64->shm_lpid);
-		} else {
-			if (!access_ok(VERIFY_WRITE, up32, sizeof(*up32))) {
-				err = -EFAULT;
-				break;
-			}
-			err2 = __put_user(s64.shm_perm.key, &up32->shm_perm.key);
-			err2 |= __put_user(s64.shm_perm.uid, &up32->shm_perm.uid);
-			err2 |= __put_user(s64.shm_perm.gid, &up32->shm_perm.gid);
-			err2 |= __put_user(s64.shm_perm.cuid, &up32->shm_perm.cuid);
-			err2 |= __put_user(s64.shm_perm.cgid, &up32->shm_perm.cgid);
-			err2 |= __put_user(s64.shm_perm.mode, &up32->shm_perm.mode);
-			err2 |= __put_user(s64.shm_perm.seq, &up32->shm_perm.seq);
-			err2 |= __put_user(s64.shm_atime, &up32->shm_atime);
-			err2 |= __put_user(s64.shm_dtime, &up32->shm_dtime);
-			err2 |= __put_user(s64.shm_ctime, &up32->shm_ctime);
-			err2 |= __put_user(s64.shm_segsz, &up32->shm_segsz);
-			err2 |= __put_user(s64.shm_nattch, &up32->shm_nattch);
-			err2 |= __put_user(s64.shm_cpid, &up32->shm_cpid);
-			err2 |= __put_user(s64.shm_lpid, &up32->shm_lpid);
-		}
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	      case SHM_INFO:
-		old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		err = sys_shmctl(first, second, (void *)&si);
-		set_fs(old_fs);
-		if (err < 0)
-			break;
-
-		if (!access_ok(VERIFY_WRITE, uip, sizeof(*uip))) {
-			err = -EFAULT;
-			break;
-		}
-		err2 = __put_user(si.used_ids, &uip->used_ids);
-		err2 |= __put_user(si.shm_tot, &uip->shm_tot);
-		err2 |= __put_user(si.shm_rss, &uip->shm_rss);
-		err2 |= __put_user(si.shm_swp, &uip->shm_swp);
-		err2 |= __put_user(si.swap_attempts, &uip->swap_attempts);
-		err2 |= __put_user(si.swap_successes, &uip->swap_successes);
-		if (err2)
-			err = -EFAULT;
-		break;
-
-	}
-	return err;
-}
-
-extern int sem_ctls[];
-#define sc_semopm	(sem_ctls[2])
-
-static long
-semtimedop32(int semid, struct sembuf *tsops, int nsops,
-	     struct compat_timespec *timeout32)
-{
-	struct timespec t;
-	mm_segment_t oldfs;
-	long ret;
-
-	/* parameter checking precedence should mirror sys_semtimedop() */
-	if (nsops < 1 || semid < 0)
-		return -EINVAL;
-	if (nsops > sc_semopm)
-		return -E2BIG;
-	if (!access_ok(VERIFY_READ, tsops, nsops * sizeof(struct sembuf)) ||
-	    get_compat_timespec(&t, timeout32))
-		return -EFAULT;
-
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_semtimedop(semid, tsops, nsops, &t);
-	set_fs(oldfs);
-	return ret;
-}
-
 asmlinkage long
 sys32_ipc(u32 call, int first, int second, int third, u32 ptr, u32 fifth)
 {
@@ -1632,36 +1047,36 @@ sys32_ipc(u32 call, int first, int secon
 	switch (call) {
 	      case SEMTIMEDOP:
 		if (fifth)
-			return semtimedop32(first, (struct sembuf *)AA(ptr),
-				second, (struct compat_timespec *)AA(fifth));
+			return compat_sys_semtimedop(first, compat_ptr(ptr),
+				second, compat_ptr(fifth));
 		/* else fall through for normal semop() */
 	      case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		return sys_semtimedop(first, (struct sembuf *)AA(ptr), second,
+		return sys_semtimedop(first, compat_ptr(ptr), second,
 				      NULL);
 	      case SEMGET:
 		return sys_semget(first, second, third);
 	      case SEMCTL:
-		return semctl32(first, second, third, (void *)AA(ptr));
+		return compat_sys_semctl(first, second, third, compat_ptr(ptr));
 
 	      case MSGSND:
-		return do_sys32_msgsnd(first, second, third, (void *)AA(ptr));
+		return compat_sys_msgsnd(first, second, third, compat_ptr(ptr));
 	      case MSGRCV:
-		return do_sys32_msgrcv(first, second, fifth, third, version, (void *)AA(ptr));
+		return compat_sys_msgrcv(first, second, fifth, third, version, compat_ptr(ptr));
 	      case MSGGET:
 		return sys_msgget((key_t) first, second);
 	      case MSGCTL:
-		return msgctl32(first, second, (void *)AA(ptr));
+		return compat_sys_msgctl(first, second, compat_ptr(ptr));
 
 	      case SHMAT:
-		return shmat32(first, second, third, version, (void *)AA(ptr));
+		return compat_sys_shmat(first, second, third, version, compat_ptr(ptr));
 		break;
 	      case SHMDT:
-		return sys_shmdt((char *)AA(ptr));
+		return sys_shmdt(compat_ptr(ptr));
 	      case SHMGET:
 		return sys_shmget(first, second, third);
 	      case SHMCTL:
-		return shmctl32(first, second, (void *)AA(ptr));
+		return compat_sys_shmctl(first, second, compat_ptr(ptr));
 
 	      default:
 		return -ENOSYS;
diff -puN arch/ia64/Kconfig~compat-generic-ipc-emulation arch/ia64/Kconfig
--- 25/arch/ia64/Kconfig~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/arch/ia64/Kconfig	Mon Mar 15 14:22:21 2004
@@ -537,7 +537,11 @@ config DEBUG_INFO
 	  debugging info resulting in a larger kernel image.
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
-	  
+
+config SYSVIPC_COMPAT
+	bool
+	depends on COMPAT && SYSVIPC
+	default y
 endmenu
 
 source "security/Kconfig"
diff -puN include/asm-ia64/compat.h~compat-generic-ipc-emulation include/asm-ia64/compat.h
--- 25/include/asm-ia64/compat.h~compat-generic-ipc-emulation	Mon Mar 15 14:22:21 2004
+++ 25-akpm/include/asm-ia64/compat.h	Mon Mar 15 14:23:36 2004
@@ -11,6 +11,7 @@ typedef u32		compat_size_t;
 typedef s32		compat_ssize_t;
 typedef s32		compat_time_t;
 typedef s32		compat_clock_t;
+typedef s32		compat_key_t;
 typedef s32		compat_pid_t;
 typedef u16		compat_uid_t;
 typedef u16		compat_gid_t;
@@ -116,6 +117,64 @@ typedef u32		compat_sigset_word;
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+struct compat_ipc64_perm {
+	compat_key_t key;
+	compat_uid32_t uid;
+	compat_gid32_t gid;
+	compat_uid32_t cuid;
+	compat_gid32_t cgid;
+	unsigned short mode;
+	unsigned short __pad1;
+	unsigned short seq;
+	unsigned short __pad2;
+	compat_ulong_t unused1;
+	compat_ulong_t unused2;
+};
+
+struct compat_semid64_ds {
+	struct compat_ipc64_perm sem_perm;
+	compat_time_t  sem_otime;
+	compat_ulong_t __unused1;
+	compat_time_t  sem_ctime;
+	compat_ulong_t __unused2;
+	compat_ulong_t sem_nsems;
+	compat_ulong_t __unused3;
+	compat_ulong_t __unused4;
+};
+
+struct compat_msqid64_ds {
+	struct compat_ipc64_perm msg_perm;
+	compat_time_t  msg_stime;
+	compat_ulong_t __unused1;
+	compat_time_t  msg_rtime;
+	compat_ulong_t __unused2;
+	compat_time_t  msg_ctime;
+	compat_ulong_t __unused3;
+	compat_ulong_t msg_cbytes;
+	compat_ulong_t msg_qnum;
+	compat_ulong_t msg_qbytes;
+	compat_pid_t   msg_lspid;
+	compat_pid_t   msg_lrpid;
+	compat_ulong_t __unused4;
+	compat_ulong_t __unused5;
+};
+
+struct compat_shmid64_ds {
+	struct compat_ipc64_perm shm_perm;
+	compat_size_t  shm_segsz;
+	compat_time_t  shm_atime;
+	compat_ulong_t __unused1;
+	compat_time_t  shm_dtime;
+	compat_ulong_t __unused2;
+	compat_time_t  shm_ctime;
+	compat_ulong_t __unused3;
+	compat_pid_t   shm_cpid;
+	compat_pid_t   shm_lpid;
+	compat_ulong_t shm_nattch;
+	compat_ulong_t __unused4;
+	compat_ulong_t __unused5;
+};
+
 /*
  * A pointer passed in from user mode. This should not be used for syscall parameters,
  * just declare them as pointers because the syscall entry code will have appropriately
diff -puN include/linux/msg.h~compat-generic-ipc-emulation include/linux/msg.h

_
