From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 13/45] fs: add do_compat_select() helper; remove in-kernel call to comapt syscall
Date: Thu, 22 Mar 2018 10:00:27 +0100
Message-ID: <20180322090059.19361-14-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using the fs-internal do_compat_select() helper allows us to get rid of
the fs-internal call to the compat_sys_select() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/select.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index b5df01c4587d..ba879c51288f 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -1265,9 +1265,9 @@ static int compat_core_sys_select(int n, compat_ulong_t __user *inp,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE5(select, int, n, compat_ulong_t __user *, inp,
-	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
-	struct compat_timeval __user *, tvp)
+static int do_compat_select(int n, compat_ulong_t __user *inp,
+	compat_ulong_t __user *outp, compat_ulong_t __user *exp,
+	struct compat_timeval __user *tvp)
 {
 	struct timespec64 end_time, *to = NULL;
 	struct compat_timeval tv;
@@ -1290,6 +1290,13 @@ COMPAT_SYSCALL_DEFINE5(select, int, n, compat_ulong_t __user *, inp,
 	return ret;
 }
 
+COMPAT_SYSCALL_DEFINE5(select, int, n, compat_ulong_t __user *, inp,
+	compat_ulong_t __user *, outp, compat_ulong_t __user *, exp,
+	struct compat_timeval __user *, tvp)
+{
+	return do_compat_select(n, inp, outp, exp, tvp);
+}
+
 struct compat_sel_arg_struct {
 	compat_ulong_t n;
 	compat_uptr_t inp;
@@ -1304,8 +1311,8 @@ COMPAT_SYSCALL_DEFINE1(old_select, struct compat_sel_arg_struct __user *, arg)
 
 	if (copy_from_user(&a, arg, sizeof(a)))
 		return -EFAULT;
-	return compat_sys_select(a.n, compat_ptr(a.inp), compat_ptr(a.outp),
-				 compat_ptr(a.exp), compat_ptr(a.tvp));
+	return do_compat_select(a.n, compat_ptr(a.inp), compat_ptr(a.outp),
+				compat_ptr(a.exp), compat_ptr(a.tvp));
 }
 
 static long do_compat_pselect(int n, compat_ulong_t __user *inp,
-- 
2.16.2
