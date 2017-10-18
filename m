From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [PATCH 4/4][PoC][RFC] Allow to trace fd usage with rlimit-events
Date: Wed, 18 Oct 2017 22:32:30 +0200
Message-ID: <20171018203230.29871-5-k.opasiak@samsung.com>
References: <20171018203230.29871-1-k.opasiak@samsung.com>
        <CGME20171018203342epcas1p23933a20a33807f92c716433374374397@epcas1p2.samsung.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22622 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751649AbdJRUdp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Oct 2017 16:33:45 -0400
In-reply-to: <20171018203230.29871-1-k.opasiak@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, b.zolnierkie@samsung.com, andrzej.p@samsung.com, kopasiak90@gmail.com, Krzysztof Opasiak <k.opasiak@samsung.com>

Add rlimit-events calls to file descriptors management
code to allow tracing of FD usage.

This allows userspace process (monitor) to get notification when
other process (subject) uses given amount of file descriptors.

This can be used to for example asynchronously monitor number
of open FD's in system services instead of polling with
predefined interval.

Signed-off-by: Krzysztof Opasiak <k.opasiak@samsung.com>
---
 drivers/android/binder.c |  4 +--
 fs/exec.c                |  2 +-
 fs/file.c                | 83 ++++++++++++++++++++++++++++++++++++++++--------
 fs/open.c                |  2 +-
 include/linux/fdtable.h  |  9 +++---
 5 files changed, 77 insertions(+), 23 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index d802384ccdd3..b4be938a8ddf 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -417,7 +417,7 @@ static int task_get_unused_fd_flags(struct binder_proc *proc, int flags)
 	rlim_cur = task_rlimit(proc->tsk, RLIMIT_NOFILE);
 	unlock_task_sighand(proc->tsk, &irqs);
 
-	return __alloc_fd(files, 0, rlim_cur, flags);
+	return __alloc_fd(proc->tsk, 0, rlim_cur, flags);
 }
 
 /*
@@ -440,7 +440,7 @@ static long task_close_fd(struct binder_proc *proc, unsigned int fd)
 	if (proc->files == NULL)
 		return -ESRCH;
 
-	retval = __close_fd(proc->files, fd);
+	retval = __close_fd(proc->tsk, fd);
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
 		     retval == -ERESTARTNOINTR ||
diff --git a/fs/exec.c b/fs/exec.c
index 964e34e307df..01bd18d29ee4 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1297,7 +1297,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 * trying to access the should-be-closed file descriptors of a process
 	 * undergoing exec(2).
 	 */
-	do_close_on_exec(current->files);
+	do_close_on_exec(current);
 	return 0;
 
 out:
