Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:58881 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934432AbaE3UKy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2014 16:10:54 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 29/32] f2fs: convert to struct inode_time
Date: Fri, 30 May 2014 22:01:53 +0200
Message-ID: <1401480116-1973111-30-git-send-email-arnd@arndb.de>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk.kim@samsung.com>, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <20140530200153.hFoJR8Bus9XJziUhuM8zpWnmlxBGmydr8UcOshVAkYQ@z>

f2fs uses unsigned 40-bit seconds for inode timestamps, which will work
basically forever, but the VFS uses struct timespec for timestamps,
which is only good until 2038 on 32-bit CPUs.

This gets us one small step closer to lifting the VFS limit by using
struct inode_time in f2fs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
---
 fs/f2fs/file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 37d0e1f..6ff6e5b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -474,13 +474,13 @@ static void __setattr_copy(struct inode *inode, const struct iattr *attr)
 	if (ia_valid & ATTR_GID)
 		inode->i_gid = attr->ia_gid;
 	if (ia_valid & ATTR_ATIME)
-		inode->i_atime = timespec_trunc(attr->ia_atime,
+		inode->i_atime = inode_time_trunc(attr->ia_atime,
 						inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MTIME)
-		inode->i_mtime = timespec_trunc(attr->ia_mtime,
+		inode->i_mtime = inode_time_trunc(attr->ia_mtime,
 						inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_CTIME)
-		inode->i_ctime = timespec_trunc(attr->ia_ctime,
+		inode->i_ctime = inode_time_trunc(attr->ia_ctime,
 						inode->i_sb->s_time_gran);
 	if (ia_valid & ATTR_MODE) {
 		umode_t mode = attr->ia_mode;
-- 
1.8.3.2

