From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
Date: Sat, 29 Sep 2018 23:15:33 +1000
Message-ID: <20180929131534.24472-1-cyphar@cyphar.com>
References: <20180929103453.12025-1-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org, Aleksa Sarai <cyphar@cyphar.com>
List-Id: linux-arch.vger.kernel.org

The primary motivation for the need for this flag is container runtimes
which have to interact with malicious root filesystems in the host
namespaces. One of the first requirements for a container runtime to be
secure against a malicious rootfs is that they correctly scope symlinks
(that is, they should be scoped as though they are chroot(2)ed into the
container's rootfs) and ".."-style paths. The already-existing AT_XDEV
and AT_NO_PROCLINKS help defend against other potential attacks in a
malicious rootfs scenario.

Currently most container runtimes try to do this resolution in
userspace[1], causing many potential race conditions. In addition, the
"obvious" alternative (actually performing a {ch,pivot_}root(2))
requires a fork+exec which is *very* costly if necessary for every
filesystem operation involving a container.

The most significant change in semantics with AT_THIS_ROOT is that
*at(2) syscalls now no longer have the property that an absolute
pathname causes the dirfd to be ignored completely (if LOOKUP_CHROOT is
specified). The reasoning behind this is that AT_THIS_ROOT necessarily
has to chroot-scope symlinks with absolute paths to dirfd, and so doing
it for the base path seems to be the most consistent behaviour (and also
avoids foot-gunning users who want to chroot-scope paths that might be
absolute).

Currently this is only enabled for the stat(2) and openat(2) family (the
latter has its own flag O_THISROOT with the same semantics). Ideally
this flag would be supported by all *at(2) syscalls, but this will
require adding flags arguments to many of them (and will be done in a
separate patchset).

[1]: https://github.com/cyphar/filepath-securejoin

Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <christian@brauner.io>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/fcntl.c                       |   2 +-
 fs/namei.c                       | 121 +++++++++++++++++--------------
 fs/open.c                        |   2 +
 fs/stat.c                        |   4 +-
 include/linux/fcntl.h            |   2 +-
 include/linux/namei.h            |   1 +
 include/uapi/asm-generic/fcntl.h |   3 +
 include/uapi/linux/fcntl.h       |   2 +
 8 files changed, 81 insertions(+), 56 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index e343618736f7..4c36c5b9fdb9 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(25 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(26 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 757dd783771c..1b984f0dbbb4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2193,9 +2193,64 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	}
 }
 
+/*
+ * Configure nd->path based on the nd->dfd. This is only used as part of
+ * path_init().
+ */
+static inline int dirfd_path_init(struct nameidata *nd)
+{
+	if (nd->dfd == AT_FDCWD) {
+		if (nd->flags & LOOKUP_RCU) {
+			struct fs_struct *fs = current->fs;
+			unsigned seq;
+
+			do {
+				seq = read_seqcount_begin(&fs->seq);
+				nd->path = fs->pwd;
+				nd->inode = nd->path.dentry->d_inode;
+				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
+			} while (read_seqcount_retry(&fs->seq, seq));
+		} else {
+			get_fs_pwd(current->fs, &nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+	} else {
+		/* Caller must check execute permissions on the starting path component */
+		struct fd f = fdget_raw(nd->dfd);
+		struct dentry *dentry;
+
+		if (!f.file)
+			return -EBADF;
+
+		dentry = f.file->f_path.dentry;
+
+		if (*nd->name->name && unlikely(!d_can_lookup(dentry))) {
+			fdput(f);
+			return -ENOTDIR;
+		}
+
+		nd->path = f.file->f_path;
+		if (nd->flags & LOOKUP_RCU) {
+			nd->inode = nd->path.dentry->d_inode;
+			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+		} else {
+			path_get(&nd->path);
+			nd->inode = nd->path.dentry->d_inode;
+		}
+		fdput(f);
+	}
+	if (unlikely(nd->flags & (LOOKUP_CHROOT | LOOKUP_BENEATH))) {
+		nd->root = nd->path;
+		if (!(nd->flags & LOOKUP_RCU))
+			path_get(&nd->root);
+	}
+	return 0;
+}
+
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
+	int error;
 	const char *s = nd->name->name;
 
 	if (!*s)
@@ -2230,65 +2285,25 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->path.dentry = NULL;
 
 	nd->m_seq = read_seqbegin(&mount_lock);
+	if (unlikely(flags & LOOKUP_CHROOT)) {
+		error = dirfd_path_init(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+	}
 	if (*s == '/') {
-		int error;
-		set_root(nd);
+		if (likely(!nd->root.mnt))
+			set_root(nd);
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			s = ERR_PTR(error);
 		return s;
-	} else if (nd->dfd == AT_FDCWD) {
-		if (flags & LOOKUP_RCU) {
-			struct fs_struct *fs = current->fs;
-			unsigned seq;
-
-			do {
-				seq = read_seqcount_begin(&fs->seq);
-				nd->path = fs->pwd;
-				nd->inode = nd->path.dentry->d_inode;
-				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
-			} while (read_seqcount_retry(&fs->seq, seq));
-		} else {
-			get_fs_pwd(current->fs, &nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		if (unlikely(flags & LOOKUP_BENEATH)) {
-			nd->root = nd->path;
-			if (!(flags & LOOKUP_RCU))
-				path_get(&nd->root);
-		}
-		return s;
-	} else {
-		/* Caller must check execute permissions on the starting path component */
-		struct fd f = fdget_raw(nd->dfd);
-		struct dentry *dentry;
-
-		if (!f.file)
-			return ERR_PTR(-EBADF);
-
-		dentry = f.file->f_path.dentry;
-
-		if (*s && unlikely(!d_can_lookup(dentry))) {
-			fdput(f);
-			return ERR_PTR(-ENOTDIR);
-		}
-
-		nd->path = f.file->f_path;
-		if (flags & LOOKUP_RCU) {
-			nd->inode = nd->path.dentry->d_inode;
-			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
-		} else {
-			path_get(&nd->path);
-			nd->inode = nd->path.dentry->d_inode;
-		}
-		if (unlikely(flags & LOOKUP_BENEATH)) {
-			nd->root = nd->path;
-			if (!(flags & LOOKUP_RCU))
-				path_get(&nd->root);
-		}
-		fdput(f);
-		return s;
 	}
+	if (likely(!nd->path.mnt)) {
+		error = dirfd_path_init(nd);
+		if (unlikely(error))
+			return ERR_PTR(error);
+	}
+	return s;
 }
 
 static const char *trailing_symlink(struct nameidata *nd)
diff --git a/fs/open.c b/fs/open.c
index 80f5f566a5ff..81d148f626cd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -996,6 +996,8 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_NO_PROCLINKS;
 	if (flags & O_NOSYMLINKS)
 		lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (flags & O_THISROOT)
+		lookup_flags |= LOOKUP_CHROOT;
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
diff --git a/fs/stat.c b/fs/stat.c
index 791e61b916ae..e8366e4812c3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -172,7 +172,7 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 
 	if (flags & ~(AT_SYMLINK_NOFOLLOW | AT_NO_AUTOMOUNT | AT_EMPTY_PATH |
 		      KSTAT_QUERY_FLAGS | AT_BENEATH | AT_XDEV |
-		      AT_NO_PROCLINKS | AT_NO_SYMLINKS))
+		      AT_NO_PROCLINKS | AT_NO_SYMLINKS | AT_THIS_ROOT))
 		return -EINVAL;
 
 	if (flags & AT_SYMLINK_NOFOLLOW)
@@ -189,6 +189,8 @@ int vfs_statx(int dfd, const char __user *filename, int flags,
 		lookup_flags |= LOOKUP_NO_PROCLINKS;
 	if (flags & AT_NO_SYMLINKS)
 		lookup_flags |= LOOKUP_NO_SYMLINKS;
+	if (flags & AT_THIS_ROOT)
+		lookup_flags |= LOOKUP_CHROOT;
 
 retry:
 	error = user_path_at(dfd, filename, lookup_flags, &path);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index ad5bba4b5b12..95480cd4c09d 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_BENEATH | O_XDEV | \
-	 O_NOPROCLINKS | O_NOSYMLINKS)
+	 O_NOPROCLINKS | O_NOSYMLINKS | O_THISROOT)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (BITS_PER_LONG != 32)
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 5ff7f3362d1b..7ec9e2d84649 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -53,6 +53,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_NO_PROCLINKS	0x040000 /* No /proc/$pid/fd/ "symlink" crossing. */
 #define LOOKUP_NO_SYMLINKS	0x080000 /* No symlink crossing *at all*.
 					    Implies LOOKUP_NO_PROCLINKS. */
+#define LOOKUP_CHROOT		0x100000 /* Treat dirfd as %current->fs->root. */
 
 extern int path_pts(struct path *path);
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index c2bf5983e46a..11206b0e927c 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -113,6 +113,9 @@
 #ifndef O_NOSYMLINKS
 #define O_NOSYMLINKS	01000000000
 #endif
+#ifndef O_THISROOT
+#define O_THISROOT	02000000000
+#endif
 
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 551a9e2166a8..ea978457b68f 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -99,6 +99,8 @@
 #define AT_NO_PROCLINKS		0x40000 /* No /proc/$pid/fd/... "symlinks". */
 #define AT_NO_SYMLINKS		0x80000 /* No symlinks *at all*.
 					   Implies AT_NO_PROCLINKS. */
+#define AT_THIS_ROOT		0x100000 /* Path resolution acts as though
+					   it is chroot-ed into dirfd. */
 
 
 #endif /* _UAPI_LINUX_FCNTL_H */
-- 
2.19.0
