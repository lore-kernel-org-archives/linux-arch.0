From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.4 077/162] sched/core, x86: Make struct thread_info arch specific again
Date: Thu, 19 Dec 2019 19:33:05 +0100
Message-ID: <20191219183212.482196665@linuxfoundation.org>
References: <20191219183150.477687052@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191219183150.477687052@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, keescook@chromium.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, "zhangyi (F)" <yi.zhang@huawei.com>
List-Id: linux-arch.vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

commit c8061485a0d7569a865a3cc3c63347b0f42b3765 upstream.

The following commit:

  c65eacbe290b ("sched/core: Allow putting thread_info into task_struct")

... made 'struct thread_info' a generic struct with only a
single ::flags member, if CONFIG_THREAD_INFO_IN_TASK_STRUCT=y is
selected.

This change however seems to be quite x86 centric, since at least the
generic preemption code (asm-generic/preempt.h) assumes that struct
thread_info also has a preempt_count member, which apparently was not
true for x86.

We could add a bit more #ifdefs to solve this problem too, but it seems
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
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: keescook@chromium.org
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/1476901693-8492-2-git-send-email-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[ zhangyi: skip defination of INIT_THREAD_INFO and struct thread_info ]
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/thread_info.h |   11 -----------
 1 file changed, 11 deletions(-)

--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -14,17 +14,6 @@ struct timespec;
 struct compat_timespec;
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
-struct thread_info {
-	u32			flags;		/* low level flags */
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
 
