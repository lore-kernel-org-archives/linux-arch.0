From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH] ilp32: fix {GET,SET}SIGMASK request for ptrace
Date: Sat, 13 Aug 2016 17:52:28 +0300
Message-ID: <20160813145228.GA24335@yury-N73SV>
References: <1466207668-10549-1-git-send-email-ynorov@caviumnetworks.com>
 <1466207668-10549-13-git-send-email-ynorov@caviumnetworks.com>
 <5770B041.3040509@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <libc-alpha-return-72468-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <5770B041.3040509@huawei.com>
To: zhouchengming <zhouchengming1@huawei.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

On Mon, Jun 27, 2016 at 12:49:05PM +0800, zhouchengming wrote:
> The function compat_ptrace_request(used by ilp32) don't handle
> {GET,SET}SIGMASK request, so it will be handled by ptrace_request.
> But it's wrong because the compat_sigset_t of ilp32 differs from
> the sigset_t of aarch64. The patch fixes it.

Hi Zhou, all,

Reviewing your patch I found that we have 2 identical declarations of
put_sigset_t() and get_sigset_t(). So I moved it under 
arch/arm64/include/asm/signal32_common.h

I also reworked related code to remove unneeded function and variable
declarations. With all that your patch is looking like below. You can
try latest series here: https://github.com/norov/linux/tree/ilp32-4.8

It's based on v4.8, and addresses some comments. I'm going to meld
this patch with current patchset as it basicly the bugfux and update
submission when I'll finish with all comments.

Yury.


From 6a023da977713e9eade0a404c4f000d432d1fd67 Mon Sep 17 00:00:00 2001
From: Yury Norov <ynorov@caviumnetworks.com>
Date: Sat, 13 Aug 2016 17:36:59 +0300
Subject: [PATCH] aaa

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/signal32.h        |  3 ++
 arch/arm64/include/asm/signal32_common.h |  3 ++
 arch/arm64/include/asm/signal_ilp32.h    |  4 +++
 arch/arm64/kernel/ptrace.c               | 47 ++++++++++++++++++++++++++++++--
 arch/arm64/kernel/signal32.c             | 22 ---------------
 arch/arm64/kernel/signal32_common.c      | 21 ++++++++++++++
 arch/arm64/kernel/signal_ilp32.c         | 25 +----------------
 7 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/include/asm/signal32.h b/arch/arm64/include/asm/signal32.h
index e68fcce..1c4ede7 100644
--- a/arch/arm64/include/asm/signal32.h
+++ b/arch/arm64/include/asm/signal32.h
@@ -13,6 +13,9 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#include <asm/signal32_common.h>
+
 #ifndef __ASM_SIGNAL32_H
 #define __ASM_SIGNAL32_H
 
diff --git a/arch/arm64/include/asm/signal32_common.h b/arch/arm64/include/asm/signal32_common.h
index b4f2099..e3e2d01 100644
--- a/arch/arm64/include/asm/signal32_common.h
+++ b/arch/arm64/include/asm/signal32_common.h
@@ -19,6 +19,9 @@
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from);
 int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from);
 
+int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set);
+int get_sigset_t(sigset_t *set, const compat_sigset_t __user *uset);
+
 #endif /* CONFIG_COMPAT*/
 
 #endif /* __ASM_SIGNAL32_COMMON_H */
diff --git a/arch/arm64/include/asm/signal_ilp32.h b/arch/arm64/include/asm/signal_ilp32.h
index 30eff23..3c6d737 100644
--- a/arch/arm64/include/asm/signal_ilp32.h
+++ b/arch/arm64/include/asm/signal_ilp32.h
@@ -11,6 +11,10 @@
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
+
+#include <asm/signal32_common.h>
+#include <asm/signal_common.h>
+
 #ifndef __ASM_SIGNAL_ILP32_H
 #define __ASM_SIGNAL_ILP32_H
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index e69c79a..4f0df07 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -41,6 +41,7 @@
 
 #include <asm/debug-monitors.h>
 #include <asm/pgtable.h>
+#include <asm/signal32_common.h>
 #include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
@@ -1332,15 +1333,55 @@ COMPAT_SYSCALL_DEFINE4(aarch32_ptrace, compat_long_t, request, compat_long_t, pi
 
 #endif /* CONFIG_AARCH32_EL0 */
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_ARM64_ILP32
 
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	return compat_ptrace_request(child, request, caddr, cdata);
+	sigset_t new_set;
+
+	switch (request) {
+	case PTRACE_GETSIGMASK:
+		if (caddr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		return put_sigset_t((compat_sigset_t __user *) (u64) cdata,
+					&child->blocked);
+
+	case PTRACE_SETSIGMASK:
+		if (caddr != sizeof(compat_sigset_t))
+			return -EINVAL;
+
+		if (get_sigset_t(&new_set, (compat_sigset_t __user *) (u64) cdata))
+			return -EFAULT;
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
+		return 0;
+
+	default:
+		return compat_ptrace_request(child, request, caddr, cdata);
+	}
 }
 
-#endif /* CONFIG_COMPAT */
+#elif defined (CONFIG_COMPAT)
+
+long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
+		compat_ulong_t caddr, compat_ulong_t cdata)
+{
+	return 0;
+}
+
+#endif
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b103af3..f2c1a38 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -103,28 +103,6 @@ struct compat_rt_sigframe {
 
 #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
 
-static inline int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
-{
-	compat_sigset_t	cset;
-
-	cset.sig[0] = set->sig[0] & 0xffffffffull;
-	cset.sig[1] = set->sig[0] >> 32;
-
-	return copy_to_user(uset, &cset, sizeof(*uset));
-}
-
-static inline int get_sigset_t(sigset_t *set,
-			       const compat_sigset_t __user *uset)
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
 /*
  * VFP save/restore code.
  *
diff --git a/arch/arm64/kernel/signal32_common.c b/arch/arm64/kernel/signal32_common.c
index 8fbb609..4a45aa6 100644
--- a/arch/arm64/kernel/signal32_common.c
+++ b/arch/arm64/kernel/signal32_common.c
@@ -28,6 +28,27 @@
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 
+int put_sigset_t(compat_sigset_t __user *uset, sigset_t *set)
+{
+	compat_sigset_t	cset;
+
+	cset.sig[0] = set->sig[0] & 0xffffffffull;
+	cset.sig[1] = set->sig[0] >> 32;
+
+	return copy_to_user(uset, &cset, sizeof(*uset));
+}
+
+int get_sigset_t(sigset_t *set, const compat_sigset_t __user *uset)
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
 int copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from)
 {
 	int err;
diff --git a/arch/arm64/kernel/signal_ilp32.c b/arch/arm64/kernel/signal_ilp32.c
index 8ca64b9..7cc9122 100644
--- a/arch/arm64/kernel/signal_ilp32.c
+++ b/arch/arm64/kernel/signal_ilp32.c
@@ -26,8 +26,7 @@
 
 #include <asm/esr.h>
 #include <asm/fpsimd.h>
-#include <asm/signal32_common.h>
-#include <asm/signal_common.h>
+#include <asm/signal_ilp32.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/ucontext.h>
@@ -58,28 +57,6 @@ struct ilp32_rt_sigframe {
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
2.7.4
