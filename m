From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 11/11] prctl: Refactor PR_{SET,GET}_UNALIGN to reduce boilerplate
Date: Mon, 14 May 2018 18:14:27 +0100
Message-ID: <1526318067-4964-12-git-send-email-Dave.Martin@arm.com>
References: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526318067-4964-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
List-Id: linux-arch.vger.kernel.org

The PR_SET_UNALIGN and PR_GET_UNALIGN prctl() calls are implemented
by five architectures today, but there is some irregularity and
duplication in the way they are implemented.

This patch moves the common put_user() operation to common code,
since the user pointer type is the same in all cases.

Because this is hardly hot-path code, there is no strong reason to
inline the arch backends for these operations, so this patch also
pushes them down into the arch trees as proper C functions, and
regularises the style of the backends somewhat.

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
 arch/Kconfig                         |  3 +++
 arch/alpha/Kconfig                   |  1 +
 arch/alpha/include/asm/thread_info.h | 23 -----------------------
 arch/alpha/kernel/Makefile           |  2 +-
 arch/alpha/kernel/sys.c              | 36 ++++++++++++++++++++++++++++++++++++
 arch/ia64/Kconfig                    |  1 +
 arch/ia64/include/asm/processor.h    | 12 ------------
 arch/ia64/kernel/sys_ia64.c          | 15 +++++++++++++++
 arch/parisc/Kconfig                  |  1 +
 arch/parisc/include/asm/processor.h  | 14 --------------
 arch/parisc/kernel/sys_parisc.c      | 15 +++++++++++++++
 arch/powerpc/Kconfig                 |  1 +
 arch/powerpc/include/asm/processor.h |  6 ------
 arch/powerpc/kernel/process.c        |  6 +++---
 arch/sh/Kconfig                      |  1 +
 arch/sh/include/asm/processor.h      |  7 -------
 arch/sh/mm/alignment.c               |  8 ++++----
 include/linux/prctl.h                |  8 ++++++++
 kernel/sys.c                         | 20 ++++++++++----------
 19 files changed, 100 insertions(+), 80 deletions(-)
 create mode 100644 arch/alpha/kernel/sys.c

diff --git a/arch/Kconfig b/arch/Kconfig
index b34b3e8..a9195ffc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -972,4 +972,7 @@ config REFCOUNT_FULL
 config HAVE_PRCTL_ARCH
 	bool
 
+config HAVE_ARCH_PR_SET_GET_UNALIGN
+	bool
+
 source "kernel/gcov/Kconfig"
diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index b202288..afb9aaa 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -23,6 +23,7 @@ config ALPHA
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_PR_SET_GET_UNALIGN
 	select HAVE_MOD_ARCH_SPECIFIC
 	select MODULES_USE_ELF_RELA
 	select ODD_RT_SIGACTION
diff --git a/arch/alpha/include/asm/thread_info.h b/arch/alpha/include/asm/thread_info.h
index 403b3c8..7ba2099 100644
--- a/arch/alpha/include/asm/thread_info.h
+++ b/arch/alpha/include/asm/thread_info.h
@@ -85,28 +85,5 @@ register struct thread_info *__current_thread_info __asm__("$8");
 #define TS_UAC_NOFIX		0x0002	/* ! flags as they match          */
 #define TS_UAC_SIGBUS		0x0004	/* ! userspace part of 'osf_sysinfo' */
 
-#define SET_UNALIGN_CTL(value)	({					\
-	__u32 status = current_thread_info()->status & ~UAC_BITMASK;	\
-	if (value & PR_UNALIGN_NOPRINT)					\
-		status |= TS_UAC_NOPRINT;				\
-	if (value & PR_UNALIGN_SIGBUS)					\
-		status |= TS_UAC_SIGBUS;				\
-	if (value & 4)	/* alpha-specific */				\
-		status |= TS_UAC_NOFIX;					\
-	current_thread_info()->status = status;				\
-	0; })
-
-#define GET_UNALIGN_CTL(value)	({					\
-	__u32 status = current_thread_info()->status & ~UAC_BITMASK;	\
-	__u32 res = 0;							\
-	if (status & TS_UAC_NOPRINT)					\
-		res |= PR_UNALIGN_NOPRINT;				\
-	if (status & TS_UAC_SIGBUS)					\
-		res |= PR_UNALIGN_SIGBUS;				\
-	if (status & TS_UAC_NOFIX)					\
-		res |= 4;						\
-	put_user(res, (int __user *)(value));				\
-	})
-
 #endif /* __KERNEL__ */
 #endif /* _ALPHA_THREAD_INFO_H */
diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index 5a74581..e4b5294 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -9,7 +9,7 @@ ccflags-y	:= -Wno-sign-compare
 
 obj-y    := entry.o traps.o process.o osf_sys.o irq.o \
 	    irq_alpha.o signal.o setup.o ptrace.o time.o \
-	    systbls.o err_common.o io.o bugs.o
+	    systbls.o err_common.o io.o bugs.o sys.o
 
 obj-$(CONFIG_VGA_HOSE)	+= console.o
 obj-$(CONFIG_SMP)	+= smp.o
diff --git a/arch/alpha/kernel/sys.c b/arch/alpha/kernel/sys.c
new file mode 100644
index 0000000..3dc454f
--- /dev/null
+++ b/arch/alpha/kernel/sys.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/prctl.h>
+#include <linux/thread_info.h>
+#include <linux/uaccess.h>
+
+int arch_set_unalign_ctl(unsigned int val)
+{
+	__u32 status = current_thread_info()->status & ~UAC_BITMASK;
+
+	if (val & PR_UNALIGN_NOPRINT)
+		status |= TS_UAC_NOPRINT;
+	if (val & PR_UNALIGN_SIGBUS)
+		status |= TS_UAC_SIGBUS;
+	if (val & 4)	/* alpha-specific */
+		status |= TS_UAC_NOFIX;
+
+	current_thread_info()->status = status;
+
+	return 0;
+}
+
+int arch_get_unalign_ctl(void)
+{
+	__u32 status = current_thread_info()->status & ~UAC_BITMASK;
+	int res = 0;
+
+	if (status & TS_UAC_NOPRINT)
+		res |= PR_UNALIGN_NOPRINT;
+	if (status & TS_UAC_SIGBUS)
+		res |= PR_UNALIGN_SIGBUS;
+	if (status & TS_UAC_NOFIX)
+		res |= 4;
+
+	return res;
+}
diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index a673dd7..ab62a57 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -55,6 +55,7 @@ config IA64
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_PRCTL_ARCH
+	select HAVE_ARCH_PR_SET_GET_UNALIGN
 	default y
 	help
 	  The Itanium Processor Family is Intel's 64-bit successor to
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 8d5184f..49f4ef9 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -247,18 +247,6 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
-#define SET_UNALIGN_CTL(value)								\
-({												\
-	current->thread.flags = ((current->thread.flags & ~IA64_THREAD_UAC_MASK)			\
-				| (((value) << IA64_THREAD_UAC_SHIFT) & IA64_THREAD_UAC_MASK));	\
-	0;											\
-})
-#define GET_UNALIGN_CTL(addr)								\
-({												\
-	put_user((current->thread.flags & IA64_THREAD_UAC_MASK) >> IA64_THREAD_UAC_SHIFT,	\
-		 (int __user *) (addr));							\
-})
-
 struct thread_struct {
 	__u32 flags;			/* various thread flags (see IA64_THREAD_*) */
 	/* writing on_ustack is performance-critical, so it's worth spending 8 bits on it... */
diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
index d996585..2c2fd65 100644
--- a/arch/ia64/kernel/sys_ia64.c
+++ b/arch/ia64/kernel/sys_ia64.c
@@ -206,3 +206,18 @@ int prctl_arch(int option, unsigned long arg2, unsigned long arg3,
 		return -EINVAL;
 	}
 }
