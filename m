From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 2/7] syscalls: introduce CONFIG_ARCH_HAS_SYSCALL_WRAPPER
Date: Fri, 30 Mar 2018 11:37:15 +0200
Message-ID: <20180330093720.6780-3-linux@dominikbrodowski.net>
References: <20180330093720.6780-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330093720.6780-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

It may be useful for an architecture to override the definitions of the
SYSCALL_DEFINE0() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>,
in particular to use a different calling convention for syscalls.

This patch provides a mechanism to do so: It introduces
CONFIG_ARCH_HAS_SYSCALL_WRAPPER. If it is enabled, <asm/sycall_wrapper.h>
is included in <linux/syscalls.h> and may be used to define the macros
mentioned above. Moreover, as the syscall calling convention may be
different if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is set, the syscall function
prototypes in <linux/syscalls.h> are #ifndef'd out in that case.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 include/linux/syscalls.h | 23 +++++++++++++++++++++++
 init/Kconfig             |  7 +++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index b961184f597a..503ab245d4ce 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -81,6 +81,17 @@ union bpf_attr;
 #include <linux/key.h>
 #include <trace/syscall.h>
 
+#ifdef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
+/*
+ * It may be useful for an architecture to override the definitions of the
+ * SYSCALL_DEFINE0() and __SYSCALL_DEFINEx() macros, in particular to use a
+ * different calling convention for syscalls. To allow for that, the prototypes
+ * for the sys_*() functions below will *not* be included if
+ * CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
+ */
+#include <asm/syscall_wrapper.h>
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 /*
  * __MAP - apply a macro to syscall arguments
  * __MAP(n, m, t1, a1, t2, a2, ..., tn, an) will expand to
@@ -189,11 +200,13 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 }
 #endif
 
+#ifndef SYSCALL_DEFINE0
 #define SYSCALL_DEFINE0(sname)					\
 	SYSCALL_METADATA(_##sname, 0);				\
 	asmlinkage long sys_##sname(void);			\
 	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
 	asmlinkage long sys_##sname(void)
+#endif /* SYSCALL_DEFINE0 */
 
 #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
 #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
@@ -209,6 +222,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	__SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
 
 #define __PROTECT(...) asmlinkage_protect(__VA_ARGS__)
+
+#ifndef __SYSCALL_DEFINEx
 #define __SYSCALL_DEFINEx(x, name, ...)					\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(SyS##name))));		\
@@ -223,6 +238,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 		return ret;						\
 	}								\
 	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__))
+#endif /* __SYSCALL_DEFINEx */
 
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
@@ -252,7 +268,12 @@ static inline void addr_limit_user_check(void)
  * Please note that these prototypes here are only provided for information
  * purposes, for static analysis, and for linking from the syscall table.
  * These functions should not be called elsewhere from kernel code.
+ *
+ * As the syscall calling convention may be different from the default
+ * for architectures overriding the syscall calling convention, do not
+ * include the prototypes if CONFIG_ARCH_HAS_SYSCALL_WRAPPER is enabled.
  */
+#ifndef CONFIG_ARCH_HAS_SYSCALL_WRAPPER
 asmlinkage long sys_io_setup(unsigned nr_reqs, aio_context_t __user *ctx);
 asmlinkage long sys_io_destroy(aio_context_t ctx);
 asmlinkage long sys_io_submit(aio_context_t, long,
@@ -1076,6 +1097,8 @@ asmlinkage long sys_old_mmap(struct mmap_arg_struct __user *arg);
  */
 asmlinkage long sys_ni_syscall(void);
 
+#endif /* CONFIG_ARCH_HAS_SYSCALL_WRAPPER */
+
 
 /*
  * Kernel code should not call syscalls (i.e., sys_xyzyyz()) directly.
diff --git a/init/Kconfig b/init/Kconfig
index e37f4b2a6445..6079629be211 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1924,3 +1924,10 @@ source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
+
+# It may be useful for an architecture to override the definitions of the
+# SYSCALL_DEFINE() and __SYSCALL_DEFINEx() macros in <linux/syscalls.h>,
+# in particular to use a different calling convention for syscalls.
+config ARCH_HAS_SYSCALL_WRAPPER
+	def_bool n
+	depends on !COMPAT
-- 
2.16.3
