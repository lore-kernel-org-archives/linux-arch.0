Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58863815F5
	for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303260; cv=none; b=UC0qkJZYQqDoF2Ylla3/rhxKA+/M4oN7FLeScfWw0nk/V9xEeBuwQv1YhFmgVssbbhm89H5YGfo+cfx56meDCppi5cEJXQZ6JixanpsJRDqgkpPxHXGagjmDKtlWic8pC0YGrDWscSs6XWK51HIKcnZysWk/TEu0it433b/2VgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303260; c=relaxed/simple;
	bh=R96M2HsK51b1mMs57zJIU/U0xnQMx6/SFAKXnmlYwAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3597rlvh8GxU8VnSJPYpX86BtJCSPwwniZGzVrRez801DZ80NlVT/luAWSn6E6EK/hTAwcrWy5rollFDz+NVU+f+3xkCWAQjq58gnyrkzTrD9tr0aSmUp7P0qsfqK+Ai6CmJ8nffoQQAjQiLeflYNxN9+MuMqb5juSmaCP8O8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NZnqGjny; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NZnqGjny"
X-KPN-MessageId: c4a6903e-2703-11f1-89dd-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c4a6903e-2703-11f1-89dd-00505699b430;
	Mon, 23 Mar 2026 23:00:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=tvshHGEr9YHHg3sqjWTB5bPygbqIz0+YqTJKx2d+dlM=;
	b=NZnqGjnysx+FchhTgiicqUDlHva6kM7pn78q1p9qe550pUV8BNqf+b/0gD5CwJFGeYo6mb9iCUMZp
	 ggyDX3PInFPI+Em3xmrrUMiZ48Q/sBhlLxAy57olrIFwRGZzm9GNkwYfOrVZ9IurDDLU4zmy83rjV5
	 FZN06S8RXQ2jveQcYsjhNMb4F9XNRoPWrQqClkCv+MA6i/E9oL71ON11dj/XZ2kHx7bdXDBu7KXMwr
	 EBkpq2vOBt87z1a3o6ZSg5YOQfq5RW4HFDdH5Y0WtOORo1/K6uWy0useUKRGoXX6aIPUu3gi7rjXWz
	 Q6VP+i3iMa7UOhjqfxE+OS/bnWMkPlg==
X-KPN-MID: 33|Ht4vvNqQXryrIM92aUJqfw7eho2Yif+yOwqnj2q2UZFt56luZkvDi95Ju5u0wxk
 18TrR5vU5BRXK/AEz9hF0/g==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PWWJOykzATbDQYlFM9E6fUs5nVA+UZQ5dr7/DPZSG/RahrKPBjf7ETJiBZdEa5I
 X4hyvyG1ZSBJLmezDPK+Qng==
Received: from daedalus.home (unknown [178.229.142.171])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c43b5d0f-2703-11f1-8d40-00505699b758;
	Mon, 23 Mar 2026 23:00:56 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Kees Cook <kees@kernel.org>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	wangzijie <wangzijie1@honor.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] vfs: transitive upgrade restrictions for fds
Date: Mon, 23 Mar 2026 23:00:22 +0100
Message-ID: <20260323220029.765874-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323220029.765874-1-jkoolstra@xs4all.nl>
References: <20260323220029.765874-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add upgrade restrictions to openat2(). Extend struct open_how to allow
setting transitive restrictions on using file descriptors to open other
files. A use case for this feature is to block services or containers
from re-opening/upgrading an O_PATH file descriptor through e.g.
/proc/<pid>/fd/<nr as O_WRONLY.

The idea for this features comes form the UAPI group kernel feature idea
list [1].

[1] https://github.com/uapi-group/kernel-features?tab=readme-ov-file#upgrade-masks-in-openat2

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/file_table.c                  |  2 ++
 fs/internal.h                    |  1 +
 fs/namei.c                       | 38 ++++++++++++++++++++++++++++----
 fs/open.c                        |  9 ++++++++
 fs/proc/base.c                   | 24 ++++++++++++++------
 fs/proc/fd.c                     |  6 ++++-
 fs/proc/internal.h               |  4 +++-
 include/linux/fcntl.h            |  6 ++++-
 include/linux/fs.h               |  1 +
 include/linux/namei.h            | 15 ++++++++++++-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 include/uapi/linux/openat2.h     |  1 +
 12 files changed, 96 insertions(+), 15 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e..b98038009fd2 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -196,6 +196,8 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
 	f->f_wb_err	= 0;
 	f->f_sb_err	= 0;
 
