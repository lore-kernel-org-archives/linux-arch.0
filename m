From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/3] thread_info: factor out restart_block
Date: Wed, 19 Oct 2016 19:28:12 +0100
Message-ID: <1476901693-8492-3-git-send-email-mark.rutland@arm.com>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, hpa@zytor.com, keescook@chromium.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

Since commit f56141e3e2d9aabf ("all arches, signal: move restart_block
to struct task_struct"), thread_info and restart_block have been
logically distinct, yet struct restart_block is still defined in
<linux/thread_info.h>.

At least one architecture (erroneously) uses restart_block as part of
its thread_info, and thus the definition of restart_block must come
before the include of <asm/thread_info>. Subsequent patches in this
series need to shuffle the order of includes and definitions in
<linux/thread_info.h>, and will make this ordering fragile.

This patch moves the definition of restart_block out to its own header.
This serves as generic cleanup, logically separating thread_info and
restart_block, and also makes it easier to avoid fragility.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/restart_block.h | 51 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/thread_info.h   | 41 +---------------------------------
 2 files changed, 52 insertions(+), 40 deletions(-)
 create mode 100644 include/linux/restart_block.h

diff --git a/include/linux/restart_block.h b/include/linux/restart_block.h
new file mode 100644
index 0000000..0d905d8
--- /dev/null
+++ b/include/linux/restart_block.h
@@ -0,0 +1,51 @@
+/*
+ * Common syscall restarting data
+ */
+#ifndef __LINUX_RESTART_BLOCK_H
+#define __LINUX_RESTART_BLOCK_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+struct timespec;
+struct compat_timespec;
+struct pollfd;
+
+/*
+ * System call restart block.
+ */
+struct restart_block {
+	long (*fn)(struct restart_block *);
+	union {
+		/* For futex_wait and futex_wait_requeue_pi */
+		struct {
+			u32 __user *uaddr;
+			u32 val;
+			u32 flags;
+			u32 bitset;
+			u64 time;
+			u32 __user *uaddr2;
+		} futex;
+		/* For nanosleep */
+		struct {
+			clockid_t clockid;
+			struct timespec __user *rmtp;
+#ifdef CONFIG_COMPAT
+			struct compat_timespec __user *compat_rmtp;
+#endif
+			u64 expires;
+		} nanosleep;
+		/* For poll */
+		struct {
+			struct pollfd __user *ufds;
+			int nfds;
+			int has_timeout;
+			unsigned long tv_sec;
+			unsigned long tv_nsec;
+		} poll;
+	};
+};
+
+extern long do_no_restart_syscall(struct restart_block *parm);
+
+#endif /* __LINUX_RESTART_BLOCK_H */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 2873baf..c75c6ab 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -9,51 +9,12 @@
 
 #include <linux/types.h>
 #include <linux/bug.h>
-
-struct timespec;
-struct compat_timespec;
+#include <linux/restart_block.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 #define current_thread_info() ((struct thread_info *)current)
 #endif
 
-/*
- * System call restart block.
- */
-struct restart_block {
-	long (*fn)(struct restart_block *);
-	union {
-		/* For futex_wait and futex_wait_requeue_pi */
-		struct {
-			u32 __user *uaddr;
-			u32 val;
-			u32 flags;
-			u32 bitset;
-			u64 time;
-			u32 __user *uaddr2;
-		} futex;
-		/* For nanosleep */
-		struct {
-			clockid_t clockid;
-			struct timespec __user *rmtp;
-#ifdef CONFIG_COMPAT
-			struct compat_timespec __user *compat_rmtp;
-#endif
-			u64 expires;
-		} nanosleep;
-		/* For poll */
-		struct {
-			struct pollfd __user *ufds;
-			int nfds;
-			int has_timeout;
-			unsigned long tv_sec;
-			unsigned long tv_nsec;
-		} poll;
-	};
-};
-
-extern long do_no_restart_syscall(struct restart_block *parm);
-
 #include <linux/bitops.h>
 #include <asm/thread_info.h>
 
-- 
1.9.1
