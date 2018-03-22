From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 20/45] kernel: add do_compat_sigaltstack() helper; remove in-kernel call to compat syscall
Date: Thu, 22 Mar 2018 10:00:34 +0100
Message-ID: <20180322090059.19361-21-linux@dominikbrodowski.net>
References: <20180322090059.19361-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322090059.19361-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, viro@ZenIV.linux.org.uk, arnd@arndb.de, linux-arch@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Using this helper allows us to avoid the in-kernel call to the
compat_sys_sigaltstack() syscall.

This patch is part of a series which tries to remove in-kernel calls to
syscalls. On this basis, the syscall entry path can be streamlined.

Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 kernel/signal.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 985c61749bcf..f04466655238 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3573,9 +3573,8 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE2(sigaltstack,
-			const compat_stack_t __user *, uss_ptr,
-			compat_stack_t __user *, uoss_ptr)
+static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
+				 compat_stack_t __user *uoss_ptr)
 {
 	stack_t uss, uoss;
 	int ret;
@@ -3602,9 +3601,16 @@ COMPAT_SYSCALL_DEFINE2(sigaltstack,
 	return ret;
 }
 
+COMPAT_SYSCALL_DEFINE2(sigaltstack,
+			const compat_stack_t __user *, uss_ptr,
+			compat_stack_t __user *, uoss_ptr)
+{
+	return do_compat_sigaltstack(uss_ptr, uoss_ptr);
+}
+
 int compat_restore_altstack(const compat_stack_t __user *uss)
 {
-	int err = compat_sys_sigaltstack(uss, NULL);
+	int err = do_compat_sigaltstack(uss, NULL);
 	/* squash all but -EFAULT for now */
 	return err == -EFAULT ? err : 0;
 }
-- 
2.16.2