+	f->f_allowed_upgrades = VALID_UPGRADE_FLAGS;
+
 	/*
 	 * We're SLAB_TYPESAFE_BY_RCU so initialize f_ref last. While
 	 * fget-rcu pattern users need to be able to handle spurious
diff --git a/fs/internal.h b/fs/internal.h
index cbc384a1aa09..0a37bb208184 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -189,6 +189,7 @@ struct open_flags {
 	int acc_mode;
 	int intent;
 	int lookup_flags;
+	unsigned int allowed_upgrades;
 };
 extern struct file *do_file_open(int dfd, struct filename *pathname,
 		const struct open_flags *op);
diff --git a/fs/namei.c b/fs/namei.c
index 58f715f7657e..3982908ff995 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -743,6 +743,7 @@ struct nameidata {
 	int		dfd;
 	vfsuid_t	dir_vfsuid;
 	umode_t		dir_mode;
+	unsigned int	allowed_upgrades;
 } __randomize_layout;
 
 #define ND_ROOT_PRESET 1
@@ -760,6 +761,7 @@ static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 	p->path.mnt = NULL;
 	p->path.dentry = NULL;
 	p->total_link_count = old ? old->total_link_count : 0;
+	p->allowed_upgrades = VALID_UPGRADE_FLAGS;
 	p->saved = old;
 	current->nameidata = p;
 }
@@ -1155,12 +1157,11 @@ static int nd_jump_root(struct nameidata *nd)
 	nd->state |= ND_JUMPED;
 	return 0;
 }
-
 /*
  * Helper to directly jump to a known parsed path from ->get_link,
  * caller must have taken a reference to path beforehand.
  */
-int nd_jump_link(const struct path *path)
+int nd_jump_link_how(const struct path *path, const struct jump_how how)
 {
 	int error = -ELOOP;
 	struct nameidata *nd = current->nameidata;
@@ -1181,6 +1182,7 @@ int nd_jump_link(const struct path *path)
 	nd->path = *path;
 	nd->inode = nd->path.dentry->d_inode;
 	nd->state |= ND_JUMPED;
+	nd->allowed_upgrades &= how.allowed_upgrades;
 	return 0;
 
 err:
@@ -2738,6 +2740,8 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		if (fd_empty(f))
 			return ERR_PTR(-EBADF);
 
+		nd->allowed_upgrades = fd_file(f)->f_allowed_upgrades;
+
 		if (flags & LOOKUP_LINKAT_EMPTY) {
 			if (fd_file(f)->f_cred != current_cred() &&
 			    !ns_capable(fd_file(f)->f_cred->user_ns, CAP_DAC_READ_SEARCH))
@@ -4266,6 +4270,28 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 	return 0;
 }
 
+static bool may_upgrade(const int flag, const unsigned int allowed_upgrades)
+{
+	int mode = flag & O_ACCMODE;
+	unsigned int allowed = allowed_upgrades & ~DENY_UPGRADES;
+
+	if (mode != O_WRONLY && !(allowed & READ_UPGRADABLE))
+		return false;
+	if (mode != O_RDONLY && !(allowed & WRITE_UPGRADABLE))
+		return false;
+	return true;
+}
+
+static int may_open_upgrade(struct mnt_idmap *idmap, const struct path *path,
+			    int acc_mode, int flag,
+			    const unsigned int allowed_upgrades)
+{
+	if (!may_upgrade(flag, allowed_upgrades))
+		return -EACCES;
+
+	return may_open(idmap, path, acc_mode, flag);
+}
+
 static int handle_truncate(struct mnt_idmap *idmap, struct file *filp)
 {
 	const struct path *path = &filp->f_path;
@@ -4666,7 +4692,8 @@ static int do_open(struct nameidata *nd,
 			return error;
 		do_truncate = true;
 	}
-	error = may_open(idmap, &nd->path, acc_mode, open_flag);
+	error = may_open_upgrade(idmap, &nd->path, acc_mode, open_flag,
+				 nd->allowed_upgrades);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
 	if (!error)
@@ -4831,8 +4858,11 @@ static struct file *path_openat(struct nameidata *nd,
 		terminate_walk(nd);
 	}
 	if (likely(!error)) {
-		if (likely(file->f_mode & FMODE_OPENED))
+		if (likely(file->f_mode & FMODE_OPENED)) {
+			file->f_allowed_upgrades =
+				op->allowed_upgrades & nd->allowed_upgrades;
 			return file;
+		}
 		WARN_ON(1);
 		error = -EINVAL;
 	}
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..212a1d260947 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1167,6 +1167,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 	struct open_how how = {
 		.flags = flags & VALID_OPEN_FLAGS,
 		.mode = mode & S_IALLUGO,
+		.allowed_upgrades = VALID_UPGRADE_FLAGS
 	};
 
 	/* O_PATH beats everything else. */
@@ -1300,6 +1301,14 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	}
 
 	op->lookup_flags = lookup_flags;
+
+	if (how->allowed_upgrades == 0)
+		op->allowed_upgrades = VALID_UPGRADE_FLAGS;
+	else if (how->allowed_upgrades & ~VALID_UPGRADE_FLAGS)
+		return -EINVAL;
+	else
+		op->allowed_upgrades = how->allowed_upgrades;
+
 	return 0;
 }
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4c863d17dfb4..84c54f9dffd9 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -218,7 +218,8 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	return result;
 }
 
