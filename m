From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 053/109] fs: add do_signalfd4() helper; remove internal calls to sys_signalfd4()
Date: Thu, 29 Mar 2018 13:23:30 +0200
Message-ID: <20180329112426.23043-54-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

Using this helper removes in-kernel calls to the sys_signalfd4() syscall
function.

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 fs/signalfd.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 76bf9cc62074..501c41f3351f 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -256,8 +256,8 @@ static const struct file_operations signalfd_fops = {
 	.llseek		= noop_llseek,
 };
 
-SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
-		size_t, sizemask, int, flags)
+static int do_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask,
+			int flags)
 {
 	sigset_t sigmask;
 	struct signalfd_ctx *ctx;
@@ -310,10 +310,16 @@ SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
 	return ufd;
 }
 
+SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user *, user_mask,
+		size_t, sizemask, int, flags)
+{
+	return do_signalfd4(ufd, user_mask, sizemask, flags);
+}
+
 SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *, user_mask,
 		size_t, sizemask)
 {
-	return sys_signalfd4(ufd, user_mask, sizemask, 0);
+	return do_signalfd4(ufd, user_mask, sizemask, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -333,7 +339,7 @@ COMPAT_SYSCALL_DEFINE4(signalfd4, int, ufd,
 	if (copy_to_user(ksigmask, &tmp, sizeof(sigset_t)))
 		return -EFAULT;
 
-	return sys_signalfd4(ufd, ksigmask, sizeof(sigset_t), flags);
+	return do_signalfd4(ufd, ksigmask, sizeof(sigset_t), flags);
 }
 
 COMPAT_SYSCALL_DEFINE3(signalfd, int, ufd,
-- 
2.16.3
