From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 051/109] fs: add do_futimesat() helper; remove internal call to sys_futimesat()
Date: Thu, 29 Mar 2018 13:23:28 +0200
Message-ID: <20180329112426.23043-52-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper removes the in-kernel call to the sys_futimesat()
syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/utimes.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/utimes.c b/fs/utimes.c
index e4b3d7c2c9f5..5be035ed26c0 100644
--- a/fs/utimes.c
+++ b/fs/utimes.c
@@ -184,8 +184,8 @@ SYSCALL_DEFINE4(utimensat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, flags);
 }
 
-SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
-		struct timeval __user *, utimes)
+static long do_futimesat(int dfd, const char __user *filename,
+			 struct timeval __user *utimes)
 {
 	struct timeval times[2];
 	struct timespec64 tstimes[2];
@@ -212,10 +212,17 @@ SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
 	return do_utimes(dfd, filename, utimes ? tstimes : NULL, 0);
 }
 
+
+SYSCALL_DEFINE3(futimesat, int, dfd, const char __user *, filename,
+		struct timeval __user *, utimes)
+{
+	return do_futimesat(dfd, filename, utimes);
+}
+
 SYSCALL_DEFINE2(utimes, char __user *, filename,
 		struct timeval __user *, utimes)
 {
-	return sys_futimesat(AT_FDCWD, filename, utimes);
+	return do_futimesat(AT_FDCWD, filename, utimes);
 }
 
 #ifdef CONFIG_COMPAT
-- 
2.16.3
