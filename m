From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 3/7] syscalls/x86: use struct pt_regs based syscall calling for 64bit syscalls
Date: Fri, 30 Mar 2018 11:37:16 +0200
Message-ID: <20180330093720.6780-4-linux@dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330093720.6780-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Let's make use of ARCH_HAS_SYSCALL_WRAPPER on pure 64bit x86-64 systems:

Each syscall defines a stub which takes struct pt_regs as its only
argument. It decodes just those parameters it needs, e.g:

	asmlinkage long sys_xyzzy(struct pt_regs *regs)
	{
		return SyS_xyzzy(regs->di, regs->si, regs->dx);
	}

This approach avoids leaking random user-provided register content down
the call chain.

For example, for sys_recv() which is a 4-parameter syscall, the assembly
now is (in slightly reordered fashion):

	<sys_recv>:
		callq	<__fentry__>

		/* decode regs->di, ->si, ->dx and ->r10 */
		mov	0x70(%rdi),%rdi
		mov	0x68(%rdi),%rsi
		mov	0x60(%rdi),%rdx
		mov	0x38(%rdi),%rcx

		[ SyS_recv() is automatically inlined by the compiler,
		  as it is not [yet] used anywhere else ]
		/* clear %r9 and %r8, the 5th and 6th args */
		xor	%r9d,%r9d
		xor	%r8d,%r8d

		/* do the actual work */
		callq	__sys_recvfrom

		/* cleanup and return */
		cltq
		retq

The only valid place in an x86-64 kernel which rightfully calls
a syscall function on its own -- vsyscall -- needs to be modified
to pass struct pt_regs onwards as well.

This patch is based on an original proof-of-concept

	From: Linus Torvalds <torvalds@linux-foundation.org>
	Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

and was split up and heavily modified by me, in particular to base it on
ARCH_HAS_SYSCALL_WRAPPER, to limit it to 64bit-only for the time being,
 and to update the vsyscall to the new calling convention.

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
 arch/x86/Kconfig                       |  5 +++
 arch/x86/entry/common.c                |  4 ++
 arch/x86/entry/syscall_64.c            |  9 ++++-
 arch/x86/entry/vsyscall/vsyscall_64.c  | 16 ++++++++
 arch/x86/include/asm/syscall.h         |  4 ++
 arch/x86/include/asm/syscall_wrapper.h | 69 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/syscalls.h        |  7 ++++
 include/linux/syscalls.h               |  2 +-
 8 files changed, 113 insertions(+), 3 deletions(-)
 create mode 100644 arch/x86/include/asm/syscall_wrapper.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 0fa71a78ec99..a5db03705452 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2957,3 +2957,8 @@ source "crypto/Kconfig"
 source "arch/x86/kvm/Kconfig"
 
 source "lib/Kconfig"
+
+config SYSCALL_PTREGS
+	def_bool y
+	depends on X86_64 && !COMPAT
+	select ARCH_HAS_SYSCALL_WRAPPER
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index a8b066dbbf48..e1b91bffa988 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -284,9 +284,13 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
 	nr &= __SYSCALL_MASK;
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
+#ifdef CONFIG_SYSCALL_PTREGS
+		regs->ax = sys_call_table[nr](regs);
+#else
 		regs->ax = sys_call_table[nr](
 			regs->di, regs->si, regs->dx,
 			regs->r10, regs->r8, regs->r9);
+#endif
 	}
 
 	syscall_return_slowpath(regs);
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index c176d2fab1da..b4e724777a7d 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -7,14 +7,19 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
+#ifdef CONFIG_SYSCALL_PTREGS
+/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
+extern asmlinkage long sys_ni_syscall(struct pt_regs *);
+#define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(struct pt_regs *);
+#else /* CONFIG_SYSCALL_PTREGS */
+extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #define __SYSCALL_64(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#endif /* CONFIG_SYSCALL_PTREGS */
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
 #define __SYSCALL_64(nr, sym, qual) [nr] = sym,
 
-extern long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 8560ef68a9d6..9fad68899f82 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -227,19 +227,35 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
+#ifdef CONFIG_SYSCALL_PTREGS
+		/* this decodes regs->di and regs->si on its own */
+		ret = sys_gettimeofday(regs);
+#else
 		ret = sys_gettimeofday(
 			(struct timeval __user *)regs->di,
 			(struct timezone __user *)regs->si);
+#endif /* CONFIG_SYSCALL_PTREGS */
 		break;
 
 	case 1:
+#ifdef CONFIG_SYSCALL_PTREGS
+		/* this decodes regs->di on its own */
+		ret = sys_time(regs);
+#else
 		ret = sys_time((time_t __user *)regs->di);
+#endif /* CONFIG_SYSCALL_PTREGS */
 		break;
 
 	case 2:
+#ifdef CONFIG_SYSCALL_PTREGS
+		/* this decodes regs->di, regs->si and regs->dx on its own */
+		regs->dx = 0;
+		ret = sys_getcpu(regs);
+#else
 		ret = sys_getcpu((unsigned __user *)regs->di,
 				 (unsigned __user *)regs->si,
 				 NULL);
+#endif /* CONFIG_SYSCALL_PTREGS */
 		break;
 	}
 
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index 03eedc21246d..8702c7951bc7 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -20,9 +20,13 @@
 #include <asm/thread_info.h>	/* for TS_COMPAT */
 #include <asm/unistd.h>
 
