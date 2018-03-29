Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:58700 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbeC2L0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:01 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 050/109] fs: add do_renameat2() helper; remove internal call to sys_renameat2()
Date: Thu, 29 Mar 2018 13:23:27 +0200
Message-ID: <20180329112426.23043-51-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <20180329112327.iT5OzWsegwgNRFUh7FmR1UdJBR0XiCR3lLZ85aCEvG0@z>

Using this helper removes in-kernel calls to the sys_renameat2() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/namei.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 921ae32dbc80..524e829ffc7d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4478,8 +4478,8 @@ int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 }
 EXPORT_SYMBOL(vfs_rename);
 
-SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
-		int, newdfd, const char __user *, newname, unsigned int, flags)
+static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
+			const char __user *newname, unsigned int flags)
 {
 	struct dentry *old_dentry, *new_dentry;
 	struct dentry *trap;
@@ -4621,15 +4621,21 @@ SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
 	return error;
 }
 
+SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
+		int, newdfd, const char __user *, newname, unsigned int, flags)
+{
+	return do_renameat2(olddfd, oldname, newdfd, newname, flags);
+}
+
 SYSCALL_DEFINE4(renameat, int, olddfd, const char __user *, oldname,
 		int, newdfd, const char __user *, newname)
 {
-	return sys_renameat2(olddfd, oldname, newdfd, newname, 0);
+	return do_renameat2(olddfd, oldname, newdfd, newname, 0);
 }
 
 SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newname)
 {
-	return sys_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
+	return do_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
 }
 
 int vfs_whiteout(struct inode *dir, struct dentry *dentry)
-- 
2.16.3