diff --git a/fs/file.c b/fs/file.c
index 1c2972e3a405..43ed27238b09 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/rlimit_noti_kern.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -268,7 +269,7 @@ static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
+static unsigned int get_last_open_file(struct fdtable *fdt)
 {
 	unsigned int size = fdt->max_fds;
 	unsigned int i;
@@ -314,7 +315,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = count_open_files(old_fdt);
+	open_files = get_last_open_file(old_fdt);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -345,7 +346,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = count_open_files(old_fdt);
+		open_files = get_last_open_file(old_fdt);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
@@ -477,6 +478,31 @@ struct files_struct init_files = {
 	.file_lock	= __SPIN_LOCK_UNLOCKED(init_files.file_lock),
 };
 
+static unsigned int count_open_fds(struct fdtable *fdt)
+{
+	unsigned int maxfd = fdt->max_fds;
+	unsigned int maxbit = maxfd / BITS_PER_LONG;
+	unsigned int count = 0;
+	int i;
+
+	i = find_next_zero_bit(fdt->full_fds_bits, maxbit, 0);
+	/* If there is no free fds */
+	if (i > maxbit)
+		return maxfd;
+#if BITS_PER_LONG == 32
+#define HWEIGHT_LONG hweight32
+#else
+#define HWEIGHT_LONG hweight64
+#endif
+
+	count += i * BITS_PER_LONG;
+	for (; i < maxbit; ++i)
+		count += HWEIGHT_LONG(fdt->open_fds[i]);
+
+#undef HWEIGHT_LONG
+	return count;
+}
+
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
 	unsigned int maxfd = fdt->max_fds;
@@ -494,9 +520,10 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 /*
  * allocate a file descriptor, mark it busy.
  */
-int __alloc_fd(struct files_struct *files,
-	       unsigned start, unsigned end, unsigned flags)
+int __alloc_fd(struct task_struct *owner, unsigned int start, unsigned int end,
+	       unsigned int flags)
 {
+	struct files_struct *files = owner->files;
 	unsigned int fd;
 	int error;
 	struct fdtable *fdt;
@@ -539,6 +566,13 @@ int __alloc_fd(struct files_struct *files,
 	else
 		__clear_close_on_exec(fd, fdt);
 	error = fd;
+
+	if (rlimit_noti_watch_active(owner, RLIMIT_NOFILE)) {
+		unsigned int count;
+
+		count = count_open_fds(fdt);
+		rlimit_noti_res_changed(owner, RLIMIT_NOFILE, count - 1, count);
+	}
 #if 1
 	/* Sanity check */
 	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
@@ -554,28 +588,37 @@ int __alloc_fd(struct files_struct *files,
 
 static int alloc_fd(unsigned start, unsigned flags)
 {
-	return __alloc_fd(current->files, start, rlimit(RLIMIT_NOFILE), flags);
+	return __alloc_fd(current,
+			  start, rlimit(RLIMIT_NOFILE), flags);
 }
 
 int get_unused_fd_flags(unsigned flags)
 {
-	return __alloc_fd(current->files, 0, rlimit(RLIMIT_NOFILE), flags);
+	return alloc_fd(0, flags);
 }
 EXPORT_SYMBOL(get_unused_fd_flags);
 
-static void __put_unused_fd(struct files_struct *files, unsigned int fd)
+static void __put_unused_fd(struct task_struct *owner, unsigned int fd)
 {
+	struct files_struct *files = owner->files;
 	struct fdtable *fdt = files_fdtable(files);
 	__clear_open_fd(fd, fdt);
 	if (fd < files->next_fd)
 		files->next_fd = fd;
+
+	if (rlimit_noti_watch_active(owner, RLIMIT_NOFILE)) {
+		unsigned int count;
+
+		count = count_open_fds(fdt);
+		rlimit_noti_res_changed(owner, RLIMIT_NOFILE, count + 1, count);
+	}
 }
 
 void put_unused_fd(unsigned int fd)
 {
 	struct files_struct *files = current->files;
 	spin_lock(&files->file_lock);
-	__put_unused_fd(files, fd);
+	__put_unused_fd(current, fd);
 	spin_unlock(&files->file_lock);
 }
 
@@ -632,8 +675,9 @@ EXPORT_SYMBOL(fd_install);
 /*
  * The same warnings as for __alloc_fd()/__fd_install() apply here...
  */
-int __close_fd(struct files_struct *files, unsigned fd)
+int __close_fd(struct task_struct *owner, unsigned int fd)
 {
+	struct files_struct *files = owner->files;
 	struct file *file;
 	struct fdtable *fdt;
 
@@ -646,7 +690,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 		goto out_unlock;
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	__clear_close_on_exec(fd, fdt);
-	__put_unused_fd(files, fd);
+	__put_unused_fd(owner, fd);
 	spin_unlock(&files->file_lock);
 	return filp_close(file, files);
 
@@ -655,10 +699,11 @@ int __close_fd(struct files_struct *files, unsigned fd)
 	return -EBADF;
 }
 
-void do_close_on_exec(struct files_struct *files)
+void do_close_on_exec(struct task_struct *tsk)
 {
 	unsigned i;
 	struct fdtable *fdt;
+	struct files_struct *files = tsk->files;
 
 	/* exec unshares first */
 	spin_lock(&files->file_lock);
@@ -680,7 +725,7 @@ void do_close_on_exec(struct files_struct *files)
 			if (!file)
 				continue;
 			rcu_assign_pointer(fdt->fd[fd], NULL);
-			__put_unused_fd(files, fd);
+			__put_unused_fd(tsk, fd);
 			spin_unlock(&files->file_lock);
 			filp_close(file, files);
 			cond_resched();
@@ -852,6 +897,16 @@ __releases(&files->file_lock)
 		__set_close_on_exec(fd, fdt);
 	else
 		__clear_close_on_exec(fd, fdt);
+
+	/* If fd was previously open then number of opened fd stays untouched */
+	if (!tofree && rlimit_noti_watch_active(current, RLIMIT_NOFILE)) {
+		unsigned int count;
+
+		count = count_open_fds(fdt);
+		rlimit_noti_res_changed(current, RLIMIT_NOFILE,
+					count - 1, count);
+	}
+
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
@@ -870,7 +925,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	struct files_struct *files = current->files;
 
 	if (!file)
-		return __close_fd(files, fd);
+		return __close_fd(current, fd);
 
 	if (fd >= rlimit(RLIMIT_NOFILE))
 		return -EBADF;
diff --git a/fs/open.c b/fs/open.c
index cd0c5be8d012..0fef6288f88c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1148,7 +1148,7 @@ EXPORT_SYMBOL(filp_close);
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-	int retval = __close_fd(current->files, fd);
+	int retval = __close_fd(current, fd);
 
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 6e84b2cae6ad..6379753c0037 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -106,17 +106,16 @@ void put_files_struct(struct files_struct *fs);
 void reset_files_struct(struct files_struct *);
 int unshare_files(struct files_struct **);
 struct files_struct *dup_fd(struct files_struct *, int *) __latent_entropy;
-void do_close_on_exec(struct files_struct *);
+void do_close_on_exec(struct task_struct *tsk);
 int iterate_fd(struct files_struct *, unsigned,
 		int (*)(const void *, struct file *, unsigned),
 		const void *);
 
-extern int __alloc_fd(struct files_struct *files,
-		      unsigned start, unsigned end, unsigned flags);
+extern int __alloc_fd(struct task_struct *owner,
+		      unsigned int start, unsigned int end, unsigned int flags);
 extern void __fd_install(struct files_struct *files,
 		      unsigned int fd, struct file *file);
-extern int __close_fd(struct files_struct *files,
-		      unsigned int fd);
+extern int __close_fd(struct task_struct *owner, unsigned int fd);
 
 extern struct kmem_cache *files_cachep;
 
-- 
2.9.3