+#ifdef CONFIG_SYSCALL_PTREGS
+typedef asmlinkage long (*sys_call_ptr_t)(struct pt_regs *);
+#else
 typedef asmlinkage long (*sys_call_ptr_t)(unsigned long, unsigned long,
 					  unsigned long, unsigned long,
 					  unsigned long, unsigned long);
+#endif /* CONFIG_SYSCALL_PTREGS */
 extern const sys_call_ptr_t sys_call_table[];
 
 #if defined(CONFIG_X86_32)
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
new file mode 100644
index 000000000000..ca928adf4a53
--- /dev/null
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * syscall_wrapper.h - x86 specific wrappers to syscall definitions
+ */
+
+#ifndef _ASM_X86_SYSCALL_WRAPPER_H
+#define _ASM_X86_SYSCALL_WRAPPER_H
+
+/*
+ * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
+ * struct pt_regs *regs as the only argument of the syscall stub named
+ * sys_*(). It decodes just the registers it needs and passes them on to
+ * the SyS_*() wrapper and then to the SYSC_*() function doing the actual job.
+ * These wrappers and functions are inlined, meaning that the assembly looks
+ * as follows (slightly re-ordered):
+ *
+ * <sys_recv>:			<-- syscall with 4 parameters
+ *	callq	<__fentry__>
+ *
+ *	mov	0x70(%rdi),%rdi	<-- decode regs->di
+ *	mov	0x68(%rdi),%rsi	<-- decode regs->si
+ *	mov	0x60(%rdi),%rdx	<-- decode regs->dx
+ *	mov	0x38(%rdi),%rcx	<-- decode regs->r10
+ *
+ *	xor	%r9d,%r9d	<-- clear %r9
+ *	xor	%r8d,%r8d	<-- clear %r8
+ *
+ *	callq	__sys_recvfrom	<-- do the actual work in __sys_recvfrom()
+ *				    which takes 6 arguments
+ *
+ *	cltq			<-- extend return value to 64bit
+ *	retq			<-- return
+ *
+ * This approach avoids leaking random user-provided register content down
+ * the call chain.
+ *
+ * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
+ * obvious reasons, there is no need to override it.
+ */
+#define __SYSCALL_DEFINEx(x, name, ...)					\
+	asmlinkage long sys##name(struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
+	static long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));		\
+	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
+	asmlinkage long sys##name(struct pt_regs *regs)			\
+	{								\
+		return SyS##name(__MAP(x,__SC_ARGS			\
+			,,regs->di,,regs->si,,regs->dx			\
+			,,regs->r10,,regs->r8,,regs->r9));		\
+	}								\
+	static long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{								\
+		long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
+		__MAP(x,__SC_TEST,__VA_ARGS__);				\
+		__PROTECT(x, ret,__MAP(x,__SC_ARGS,__VA_ARGS__));	\
+		return ret;						\
+	}								\
+	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+/*
+ * for VSYSCALLS, we need to declare these three syscalls with the new
+ * pt_regs-based calling convention for in-kernel use.
+ */
+struct pt_regs;
+asmlinkage long sys_getcpu(struct pt_regs *regs);	/* di, si, dx */
+asmlinkage long sys_gettimeofday(struct pt_regs *regs); /* di, si */
+asmlinkage long sys_time(struct pt_regs *regs);		/* di */
+
+#endif /* _ASM_X86_SYSCALL_WRAPPER_H */
diff --git a/arch/x86/include/asm/syscalls.h b/arch/x86/include/asm/syscalls.h
index ae6e05fdc24b..e4ad93c05f02 100644
--- a/arch/x86/include/asm/syscalls.h
+++ b/arch/x86/include/asm/syscalls.h
@@ -18,6 +18,12 @@
 /* Common in X86_32 and X86_64 */
 /* kernel/ioport.c */
 long ksys_ioperm(unsigned long from, unsigned long num, int turn_on);
+
+#ifndef CONFIG_SYSCALL_PTREGS
+/*
+ * If CONFIG_SYSCALL_PTREGS is enabled, a different syscall calling convention
+ * is used. Do not include these -- invalid -- prototypes then
+ */
 asmlinkage long sys_ioperm(unsigned long, unsigned long, int);
 asmlinkage long sys_iopl(unsigned int);
 
@@ -53,4 +59,5 @@ asmlinkage long sys_mmap(unsigned long, unsigned long, unsigned long,
 			 unsigned long, unsigned long, unsigned long);
 
 #endif /* CONFIG_X86_32 */
+#endif /* CONFIG_SYSCALL_PTREGS */
 #endif /* _ASM_X86_SYSCALLS_H */
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 503ab245d4ce..d7168b3a4b4c 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -102,7 +102,7 @@ union bpf_attr;
  * for SYSCALL_DEFINE<n>/COMPAT_SYSCALL_DEFINE<n>
  */
 #define __MAP0(m,...)
-#define __MAP1(m,t,a) m(t,a)
+#define __MAP1(m,t,a,...) m(t,a)
 #define __MAP2(m,t,a,...) m(t,a), __MAP1(m,__VA_ARGS__)
 #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
 #define __MAP4(m,t,a,...) m(t,a), __MAP3(m,__VA_ARGS__)
-- 
2.16.3
