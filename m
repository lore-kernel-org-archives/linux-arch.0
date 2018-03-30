From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 5/7] syscalls/x86: use struct pt_regs based syscall calling for IA32_EMULATION and x32
Date: Fri, 30 Mar 2018 11:37:18 +0200
Message-ID: <20180330093720.6780-6-linux@dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330093720.6780-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-arch.vger.kernel.org

Extend ARCH_HAS_SYSCALL_WRAPPER for i386 emulation and for x32 on 64-bit
x86.

For x32, all we need to do is to create an additional stub for each
compat syscall which decodes the parameters in x86-64 ordering, e.g.:

	asmlinkage long __compat_sys_x32_xyzzy(struct pt_regs *regs)
	{
		return c_SyS_xyzzy(regs->di, regs->si, regs->dx);
	}

For i386 emulation, we need to teach compat_sys_*() to take struct
pt_regs as its only argument, e.g.:

	asmlinkage long compat_sys_xyzzy(struct pt_regs *regs)
	{
		return c_SyS_xyzzy(regs->bx, regs->cx, regs->dx);
	}

In addition, we need to create additional stubs for common syscalls
(that is, for syscalls which have the same parameters on 32bit and 64bit),
e.g.:

	asmlinkage long __sys32_ia32_xyzzy(struct pt_regs *regs)
	{
		return c_sys_xyzzy(regs->bx, regs->cx, regs->dx);
	}

This approach avoids leaking random user-provided register content down
the call chain.

This patch is based on an original proof-of-concept

        From: Linus Torvalds <torvalds@linux-foundation.org>
        Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

and was split up and heavily modified by me, in particular to base it on
ARCH_HAS_SYSCALL_WRAPPER.

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
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/Kconfig                       |   2 +-
 arch/x86/entry/common.c                |   4 ++
 arch/x86/entry/syscall_32.c            |  15 +++-
 arch/x86/entry/syscalls/syscall_64.tbl |  74 +++++++++----------
 arch/x86/entry/syscalls/syscalltbl.sh  |   8 +++
 arch/x86/include/asm/syscall_wrapper.h | 128 +++++++++++++++++++++++++++++++--
 6 files changed, 187 insertions(+), 44 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a5db03705452..2ad46f7c522c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2960,5 +2960,5 @@ source "lib/Kconfig"
 
 config SYSCALL_PTREGS
 	def_bool y
-	depends on X86_64 && !COMPAT
+	depends on X86_64
 	select ARCH_HAS_SYSCALL_WRAPPER
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e1b91bffa988..425f798b39e3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -325,6 +325,9 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
+#ifdef CONFIG_SYSCALL_PTREGS
+		regs->ax = ia32_sys_call_table[nr](regs);
+#else
 		/*
 		 * It's possible that a 32-bit syscall implementation
 		 * takes a 64-bit parameter but nonetheless assumes that
@@ -335,6 +338,7 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
 			(unsigned int)regs->bx, (unsigned int)regs->cx,
 			(unsigned int)regs->dx, (unsigned int)regs->si,
 			(unsigned int)regs->di, (unsigned int)regs->bp);
+#endif /* CONFIG_SYSCALL_PTREGS */
 	}
 
 	syscall_return_slowpath(regs);
diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 95c294963612..bbd8dda36c7d 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -7,14 +7,23 @@
 #include <asm/asm-offsets.h>
 #include <asm/syscall.h>
 
