From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 30/32] fuse: convert to struct inode_time
Date: Fri, 30 May 2014 22:01:54 +0200
Message-ID: <1401480116-1973111-31-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

fuse uses 64-bit seconds for inode timestamps in the user interface,
which will work basically forever, but the VFS uses struct timespec
for timestamps, which is only good until 2038 on 32-bit CPUs.

This gets us one small step closer to lifting the VFS limit by using
struct inode_time in fuse.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 754dcf2..58f138e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -203,7 +203,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	bool is_wb = fc->writeback_cache;
 	loff_t oldsize;
-	struct timespec old_mtime;
+	struct inode_time old_mtime;
 
 	spin_lock(&fc->lock);
 	if ((attr_version != 0 && fi->attr_version > attr_version) ||
@@ -232,7 +232,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			truncate_pagecache(inode, attr->size);
 			inval = true;
 		} else if (fc->auto_inval_data) {
-			struct timespec new_mtime = {
+			struct inode_time new_mtime = {
 				.tv_sec = attr->mtime,
 				.tv_nsec = attr->mtimensec,
 			};
@@ -241,7 +241,7 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 			 * Auto inval mode also checks and invalidates if mtime
 			 * has changed.
 			 */
-			if (!timespec_equal(&old_mtime, &new_mtime))
+			if (!inode_time_equal(&old_mtime, &new_mtime))
 				inval = true;
 		}
 
-- 
1.8.3.2
