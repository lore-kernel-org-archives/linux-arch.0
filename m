From: Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/3] sched/core,x86: make struct thread_info arch specific again
Date: Wed, 19 Oct 2016 19:28:11 +0100
Message-ID: <1476901693-8492-2-git-send-email-mark.rutland@arm.com>
References: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476901693-8492-1-git-send-email-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, heiko.carstens@de.ibm.com, hpa@zytor.com, keescook@chromium.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit c65eacbe290b ("sched/core: Allow putting thread_info into
task_struct") made struct thread_info a generic struct with only a
single flags member if THREAD_INFO_IN_TASK_STRUCT is selected.

This change however seems to be quite x86 centric, since at least the
generic preemption code (asm-generic/preempt.h) assumes that struct
thread_info also has a preempt_count member, which apparently was not
true for x86.

We could add a bit more ifdefs to solve this problem too, but it seems
to be much simpler to make struct thread_info arch specific
again. This also makes the conversion to THREAD_INFO_IN_TASK_STRUCT a
bit easier for architectures that have a couple of arch specific stuff
in their thread_info definition.

The arch specific stuff _could_ be moved to thread_struct. However
keeping them in thread_info makes it easier: accessing thread_info
members is simple, since it is at the beginning of the task_struct,
while the thread_struct is at the end. At least on s390 the offsets
needed to access members of the thread_struct (with task_struct as
base) are too large for various asm instructions.  This is not a
problem when keeping these members within thread_info.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/thread_info.h |  9 +++++++++
 include/linux/thread_info.h        | 11 -----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 2aaca53..ad6f5eb0 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -52,6 +52,15 @@
 #include <asm/cpufeature.h>
 #include <linux/atomic.h>
 
+struct thread_info {
+	unsigned long		flags;		/* low level flags */
+};
+
+#define INIT_THREAD_INFO(tsk)			\
+{						\
+	.flags		= 0,			\
+}
+
 #define init_stack		(init_thread_union.stack)
 
 #else /* !__ASSEMBLY__ */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 45f004e..2873baf 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -14,17 +14,6 @@
 struct compat_timespec;
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-struct thread_info {
-	unsigned long		flags;		/* low level flags */
-};
-
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.flags		= 0,			\
-}
-#endif
-
-#ifdef CONFIG_THREAD_INFO_IN_TASK
 #define current_thread_info() ((struct thread_info *)current)
 #endif
 
-- 
1.9.1
