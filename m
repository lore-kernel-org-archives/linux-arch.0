Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from isilmar-4.linta.de ([136.243.71.142]:59534 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbeC2L0R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Mar 2018 07:26:17 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 049/109] fs: add do_pipe2() helper; remove internal call to sys_pipe2()
Date: Thu, 29 Mar 2018 13:23:26 +0200
Message-ID: <20180329112426.23043-50-linux@dominikbrodowski.net>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <20180329112326.wAY4J2q3DYr2lUnL0oyPRwbyL-Sl4qJ13ZXpJCSz0cI@z>

Using this helper removes an in-kernel call to the sys_pipe2() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/pipe.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 7b1954caf388..39d6f431da83 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -841,7 +841,7 @@ int do_pipe_flags(int *fd, int flags)
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
  */
-SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
+static int do_pipe2(int __user *fildes, int flags)
 {
 	struct file *files[2];
 	int fd[2];
@@ -863,9 +863,14 @@ SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
 	return error;
 }
 
+SYSCALL_DEFINE2(pipe2, int __user *, fildes, int, flags)
+{
+	return do_pipe2(fildes, flags);
+}
+
 SYSCALL_DEFINE1(pipe, int __user *, fildes)
 {
-	return sys_pipe2(fildes, 0);
+	return do_pipe2(fildes, 0);
 }
 
 static int wait_for_partner(struct pipe_inode_info *pipe, unsigned int *cnt)
-- 
2.16.3
