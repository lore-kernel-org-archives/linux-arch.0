From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 4/3] syscalls/x86: adapt syscall_wrapper.h to the new syscall
 stub naming convention
Date: Sun, 8 Apr 2018 22:06:58 +0200
Message-ID: <20180408200658.GA29848@light.dominikbrodowski.net>
References: <20180407074651.29014-1-linux@dominikbrodowski.net>
 <20180408083550.32d65b6ra6yca5p7@gmail.com>
 <20180408091536.GA10120@light.dominikbrodowski.net>
 <20180408195952.GA27462@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180408195952.GA27462@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Maninder Singh <maninder1.s@samsung.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Make the code in syscall_wrapper.h more readable by naming the stub macros
similar to the stub they provide. While at it, fix a stray newline at the
end of the __IA32_COMPAT_SYS_STUBx macro.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
index bad0295739bf..37ee1985d156 100644
--- a/arch/x86/include/asm/syscall_wrapper.h
+++ b/arch/x86/include/asm/syscall_wrapper.h
@@ -28,15 +28,15 @@
  * kernel/sys_ni.c and SYS_NI in kernel/time/posix-stubs.c to cover this
  * case as well.
  */
-#define COMPAT_SC_IA32_STUBx(x, name, ...)				\
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__ia32_compat_sys##name, ERRNO);		\
 	asmlinkage long __ia32_compat_sys##name(const struct pt_regs *regs)\
 	{								\
 		return __do_compat_sys##name(SC_IA32_REGS_TO_ARGS(x,__VA_ARGS__));\
-	}								\
+	}
 
-#define SC_IA32_WRAPPERx(x, name, ...)					\
+#define __IA32_SYS_STUBx(x, name, ...)					\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs);	\
 	ALLOW_ERROR_INJECTION(__ia32_sys##name, ERRNO);			\
 	asmlinkage long __ia32_sys##name(const struct pt_regs *regs)	\
@@ -64,8 +64,8 @@
 	SYSCALL_ALIAS(__ia32_sys_##name, sys_ni_posix_timers)
 
 #else /* CONFIG_IA32_EMULATION */
-#define COMPAT_SC_IA32_STUBx(x, name, ...)
-#define SC_IA32_WRAPPERx(x, fullname, name, ...)
+#define __IA32_COMPAT_SYS_STUBx(x, name, ...)
+#define __IA32_SYS_STUBx(x, fullname, name, ...)
 #endif /* CONFIG_IA32_EMULATION */
 
 
@@ -75,7 +75,7 @@
  * of the x86-64-style parameter ordering of x32 syscalls. The syscalls common
  * with x86_64 obviously do not need such care.
  */
-#define COMPAT_SC_X32_STUBx(x, name, ...)				\
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)				\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs);\
 	ALLOW_ERROR_INJECTION(__x32_compat_sys##name, ERRNO);		\
 	asmlinkage long __x32_compat_sys##name(const struct pt_regs *regs)\
@@ -84,7 +84,7 @@
 	}								\
 
 #else /* CONFIG_X86_X32 */
-#define COMPAT_SC_X32_STUBx(x, name, ...)
+#define __X32_COMPAT_SYS_STUBx(x, name, ...)
 #endif /* CONFIG_X86_X32 */
 
 
@@ -97,8 +97,8 @@
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)					\
 	static long __do_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
 	static inline long __in_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
-	COMPAT_SC_IA32_STUBx(x, name, __VA_ARGS__)				\
-	COMPAT_SC_X32_STUBx(x, name, __VA_ARGS__)				\
+	__IA32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
+	__X32_COMPAT_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __do_compat_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{									\
 		return __in_compat_sys##name(__MAP(x,__SC_DELOUSE,__VA_ARGS__));\
@@ -163,7 +163,7 @@
 	{								\
 		return __do_sys##name(SC_X86_64_REGS_TO_ARGS(x,__VA_ARGS__));\
 	}								\
-	SC_IA32_WRAPPERx(x, name, __VA_ARGS__)				\
+	__IA32_SYS_STUBx(x, name, __VA_ARGS__)				\
 	static long __do_sys##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
 	{								\
 		long ret = __in_sys##name(__MAP(x,__SC_CAST,__VA_ARGS__));\
