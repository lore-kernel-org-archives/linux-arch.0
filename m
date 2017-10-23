From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH 04/19] fs: dcache: Kill off ACCESS_ONCE()
Date: Mon, 23 Oct 2017 14:07:14 -0700
Message-ID: <1508792849-3115-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20171023210408.GA2930@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023210408.GA2930@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, snitzer@redhat.com, thor.thayer@linux.intel.com, viro@zeniv.linux.org.uk, davem@davemloft.net, shuah@kernel.org, mpe@ellerman.id.au, tj@kernel.org, torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

For several reasons, it is desirable to use {READ,WRITE}_ONCE() in
preference to ACCESS_ONCE(), and new code is expected to use one of the
former. So far, there's been no reason to change most existing uses of
ACCESS_ONCE(), as these aren't currently harmful.

However, for some features it is necessary to instrument reads and
writes separately, which is not possible with ACCESS_ONCE(). This
distinction is critical to correct operation.

It's possible to transform the bulk of kernel code using the Coccinelle
script below. However, this doesn't handle comments, leaving references
to ACCESS_ONCE() instances which have been removed. As a preparatory
step, this patch converts the dcache code and comments to use
{READ,WRITE}_ONCE() consistently.

----
virtual patch

@ depends on patch @
expression E1, E2;
@@

- ACCESS_ONCE(E1) = E2
+ WRITE_ONCE(E1, E2)

@ depends on patch @
expression E;
@@

- ACCESS_ONCE(E)
+ READ_ONCE(E)
----

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 fs/dcache.c            | 18 +++++++++---------
 include/linux/dcache.h |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index f90141387f01..f283cd31a491 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -630,7 +630,7 @@ static inline struct dentry *lock_parent(struct dentry *dentry)
 	rcu_read_lock();
 	spin_unlock(&dentry->d_lock);
 again:
-	parent = ACCESS_ONCE(dentry->d_parent);
+	parent = READ_ONCE(dentry->d_parent);
 	spin_lock(&parent->d_lock);
 	/*
 	 * We can't blindly lock dentry until we are sure
@@ -721,7 +721,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * around with a zero refcount.
 	 */
 	smp_rmb();
-	d_flags = ACCESS_ONCE(dentry->d_flags);
+	d_flags = READ_ONCE(dentry->d_flags);
 	d_flags &= DCACHE_REFERENCED | DCACHE_LRU_LIST | DCACHE_DISCONNECTED;
 
 	/* Nothing to do? Dropping the reference was all we needed? */
@@ -850,11 +850,11 @@ struct dentry *dget_parent(struct dentry *dentry)
 	 * locking.
 	 */
 	rcu_read_lock();
-	ret = ACCESS_ONCE(dentry->d_parent);
+	ret = READ_ONCE(dentry->d_parent);
 	gotref = lockref_get_not_zero(&ret->d_lockref);
 	rcu_read_unlock();
 	if (likely(gotref)) {
-		if (likely(ret == ACCESS_ONCE(dentry->d_parent)))
+		if (likely(ret == READ_ONCE(dentry->d_parent)))
 			return ret;
 		dput(ret);
 	}
@@ -3040,7 +3040,7 @@ static int prepend(char **buffer, int *buflen, const char *str, int namelen)
  * @buflen: allocated length of the buffer
  * @name:   name string and length qstr structure
  *
- * With RCU path tracing, it may race with d_move(). Use ACCESS_ONCE() to
+ * With RCU path tracing, it may race with d_move(). Use READ_ONCE() to
  * make sure that either the old or the new name pointer and length are
  * fetched. However, there may be mismatch between length and pointer.
  * The length cannot be trusted, we need to copy it byte-by-byte until
@@ -3054,8 +3054,8 @@ static int prepend(char **buffer, int *buflen, const char *str, int namelen)
  */
 static int prepend_name(char **buffer, int *buflen, const struct qstr *name)
 {
-	const char *dname = ACCESS_ONCE(name->name);
-	u32 dlen = ACCESS_ONCE(name->len);
+	const char *dname = READ_ONCE(name->name);
+	u32 dlen = READ_ONCE(name->len);
 	char *p;
 
 	smp_read_barrier_depends();
@@ -3120,7 +3120,7 @@ static int prepend_path(const struct path *path,
 		struct dentry * parent;
 
 		if (dentry == vfsmnt->mnt_root || IS_ROOT(dentry)) {
-			struct mount *parent = ACCESS_ONCE(mnt->mnt_parent);
+			struct mount *parent = READ_ONCE(mnt->mnt_parent);
 			/* Escaped? */
 			if (dentry != vfsmnt->mnt_root) {
 				bptr = *buffer;
@@ -3130,7 +3130,7 @@ static int prepend_path(const struct path *path,
 			}
 			/* Global root? */
 			if (mnt != parent) {
-				dentry = ACCESS_ONCE(mnt->mnt_mountpoint);
+				dentry = READ_ONCE(mnt->mnt_mountpoint);
 				mnt = parent;
 				vfsmnt = &mnt->mnt;
 				continue;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index ed1a7cf6923a..1d8f5818f647 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -519,7 +519,7 @@ static inline struct inode *d_inode(const struct dentry *dentry)
 }
 
 /**
- * d_inode_rcu - Get the actual inode of this dentry with ACCESS_ONCE()
+ * d_inode_rcu - Get the actual inode of this dentry with READ_ONCE()
  * @dentry: The dentry to query
  *
  * This is the helper normal filesystems should use to get at their own inodes
@@ -527,7 +527,7 @@ static inline struct inode *d_inode(const struct dentry *dentry)
  */
 static inline struct inode *d_inode_rcu(const struct dentry *dentry)
 {
-	return ACCESS_ONCE(dentry->d_inode);
+	return READ_ONCE(dentry->d_inode);
 }
 
 /**
-- 
2.5.2
