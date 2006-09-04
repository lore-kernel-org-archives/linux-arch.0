Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:19098 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751534AbWIDT17 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Sep 2006 15:27:59 -0400
Subject: [PATCH] Revert [i386/x86_64]: Remove __KERNEL__ ifdef around
	_syscall*()
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200608302359.k7UNxIZW027536@hera.kernel.org>
References: <200608302359.k7UNxIZW027536@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 12:27:29 -0700
Message-Id: <1157398050.2473.137.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@osdl.org, akpm@osdl.org, ak@suse.de
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2006-08-30 at 23:59 +0000, Linux Kernel Mailing List wrote:
> commit 386dcafaacd212ef4a8aeed67a7db3ffbb44c7b2
> tree 99e470b46fb81a1cde164458d03c9c9d807c1231
> parent 266f0566761cf88906d634727b3d9fc2556f5cbd
> author Andi Kleen <ak@suse.de> 1156959438 +0200
> committer Linus Torvalds <torvalds@g5.osdl.org> 1156979116 -0700
> 
> [PATCH] i386: Remove __KERNEL__ ifdef around _syscall*()
> 
> After all their only point is having them in user space.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

This patch is wrong. The kernel headers do _not_ exist merely to provide
a library of stuff for userspace to abuse. In particular, they do not
exist to provide arch maintainers with a convenient dumping ground for
helper functionality which already exists in userspace anyway.

These macros should be inside #ifdef __KERNEL__ for three reasons:

1. C libraries have their own syscall(); there's no _need_ for these
   macros to be exported by the kernel.

2. These macros work in-kernel but they are _not_ designed to work in
   the general case in userspace. The i386 version is broken for PIC
   code, for example.

3. We should be consistent about what we provide in kernel headers.
   Since we don't provide these macros on other architectures, we should
   not do so on i386 and x86_64 -- especially as the reason for doing so
   seems to be just that the arch maintainer doesn't want to use the
   proper glibc function in his test hacks.

With these two patches from Andi, we have restored _syscallX() to user
visibility on x86_64, while it's broken on i386 and absent on other
architectures. That's a very suboptimal state of affairs.

I see three possible ways to fix this. The first, and the sanest, is
just to put the ifdefs back and remove these macros from user view, as
in the patch below.

The second option, if the consensus really is that we should ignore
reason #1 above and export these unneeded macros, is that we can apply
the patch below and then also add generic versions of _syscall*() in
linux/unistd.h which just invoke libc's syscall(), instead of trying to
use the in-kernel assembly versions. That would at least address #2 and
#3 -- and in fact some distributions have been shipping with that
in /usr/include/linux/unistd.h for a long time already.

The third, and least sensible, option would be to accept what Andi has
done and then attempt to address #2 and #3 above by _fixing_ the macros
so that they work in the general case -- in all types of code and on all
architectures. Even in that case, the patch below should be applied to
remove these macros from user view as an interim measure until they are
actually fixed and consistent across architectures and code models.

What we have _now_, however, is entirely unacceptable. Please apply the
following patch to fix it:

Signed-off-by: David Woodhouse <dwmw2@infradead.org>

diff --git a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
index d983b74..fc1c8dd 100644
--- a/include/asm-i386/unistd.h
+++ b/include/asm-i386/unistd.h
@@ -324,6 +324,8 @@ #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
 
+#ifdef __KERNEL__
+
 #define NR_syscalls 318
 
 /*
@@ -423,8 +425,6 @@ __asm__ volatile ("push %%ebp ; push %%e
 __syscall_return(type,__res); \
 }
 
-#ifdef __KERNEL__
-
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
diff --git a/include/asm-x86_64/unistd.h b/include/asm-x86_64/unistd.h
index 2d89d30..40d96b3 100644
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
 
@@ -838,9 +838,8 @@ asmlinkage long sys_rt_sigaction(int sig
 				struct sigaction __user *oact,
 				size_t sigsetsize);
 
-#endif
-
-#endif
+#endif /* __ASSEMBLY__ */
+#endif /* __NO_STUBS */
 
 /*
  * "Conditional" syscalls
@@ -850,6 +849,6 @@ #endif
  */
 #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall")
 
-#endif
+#endif /* __KERNEL__ */
 
-#endif
+#endif /* _ASM_X86_64_UNISTD_H_ */


-- 
dwmw2

