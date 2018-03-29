From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 005/109] mm: use do_futex() instead of sys_futex() in mm_release()
Date: Thu, 29 Mar 2018 13:22:42 +0200
Message-ID: <20180329112426.23043-6-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

sys_futex() is a wrapper to do_futex() which does not modify any
values here:

- uaddr, val and val3 are kept the same

- op is masked with FUTEX_CMD_MASK, but is always set to FUTEX_WAKE.
  Therefore, val2 is always 0.

- as utime is set to NULL, *timeout is NULL

This patch is part of a series which removes in-kernel calls to syscalls.
On this basis, the syscall entry path can be streamlined. For details, see
http://lkml.kernel.org/r/20180325162527.GA17492@light.dominikbrodowski.net

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/futex.h | 13 ++++++++++---
 kernel/fork.c         |  4 ++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index c0fb9a24bbd2..821ae502d3d8 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -9,9 +9,6 @@ struct inode;
 struct mm_struct;
 struct task_struct;
 
-long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
-	      u32 __user *uaddr2, u32 val2, u32 val3);
-
 extern int
 handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi);
 
@@ -55,6 +52,9 @@ union futex_key {
 
 #ifdef CONFIG_FUTEX
 extern void exit_robust_list(struct task_struct *curr);
+
+long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
+	      u32 __user *uaddr2, u32 val2, u32 val3);
 #ifdef CONFIG_HAVE_FUTEX_CMPXCHG
 #define futex_cmpxchg_enabled 1
 #else
@@ -64,6 +64,13 @@ extern int futex_cmpxchg_enabled;
 static inline void exit_robust_list(struct task_struct *curr)
 {
 }
+
+static inline long do_futex(u32 __user *uaddr, int op, u32 val,
+			    ktime_t *timeout, u32 __user *uaddr2,
+			    u32 val2, u32 val3)
+{
+	return -EINVAL;
+}
 #endif
 
 #ifdef CONFIG_FUTEX_PI
diff --git a/kernel/fork.c b/kernel/fork.c
index e5d9d405ae4e..b1e031aac9db 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1198,8 +1198,8 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 			 * not set up a proper pointer then tough luck.
 			 */
 			put_user(0, tsk->clear_child_tid);
-			sys_futex(tsk->clear_child_tid, FUTEX_WAKE,
-					1, NULL, NULL, 0);
+			do_futex(tsk->clear_child_tid, FUTEX_WAKE,
+					1, NULL, NULL, 0, 0);
 		}
 		tsk->clear_child_tid = NULL;
 	}
-- 
2.16.3
