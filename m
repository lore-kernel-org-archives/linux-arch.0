From: Firoz Khan <firoz.khan@linaro.org>
Subject: [PATCH v1 1/4] xtensa: move SYS_XTENSA_* macros to non uapi header
Date: Thu,  1 Nov 2018 19:26:18 +0530
Message-ID: <1541080581-4072-2-git-send-email-firoz.khan@linaro.org>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
List-Id: linux-arch.vger.kernel.org

All the SYS_XTENSA_* macros used by sysxtensa syscall
handlers are resides in the uapi header file move to
non uapi header asm/unistd.h as it is not used by any
user space applications.

It is correct to keep these macros in non uapi header
file asm/unistd.h while uapi/asm/unistd.h must hold
information only useful for user space applications.

One of the patch in this patch series will generate
uapi header file. The information which directly used
by the user space application must be present in uapi
file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/xtensa/include/asm/unistd.h      | 18 ++++++++++++++++++
 arch/xtensa/include/uapi/asm/unistd.h | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index ed66db3..c73eca83 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -22,4 +22,22 @@
 #define __IGNORE_vfork				/* use clone */
 #define __IGNORE_fadvise64			/* use fadvise64_64 */
 
+/*
+ * sysxtensa syscall handler
+ *
+ * int sysxtensa (SYS_XTENSA_ATOMIC_SET,     ptr, val,    unused);
+ * int sysxtensa (SYS_XTENSA_ATOMIC_ADD,     ptr, val,    unused);
+ * int sysxtensa (SYS_XTENSA_ATOMIC_EXG_ADD, ptr, val,    unused);
+ * int sysxtensa (SYS_XTENSA_ATOMIC_CMP_SWP, ptr, oldval, newval);
+ *        a2            a6                   a3    a4      a5
+ */
+
+#define SYS_XTENSA_RESERVED               0     /* don't use this */
+#define SYS_XTENSA_ATOMIC_SET             1     /* set variable */
+#define SYS_XTENSA_ATOMIC_EXG_ADD         2     /* exchange memory and add */
+#define SYS_XTENSA_ATOMIC_ADD             3     /* add to memory */
+#define SYS_XTENSA_ATOMIC_CMP_SWP         4     /* compare and swap */
+
+#define SYS_XTENSA_COUNT                  5     /* count */
+
 #endif /* _XTENSA_UNISTD_H */
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index bc3f62d..c8ac79a 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -780,24 +780,6 @@
 
 #define __NR_syscall_count			352
 
-/*
- * sysxtensa syscall handler
- *
- * int sysxtensa (SYS_XTENSA_ATOMIC_SET,     ptr, val,    unused);
- * int sysxtensa (SYS_XTENSA_ATOMIC_ADD,     ptr, val,    unused);
- * int sysxtensa (SYS_XTENSA_ATOMIC_EXG_ADD, ptr, val,    unused);
- * int sysxtensa (SYS_XTENSA_ATOMIC_CMP_SWP, ptr, oldval, newval);
- *        a2            a6                   a3    a4      a5
- */
-
-#define SYS_XTENSA_RESERVED               0     /* don't use this */
-#define SYS_XTENSA_ATOMIC_SET             1     /* set variable */
-#define SYS_XTENSA_ATOMIC_EXG_ADD         2     /* exchange memory and add */
-#define SYS_XTENSA_ATOMIC_ADD             3     /* add to memory */
-#define SYS_XTENSA_ATOMIC_CMP_SWP         4     /* compare and swap */
-
-#define SYS_XTENSA_COUNT                  5     /* count */
-
 #undef __SYSCALL
 
 #endif /* _UAPI_XTENSA_UNISTD_H */
-- 
1.9.1
