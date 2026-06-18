Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FB3E47B;
	Thu, 18 Jun 2026 03:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752067; cv=none; b=G1q00aUCVnfWKi5mRSbi3l+NbMYGqa7rsJ5FxYtbJsXdRrUtR6YDcFjihqHTpiNVnG9az4uHH425qGIdKMYNS31G4NVxBCJBoyCxzK2js7aBz32vLnidHd9Pig6aNI7EzSmMC6HDwwb8Dc/7bY+DbXKZnmv8td9+v47+uMbawkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752067; c=relaxed/simple;
	bh=Uzpr9NS3HurYRwItemN5xvBVjkrAVfgNbuybr+YWdNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kqw2hEI6p6+DpLhhenoISPVB8L1brSqh1m3v8NXGdo49L4jopnRAbEefd4k9jhgMKTqf2a0JNwOxUCarD5zIwvKbpjkslu3wSbwSrm7VTBfZpkD4YWYiUm0s/jjmGpRJ135sRbp50Jcm94SaB1PF6AeWZzFVWfN3oHatCaMQMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NuQJWoUa; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NuQJWoUa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7V
	i66Y/I2Fpuad7v3k+rJy085uZ3cYzavPfEyjvuwRo=; b=NuQJWoUawnvQiGLnc3
	IJX1vTo+eAbzkEN4TZqfMLMYMLXNA7S0BXooZgG5m9qWwLDKlNqbRoky3sAkxghC
	dt0VC5CZRGN9HlNV+04HasGKjv9EWG74NZPG/iBSDD5rc2tjwUDsmJC40UnieVlT
	6XcCeHZjvormGgFP0HxXtcPGg=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wB3dXDWYDNq0RM8EA--.1564S2;
	Thu, 18 Jun 2026 11:07:04 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	ebiederm@xmission.com,
	keescook@chromium.org,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	allen.lkml@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Xin Zhao <jackzxcui1989@163.com>
Subject: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before dumping core
Date: Thu, 18 Jun 2026 11:07:00 +0800
Message-Id: <20260618030700.2511668-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3dXDWYDNq0RM8EA--.1564S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3KFWrtr1Dtw43ur4UCr4fuFg_yoWkAF4UpF
	yYg34DtrWUGFW093srAayDAw1fKw1kGr1DWryxW34SyF1rKr15XFn3GryjyF15Jr4v9FZF
	vFy3Kry7GrZrJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEtCztUUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCvxi1v2ozYNg0XQAA3l

A coredump typically takes some time to complete. If we happen to hold a
write lock with flock just before triggering the coredump, that write lock
will not be released during the entire coredump process. As a result,
other processes attempting to acquire the same write lock may experience
significant delays.

To address this, we introduce the F_[GET|SET]FD_EX fcntl operation and the
FD_CLOBCOR flag, allowing coredump_wait() to release any file descriptors
marked with FD_CLOBCOR. We can also assign the FD_CLOBCOR flag to specific
shared memory segments, preventing the coredump from including shared
memory that we are not interested in, thereby reducing both the coredump
duration and the size of the core file.

We actually considered using signals that generate coredumps to perform
the actions we wanted in user space. However, since other threads within
the process are not frozen when handling these signals, indiscriminately
closing an fd can lead to concurrency issues. For example, if the thread
that triggered the coredump closes the fd in the signal handler while
other threads are using the resources associated with that fd, it could
cause secondary corruption of the coredump state.

Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
---
 fs/coredump.c                    |  2 +
 fs/fcntl.c                       |  7 +++
 fs/file.c                        | 91 ++++++++++++++++++++++++++++++--
 include/linux/fdtable.h          |  7 +++
 include/linux/file.h             |  2 +
 include/linux/sched/task.h       |  1 +
 include/uapi/asm-generic/fcntl.h | 11 ++++
 7 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index bb6fdb1f4..d927fe93d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -548,6 +548,8 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 		}
 	}
 
+	exit_files_before_core(tsk);
+
 	return core_waiters;
 }
 
diff --git a/fs/fcntl.c b/fs/fcntl.c
index beab8080b..14b774250 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -470,6 +470,13 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = 0;
 		set_close_on_exec(fd, argi & FD_CLOEXEC);
 		break;
+	case F_GETFD_EX:
+		err = get_close_before_core(fd) ? FD_CLOBCOR : 0;
+		break;
+	case F_SETFD_EX:
+		err = 0;
+		set_close_before_core(fd, argi & FD_CLOBCOR);
+		break;
 	case F_GETFL:
 		err = filp->f_flags;
 		break;
