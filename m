From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH 2/6] alpha: Add CONFIG_OSF4_COMPAT for compat syscall support
Date: Mon, 16 Jul 2018 15:53:54 +0530
Message-ID: <1531736638-15294-3-git-send-email-firoz.khan@linaro.org>
References: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531736638-15294-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-alpha@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, Firoz Khan <firoz.khan@linaro.org>
List-Id: linux-arch.vger.kernel.org

Removed the CONFIG_OSF4_COMPAT check from systbls.S and
kept it in osf_sys.c, so it will provide the same system
call support. To do so, we can keep a generic formatted
system call table file across all architectures.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/kernel/osf_sys.c | 9 ++++++---
 arch/alpha/kernel/systbls.S | 5 -----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 6e92175..696a6b7 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1349,7 +1349,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 
 #ifdef CONFIG_OSF4_COMPAT
-
 /* Clear top 32 bits of iov_len in the user's buffer for
    compatibility with old versions of OSF/1 where iov_len
    was defined as int. */
@@ -1366,27 +1365,31 @@ osf_fix_iov_len(const struct iovec __user *iov, unsigned long count)
 	}
 	return 0;
 }
+#endif
 
 SYSCALL_DEFINE3(osf_readv, unsigned long, fd,
 		const struct iovec __user *, vector, unsigned long, count)
 {
+#ifdef CONFIG_OSF4_COMPAT
 	if (unlikely(personality(current->personality) == PER_OSF4))
 		if (osf_fix_iov_len(vector, count))
 			return -EFAULT;
+#endif
+
 	return sys_readv(fd, vector, count);
 }
 
 SYSCALL_DEFINE3(osf_writev, unsigned long, fd,
 		const struct iovec __user *, vector, unsigned long, count)
 {
+#ifdef CONFIG_OSF4_COMPAT
 	if (unlikely(personality(current->personality) == PER_OSF4))
 		if (osf_fix_iov_len(vector, count))
 			return -EFAULT;
+#endif
 	return sys_writev(fd, vector, count);
 }
 
-#endif
-
 SYSCALL_DEFINE2(osf_getpriority, int, which, int, who)
 {
 	int prio = sys_getpriority(which, who);
diff --git a/arch/alpha/kernel/systbls.S b/arch/alpha/kernel/systbls.S
index 1374e59..fcf2f60 100644
--- a/arch/alpha/kernel/systbls.S
+++ b/arch/alpha/kernel/systbls.S
@@ -132,13 +132,8 @@ sys_call_table:
 	.quad sys_osf_getrusage
 	.quad sys_getsockopt
 	.quad alpha_ni_syscall
-#ifdef CONFIG_OSF4_COMPAT
 	.quad sys_osf_readv			/* 120 */
 	.quad sys_osf_writev
-#else
-	.quad sys_readv				/* 120 */
-	.quad sys_writev
-#endif
 	.quad sys_osf_settimeofday
 	.quad sys_fchown
 	.quad sys_fchmod
-- 
2.7.4
