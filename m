From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH v7 02/22] asm-generic/syscall.h: turn
 syscall_[gs]et_arguments into wrappers
Date: Mon, 7 Jan 2019 05:52:44 +0300
Message-ID: <20190107025244.GB1207@altlinux.org>
References: <20190107025101.GA1182@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Add a generic wrapper syscall_get_arguments() that checks
its arguments and calls arch-specific __syscall_get_arguments().

Likewise, add a generic wrapper syscall_set_arguments() that checks
its arguments and calls arch-specific __syscall_set_arguments().

This is the first step on the way of getting rid of BUGs, BUG_ONs,
and replicated error checks in arch-specific asm/syscall.h files.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Notes:
    v7: unchanged
    v6: initial revision

 include/asm-generic/syscall.h | 47 +++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index 9863a5f8fbe8..fdefe27fa63f 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -122,10 +122,34 @@ syscall_set_return_value(struct task_struct *task, struct pt_regs *regs,
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
+ *
+ * This function is a wrapper around arch-specific __syscall_get_arguments.
  */
 static void
+__syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n, unsigned long *args);
+
+static inline void
 syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
-		      unsigned int i, unsigned int n, unsigned long *args);
+		      unsigned int i, unsigned int n, unsigned long *args)
+{
+	/*
+	 * Ideally there should have been a BUILD_BUG_ON(i + n > 6)
+	 * instead of these checks because it is a "cannot happen"
+	 * kind of assertion.
+	 */
+	if (WARN_ON_ONCE(i > 6)) {
+		memset(args, 0, n * sizeof(args[0]));
+		return;
+	}
+	if (WARN_ON_ONCE(n > 6 - i)) {
+		unsigned int extra = n - (6 - i);
+
+		n = 6 - i;
+		memset(&args[n], 0, extra * sizeof(args[0]));
+	}
+	__syscall_get_arguments(task, regs, i, n, args);
+}
 
 /**
  * syscall_set_arguments - change system call parameter value
@@ -143,11 +167,30 @@ syscall_get_arguments(struct task_struct *task, struct pt_regs *regs,
  * entry to a system call, due to %TIF_SYSCALL_TRACE or %TIF_SYSCALL_AUDIT.
  * It's invalid to call this with @i + @n > 6; we only support system calls
  * taking up to 6 arguments.
+ *
+ * This function is a wrapper around arch-specific __syscall_set_arguments.
  */
 static void
+__syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
+			unsigned int i, unsigned int n,
+			const unsigned long *args);
+
+static inline void
 syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
 		      unsigned int i, unsigned int n,
-		      const unsigned long *args);
+		      const unsigned long *args)
+{
+	/*
+	 * Ideally there should have been a BUILD_BUG_ON(i + n > 6)
+	 * instead of these checks because it is a "cannot happen"
+	 * kind of assertion.
+	 */
+	if (WARN_ON_ONCE(i > 6))
+		return;
+	if (WARN_ON_ONCE(n > 6 - i))
+		n = 6 - i;
+	__syscall_set_arguments(task, regs, i, n, args);
+}
 
 /**
  * syscall_get_arch - return the AUDIT_ARCH for the current system call
-- 
ldv
