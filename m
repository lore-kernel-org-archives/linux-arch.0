From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
Date: Thu, 29 Nov 2018 14:13:31 +0530
Message-ID: <1543481016-18500-2-git-send-email-firoz.khan@linaro.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in mips architecture. We have to change the value of
__NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_Linux_syscalls value.

1. Update __NR_Linux_syscalls in asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system
   call or delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_Linux_syscalls. The macro __NR_syscalls also
added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
index f25dd1d..6914be5 100644
--- a/arch/mips/include/uapi/asm/unistd.h
+++ b/arch/mips/include/uapi/asm/unistd.h
@@ -391,11 +391,14 @@
 #define __NR_rseq			(__NR_Linux + 367)
 #define __NR_io_pgetevents		(__NR_Linux + 368)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			368
+#endif
 
 /*
  * Offset of the last Linux o32 flavoured syscall
  */
-#define __NR_Linux_syscalls		368
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
 
@@ -738,10 +741,14 @@
 #define __NR_rseq			(__NR_Linux + 327)
 #define __NR_io_pgetevents		(__NR_Linux + 328)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			328
+#endif
+
 /*
  * Offset of the last Linux 64-bit flavoured syscall
  */
-#define __NR_Linux_syscalls		328
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_ABI64 */
 
@@ -1088,10 +1095,14 @@
 #define __NR_rseq			(__NR_Linux + 331)
 #define __NR_io_pgetevents		(__NR_Linux + 332)
 
+#ifdef __KERNEL__
+#define __NR_syscalls			332
+#endif
+
 /*
  * Offset of the last N32 flavoured syscall
  */
-#define __NR_Linux_syscalls		332
+#define __NR_Linux_syscalls		__NR_syscalls
 
 #endif /* _MIPS_SIM == _MIPS_SIM_NABI32 */
 
-- 
1.9.1
