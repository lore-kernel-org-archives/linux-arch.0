From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 10/11] prctl: Remove redundant task argument from PR_{SET,GET}_UNALIGN backends
Date: Mon, 14 May 2018 18:14:26 +0100
Message-ID: <1526318067-4964-11-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
List-Id: linux-arch.vger.kernel.org

Architecture backends for the PT_SET_UNALIGN and PR_GET_UNALIGN
prctl() calls take a task argument that is redundant, since the
only thing ever passed is "current".

This patch gets rid of the redundant arguments.

No functional change.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
---
 arch/alpha/include/asm/thread_info.h | 10 +++++-----
 arch/ia64/include/asm/processor.h    |  8 ++++----
 arch/parisc/include/asm/processor.h  |  8 ++++----
 arch/powerpc/include/asm/processor.h |  8 ++++----
 arch/powerpc/kernel/process.c        |  8 ++++----
 arch/sh/include/asm/processor.h      |  8 ++++----
 arch/sh/mm/alignment.c               | 10 +++++-----
 kernel/sys.c                         |  8 ++++----
 8 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 807d7b9..403b3c8 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -85,19 +85,19 @@ register struct thread_info *__current_thread_info __asm__("$8");
 #define TS_UAC_NOFIX		0x0002	/* ! flags as they match          */
 #define TS_UAC_SIGBUS		0x0004	/* ! userspace part of 'osf_sysinfo' */
 
-#define SET_UNALIGN_CTL(task,value)	({				\
-	__u32 status = task_thread_info(task)->status & ~UAC_BITMASK;	\
+#define SET_UNALIGN_CTL(value)	({					\
+	__u32 status = current_thread_info()->status & ~UAC_BITMASK;	\
 	if (value & PR_UNALIGN_NOPRINT)					\
 		status |= TS_UAC_NOPRINT;				\
 	if (value & PR_UNALIGN_SIGBUS)					\
 		status |= TS_UAC_SIGBUS;				\
 	if (value & 4)	/* alpha-specific */				\
 		status |= TS_UAC_NOFIX;					\
-	task_thread_info(task)->status = status;			\
+	current_thread_info()->status = status;				\
 	0; })
 
