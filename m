From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 048/109] fs: add do_readlinkat() helper; remove internal call to sys_readlinkat()
Date: Thu, 29 Mar 2018 13:23:25 +0200
Message-ID: <20180329112426.23043-49-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using the do_readlinkat() helper removes an in-kernel call to the
sys_readlinkat() syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/stat.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/stat.c b/fs/stat.c
index 873785dae022..f8e6fb2c3657 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -379,8 +379,8 @@ SYSCALL_DEFINE2(newfstat, unsigned int, fd, struct stat __user *, statbuf)
 	return error;
 }
 
-SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
-		char __user *, buf, int, bufsiz)
+static int do_readlinkat(int dfd, const char __user *pathname,
+			 char __user *buf, int bufsiz)
 {
 	struct path path;
 	int error;
@@ -415,10 +415,16 @@ SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
 	return error;
 }
 
+SYSCALL_DEFINE4(readlinkat, int, dfd, const char __user *, pathname,
+		char __user *, buf, int, bufsiz)
+{
+	return do_readlinkat(dfd, pathname, buf, bufsiz);
+}
+
 SYSCALL_DEFINE3(readlink, const char __user *, path, char __user *, buf,
 		int, bufsiz)
 {
-	return sys_readlinkat(AT_FDCWD, path, buf, bufsiz);
+	return do_readlinkat(AT_FDCWD, path, buf, bufsiz);
 }
 
 
-- 
2.16.3
