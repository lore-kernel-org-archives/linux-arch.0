From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Date: Sat, 29 Sep 2018 20:34:51 +1000
Message-ID: <20180929103453.12025-2-cyphar@cyphar.com>
References: <20180929103453.12025-1-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org, Aleksa Sarai <cyphar@cyphar.com>
List-Id: linux-arch.vger.kernel.org

Add the following flags for path resolution. The primary justification
for these flags is to allow for programs to be far more strict about how
they want path resolution to handle symlinks, mountpoint crossings, and
paths that escape the dirfd (through an absolute path or ".."
shenanigans).

This is of particular concern to container runtimes that want to be very
careful about malicious root filesystems that a container's init might
have screwed around with (and there is no real way to protect against
this in userspace if you consider potential races against a malicious
container's init).

* AT_BENEATH: Disallow ".." or absolute paths (either in the path or
  found during symlink resolution) to escape the starting point of name
  resolution, though ".." is permitted in cases like "foo/../bar".
  Relative symlinks are still allowed (as long as they don't escape the
  starting point).

* AT_XDEV: Disallow mount-point crossing (both *down* into one, or *up*
  from one). The primary "scoping" use is to blocking resolution that
  crosses a bind-mount, which has a similar property to a symlink (in
  the way that it allows for escape from the starting-point). Since it
  is not possible to differentiate bind-mounts However since
  bind-mounting requires privileges (in ways symlinks don't) this has
  been split from LOOKUP_BENEATH. The naming is based on "find -xdev"
  (though find(1) doesn't walk upwards, the semantics seem obvious).

* AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a very
  specific restriction, and it exists because /proc/$pid/fd/...
  "symlinks" allow for access outside nd->root and pose risk to
  container runtimes that don't want to be tricked into accessing a host
  path (but do want to allow no-funny-business symlink resolution).

* AT_NO_SYMLINK: Disallows symlink jumping *of any kind*. Implies
  AT_NO_PROCLINK (obviously).

The AT_NO_*LINK flags return -ELOOP if path resolution would violates
their requirement, while the others all return -EXDEV. Currently these
are only enabled for the stat(2) family and the openat(2) family (the
latter has its own brand of O_* flags with the same semantics). Ideally
these flags would be supported by all *at(2) syscalls, but this will
require adding flags arguments to many of them (and will be done in a
separate patchset).

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fcntl.c                       |  2 +-
 fs/namei.c                       | 61 ++++++++++++++++++++++++++------
 fs/open.c                        |  8 +++++
 fs/stat.c                        | 13 +++++--
 include/linux/fcntl.h            |  3 +-
 include/linux/namei.h            |  7 ++++
 include/uapi/asm-generic/fcntl.h | 17 +++++++++
 include/uapi/linux/fcntl.h       |  8 +++++
 8 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 4137d96534a6..e343618736f7 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(25 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index fb913148d4d1..757dd783771c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -859,6 +859,8 @@ static int nd_jump_root(struct nameidata *nd)
 		path_get(&nd->path);
 		nd->inode = nd->path.dentry->d_inode;
 	}
+	if (unlikely(nd->flags & LOOKUP_BENEATH))
+		return -EXDEV;
 	nd->flags |= LOOKUP_JUMPED;
 	return 0;
 }
@@ -1083,14 +1085,19 @@ const char *get_link(struct nameidata *nd)
 		} else {
 			res = get(dentry, inode, &last->done);
 		}
+		/* If we just jumped it was because of a procfs-style link. */
+		if (unlikely(nd->flags & LOOKUP_JUMPED) &&
+		    unlikely(nd->flags & LOOKUP_NO_PROCLINKS))
+			return ERR_PTR(-ELOOP);
 		if (IS_ERR_OR_NULL(res))
 			return res;
 	}
 	if (*res == '/') {
 		if (!nd->root.mnt)
 			set_root(nd);
-		if (unlikely(nd_jump_root(nd)))
-			return ERR_PTR(-ECHILD);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
 		while (unlikely(*++res == '/'))
 			;
 	}
@@ -1271,12 +1278,16 @@ static int follow_managed(struct path *path, struct nameidata *nd)
 		break;
 	}
 
