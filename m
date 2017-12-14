From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: [RFC PATCH v2 4/4] Allow to trace fd usage with rlimit-events
Date: Thu, 14 Dec 2017 23:00:12 +0100
Message-ID: <20171214220012.10103-5-k.opasiak@samsung.com>
References: <20171214220012.10103-1-k.opasiak@samsung.com>
        <CGME20171214220049epcas2p222a0a63c7aa70908ae316644e121100b@epcas2p2.samsung.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:31709 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbdLNWAv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Dec 2017 17:00:51 -0500
In-reply-to: <20171214220012.10103-1-k.opasiak@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, k.lewandowsk@samsung.com, l.stelmach@samsung.com, p.szewczyk@samsung.com, Krzysztof Opasiak <k.opasiak@samsung.com>

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
 fs/file.c                | 82 +++++++++++++++++++++++++++++++++++++++---------
 fs/open.c                |  2 +-
 include/linux/fdtable.h  |  8 ++---
 5 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index fddf76ef5bd6..06bb13e75260 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -890,7 +890,7 @@ static int task_get_unused_fd_flags(struct binder_proc *proc, int flags)
 	rlim_cur = task_rlimit(proc->tsk, RLIMIT_NOFILE);
 	unlock_task_sighand(proc->tsk, &irqs);
 
-	return __alloc_fd(files, 0, rlim_cur, flags);
+	return __alloc_fd(proc->tsk, files, 0, rlim_cur, flags);
 }
 
 /*
@@ -913,7 +913,7 @@ static long task_close_fd(struct binder_proc *proc, unsigned int fd)
 	if (proc->files == NULL)
 		return -ESRCH;
 
-	retval = __close_fd(proc->files, fd);
+	retval = __close_fd(proc->tsk, proc->files, fd);
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
 		     retval == -ERESTARTNOINTR ||
diff --git a/fs/exec.c b/fs/exec.c
index 3e14ba25f678..bfc63506876d 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1293,7 +1293,7 @@ int flush_old_exec(struct linux_binprm * bprm)
 	 * trying to access the should-be-closed file descriptors of a process
 	 * undergoing exec(2).
 	 */
-	do_close_on_exec(current->files);
+	do_close_on_exec(current);
 	return 0;
 
 out:
diff --git a/fs/file.c b/fs/file.c
index 4eecbf4244a5..2f2e14a18e19 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/workqueue.h>
+#include <linux/rlimit_noti_kern.h>
 
 unsigned int sysctl_nr_open __read_mostly = 1024*1024;
 unsigned int sysctl_nr_open_min = BITS_PER_LONG;
@@ -255,7 +256,7 @@ static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 	__clear_bit(fd / BITS_PER_LONG, fdt->full_fds_bits);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
+static unsigned int get_last_open_file(struct fdtable *fdt)
 {
 	unsigned int size = fdt->max_fds;
 	unsigned int i;
@@ -301,7 +302,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 
 	spin_lock(&oldf->file_lock);
 	old_fdt = files_fdtable(oldf);
-	open_files = count_open_files(old_fdt);
+	open_files = get_last_open_file(old_fdt);
 
 	/*
 	 * Check whether we need to allocate a larger fd array and fd set.
@@ -332,7 +333,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 		 */
 		spin_lock(&oldf->file_lock);
 		old_fdt = files_fdtable(oldf);
-		open_files = count_open_files(old_fdt);
+		open_files = get_last_open_file(old_fdt);
 	}
 
 	copy_fd_bitmaps(new_fdt, old_fdt, open_files);
@@ -464,6 +465,31 @@ struct files_struct init_files = {
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
@@ -481,8 +507,8 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 /*
  * allocate a file descriptor, mark it busy.
  */
-int __alloc_fd(struct files_struct *files,
-	       unsigned start, unsigned end, unsigned flags)
+int __alloc_fd(struct task_struct *owner, struct files_struct *files,
+	       unsigned int start, unsigned int end, unsigned int flags)
 {
 	unsigned int fd;
 	int error;
@@ -526,6 +552,13 @@ int __alloc_fd(struct files_struct *files,
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
@@ -541,28 +574,37 @@ int __alloc_fd(struct files_struct *files,
 
 static int alloc_fd(unsigned start, unsigned flags)
 {
-	return __alloc_fd(current->files, start, rlimit(RLIMIT_NOFILE), flags);
+	return __alloc_fd(current, current->files,
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
 
@@ -619,7 +661,8 @@ EXPORT_SYMBOL(fd_install);
 /*
  * The same warnings as for __alloc_fd()/__fd_install() apply here...
  */
-int __close_fd(struct files_struct *files, unsigned fd)
+int __close_fd(struct task_struct *owner, struct files_struct *files,
+	       unsigned int fd)
 {
 	struct file *file;
 	struct fdtable *fdt;
@@ -633,7 +676,7 @@ int __close_fd(struct files_struct *files, unsigned fd)
 		goto out_unlock;
 	rcu_assign_pointer(fdt->fd[fd], NULL);
 	__clear_close_on_exec(fd, fdt);
-	__put_unused_fd(files, fd);
+	__put_unused_fd(owner, fd);
 	spin_unlock(&files->file_lock);
 	return filp_close(file, files);
 
@@ -642,10 +685,11 @@ int __close_fd(struct files_struct *files, unsigned fd)
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
@@ -667,7 +711,7 @@ void do_close_on_exec(struct files_struct *files)
 			if (!file)
 				continue;
 			rcu_assign_pointer(fdt->fd[fd], NULL);
-			__put_unused_fd(files, fd);
+			__put_unused_fd(tsk, fd);
 			spin_unlock(&files->file_lock);
 			filp_close(file, files);
 			cond_resched();
@@ -839,6 +883,16 @@ __releases(&files->file_lock)
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
@@ -857,7 +911,7 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	struct files_struct *files = current->files;
 
 	if (!file)
-		return __close_fd(files, fd);
+		return __close_fd(current, files, fd);
 
 	if (fd >= rlimit(RLIMIT_NOFILE))
 		return -EBADF;
diff --git a/fs/open.c b/fs/open.c
index 7ea118471dce..dc0d19d35df0 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1152,7 +1152,7 @@ EXPORT_SYMBOL(filp_close);
  */
 SYSCALL_DEFINE1(close, unsigned int, fd)
 {
-	int retval = __close_fd(current->files, fd);
+	int retval = __close_fd(current, current->files, fd);
 
 	/* can't restart close syscall because file table entry was cleared */
 	if (unlikely(retval == -ERESTARTSYS ||
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 1c65817673db..b254796e46b7 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -107,16 +107,16 @@ void put_files_struct(struct files_struct *fs);
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
+extern int __alloc_fd(struct task_struct *owner, struct files_struct *files,
+		      unsigned int start, unsigned int end, unsigned int flags);
 extern void __fd_install(struct files_struct *files,
 		      unsigned int fd, struct file *file);
-extern int __close_fd(struct files_struct *files,
+extern int __close_fd(struct task_struct *owner, struct files_struct *files,
 		      unsigned int fd);
 
 extern struct kmem_cache *files_cachep;
-- 
2.9.3
