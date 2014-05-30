From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 26/32] reiserfs: convert to struct inode_time
Date: Fri, 30 May 2014 22:01:50 +0200
Message-ID: <1401480116-1973111-27-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, reiserfs-devel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

reiserfs uses unsigned 32-bit seconds for inode timestamps, which will work
for the next 92 years, but the VFS uses struct timespec for timestamps,
which is only good until 2038 on 32-bit CPUs.

This gets us one small step closer to lifting the VFS limit by using
struct inode_time in reiserfs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: reiserfs-devel@vger.kernel.org
---
 fs/reiserfs/namei.c | 2 +-
 fs/reiserfs/xattr.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index e825f8b..4b81c84 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1215,7 +1215,7 @@ static int reiserfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 	int jbegin_count;
 	umode_t old_inode_mode;
 	unsigned long savelink = 1;
-	struct timespec ctime;
+	struct inode_time ctime;
 
 	/* three balancings: (1) old name removal, (2) new name insertion
 	   and (3) maybe "save" link insertion
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 5cdfbd6..13367ca 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -426,9 +426,9 @@ int reiserfs_commit_write(struct file *f, struct page *page,
 
 static void update_ctime(struct inode *inode)
 {
-	struct timespec now = current_fs_time(inode->i_sb);
+	struct inode_time now = current_fs_time(inode->i_sb);
 	if (inode_unhashed(inode) || !inode->i_nlink ||
-	    timespec_equal(&inode->i_ctime, &now))
+	    inode_time_equal(&inode->i_ctime, &now))
 		return;
 
 	inode->i_ctime = CURRENT_TIME_SEC;
-- 
1.8.3.2
