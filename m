From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 073/109] hostfs: rename do_rmdir() to hostfs_do_rmdir()
Date: Thu, 29 Mar 2018 13:23:50 +0200
Message-ID: <20180329112426.23043-74-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

do_rmdir() is used in the VFS layer at fs/namei.c, so use a different
name in hostfs.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net
Acked-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/hostfs/hostfs.h      | 2 +-
 fs/hostfs/hostfs_kern.c | 2 +-
 fs/hostfs/hostfs_user.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hostfs/hostfs.h b/fs/hostfs/hostfs.h
index ffaec2e7526c..cb8374af08a6 100644
--- a/fs/hostfs/hostfs.h
+++ b/fs/hostfs/hostfs.h
@@ -84,7 +84,7 @@ extern int set_attr(const char *file, struct hostfs_iattr *attrs, int fd);
 extern int make_symlink(const char *from, const char *to);
 extern int unlink_file(const char *file);
 extern int do_mkdir(const char *file, int mode);
-extern int do_rmdir(const char *file);
+extern int hostfs_do_rmdir(const char *file);
 extern int do_mknod(const char *file, int mode, unsigned int major,
 		    unsigned int minor);
 extern int link_file(const char *from, const char *to);
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c148e7f4f451..3cd85eb5bbb1 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -706,7 +706,7 @@ static int hostfs_rmdir(struct inode *ino, struct dentry *dentry)
 
 	if ((file = dentry_name(dentry)) == NULL)
 		return -ENOMEM;
-	err = do_rmdir(file);
+	err = hostfs_do_rmdir(file);
 	__putname(file);
 	return err;
 }
diff --git a/fs/hostfs/hostfs_user.c b/fs/hostfs/hostfs_user.c
index 9c1e0f019880..5ecc4706172b 100644
--- a/fs/hostfs/hostfs_user.c
+++ b/fs/hostfs/hostfs_user.c
@@ -304,7 +304,7 @@ int do_mkdir(const char *file, int mode)
 	return 0;
 }
 
-int do_rmdir(const char *file)
+int hostfs_do_rmdir(const char *file)
 {
 	int err;
 
-- 
2.16.3
