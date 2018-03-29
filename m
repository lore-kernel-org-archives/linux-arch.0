From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 057/109] fs: add kern_select() helper; remove in-kernel call to sys_select()
Date: Thu, 29 Mar 2018 13:23:34 +0200
Message-ID: <20180329112426.23043-58-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the sys_umount()
syscall.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/select.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index b6c36254028a..b5df01c4587d 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -675,8 +675,8 @@ int core_sys_select(int n, fd_set __user *inp, fd_set __user *outp,
 	return ret;
 }
 
-SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
-		fd_set __user *, exp, struct timeval __user *, tvp)
+static int kern_select(int n, fd_set __user *inp, fd_set __user *outp,
+		       fd_set __user *exp, struct timeval __user *tvp)
 {
 	struct timespec64 end_time, *to = NULL;
 	struct timeval tv;
@@ -699,6 +699,12 @@ SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
 	return ret;
 }
 
+SYSCALL_DEFINE5(select, int, n, fd_set __user *, inp, fd_set __user *, outp,
+		fd_set __user *, exp, struct timeval __user *, tvp)
+{
+	return kern_select(n, inp, outp, exp, tvp);
+}
+
 static long do_pselect(int n, fd_set __user *inp, fd_set __user *outp,
 		       fd_set __user *exp, struct timespec __user *tsp,
 		       const sigset_t __user *sigmask, size_t sigsetsize)
@@ -784,7 +790,7 @@ SYSCALL_DEFINE1(old_select, struct sel_arg_struct __user *, arg)
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
-	return sys_select(a.n, a.inp, a.outp, a.exp, a.tvp);
+	return kern_select(a.n, a.inp, a.outp, a.exp, a.tvp);
 }
 #endif
 
-- 
2.16.3
