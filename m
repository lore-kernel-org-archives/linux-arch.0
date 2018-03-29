From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH 106/109] syscalls/x86: auto-create compat_sys_*() prototypes
Date: Thu, 29 Mar 2018 13:24:23 +0200
Message-ID: <20180329112426.23043-107-linux@dominikbrodowski.net>
References: <20180329112426.23043-1-linux@dominikbrodowski.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180329112426.23043-1-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: viro@ZenIV.linux.org.uk, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

compat_sys_*() functions are no longer called from within the kernel on
x86 except from the system call table. Linking the system call does not
require compat_sys_*() function prototypes at least on x86. Therefore,
generate compat_sys_*() prototypes on-the-fly within the
COMPAT_SYSCALL_DEFINEx() macro, and remove x86-specific prototypes from
various header files.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David S. Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: x86@kernel.org
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 arch/x86/ia32/ia32_signal.c     |  1 -
 arch/x86/ia32/sys_ia32.c        |  2 +-
 arch/x86/include/asm/sys_ia32.h | 64 -----------------------------------------
 include/linux/compat.h          | 17 ++---------
 4 files changed, 4 insertions(+), 80 deletions(-)
 delete mode 100644 arch/x86/include/asm/sys_ia32.h

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 41c671854642..86b1341cba9a 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -33,7 +33,6 @@
 #include <asm/vdso.h>
 #include <asm/sigframe.h>
 #include <asm/sighandling.h>
-#include <asm/sys_ia32.h>
 #include <asm/smap.h>
 
 /*
diff --git a/arch/x86/ia32/sys_ia32.c b/arch/x86/ia32/sys_ia32.c
index bd8a7020b9a7..11ef7b7c9cc8 100644
--- a/arch/x86/ia32/sys_ia32.c
+++ b/arch/x86/ia32/sys_ia32.c
@@ -47,7 +47,7 @@
 #include <linux/uaccess.h>
 #include <linux/atomic.h>
 #include <asm/vgtod.h>
-#include <asm/sys_ia32.h>
+#include <asm/ia32.h>
 
 #define AA(__x)		((unsigned long)(__x))
 
diff --git a/arch/x86/include/asm/sys_ia32.h b/arch/x86/include/asm/sys_ia32.h
deleted file mode 100644
index 2ee6e3b96656..000000000000
--- a/arch/x86/include/asm/sys_ia32.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * sys_ia32.h - Linux ia32 syscall interfaces
- *
- * Copyright (c) 2008 Jaswinder Singh Rajput
- *
- * This file is released under the GPLv2.
- * See the file COPYING for more details.
- */
-
-#ifndef _ASM_X86_SYS_IA32_H
-#define _ASM_X86_SYS_IA32_H
-
-#ifdef CONFIG_COMPAT
-
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <linux/types.h>
-#include <linux/signal.h>
-#include <asm/compat.h>
-#include <asm/ia32.h>
-
-/* ia32/sys_ia32.c */
-asmlinkage long compat_sys_x86_truncate64(const char __user *, unsigned long,
-					  unsigned long);
-asmlinkage long compat_sys_x86_ftruncate64(unsigned int, unsigned long,
-					   unsigned long);
-
-asmlinkage long compat_sys_x86_stat64(const char __user *,
-				      struct stat64 __user *);
-asmlinkage long compat_sys_x86_lstat64(const char __user *,
-				       struct stat64 __user *);
-asmlinkage long compat_sys_x86_fstat64(unsigned int, struct stat64 __user *);
-asmlinkage long compat_sys_x86_fstatat(unsigned int, const char __user *,
-			      struct stat64 __user *, int);
-struct mmap_arg_struct32;
-asmlinkage long compat_sys_x86_mmap(struct mmap_arg_struct32 __user *);
-
-asmlinkage long compat_sys_x86_pread(unsigned int, char __user *, u32, u32,
-				     u32);
-asmlinkage long compat_sys_x86_pwrite(unsigned int, const char __user *, u32,
-				      u32, u32);
-
-asmlinkage long compat_sys_x86_fadvise64_64(int, __u32, __u32, __u32, __u32,
-					    int);
-
-asmlinkage ssize_t compat_sys_x86_readahead(int, unsigned int, unsigned int,
-					    size_t);
-asmlinkage long compat_sys_x86_sync_file_range(int, unsigned int, unsigned int,
-					       unsigned int, unsigned int,
-					       int);
-asmlinkage long compat_sys_x86_fadvise64(int, unsigned int, unsigned int,
-					 size_t, int);
-asmlinkage long compat_sys_x86_fallocate(int, int, unsigned int, unsigned int,
-					 unsigned int, unsigned int);
-asmlinkage long compat_sys_x86_clone(unsigned long, unsigned long, int __user *,
-				     unsigned long, int __user *);
-
-/* ia32/ia32_signal.c */
-asmlinkage long sys32_sigreturn(void);
-asmlinkage long sys32_rt_sigreturn(void);
-
-#endif /* CONFIG_COMPAT */
-
-#endif /* _ASM_X86_SYS_IA32_H */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index f881cce627f6..8cb8710db0ab 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -49,6 +49,7 @@
 	COMPAT_SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
 
 #define COMPAT_SYSCALL_DEFINEx(x, name, ...)				\
+	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))\
 		__attribute__((alias(__stringify(compat_SyS##name))));  \
 	static inline long C_SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));\
@@ -507,8 +508,8 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 
 /*
  * These syscall function prototypes are kept in the same order as
- * include/uapi/asm-generic/unistd.h. Architecture specific entries go below,
- * followed by deprecated or obsolete system calls.
+ * include/uapi/asm-generic/unistd.h. Deprecated or obsolete system calls
+ * go below.
  *
  * Please note that these prototypes here are only provided for information
  * purposes, for static analysis, and for linking from the syscall table.
@@ -882,18 +883,6 @@ asmlinkage long compat_sys_pwritev64v2(unsigned long fd,
 #endif
 
 
-/*
- * Architecture-specific system calls
- */
-
-/* fs/quota/compat.c -- x86 only */
-asmlinkage long compat_sys_quotactl32(unsigned int cmd,
-		const char __user *special, qid_t id, void __user *addr);
-
-/* arch_prctl -- x86 */
-asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);
-
-
 /*
  * Deprecated system calls which are still defined in
  * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
-- 
2.16.3