-static int proc_cwd_link(struct dentry *dentry, struct path *path)
+static int proc_cwd_link(struct dentry *dentry, struct path *path,
+			 struct jump_how *jump_how)
 {
 	struct task_struct *task = get_proc_task(d_inode(dentry));
 	int result = -ENOENT;
@@ -227,6 +228,7 @@ static int proc_cwd_link(struct dentry *dentry, struct path *path)
 		task_lock(task);
 		if (task->fs) {
 			get_fs_pwd(task->fs, path);
+			*jump_how = JUMP_HOW_UNRESTRICTED;
 			result = 0;
 		}
 		task_unlock(task);
@@ -235,7 +237,8 @@ static int proc_cwd_link(struct dentry *dentry, struct path *path)
 	return result;
 }
 
-static int proc_root_link(struct dentry *dentry, struct path *path)
+static int proc_root_link(struct dentry *dentry, struct path *path,
+			  struct jump_how *jump_how)
 {
 	struct task_struct *task = get_proc_task(d_inode(dentry));
 	int result = -ENOENT;
@@ -243,6 +246,7 @@ static int proc_root_link(struct dentry *dentry, struct path *path)
 	if (task) {
 		result = get_task_root(task, path);
 		put_task_struct(task);
+		*jump_how = JUMP_HOW_UNRESTRICTED;
 	}
 	return result;
 }
@@ -1777,7 +1781,8 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
-static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
+static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
+			 struct jump_how *jump_how)
 {
 	struct task_struct *task;
 	struct file *exe_file;
@@ -1789,6 +1794,7 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 	put_task_struct(task);
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
+		*jump_how = JUMP_HOW_UNRESTRICTED;
 		path_get(&exe_file->f_path);
 		fput(exe_file);
 		return 0;
@@ -1801,6 +1807,7 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct delayed_call *done)
 {
 	struct path path;
+	struct jump_how jump_how;
 	int error = -EACCES;
 
 	if (!dentry)
@@ -1810,11 +1817,11 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 	if (!proc_fd_access_allowed(inode))
 		goto out;
 
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
+	error = PROC_I(inode)->op.proc_get_link(dentry, &path, &jump_how);
 	if (error)
 		goto out;
 
-	error = nd_jump_link(&path);
+	error = nd_jump_link_how(&path, jump_how);
 out:
 	return ERR_PTR(error);
 }
@@ -1848,12 +1855,13 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 	int error = -EACCES;
 	struct inode *inode = d_inode(dentry);
 	struct path path;