-#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long) ;
+#ifdef CONFIG_SYSCALL_PTREGS
+/* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
+#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(struct pt_regs *);
+
+/* this is a lie, but it does not hurt as sys_ni_syscall just returns -EINVAL */
+extern asmlinkage long sys_ni_syscall(struct pt_regs *);
+
+#else /* CONFIG_SYSCALL_PTREGS */
+#define __SYSCALL_I386(nr, sym, qual) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
+#endif /* CONFIG_SYSCALL_PTREGS */
+
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
 
 #define __SYSCALL_I386(nr, sym, qual) [nr] = sym,
 
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_syscall_compat_max+1] = {
 	/*
 	 * Smells like a compiler bug -- it doesn't work
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 5aef183e2f85..a83c0f7f462f 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -342,41 +342,43 @@
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-# for native 64-bit operation.
+# for native 64-bit operation. The __compat_sys_x32 stubs are created
+# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
+# is defined.
 #
-512	x32	rt_sigaction		compat_sys_rt_sigaction
+512	x32	rt_sigaction		__compat_sys_x32_rt_sigaction
 513	x32	rt_sigreturn		sys32_x32_rt_sigreturn
-514	x32	ioctl			compat_sys_ioctl
-515	x32	readv			compat_sys_readv
-516	x32	writev			compat_sys_writev
-517	x32	recvfrom		compat_sys_recvfrom
-518	x32	sendmsg			compat_sys_sendmsg
-519	x32	recvmsg			compat_sys_recvmsg
-520	x32	execve			compat_sys_execve/ptregs
-521	x32	ptrace			compat_sys_ptrace
-522	x32	rt_sigpending		compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait
-524	x32	rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-525	x32	sigaltstack		compat_sys_sigaltstack
-526	x32	timer_create		compat_sys_timer_create
-527	x32	mq_notify		compat_sys_mq_notify
-528	x32	kexec_load		compat_sys_kexec_load
-529	x32	waitid			compat_sys_waitid
-530	x32	set_robust_list		compat_sys_set_robust_list
-531	x32	get_robust_list		compat_sys_get_robust_list
-532	x32	vmsplice		compat_sys_vmsplice
-533	x32	move_pages		compat_sys_move_pages
-534	x32	preadv			compat_sys_preadv64
-535	x32	pwritev			compat_sys_pwritev64
-536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		compat_sys_recvmmsg
-538	x32	sendmmsg		compat_sys_sendmmsg
-539	x32	process_vm_readv	compat_sys_process_vm_readv
-540	x32	process_vm_writev	compat_sys_process_vm_writev
-541	x32	setsockopt		compat_sys_setsockopt
-542	x32	getsockopt		compat_sys_getsockopt
-543	x32	io_setup		compat_sys_io_setup
-544	x32	io_submit		compat_sys_io_submit
-545	x32	execveat		compat_sys_execveat/ptregs
-546	x32	preadv2			compat_sys_preadv64v2
-547	x32	pwritev2		compat_sys_pwritev64v2
+514	x32	ioctl			__compat_sys_x32_ioctl
+515	x32	readv			__compat_sys_x32_readv
+516	x32	writev			__compat_sys_x32_writev
+517	x32	recvfrom		__compat_sys_x32_recvfrom
+518	x32	sendmsg			__compat_sys_x32_sendmsg
+519	x32	recvmsg			__compat_sys_x32_recvmsg
+520	x32	execve			__compat_sys_x32_execve/ptregs
+521	x32	ptrace			__compat_sys_x32_ptrace
+522	x32	rt_sigpending		__compat_sys_x32_rt_sigpending
+523	x32	rt_sigtimedwait		__compat_sys_x32_rt_sigtimedwait
+524	x32	rt_sigqueueinfo		__compat_sys_x32_rt_sigqueueinfo
+525	x32	sigaltstack		__compat_sys_x32_sigaltstack
+526	x32	timer_create		__compat_sys_x32_timer_create
+527	x32	mq_notify		__compat_sys_x32_mq_notify
+528	x32	kexec_load		__compat_sys_x32_kexec_load
+529	x32	waitid			__compat_sys_x32_waitid
+530	x32	set_robust_list		__compat_sys_x32_set_robust_list
+531	x32	get_robust_list		__compat_sys_x32_get_robust_list
+532	x32	vmsplice		__compat_sys_x32_vmsplice
+533	x32	move_pages		__compat_sys_x32_move_pages
+534	x32	preadv			__compat_sys_x32_preadv64
+535	x32	pwritev			__compat_sys_x32_pwritev64
+536	x32	rt_tgsigqueueinfo	__compat_sys_x32_rt_tgsigqueueinfo
+537	x32	recvmmsg		__compat_sys_x32_recvmmsg
+538	x32	sendmmsg		__compat_sys_x32_sendmmsg
+539	x32	process_vm_readv	__compat_sys_x32_process_vm_readv
+540	x32	process_vm_writev	__compat_sys_x32_process_vm_writev
+541	x32	setsockopt		__compat_sys_x32_setsockopt
+542	x32	getsockopt		__compat_sys_x32_getsockopt
+543	x32	io_setup		__compat_sys_x32_io_setup
+544	x32	io_submit		__compat_sys_x32_io_submit
+545	x32	execveat		__compat_sys_x32_execveat/ptregs
+546	x32	preadv2			__compat_sys_x32_preadv64v2
+547	x32	pwritev2		__compat_sys_x32_pwritev64v2
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index d71ef4bd3615..4e468f16cb3b 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -49,6 +49,14 @@ emit() {
 grep '^[0-9]' "$in" | sort -n | (
     while read nr abi name entry compat; do
 	abi=`echo "$abi" | tr '[a-z]' '[A-Z]'`
+
+	# auto-create i386 stubs for struct pt_regs calling convention
+	if [ -n "$entry" -a "$abi" = "I386" -a -z "$compat" ]; then
+	    if [ "$entry" != "sys_ni_syscall" ]; then
+		compat="__sys32_ia32_${entry#sys_}"
+	    fi
+	fi
+
 	if [ "$abi" = "COMMON" -o "$abi" = "64" ]; then
 	    # COMMON is the same as 64, except that we don't expect X32
 	    # programs to use it.  Our expectation has nothing to do with
diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index ca928adf4a53..6629a22b542c 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -6,6 +6,122 @@
 #ifndef _ASM_X86_SYSCALL_WRAPPER_H
 #define _ASM_X86_SYSCALL_WRAPPER_H
 
+/* Mapping of registers to parameters for syscalls on x86-64 and x32 */
+#define SC_X86_64_REGS_TO_ARGS(x, ...)					\
+	__MAP(x,__SC_ARGS						\
+		,,regs->di,,regs->si,,regs->dx				\
+		,,regs->r10,,regs->r8,,regs->r9)			\
+
+/* Mapping of registers to parameters for syscalls on i386 */
+#define SC_IA32_REGS_TO_ARGS(x, ...)					\
+	__MAP(x,__SC_ARGS						\
+	      ,,(unsigned int)regs->bx,,(unsigned int)regs->cx		\
+	      ,,(unsigned int)regs->dx,,(unsigned int)regs->si		\
+	      ,,(unsigned int)regs->di,,(unsigned int)regs->bp)
+
+#ifdef CONFIG_IA32_EMULATION
+/*
+ * For IA32 emulation, we need to handle "compat" syscalls *and* create
+ * additional wrappers (aptly named __sys32_ia32_sys_xyzzy) which decode
+ * the ia32 regs in the proper order for shared or "common" syscalls. As
+ * some syscalls may not be implemented, we need to expand COND_SYSCALL in
+ * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
+ * case as well.
+ */
+#define COMPAT_SC_IA32_STUBx(x, name, ...)				\
+	asmlinkage long compat_sys##name(struct pt_regs *regs);		\
+	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);			\
+	asmlinkage long compat_sys##name(struct pt_regs *regs)		\
+	{								\
+		return c_SyS##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}								\
+
+#define SC_IA32_WRAPPERx(x, name, ...)					\
+	asmlinkage long __sys32_ia32##name(struct pt_regs *regs);	\
+	asmlinkage long __sys32_ia32##name(struct pt_regs *regs)	\
+	{								\
+		return SyS##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));	\
+	}
+
+#define COND_SYSCALL(name)						\
+	cond_syscall(sys_##name);					\
+	cond_syscall(__sys32_ia32_##name)
+
+#define SYS_NI(name)							\
+	SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers);			\
+	SYSCALL_ALIAS(__sys32_ia32_##name, sys_ni_posix_timers)
+
+/*
+ * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
+ * obvious reasons, it does not care about struct pt_regs. There is a need,
+ * however, to create an alias named __sys32_ia32_sys*() if IA32_EMULATION
+ * is enabled
+ */
+#define SYSCALL_DEFINE0(sname)						\
+	SYSCALL_METADATA(_##sname, 0);					\
+	asmlinkage long sys_##sname(void);				\
+	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);			\
+	asmlinkage long __sys32_ia32_##sname(void)			\
+		__attribute__((alias(__stringify(sys_##sname))));	\
+	asmlinkage long sys_##sname(void)
+
+#else /* CONFIG_IA32_EMULATION */
+#define COMPAT_SC_IA32_STUBx(x, name, ...)
+#define SC_IA32_WRAPPERx(x, fullname, name, ...)
+#endif /* CONFIG_IA32_EMULATION */
+
+
+#ifdef CONFIG_X86_X32
+/*
+ * For the x32 ABI, we need to create a stub for compat_sys_*() which is aware
+ * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
+ * with x86_64 obviously do not need such care.
+ */
+#define COMPAT_SC_X32_STUBx(x, name, ...)				\
+	asmlinkage long __compat_sys_x32##name(struct pt_regs *regs);	\
+	ALLOW_ERROR_INJECTION(__compat_sys_x32##name, ERRNO);		\
+	asmlinkage long __compat_sys_x32##name(struct pt_regs *regs)	\
+	{								\
+		return c_SyS##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
+	}								\
+
+/* As some compat syscalls may not be implemented, we need to expand
+ * COND_SYSCALL_COMPAT in kernel/sys_ni.c and COMPAT_SYS_NI in
+ * kernel/time/posix-stubs.c to cover this case as well.
+ */
+#define COND_SYSCALL_COMPAT(name) 					\
+	cond_syscall(compat_sys_##name);				\
+	cond_syscall(__compat_sys_x32_##name)
+
+#define COMPAT_SYS_NI(name)						\
+	SYSCALL_ALIAS(compat_sys_##name, sys_ni_posix_timers);		\
+	SYSCALL_ALIAS(__compat_sys_x32_##name, sys_ni_posix_timers)
+
+#else /* CONFIG_X86_X32 */
+#define COMPAT_SC_X32_STUBx(x, name, ...)
+#endif /* CONFIG_X86_X32 */
+
+
+#ifdef CONFIG_COMPAT
+/*
+ * Compat means IA32_EMULATION and/or X86_X32. As they use a different
+ * mapping of registers to parameters, we need to generate stubs for each
+ * of them. 
+ */
+#define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
+	static long c_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
+	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
+	COMPAT_SC_IA32_STUBx(x, name, __VA_ARGS__)			\
+	COMPAT_SC_X32_STUBx(x, name, __VA_ARGS__)			\
+	static long c_SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
+	{								\
+		return C_SYSC##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));	\
+	}								\
+	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+
+#endif /* CONFIG_COMPAT */
+
+
 /*
  * Instead of the generic __SYSCALL_DEFINEx() definition, this macro takes
  * struct pt_regs *regs as the only argument of the syscall stub named
@@ -34,8 +150,13 @@
  * This approach avoids leaking random user-provided register content down
  * the call chain.
  *
+ * If IA32_EMULATION is enabled, this macro generates an additional wrapper
+ * named __sys32_ia32_*() which decodes the struct pt_regs *regs according
+ * to the i386 calling convention (bx, cx, dx, si, di, bp).
+ *
  * As the generic SYSCALL_DEFINE0() macro does not decode any parameters for
- * obvious reasons, there is no need to override it.
+ * obvious reasons, there is no need to override it unless IA32_EMULATION is
+ * enabled (see above).
  */
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(struct pt_regs *regs);		\
@@ -44,10 +165,9 @@
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
 	asmlinkage long sys##name(struct pt_regs *regs)			\
 	{								\
-		return SyS##name(__MAP(x,__SC_ARGS			\
-			,,regs->di,,regs->si,,regs->dx			\
-			,,regs->r10,,regs->r8,,regs->r9));		\
+		return SyS##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
+	SC_IA32_WRAPPERx(x, name, __VA_ARGS__)				\
 	static long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))		\
 	{								\
 		long ret = SYSC##name(__MAP(x,__SC_CAST,__VA_ARGS__));	\
-- 
2.16.3