diff --git a/fs/file.c b/fs/file.c
index 2c81c0b16..1c64dfdca 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -130,6 +130,8 @@ static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
 			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
 	bitmap_copy_and_extend(nfdt->close_on_exec, ofdt->close_on_exec,
 			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
+	bitmap_copy_and_extend(nfdt->close_before_core, ofdt->close_before_core,
+			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
 	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
 			copy_words, nwords);
 }
@@ -222,7 +224,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 	fdt->fd = data;
 
 	data = kvmalloc(max_t(size_t,
-				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
+				 3 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
 				 GFP_KERNEL_ACCOUNT);
 	if (!data)
 		goto out_arr;
@@ -230,6 +232,8 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 	data += nr / BITS_PER_BYTE;
 	fdt->close_on_exec = data;
 	data += nr / BITS_PER_BYTE;
+	fdt->close_before_core = data;
+	data += nr / BITS_PER_BYTE;
 	fdt->full_fds_bits = data;
 
 	return fdt;
@@ -330,10 +334,22 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
 	}
 }
 
+static inline void __set_close_before_core(unsigned int fd, struct fdtable *fdt,
+				       bool set)
+{
+	if (set) {
+		__set_bit(fd, fdt->close_before_core);
+	} else {
+		if (test_bit(fd, fdt->close_before_core))
+			__clear_bit(fd, fdt->close_before_core);
+	}
+}
+
 static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
 {
 	__set_bit(fd, fdt->open_fds);
 	__set_close_on_exec(fd, fdt, set);
+	__set_close_before_core(fd, fdt, false);
 	fd /= BITS_PER_LONG;
 	if (!~fdt->open_fds[fd])
 		__set_bit(fd, fdt->full_fds_bits);
@@ -400,6 +416,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	new_fdt = &newf->fdtab;
 	new_fdt->max_fds = NR_OPEN_DEFAULT;
 	new_fdt->close_on_exec = newf->close_on_exec_init;
+	new_fdt->close_before_core = newf->close_before_core_init;
 	new_fdt->open_fds = newf->open_fds_init;
 	new_fdt->full_fds_bits = newf->full_fds_bits_init;
 	new_fdt->fd = &newf->fd_array[0];
@@ -471,7 +488,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	return newf;
 }
 
