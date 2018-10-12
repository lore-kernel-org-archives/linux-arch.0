From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 21/21] csky: add support get_user_size access dword
Date: Fri, 12 Oct 2018 12:42:56 +0800
Message-ID: <edfa97ecec29c63203f75634c2842c16513ff96c.1539315391.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1539315390.git.ren_guo@c-sky.com>
References: <cover.1539315390.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, hch@infradead.org, marc.zyngier@arm.com, mark.rutland@arm.com, peterz@infradead.org, robh@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Support dword access for get_user_size and redesign put_user_size with
the same style of get_user_size. It's Ok to use xxx_user_asm_common for
all size of variable with ldb, ldh, ldw, ld.d

ld.d rx, (addr, 0) could "rx <= addr" "and r(x+1) <= addr+4" and this also
follow abiv2 gcc ABI for dword access.

abiv1 couldn't support __get_user_dword now.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/uaccess.h | 140 ++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 84 deletions(-)

diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index acaf0e210..80233e4 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -96,90 +96,32 @@ extern int __put_user_bad(void);
 	__pu_err;							\
 })
 
-#define __put_user_size(x, ptr, size, retval)		\
-do {							\
-	retval = 0;					\
-	switch (size) {                                 \
-	case 1:						\
-		__put_user_asm_b(x, ptr, retval);	\
-		break;					\
-	case 2:						\
-		__put_user_asm_h(x, ptr, retval);	\
-		break;					\
-	case 4:						\
-		__put_user_asm_w(x, ptr, retval);	\
-		break;					\
-	case 8:						\
-		__put_user_asm_64(x, ptr, retval);	\
-		break;					\
-	default:					\
-		__put_user_bad();			\
-	}	                                        \
-} while (0)
-
-/*
- * We don't tell gcc that we are accessing memory, but this is OK
- * because we do not write to any memory gcc knows about, so there
- * are no aliasing issues.
- *
- * Note that PC at a fault is the address *after* the faulting
- * instruction.
- */
-#define __put_user_asm_b(x, ptr, err)			\
-do {							\
-	int errcode;					\
-	asm volatile(					\
-	"1:     stb   %1, (%2,0)	\n"		\
-	"       br    3f		\n"		\
-	"2:     mov   %0, %3		\n"		\
-	"       br    3f		\n"		\
-	".section __ex_table, \"a\"	\n"		\
-	".align   2			\n"		\
-	".long    1b,2b			\n"		\
-	".previous			\n"		\
-	"3:				\n"		\
-	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)	\
-	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)	\
-	: "memory");					\
-} while (0)
-
-#define __put_user_asm_h(x, ptr, err)			\
-do {							\
-	int errcode;					\
-	asm volatile(					\
-	"1:     sth   %1, (%2,0)	\n"		\
-	"       br    3f		\n"		\
-	"2:     mov   %0, %3		\n"		\
-	"       br    3f		\n"		\
-	".section __ex_table, \"a\"	\n"		\
-	".align   2			\n"		\
-	".long    1b,2b			\n"		\
-	".previous			\n"		\
-	"3:				\n"		\
-	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)	\
-	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)	\
-	: "memory");					\
-} while (0)
-
-#define __put_user_asm_w(x, ptr, err)			\
-do {							\
-	int errcode;					\
-	asm volatile(					\
-	"1:     stw   %1, (%2,0)	\n"		\
-	"       br    3f		\n"		\
-	"2:     mov   %0, %3		\n"		\
-	"       br    3f		\n"		\
-	".section __ex_table,\"a\"	\n"		\
-	".align   2			\n"		\
-	".long    1b, 2b		\n"		\
-	".previous			\n"		\
-	"3:				\n"		\
-	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)	\
-	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)	\
-	: "memory");					\
+#define __put_user_size(x, ptr, size, retval)			\
+do {								\
+	retval = 0;						\
+	switch (size) {						\
+	case 1:							\
+		__put_user_asm_common(x, ptr, "stb", retval);	\
+		break;						\
+	case 2:							\
+		__put_user_asm_common(x, ptr, "sth", retval);	\
+		break;						\
+	case 4:							\
+		__put_user_asm_common(x, ptr, "stw", retval);	\
+		break;						\
+	case 8:							\
+		__put_user_asm_dword(x, ptr, retval);		\
+		break;						\
+	default:						\
+		__put_user_bad();				\
+	}							\
 } while (0)
 
-#define __put_user_asm_64(x, ptr, err)				\
+#if defined(__CSKYABIV2__)
+#define __put_user_asm_dword(x, ptr, err)			\
+	__put_user_asm_common(x, ptr, "st.d", err)
+#else
+#define __put_user_asm_dword(x, ptr, err)			\
 do {								\
 	int tmp;						\
 	int errcode;						\
@@ -205,6 +147,25 @@ do {								\
 	: "0"(err), "1"(psrc), "2"(ptr), "3"(0), "4"(-EFAULT)	\
 	: "memory");						\
 } while (0)
+#endif
+
+#define __put_user_asm_common(x, ptr, ins, err)			\
+do {								\
+	int errcode;						\
+	asm volatile(						\
+	"1:   " ins "	%1, (%2,0)	\n"			\
+	"       br	3f		\n"			\
+	"2:     mov	%0, %3		\n"			\
+	"       br	3f		\n"			\
+	".section __ex_table, \"a\"	\n"			\
+	".align   2			\n"			\
+	".long    1b,2b			\n"			\
+	".previous			\n"			\
+	"3:				\n"			\
+	: "=r"(err), "=r"(x), "=r"(ptr), "=r"(errcode)		\
+	: "0"(err), "1"(x), "2"(ptr), "3"(-EFAULT)		\
+	: "memory");						\
+} while (0)
 
 #define __get_user_nocheck(x, ptr, size)			\
 ({								\
@@ -222,6 +183,7 @@ do {								\
 	__gu_err;						\
 })
 
+extern int __get_user_bad(void);
 #define __get_user_size(x, ptr, size, retval)			\
 do {								\
 	switch (size) {						\
@@ -234,12 +196,24 @@ do {								\
 	case 4:							\
 		__get_user_asm_common((x), ptr, "ldw", retval);	\
 		break;						\
+	case 8:							\
+		__get_user_asm_common((x), ptr, "ld.d", retval);\
+		break;						\
 	default:						\
 		x = 0;						\
 		(retval) = __get_user_bad();			\
 	}							\
 } while (0)
 
+#if defined(__CSKYABIV2__)
+#define __get_user_asm_dword(x, ptr, err)			\
+	__get_user_asm_common(x, ptr, "ld.d", err)
+#else
+/* fixme: abiv1 not implement get_user_dword */
+#define __get_user_asm_dword(x, ptr, err)			\
+	__get_user_bad()
+#endif
+
 #define __get_user_asm_common(x, ptr, ins, err)			\
 do {								\
 	int errcode;						\
@@ -260,8 +234,6 @@ do {								\
 	: "memory");						\
 } while (0)
 
-extern int __get_user_bad(void);
-
 #define __copy_user(to, from, n)			\
 do {							\
 	int w0, w1, w2, w3;				\
-- 
2.7.4