-#define GET_UNALIGN_CTL(task,value)	({				\
-	__u32 status = task_thread_info(task)->status & ~UAC_BITMASK;	\
+#define GET_UNALIGN_CTL(value)	({					\
+	__u32 status = current_thread_info()->status & ~UAC_BITMASK;	\
 	__u32 res = 0;							\
 	if (status & TS_UAC_NOPRINT)					\
 		res |= PR_UNALIGN_NOPRINT;				\
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index e40242e..8d5184f 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -247,15 +247,15 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
-#define SET_UNALIGN_CTL(task,value)								\
+#define SET_UNALIGN_CTL(value)								\
 ({												\
-	(task)->thread.flags = (((task)->thread.flags & ~IA64_THREAD_UAC_MASK)			\
+	current->thread.flags = ((current->thread.flags & ~IA64_THREAD_UAC_MASK)			\
 				| (((value) << IA64_THREAD_UAC_SHIFT) & IA64_THREAD_UAC_MASK));	\
 	0;											\
 })
-#define GET_UNALIGN_CTL(task,addr)								\
+#define GET_UNALIGN_CTL(addr)								\
 ({												\
-	put_user(((task)->thread.flags & IA64_THREAD_UAC_MASK) >> IA64_THREAD_UAC_SHIFT,	\
+	put_user((current->thread.flags & IA64_THREAD_UAC_MASK) >> IA64_THREAD_UAC_SHIFT,	\
 		 (int __user *) (addr));							\
 })
 
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 2dbe558..b59720f 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -139,17 +139,17 @@ struct thread_struct {
 #define PARISC_UAC_SHIFT	0
 #define PARISC_UAC_MASK		(PARISC_UAC_NOPRINT|PARISC_UAC_SIGBUS)
 
-#define SET_UNALIGN_CTL(task,value)                                       \
+#define SET_UNALIGN_CTL(value)                                            \
         ({                                                                \
-        (task)->thread.flags = (((task)->thread.flags & ~PARISC_UAC_MASK) \
+        current->thread.flags = ((current->thread.flags & ~PARISC_UAC_MASK) \
                                 | (((value) << PARISC_UAC_SHIFT) &        \
                                    PARISC_UAC_MASK));                     \
         0;                                                                \
         })
 
-#define GET_UNALIGN_CTL(task,addr)                                        \
+#define GET_UNALIGN_CTL(addr)                                             \
         ({                                                                \
-        put_user(((task)->thread.flags & PARISC_UAC_MASK)                 \
+        put_user((current->thread.flags & PARISC_UAC_MASK)                \
                  >> PARISC_UAC_SHIFT, (int __user *) (addr));             \
         })
 
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index e1cd7ec..b8d9306 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -413,11 +413,11 @@ extern int set_fpexc_mode(unsigned int val);
 extern int get_endian(unsigned long adr);
 extern int set_endian(unsigned int val);
 
-#define GET_UNALIGN_CTL(tsk, adr)	get_unalign_ctl((tsk), (adr))
-#define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
+#define GET_UNALIGN_CTL(adr)	get_unalign_ctl((adr))
+#define SET_UNALIGN_CTL(val)	set_unalign_ctl((val))
 
-extern int get_unalign_ctl(struct task_struct *tsk, unsigned long adr);
-extern int set_unalign_ctl(struct task_struct *tsk, unsigned int val);
+extern int get_unalign_ctl(unsigned long adr);
+extern int set_unalign_ctl(unsigned int val);
 
 extern void load_fp_state(struct thread_fp_state *fp);
 extern void store_fp_state(struct thread_fp_state *fp);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 0fcb2f5..17708b7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2020,15 +2020,15 @@ int get_endian(unsigned long adr)
 	return put_user(val, (unsigned int __user *)adr);
 }
 
-int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
+int set_unalign_ctl(unsigned int val)
 {
-	tsk->thread.align_ctl = val;
+	current->thread.align_ctl = val;
 	return 0;
 }
 
-int get_unalign_ctl(struct task_struct *tsk, unsigned long adr)
+int get_unalign_ctl(unsigned long adr)
 {
-	return put_user(tsk->thread.align_ctl, (unsigned int __user *)adr);
+	return put_user(current->thread.align_ctl, (unsigned int __user *)adr);
 }
 
 static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index 6fbf8c8..ce3d9f6 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -117,11 +117,11 @@ extern void free_thread_xstate(struct task_struct *);
 extern struct kmem_cache *task_xstate_cachep;
 
 /* arch/sh/mm/alignment.c */
-extern int get_unalign_ctl(struct task_struct *, unsigned long addr);
-extern int set_unalign_ctl(struct task_struct *, unsigned int val);
+extern int get_unalign_ctl(unsigned long addr);
+extern int set_unalign_ctl(unsigned int val);
 
-#define GET_UNALIGN_CTL(tsk, addr)	get_unalign_ctl((tsk), (addr))
-#define SET_UNALIGN_CTL(tsk, val)	set_unalign_ctl((tsk), (val))
+#define GET_UNALIGN_CTL(addr)	get_unalign_ctl((addr))
+#define SET_UNALIGN_CTL(val)	set_unalign_ctl((val))
 
 /* arch/sh/mm/init.c */
 extern unsigned int mem_init_done;
diff --git a/arch/sh/mm/alignment.c b/arch/sh/mm/alignment.c
index ec2b253..bad2a31 100644
--- a/arch/sh/mm/alignment.c
+++ b/arch/sh/mm/alignment.c
@@ -80,16 +80,16 @@ unsigned int unaligned_user_action(void)
 	return action;
 }
 
-int get_unalign_ctl(struct task_struct *tsk, unsigned long addr)
+int get_unalign_ctl(unsigned long addr)
 {
-	return put_user(tsk->thread.flags & SH_THREAD_UAC_MASK,
+	return put_user(current->thread.flags & SH_THREAD_UAC_MASK,
 			(unsigned int __user *)addr);
 }
 
-int set_unalign_ctl(struct task_struct *tsk, unsigned int val)
+int set_unalign_ctl(unsigned int val)
 {
-	tsk->thread.flags = (tsk->thread.flags & ~SH_THREAD_UAC_MASK) |
-			    (val & SH_THREAD_UAC_MASK);
+	current->thread.flags = (current->thread.flags & ~SH_THREAD_UAC_MASK) |
+				(val & SH_THREAD_UAC_MASK);
 	return 0;
 }
 
diff --git a/kernel/sys.c b/kernel/sys.c
index 8111c0d..47cf999 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -72,10 +72,10 @@
 #include "uid16.h"
 
 #ifndef SET_UNALIGN_CTL
-# define SET_UNALIGN_CTL(a, b)	(-EINVAL)
+# define SET_UNALIGN_CTL(a)	(-EINVAL)
 #endif
 #ifndef GET_UNALIGN_CTL
-# define GET_UNALIGN_CTL(a, b)	(-EINVAL)
+# define GET_UNALIGN_CTL(a)	(-EINVAL)
 #endif
 
 /*
@@ -2235,10 +2235,10 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		break;
 
 	case PR_SET_UNALIGN:
-		error = SET_UNALIGN_CTL(me, arg2);
+		error = SET_UNALIGN_CTL(arg2);
 		break;
 	case PR_GET_UNALIGN:
-		error = GET_UNALIGN_CTL(me, arg2);
+		error = GET_UNALIGN_CTL(arg2);
 		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
-- 
2.1.4