+
+int arch_set_unalign_ctl(unsigned int val)
+{
+	current->thread.flags &= ~IA64_THREAD_UAC_MASK;
+	current->thread.flags |= (val << IA64_THREAD_UAC_SHIFT) &
+		IA64_THREAD_UAC_MASK;
+
+	return 0;
+}
+
+int arch_get_unalign_ctl(void)
+{
+	return (current->thread.flags & IA64_THREAD_UAC_MASK) >>
+		IA64_THREAD_UAC_SHIFT;
+}
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index fc5a574..a2f0f0a 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -44,6 +44,7 @@ config PARISC
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HASH
+	select HAVE_ARCH_PR_SET_GET_UNALIGN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select GENERIC_SCHED_CLOCK
diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index b59720f..dbea6e9 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -139,20 +139,6 @@ struct thread_struct {
 #define PARISC_UAC_SHIFT	0
 #define PARISC_UAC_MASK		(PARISC_UAC_NOPRINT|PARISC_UAC_SIGBUS)
 
-#define SET_UNALIGN_CTL(value)                                            \
-        ({                                                                \
-        current->thread.flags = ((current->thread.flags & ~PARISC_UAC_MASK) \
-                                | (((value) << PARISC_UAC_SHIFT) &        \
-                                   PARISC_UAC_MASK));                     \
-        0;                                                                \
-        })
-
-#define GET_UNALIGN_CTL(addr)                                             \
-        ({                                                                \
-        put_user((current->thread.flags & PARISC_UAC_MASK)                \
-                 >> PARISC_UAC_SHIFT, (int __user *) (addr));             \
-        })
-
 #define INIT_THREAD { \
 	.regs = {	.gr	= { 0, }, \
 			.fr	= { 0, }, \
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 43b308c..e3a7f29 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -30,6 +30,7 @@
 #include <linux/linkage.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/prctl.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/shm.h>
@@ -37,6 +38,7 @@
 #include <linux/utsname.h>
 #include <linux/personality.h>
 #include <linux/random.h>
+#include <asm/processor.h>
 
 /* we construct an artificial offset for the mapping based on the physical
  * address of the kernel mapping variable */
@@ -391,3 +393,16 @@ long parisc_personality(unsigned long personality)
 
 	return err;
 }
+
+int arch_set_unalign_ctl(unsigned int val)
+{
+	current->thread.flags &= ~PARISC_UAC_MASK;
+	current->thread.flags |= (val << PARISC_UAC_SHIFT) & PARISC_UAC_MASK;
+
+	return 0;
+}
+
+int arch_get_unalign_ctl(void)
+{
+	return (current->thread.flags & PARISC_UAC_MASK) >> PARISC_UAC_SHIFT;
+}
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b94323e..68c31fb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -181,6 +181,7 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
+	select HAVE_ARCH_PR_SET_GET_UNALIGN
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index b8d9306..8bac2f6 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -413,12 +413,6 @@ extern int set_fpexc_mode(unsigned int val);
 extern int get_endian(unsigned long adr);
 extern int set_endian(unsigned int val);
 
-#define GET_UNALIGN_CTL(adr)	get_unalign_ctl((adr))
-#define SET_UNALIGN_CTL(val)	set_unalign_ctl((val))
-
-extern int get_unalign_ctl(unsigned long adr);
-extern int set_unalign_ctl(unsigned int val);
-
 extern void load_fp_state(struct thread_fp_state *fp);
 extern void store_fp_state(struct thread_fp_state *fp);
 extern void load_vr_state(struct thread_vr_state *vr);
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 17708b7..a623373 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2020,15 +2020,15 @@ int get_endian(unsigned long adr)
 	return put_user(val, (unsigned int __user *)adr);
 }
 
-int set_unalign_ctl(unsigned int val)
+int arch_set_unalign_ctl(unsigned int val)
 {
 	current->thread.align_ctl = val;
 	return 0;
 }
 