-static struct fdtable *close_files(struct files_struct * files)
+static struct fdtable *close_files(struct files_struct *files)
 {
 	/*
 	 * It is safe to dereference the fd table without RCU or
@@ -483,6 +500,7 @@ static struct fdtable *close_files(struct files_struct * files)
 
 	for (;;) {
 		unsigned long set;
+
 		i = j * BITS_PER_LONG;
 		if (i >= fdt->max_fds)
 			break;
@@ -490,6 +508,7 @@ static struct fdtable *close_files(struct files_struct * files)
 		while (set) {
 			if (set & 1) {
 				struct file *file = fdt->fd[i];
+
 				if (file) {
 					filp_close(file, files);
 					cond_resched();
@@ -503,6 +522,41 @@ static struct fdtable *close_files(struct files_struct * files)
 	return fdt;
 }
 
+static struct fdtable *close_files_before_core(struct files_struct *files)
+{
+	/*
+	 * It is safe to dereference the fd table without RCU or
+	 * ->file_lock because this is the last reference to the
+	 * files structure.
+	 */
+	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
+	unsigned int i, j = 0;
+
+	for (;;) {
+		unsigned long set;
+
+		i = j * BITS_PER_LONG;
+		if (i >= fdt->max_fds)
+			break;
+		set = fdt->open_fds[j++];
+		while (set) {
+			if (set & 1 && close_before_core(i, files)) {
+				struct file *file = fdt->fd[i];
+
+				if (file) {
+					filp_close(file, files);
+					cond_resched();
+				}
+			}
+			i++;
+			set >>= 1;
+		}
+	}
+
+	return fdt;
+}
+
+
 void put_files_struct(struct files_struct *files)
 {
 	if (atomic_dec_and_test(&files->count)) {
@@ -517,7 +571,7 @@ void put_files_struct(struct files_struct *files)
 
 void exit_files(struct task_struct *tsk)
 {
-	struct files_struct * files = tsk->files;
+	struct files_struct *files = tsk->files;
 
 	if (files) {
 		task_lock(tsk);
@@ -527,6 +581,15 @@ void exit_files(struct task_struct *tsk)
 	}
 }
 
+void exit_files_before_core(struct task_struct *tsk)
+{
+	struct files_struct *files = tsk->files;
+
+	if (files) {
+		close_files_before_core(files);
+	}
+}
+
 struct files_struct init_files = {
 	.count		= ATOMIC_INIT(1),
 	.fdt		= &init_files.fdtab,
@@ -534,6 +597,7 @@ struct files_struct init_files = {
 		.max_fds	= NR_OPEN_DEFAULT,
 		.fd		= &init_files.fd_array[0],
 		.close_on_exec	= init_files.close_on_exec_init,
+		.close_before_core = init_files.close_before_core_init,
 		.open_fds	= init_files.open_fds_init,
 		.full_fds_bits	= init_files.full_fds_bits_init,
 	},
@@ -1277,6 +1341,7 @@ void __f_unlock_pos(struct file *f)
 void set_close_on_exec(unsigned int fd, int flag)
 {
 	struct files_struct *files = current->files;
+
 	spin_lock(&files->file_lock);
 	__set_close_on_exec(fd, files_fdtable(files), flag);
 	spin_unlock(&files->file_lock);
@@ -1285,12 +1350,32 @@ void set_close_on_exec(unsigned int fd, int flag)
 bool get_close_on_exec(unsigned int fd)
 {
 	bool res;
+
 	rcu_read_lock();
 	res = close_on_exec(fd, current->files);
 	rcu_read_unlock();
 	return res;
 }
 
+void set_close_before_core(unsigned int fd, int flag)
+{
+	struct files_struct *files = current->files;
+
+	spin_lock(&files->file_lock);
+	__set_close_before_core(fd, files_fdtable(files), flag);
+	spin_unlock(&files->file_lock);
+}
+
+bool get_close_before_core(unsigned int fd)
+{
+	bool res;
+
+	rcu_read_lock();
+	res = close_before_core(fd, current->files);
+	rcu_read_unlock();
+	return res;
+}
+
 static int do_dup2(struct files_struct *files,
 	struct file *file, unsigned fd, unsigned flags)
 __releases(&files->file_lock)
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f..0a53d09bd 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -27,6 +27,7 @@ struct fdtable {
 	unsigned int max_fds;
 	struct file __rcu **fd;      /* current fd array */
 	unsigned long *close_on_exec;
+	unsigned long *close_before_core;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
 	struct rcu_head rcu;
@@ -51,6 +52,7 @@ struct files_struct {
 	spinlock_t file_lock ____cacheline_aligned_in_smp;
 	unsigned int next_fd;
 	unsigned long close_on_exec_init[1];
+	unsigned long close_before_core_init[1];
 	unsigned long open_fds_init[1];
 	unsigned long full_fds_bits_init[1];
 	struct file __rcu * fd_array[NR_OPEN_DEFAULT];
@@ -97,6 +99,11 @@ static inline bool close_on_exec(unsigned int fd, const struct files_struct *fil
 	return test_bit(fd, files_fdtable(files)->close_on_exec);
 }
 
+static inline bool close_before_core(unsigned int fd, const struct files_struct *files)
+{
+	return test_bit(fd, files_fdtable(files)->close_before_core);
+}
+
 struct task_struct;
 
 void put_files_struct(struct files_struct *fs);
diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444..52d27328f 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -88,6 +88,8 @@ extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
 extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
 extern void set_close_on_exec(unsigned int fd, int flag);
 extern bool get_close_on_exec(unsigned int fd);
+extern void set_close_before_core(unsigned int fd, int flag);
+extern bool get_close_before_core(unsigned int fd);
 extern int __get_unused_fd_flags(unsigned flags, unsigned long nofile);
 extern int get_unused_fd_flags(unsigned flags);
 extern void put_unused_fd(unsigned int fd);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 41ed884cf..d162fb2d9 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -93,6 +93,7 @@ static inline void exit_thread(struct task_struct *tsk)
 extern __noreturn void do_group_exit(int);
 
 extern void exit_files(struct task_struct *);
+extern void exit_files_before_core(struct task_struct *);
 extern void exit_itimers(struct task_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285..f6cfe2fa5 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -131,6 +131,14 @@
 #define F_GETOWNER_UIDS	17
 #endif
 
+#ifndef F_GETFD_EX
+#define F_GETFD_EX	18
+#endif
+
+#ifndef F_SETFD_EX
+#define F_SETFD_EX	19
+#endif
+
 /*
  * Open File Description Locks
  *
@@ -159,6 +167,9 @@ struct f_owner_ex {
 /* for F_[GET|SET]FL */
 #define FD_CLOEXEC	1	/* actually anything with low bit set goes */
 
+/* for F_[GET|SET]FD_EX */
+#define FD_CLOBCOR	2	/* close the fd before dump core */
+
 /* for posix fcntl() and lockf() */
 #ifndef F_RDLCK
 #define F_RDLCK		0
-- 
2.34.1

