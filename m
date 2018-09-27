From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v2 2/5] parisc: add __NR_Linux_syscalls macro with __NR_syscalls
Date: Thu, 27 Sep 2018 19:54:24 +0530
Message-ID: <1538058267-3765-3-git-send-email-firoz.khan@linaro.org>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-parisc@vger.kernel.org, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in PARISC architecture. This macro is currently the
part of uapi/asm/unistd.h file. We have to change the value
of __NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file. The
syscall.tbl file contains the number of system call inform-
ation. So we have two option to update __NR_Linux_syscalls
value.

1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system call
   or delete an existing system call.

2. We can keep this feature it above mentioned script, that
   will count the number of syscalls and keep it in a gener-
   ated file. In this case we don't need to explicitly update
   __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved
the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
unistd.h. The macro __NR_syscalls also added for making the
name convention same across all architecture. While __NR_sys-
calls isn't strictly part of the uapi, having it as part of
the generated header to simplifies the implementation. We also
need to enclose this macro with #ifdef __KERNEL__ to avoid side
effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/uapi/asm/unistd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..255c62a 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,11 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls           351
+#endif
+
+#define __NR_Linux_syscalls     __NR_syscalls
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1