+	struct jump_how jump_how;
 
 	/* Are we allowed to snoop on the tasks file descriptors? */
 	if (!proc_fd_access_allowed(inode))
 		goto out;
 
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
+	error = PROC_I(inode)->op.proc_get_link(dentry, &path, &jump_how);
 	if (error)
 		goto out;
 
@@ -2250,7 +2258,8 @@ static const struct dentry_operations tid_map_files_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int map_files_get_link(struct dentry *dentry, struct path *path)
+static int map_files_get_link(struct dentry *dentry, struct path *path,
+			      struct jump_how *jump_how)
 {
 	unsigned long vm_start, vm_end;
 	struct vm_area_struct *vma;
@@ -2279,6 +2288,7 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	rc = -ENOENT;
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
+		*jump_how = JUMP_HOW_UNRESTRICTED;
 		*path = *file_user_path(vma->vm_file);
 		path_get(path);
 		rc = 0;
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 9eeccff49b2a..344485e8cb6f 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -171,7 +171,8 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int proc_fd_link(struct dentry *dentry, struct path *path)
+static int proc_fd_link(struct dentry *dentry, struct path *path,
+			struct jump_how *jump_how)
 {
 	struct task_struct *task;
 	int ret = -ENOENT;
@@ -183,6 +184,9 @@ static int proc_fd_link(struct dentry *dentry, struct path *path)
 
 		fd_file = fget_task(task, fd);
 		if (fd_file) {
+			*jump_how = (struct jump_how) {
+				.allowed_upgrades = fd_file->f_allowed_upgrades
+			};
 			*path = fd_file->f_path;
 			path_get(&fd_file->f_path);
 			ret = 0;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index c1e8eb984da8..42f668059a30 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -14,6 +14,7 @@
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
 #include <linux/mm.h>
+#include <linux/namei.h>
 
 struct ctl_table_header;
 struct mempolicy;
@@ -107,7 +108,8 @@ extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
 union proc_op {
-	int (*proc_get_link)(struct dentry *, struct path *);
+	int (*proc_get_link)(struct dentry *, struct path *,
+		struct jump_how *);
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..6b15b488d542 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,9 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define VALID_UPGRADE_FLAGS \
+	(DENY_UPGRADES | READ_UPGRADABLE | WRITE_UPGRADABLE)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
@@ -19,7 +22,8 @@
 
 /* List of all open_how "versions". */
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
-#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
+#define OPEN_HOW_SIZE_VER1	32 /* added allowed_upgrades */
+#define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER1
 
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b3dd145b25e..697d2fc6322b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1296,6 +1296,7 @@ struct file {
 	};
 	file_ref_t			f_ref;
 	/* --- cacheline 3 boundary (192 bytes) --- */
+	unsigned int			f_allowed_upgrades;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 58600cf234bc..b827df5b59d9 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -203,7 +203,20 @@ static inline umode_t __must_check mode_strip_umask(const struct inode *dir, umo
 	return mode;
 }
 
-extern int __must_check nd_jump_link(const struct path *path);
+struct jump_how {
+	unsigned int allowed_upgrades;
+};
+
+#define JUMP_HOW_UNRESTRICTED \
+	((const struct jump_how){ .allowed_upgrades = VALID_UPGRADE_FLAGS })
+
+extern int __must_check nd_jump_link_how(const struct path *path,
+					 const struct jump_how how);
+
+static inline int nd_jump_link(const struct path *path)
+{
+	return nd_jump_link_how(path, JUMP_HOW_UNRESTRICTED);
+}
 
 static inline void nd_terminate_link(void *name, size_t len, size_t maxlen)
 {
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..a3e36d86af1d 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -95,6 +95,10 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+#define DENY_UPGRADES		0x01
+#define READ_UPGRADABLE		(0x02 | DENY_UPGRADES)
+#define WRITE_UPGRADABLE	(0x04 | DENY_UPGRADES)
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..32c302758e72 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -20,6 +20,7 @@ struct open_how {
 	__u64 flags;
 	__u64 mode;
 	__u64 resolve;
+	__u64 allowed_upgrades;
 };
 
 /* how->resolve flags for openat2(2). */
-- 
2.53.0

