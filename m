From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 6/7] syscalls/x86: unconditionally enable struct pt_regs based syscalls on x86_64
Date: Fri, 30 Mar 2018 11:37:19 +0200
Message-ID: <20180330093720.6780-7-linux@dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330093720.6780-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Remove CONFIG_SYSCALL_PTREGS from arch/x86/Kconfig and simply select
ARCH_HAS_SYSCALL_WRAPPER unconditionally on x86-64 allows us to simplify
several codepaths.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/Kconfig                      |  6 +-----
 arch/x86/entry/common.c               | 10 ++--------
 arch/x86/entry/syscall_32.c           |  6 +++---
 arch/x86/entry/syscall_64.c           |  5 -----
 arch/x86/entry/vsyscall/vsyscall_64.c | 16 ----------------
 arch/x86/include/asm/syscall.h        |  4 ++--
 arch/x86/include/asm/syscalls.h       | 20 ++++----------------
 7 files changed, 12 insertions(+), 55 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2ad46f7c522c..7c0e135819f1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -29,6 +29,7 @@ config X86_64
 	select HAVE_ARCH_SOFT_DIRTY
 	select MODULES_USE_ELF_RELA
 	select X86_DEV_DMA_OPS
+	select ARCH_HAS_SYSCALL_WRAPPER
 
 #
 # Arch settings
@@ -2957,8 +2958,3 @@ source "crypto/Kconfig"
 source "arch/x86/kvm/Kconfig"
 
 source "lib/Kconfig"
-
-config SYSCALL_PTREGS
-	def_bool y
-	depends on X86_64
-	select ARCH_HAS_SYSCALL_WRAPPER
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 425f798b39e3..fbf6a6c3fd2d 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -284,13 +284,7 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 	nr &= __SYSCALL_MASK;
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
-#ifdef CONFIG_SYSCALL_PTREGS
 		regs->ax = sys_call_table[nr](regs);
-#else
-		regs->ax = sys_call_table[nr](
-			regs->di, regs->si, regs->dx,
-			regs->r10, regs->r8, regs->r9);
-#endif
 	}
 
 	syscall_return_slowpath(regs);
@@ -325,7 +319,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
-#ifdef CONFIG_SYSCALL_PTREGS
+#ifdef CONFIG_IA32_EMULATION
 		regs->ax = ia32_sys_call_table[nr](regs);
 #else
 		/*
@@ -338,7 +332,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 			(unsigned int)regs->bx, (unsigned int)regs->cx,
 			(unsigned int)regs->dx, (unsigned int)regs->si,
 			(unsigned int)regs->di, (unsigned int)regs->bp);
-#endif /* CONFIG_SYSCALL_PTREGS */
+#endif /* CONFIG_IA32_EMULATION */
 	}
 
 	syscall_return_slowpath(regs);
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index bbd8dda36c7d..84901c4ad67b 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -7,17 +7,17 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#ifdef CONFIG_SYSCALL_PTREGS
+#ifdef CONFIG_IA32_EMULATION
 /* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(struct pt_regs *);
 
 /* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
 extern asmlinkage long sys_ni_syscall(struct pt_regs *);
 
-#else /* CONFIG_SYSCALL_PTREGS */
+#else /* CONFIG_IA32_EMULATION */
 #define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-#endif /* CONFIG_SYSCALL_PTREGS */
+#endif /* CONFIG_IA32_EMULATION */
 
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index b4e724777a7d..0ff4de8d9571 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -7,14 +7,9 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#ifdef CONFIG_SYSCALL_PTREGS
 /* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
 extern asmlinkage long sys_ni_syscall(struct pt_regs *);
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(struct pt_regs *);
-#else /* CONFIG_SYSCALL_PTREGS */
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-#endif /* CONFIG_SYSCALL_PTREGS */
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 9fad68899f82..4e08df16d9da 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -227,35 +227,19 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
-#ifdef CONFIG_SYSCALL_PTREGS
 		/* this decodes regs->di and regs->si on its own */
 		ret = sys_gettimeofday(regs);
-#else
-		ret = sys_gettimeofday(
-			(struct timeval __user *)regs->di,
-			(struct timezone __user *)regs->si);
-#endif /* CONFIG_SYSCALL_PTREGS */
 		break;
 
 	case 1:
-#ifdef CONFIG_SYSCALL_PTREGS
 		/* this decodes regs->di on its own */
 		ret = sys_time(regs);
-#else
-		ret = sys_time((time_t __user *)regs->di);
-#endif /* CONFIG_SYSCALL_PTREGS */
 		break;
 
 	case 2:
-#ifdef CONFIG_SYSCALL_PTREGS
 		/* this decodes regs->di, regs->si and regs->dx on its own */
 		regs->dx = 0;
 		ret = sys_getcpu(regs);
-#else
-		ret = sys_getcpu((unsigned __user *)regs->di,
-				 (unsigned __user *)regs->si,
-				 NULL);
-#endif /* CONFIG_SYSCALL_PTREGS */
 		break;
 	}
 
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 8702c7951bc7..0af95296ace8 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -20,13 +20,13 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
-#ifdef CONFIG_SYSCALL_PTREGS
+#ifdef CONFIG_X86_64
 typedef asmlinkage long (*sys_call_ptr_t)(struct pt_regs *);
 #else
 typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
-#endif /* CONFIG_SYSCALL_PTREGS */
+#endif /* CONFIG_X86_64 */
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index e4ad93c05f02..a3aecee89881 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -19,10 +19,10 @@
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
 
-#ifndef CONFIG_SYSCALL_PTREGS
-/*
- * If CONFIG_SYSCALL_PTREGS is enabled, a different syscall calling convention
- * is used. Do not include these -- invalid -- prototypes then
+#ifdef CONFIG_X86_32
+/* 
+ * These definitions are only valid on pure 32bit systems; x86-64 uses a
+ * different syscall calling convention
  */
 asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
 asmlinkage long sys_iopl(unsigned int);
@@ -38,7 +38,6 @@ asmlinkage long sys_set_thread_area(struct user_desc __user *);
 asmlinkage long sys_get_thread_area(struct user_desc __user *);
 
 /* X86_32 only */
-#ifdef CONFIG_X86_32
 
 /* kernel/signal.c */
 asmlinkage long sys_sigreturn(void);
@@ -48,16 +47,5 @@ struct vm86_struct;
 asmlinkage long sys_vm86old(struct vm86_struct __user *);
 asmlinkage long sys_vm86(unsigned long, unsigned long);
 
-#else /* CONFIG_X86_32 */
-
-/* X86_64 only */
-/* kernel/process_64.c */
-asmlinkage long sys_arch_prctl(int, unsigned long);
-
-/* kernel/sys_x86_64.c */
-asmlinkage long sys_mmap(unsigned long, unsigned long, unsigned long,
-			 unsigned long, unsigned long, unsigned long);
-
 #endif /* CONFIG_X86_32 */
-#endif /* CONFIG_SYSCALL_PTREGS */
 #endif /* _ASM_X86_SYSCALLS_H */
-- 
2.16.3
