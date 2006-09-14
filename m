Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:33952 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932072AbWINWg5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 18:36:57 -0400
Subject: [PATCH] [4/5] Fix 'make headers_check' on x86_64 for 2.6.18
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 14 Sep 2006 23:36:54 +0100
Message-Id: <1158273414.4312.143.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-12 at 17:44 +0100, David Woodhouse wrote:
> asm-x86_64/elf.h requires asm/processor.h, which does not exist
> asm-x86_64/signal.h requires linux/linkage.h, which does not exist
> asm-x86_64/unistd.h requires linux/linkage.h, which does not exist
> asm-x86_64/vsyscall.h requires linux/seqlock.h, which does not exist 

Again, move stuff which shouldn't be visible inside (mostly already
existing) #ifdef __KERNEL__.

This fixes a bunch of mislabelled and unlabelled #endifs in unistd.h and
also cleans that up to conform with what's visible on other
architectures, since the minimal fix for the error reported about would
have involved a more intrusive patch, renesting other ifdefs.

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-x86_64/Kbuild b/include/asm-x86_64/Kbuild
diff --git a/include/asm-x86_64/elf.h b/include/asm-x86_64/elf.h
index b4f8f4a..a406fcb 100644
--- a/include/asm-x86_64/elf.h
+++ b/include/asm-x86_64/elf.h
@@ -7,8 +7,6 @@ #define __ASM_X86_64_ELF_H
 
 #include <asm/ptrace.h>
 #include <asm/user.h>
-#include <asm/processor.h>
-#include <asm/compat.h>
 
 /* x86-64 relocation types */
 #define R_X86_64_NONE		0	/* No reloc */
@@ -39,18 +37,23 @@ typedef elf_greg_t elf_gregset_t[ELF_NGR
 typedef struct user_i387_struct elf_fpregset_t;
 
 /*
- * This is used to ensure we don't load something for the wrong architecture.
- */
-#define elf_check_arch(x) \
-	((x)->e_machine == EM_X86_64)
-
-/*
  * These are used to set parameters in the core dumps.
  */
 #define ELF_CLASS	ELFCLASS64
 #define ELF_DATA	ELFDATA2LSB
 #define ELF_ARCH	EM_X86_64
 
+#ifdef __KERNEL__
+#include <asm/processor.h>
+#include <asm/compat.h>
+
+/*
+ * This is used to ensure we don't load something for the wrong architecture.
+ */
+#define elf_check_arch(x) \
+	((x)->e_machine == EM_X86_64)
+
+
 /* SVR4/i386 ABI (pages 3-31, 3-32) says that when the program starts %edx
    contains a pointer to a function which might be registered using `atexit'.
    This provides a mean for the dynamic linker to call DT_FINI functions for
@@ -141,7 +144,6 @@ #define ELF_HWCAP	(boot_cpu_data.x86_cap
 /* I'm not sure if we can use '-' here */
 #define ELF_PLATFORM  ("x86_64")
 
-#ifdef __KERNEL__
 extern void set_personality_64bit(void);
 #define SET_PERSONALITY(ex, ibcs2) set_personality_64bit()
 /*
diff --git a/include/asm-x86_64/signal.h b/include/asm-x86_64/signal.h
index cef7a7d..3ede2a6 100644
--- a/include/asm-x86_64/signal.h
+++ b/include/asm-x86_64/signal.h
@@ -3,13 +3,13 @@ #define _ASMx8664_SIGNAL_H
 
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
-#include <linux/linkage.h>
 #include <linux/time.h>
 
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
 #ifdef __KERNEL__
+#include <linux/linkage.h>
 /* Most things should be clean enough to redefine this at will, if care
    is taken to make libc match.  */
 
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 2d89d30..80fd48e 100644
--- a/include/asm-x86_64/unistd.h
+++ b/include/asm-x86_64/unistd.h
@@ -620,6 +620,8 @@ __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
 
+#ifdef __KERNEL__
+
 #define __NR_syscall_max __NR_move_pages
 
 #ifndef __NO_STUBS
@@ -744,8 +746,6 @@ __syscall_return(type,__res); \
 
 #else /* __KERNEL_SYSCALLS__ */
 
-#ifdef __KERNEL__
-
 #include <linux/syscalls.h>
 #include <asm/ptrace.h>
 
@@ -821,8 +821,6 @@ asmlinkage long sys_fork(struct pt_regs 
 asmlinkage long sys_vfork(struct pt_regs regs);
 asmlinkage long sys_pipe(int *fildes);
 
-#endif /* __KERNEL_SYSCALLS__ */
-
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>
@@ -838,9 +836,9 @@ asmlinkage long sys_rt_sigaction(int sig
 				struct sigaction __user *oact,
 				size_t sigsetsize);
 
-#endif
+#endif  /* __ASSEMBLY__ */
 
-#endif
+#endif /* __KERNEL_SYSCALLS__ */
 
 /*
  * "Conditional" syscalls
@@ -850,6 +848,8 @@ #endif
  */
 #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
-#endif
+#endif /* __NO_STUBS */
 
-#endif
+#endif /* __KERNEL__ */
+
+#endif /* _ASM_X86_64_UNISTD_H_ */
diff --git a/include/asm-x86_64/vsyscall.h b/include/asm-x86_64/vsyscall.h
index a85e16f..146b244 100644
--- a/include/asm-x86_64/vsyscall.h
+++ b/include/asm-x86_64/vsyscall.h
@@ -1,8 +1,6 @@
 #ifndef _ASM_X86_64_VSYSCALL_H_
 #define _ASM_X86_64_VSYSCALL_H_
 
-#include <linux/seqlock.h>
-
 enum vsyscall_num {
 	__NR_vgettimeofday,
 	__NR_vtime,
@@ -14,6 +12,7 @@ #define VSYSCALL_END (-2UL << 20)
 #define VSYSCALL_ADDR(vsyscall_nr) (VSYSCALL_START+VSYSCALL_SIZE*(vsyscall_nr))
 
 #ifdef __KERNEL__
+#include <linux/seqlock.h>
 
 #define __section_vxtime __attribute__ ((unused, __section__ (".vxtime"), aligned(16)))
 #define __section_wall_jiffies __attribute__ ((unused, __section__ (".wall_jiffies"), aligned(16)))

-- 
dwmw2