-	if (need_mntput && path->mnt == mnt)
-		mntput(path->mnt);
+	if (need_mntput) {
+		if (path->mnt == mnt)
+			mntput(path->mnt);
+		if (unlikely(nd->flags & LOOKUP_XDEV))
+			ret = -EXDEV;
+		else
+			nd->flags |= LOOKUP_JUMPED;
+	}
 	if (ret == -EISDIR || !ret)
 		ret = 1;
-	if (need_mntput)
-		nd->flags |= LOOKUP_JUMPED;
 	if (unlikely(ret < 0))
 		path_put_conditional(path, nd);
 	return ret;
@@ -1333,6 +1344,8 @@ static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
 		mounted = __lookup_mnt(path->mnt, path->dentry);
 		if (!mounted)
 			break;
+		if (unlikely(nd->flags & LOOKUP_XDEV))
+			return false;
 		path->mnt = &mounted->mnt;
 		path->dentry = mounted->mnt.mnt_root;
 		nd->flags |= LOOKUP_JUMPED;
@@ -1353,8 +1366,11 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 	struct inode *inode = nd->inode;
 
 	while (1) {
-		if (path_equal(&nd->path, &nd->root))
+		if (path_equal(&nd->path, &nd->root)) {
+			if (unlikely(nd->flags & LOOKUP_BENEATH))
+				return -EXDEV;
 			break;
+		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			struct dentry *old = nd->path.dentry;
 			struct dentry *parent = old->d_parent;
@@ -1379,6 +1395,8 @@ static int follow_dotdot_rcu(struct nameidata *nd)
 				return -ECHILD;
 			if (&mparent->mnt == nd->path.mnt)
 				break;
+			if (unlikely(nd->flags & LOOKUP_XDEV))
+				return -EXDEV;
 			/* we know that mountpoint was pinned */
 			nd->path.dentry = mountpoint;
 			nd->path.mnt = &mparent->mnt;
@@ -1481,8 +1499,11 @@ static int path_parent_directory(struct path *path)
 static int follow_dotdot(struct nameidata *nd)
 {
 	while(1) {
-		if (path_equal(&nd->path, &nd->root))
+		if (path_equal(&nd->path, &nd->root)) {
+			if (unlikely(nd->flags & LOOKUP_BENEATH))
+				return -EXDEV;
 			break;
+		}
 		if (nd->path.dentry != nd->path.mnt->mnt_root) {
 			int ret = path_parent_directory(&nd->path);
 			if (ret)
@@ -1491,6 +1512,8 @@ static int follow_dotdot(struct nameidata *nd)
 		}
 		if (!follow_up(&nd->path))
 			break;
+		if (unlikely(nd->flags & LOOKUP_XDEV))
+			return -EXDEV;
 	}
 	follow_mount(&nd->path);
 	nd->inode = nd->path.dentry->d_inode;
@@ -1720,6 +1743,8 @@ static int pick_link(struct nameidata *nd, struct path *link,
 {
 	int error;
 	struct saved *last;
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+		return -ELOOP;
 	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
 		path_to_nameidata(link, nd);
 		return -ELOOP;
@@ -2175,6 +2200,8 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
+	if (flags & LOOKUP_NO_SYMLINKS)
+		flags |= LOOKUP_NO_PROCLINKS;
 	if (flags & LOOKUP_RCU)
 		rcu_read_lock();
 
@@ -2204,10 +2231,12 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->m_seq = read_seqbegin(&mount_lock);
 	if (*s == '/') {
+		int error;
 		set_root(nd);
-		if (likely(!nd_jump_root(nd)))
-			return s;
-		return ERR_PTR(-ECHILD);
+		error = nd_jump_root(nd);
+		if (unlikely(error))
+			s = ERR_PTR(error);
+		return s;
 	} else if (nd->dfd == AT_FDCWD) {
 		if (flags & LOOKUP_RCU) {
 			struct fs_struct *fs = current->fs;
@@ -2223,6 +2252,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		if (unlikely(flags & LOOKUP_BENEATH)) {
+			nd->root = nd->path;
+			if (!(flags & LOOKUP_RCU))
+				path_get(&nd->root);
+		}
 		return s;
 	} else {
 		/* Caller must check execute permissions on the starting path component */
@@ -2247,6 +2281,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		if (unlikely(flags & LOOKUP_BENEATH)) {
+			nd->root = nd->path;
+			if (!(flags & LOOKUP_RCU))
+				path_get(&nd->root);
+		}
 		fdput(f);
 		return s;
 	}
diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..80f5f566a5ff 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -988,6 +988,14 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & O_BENEATH)
+		lookup_flags |= LOOKUP_BENEATH;
+	if (flags & O_XDEV)
+		lookup_flags |= LOOKUP_XDEV;
+	if (flags & O_NOPROCLINKS)
+		lookup_flags |= LOOKUP_NO_PROCLINKS;
+	if (flags & O_NOSYMLINKS)
+		lookup_flags |= LOOKUP_NO_SYMLINKS;
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
diff --git a/fs/stat.c b/fs/stat.c
index f8e6fb2c3657..791e61b916ae 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -170,8 +170,9 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 	int error = -EINVAL;
 	unsigned int lookup_flags = LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
 
-	if ((flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT |
-		       AT_EMPTY_PATH | KSTAT_QUERY_FLAGS)) != 0)
+	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
+		      KSTAT_QUERY_FLAGS | AT_BENEATH | AT_XDEV |
+		      AT_NO_PROCLINKS | AT_NO_SYMLINKS))
 		return -EINVAL;
 
 	if (flags & AT_SYMLINK_NOFOLLOW)
@@ -180,6 +181,14 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 		lookup_flags &= ~LOOKUP_AUTOMOUNT;
 	if (flags & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
+	if (flags & AT_BENEATH)
+		lookup_flags |= LOOKUP_BENEATH;
+	if (flags & AT_XDEV)
+		lookup_flags |= LOOKUP_XDEV;
+	if (flags & AT_NO_PROCLINKS)
+		lookup_flags |= LOOKUP_NO_PROCLINKS;
+	if (flags & AT_NO_SYMLINKS)
+		lookup_flags |= LOOKUP_NO_SYMLINKS;
 
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 27dc7a60693e..ad5bba4b5b12 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,8 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_BENEATH | O_XDEV | \
+	 O_NOPROCLINKS | O_NOSYMLINKS)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (BITS_PER_LONG != 32)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index a78606e8e3df..5ff7f3362d1b 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -47,6 +47,13 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_EMPTY		0x4000
 #define LOOKUP_DOWN		0x8000
 
+/* Scoping flags for lookup. */
+#define LOOKUP_BENEATH		0x010000 /* No escaping from starting point. */
+#define LOOKUP_XDEV		0x020000 /* No mountpoint crossing. */
+#define LOOKUP_NO_PROCLINKS	0x040000 /* No /proc/$pid/fd/ "symlink" crossing. */
+#define LOOKUP_NO_SYMLINKS	0x080000 /* No symlink crossing *at all*.
+					    Implies LOOKUP_NO_PROCLINKS. */
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..c2bf5983e46a 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -97,6 +97,23 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+/*
+ * These are identical to their AT_* counterparts (which affect the entireity
+ * of path resolution).
+ */
+#ifndef O_BENEATH
+#define O_BENEATH	00040000000 /* *Not* the same as capsicum's O_BENEATH! */
+#endif
+#ifndef O_XDEV
+#define O_XDEV		00100000000
+#endif
+#ifndef O_NOPROCLINKS
+#define O_NOPROCLINKS	00200000000
+#endif
+#ifndef O_NOSYMLINKS
+#define O_NOSYMLINKS	01000000000
+#endif
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 594b85f7cb86..551a9e2166a8 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -92,5 +92,13 @@
 
 #define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
 
+/* Flags which affect path *resolution*, not just last-component handling. */
+#define AT_BENEATH		0x10000	/* No absolute paths or ".." escaping
+					   (in-path or through symlinks) */
+#define AT_XDEV			0x20000 /* No mountpoint crossing. */
+#define AT_NO_PROCLINKS		0x40000 /* No /proc/$pid/fd/... "symlinks". */
+#define AT_NO_SYMLINKS		0x80000 /* No symlinks *at all*.
+					   Implies AT_NO_PROCLINKS. */
+
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.19.0
