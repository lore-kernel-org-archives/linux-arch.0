From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v1 2/4] xtensa: add __NR_syscalls along with __NR_syscall_count
Date: Thu,  1 Nov 2018 19:26:19 +0530
Message-ID: <1541080581-4072-3-git-send-email-firoz.khan@linaro.org>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

__NR_syscall_count macro holds the number of system call
exist in xtensa architecture. We have to change the value
of __NR_syscall_count, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_syscall_count value.

1. Update __NR_syscall_count in asm/unistd.h manually by
   counting the no.of system calls. No need to update __NR-
   _syscall_count until we either add a new system call or
   delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_syscall_count in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_syscall_count asm/unistd.h. The macro __NR_sys-
calls also added for making the name convention same across
all architecture. While __NR_syscalls isn't strictly part
of the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/xtensa/include/asm/unistd.h      | 2 ++
 arch/xtensa/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index c73eca83..b844081 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -5,6 +5,8 @@
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 
+#define __NR_syscall_count 	__NR_syscalls
+
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_LLSEEK
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index c8ac79a..fa26aa2 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -778,7 +778,9 @@
 #define __NR_statx				351
 __SYSCALL(351, sys_statx, 5)
 
-#define __NR_syscall_count			352
+#ifdef __KERNEL__
+#define __NR_syscalls				352
+#endif
 
 #undef __SYSCALL
 
-- 
1.9.1