-int get_unalign_ctl(unsigned long adr)
+int arch_get_unalign_ctl(void)
 {
-	return put_user(current->thread.align_ctl, (unsigned int __user *)adr);
+	return current->thread.align_ctl;
 }
 
 static inline int valid_irq_stack(unsigned long sp, struct task_struct *p,
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 97fe293..f9631bf 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -48,6 +48,7 @@ config SUPERH
 	select OLD_SIGSUSPEND
 	select OLD_SIGACTION
 	select HAVE_ARCH_AUDITSYSCALL
+	select HAVE_ARCH_PR_SET_GET_UNALIGN
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_NMI
 	help
diff --git a/arch/sh/include/asm/processor.h b/arch/sh/include/asm/processor.h
index ce3d9f6..ff4d332 100644
--- a/arch/sh/include/asm/processor.h
+++ b/arch/sh/include/asm/processor.h
@@ -116,13 +116,6 @@ extern unsigned int xstate_size;
 extern void free_thread_xstate(struct task_struct *);
 extern struct kmem_cache *task_xstate_cachep;
 
-/* arch/sh/mm/alignment.c */
-extern int get_unalign_ctl(unsigned long addr);
-extern int set_unalign_ctl(unsigned int val);
-
-#define GET_UNALIGN_CTL(addr)	get_unalign_ctl((addr))
-#define SET_UNALIGN_CTL(val)	set_unalign_ctl((val))
-
 /* arch/sh/mm/init.c */
 extern unsigned int mem_init_done;
 
diff --git a/arch/sh/mm/alignment.c b/arch/sh/mm/alignment.c
index bad2a31..63fc963 100644
--- a/arch/sh/mm/alignment.c
+++ b/arch/sh/mm/alignment.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/seq_file.h>
+#include <linux/prctl.h>
 #include <linux/proc_fs.h>
 #include <linux/uaccess.h>
 #include <linux/ratelimit.h>
@@ -80,13 +81,12 @@ unsigned int unaligned_user_action(void)
 	return action;
 }
 
-int get_unalign_ctl(unsigned long addr)
+int arch_get_unalign_ctl(void)
 {
-	return put_user(current->thread.flags & SH_THREAD_UAC_MASK,
-			(unsigned int __user *)addr);
+	return current->thread.flags & SH_THREAD_UAC_MASK;
 }
 
-int set_unalign_ctl(unsigned int val)
+int arch_set_unalign_ctl(unsigned int val)
 {
 	current->thread.flags = (current->thread.flags & ~SH_THREAD_UAC_MASK) |
 				(val & SH_THREAD_UAC_MASK);
diff --git a/include/linux/prctl.h b/include/linux/prctl.h
index 5ce3713..abc803e 100644
--- a/include/linux/prctl.h
+++ b/include/linux/prctl.h
@@ -16,4 +16,12 @@ static inline int prctl_arch(int option, unsigned long arg2,
 }
 #endif
 
+#ifdef CONFIG_HAVE_ARCH_PR_SET_GET_UNALIGN
+extern int arch_set_unalign_ctl(unsigned int val);
+extern int arch_get_unalign_ctl(void);
+#else
+static inline int arch_set_unalign_ctl(unsigned int val) { return -EINVAL; }
+static inline int arch_get_unalign_ctl(void) { return -EINVAL; }
+#endif
+
 #endif /* ! _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 47cf999..562ffbe 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -71,13 +71,6 @@
 
 #include "uid16.h"
 
-#ifndef SET_UNALIGN_CTL
-# define SET_UNALIGN_CTL(a)	(-EINVAL)
-#endif
-#ifndef GET_UNALIGN_CTL
-# define GET_UNALIGN_CTL(a)	(-EINVAL)
-#endif
-
 /*
  * this is where the system-wide overflow UID and GID are defined, for
  * architectures that now have 32-bit UID/GID but didn't in the past
@@ -2235,10 +2228,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		break;
 
 	case PR_SET_UNALIGN:
-		error = SET_UNALIGN_CTL(arg2);
+		error = arch_set_unalign_ctl(arg2);
 		break;
-	case PR_GET_UNALIGN:
-		error = GET_UNALIGN_CTL(arg2);
+	case PR_GET_UNALIGN: {
+		int res;
+
+		res = arch_get_unalign_ctl();
+		if (res >= 0)
+			error = put_user(res, (int __user *)arg2);
+		else
+			error = res;
+		}
 		break;
 	case PR_GET_TIMING:
 		error = PR_TIMING_STATISTICAL;
-- 
2.1.4
