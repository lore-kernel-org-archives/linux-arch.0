From: zhouchengming <zhouchengming1@huawei.com>
Subject: [PATCH] ilp32: fix {GET,SET}SIGMASK request for ptrace
Date: Mon, 27 Jun 2016 12:49:05 +0800
Message-ID: <5770B041.3040509@huawei.com>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com> <1466207668-10549-13-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:20682 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810AbcF0EvU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2016 00:51:20 -0400
In-Reply-To: <1466207668-10549-13-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net

The function compat_ptrace_request(used by ilp32) don't handle
{GET,SET}SIGMASK request, so it will be handled by ptrace_request.
But it's wrong because the compat_sigset_t of ilp32 differs from
the sigset_t of aarch64. The patch fixes it.

Signed-off-by: Zhou Chengming <zhouchengming1@huawei.com>
---
  arch/arm64/include/asm/signal_ilp32.h |   22 ++++++++++++
  arch/arm64/kernel/ptrace.c            |   62 
+++++++++++++++++++++++++++++++++
  arch/arm64/kernel/signal_ilp32.c      |   23 +------------
  3 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/signal_ilp32.h 
b/arch/arm64/include/asm/signal_ilp32.h
index 30eff23..ed52607 100644
--- a/arch/arm64/include/asm/signal_ilp32.h
+++ b/arch/arm64/include/asm/signal_ilp32.h
@@ -21,6 +21,28 @@
  int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
  			  struct pt_regs *regs);

+static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
+{
+	compat_sigset_t cset;
+
+	cset.sig[0] = set->sig[0] & 0xffffffffull;
+	cset.sig[1] = set->sig[0] >> 32;
+
+	return copy_to_user(uset, &cset, sizeof(*uset));
+}
+
+static inline int get_sigset_t(sigset_t *set,
+			       const compat_sigset_t __user *uset)
+{
+	compat_sigset_t s32;
+
+	if (copy_from_user(&s32, uset, sizeof(*uset)))
+		return -EFAULT;
+
+	set->sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
+	return 0;
+}
+
  #else

  static inline int ilp32_setup_rt_frame(int usig, struct ksignal *ksig, 
sigset_t *set,
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index a861105..8d4cad1 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -44,6 +44,7 @@
  #include <asm/syscall.h>
  #include <asm/traps.h>
  #include <asm/system_misc.h>
+#include <asm/signal_ilp32.h>

  #define CREATE_TRACE_POINTS
  #include <trace/events/syscalls.h>
@@ -1231,12 +1232,73 @@ COMPAT_SYSCALL_DEFINE4(aarch32_ptrace, 
compat_long_t, request, compat_long_t, pi

  #endif /* CONFIG_AARCH32_EL0 */

+#ifdef CONFIG_ARM64_ILP32
+
+static int compat_ilp32_ptrace(struct task_struct *child, compat_long_t 
request,
+			compat_ulong_t addr, compat_ulong_t data)
+{
+	compat_ulong_t __user *datap = compat_ptr(data);
+	int ret;
+
+	switch (request) {
+	case PTRACE_GETSIGMASK:
+		if (addr != sizeof(compat_sigset_t)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (put_sigset_t((compat_sigset_t __user *)datap, &child->blocked))
+			ret = -EFAULT;
+		else
+			ret = 0;
+		break;
+
+	case PTRACE_SETSIGMASK: {
+		sigset_t new_set;
+		if (addr != sizeof(compat_sigset_t)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (get_sigset_t(&new_set, (compat_sigset_t __user *)datap)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		sigdelsetmask(&new_set, sigmask(SIGKILL)|sigmask(SIGSTOP));
+
+		/*
+		 * Every thread does recalc_sigpending() after resume, so
+		 * retarget_shared_pending() and recalc_sigpending() are not
+		 * called here.
+		 */
+		spin_lock_irq(&child->sighand->siglock);
+		child->blocked = new_set;
+		spin_unlock_irq(&child->sighand->siglock);
+
+		ret = 0;
+		break;
+	}
+
+	default:
+		ret = compat_ptrace_request(child, request, addr, data);
+	}
+
+	return ret;
+}
+
+#endif /* CONFIG_ARM64_ILP32 */
+
  #ifdef CONFIG_COMPAT

  long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
  			compat_ulong_t caddr, compat_ulong_t cdata)
  {
+#ifdef CONFIG_ARM64_ILP32
+	return compat_ilp32_ptrace(child, request, caddr, cdata);
+#else
  	return compat_ptrace_request(child, request, caddr, cdata);
+#endif
  }

  #endif /* CONFIG_COMPAT */
diff --git a/arch/arm64/kernel/signal_ilp32.c 
b/arch/arm64/kernel/signal_ilp32.c
index 8ca64b9..3ef2749 100644
--- a/arch/arm64/kernel/signal_ilp32.c
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -28,6 +28,7 @@
  #include <asm/fpsimd.h>
  #include <asm/signal32_common.h>
  #include <asm/signal_common.h>
+#include <asm/signal_ilp32.h>
  #include <asm/uaccess.h>
  #include <asm/unistd.h>
  #include <asm/ucontext.h>
@@ -58,28 +59,6 @@ struct ilp32_rt_sigframe {
  	struct ilp32_sigframe sig;
  };

-static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
-{
-	compat_sigset_t cset;
-
-	cset.sig[0] = set->sig[0] & 0xffffffffull;
-	cset.sig[1] = set->sig[0] >> 32;
-
-	return copy_to_user(uset, &cset, sizeof(*uset));
-}
-
-static inline int get_sigset_t(sigset_t *set,
-                               const compat_sigset_t __user *uset)
-{
-	compat_sigset_t s32;
-
-	if (copy_from_user(&s32, uset, sizeof(*uset)))
-		return -EFAULT;
-
-	set->sig[0] = s32.sig[0] | (((long)s32.sig[1]) << 32);
-	return 0;
-}
-
  static int restore_ilp32_sigframe(struct pt_regs *regs,
                              struct ilp32_sigframe __user *sf)
  {
-- 
1.7.7
