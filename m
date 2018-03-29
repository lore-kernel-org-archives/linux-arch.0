From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 049/109] fs: add do_pipe2() helper; remove internal call to sys_pipe2()
Date: Thu, 29 Mar 2018 13:23:26 +0200
Message-ID: <20180329112426.23043-50-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

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
