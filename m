From: Joel Porquet <joel@porquet.org>
Subject: [PATCH 2/2] arm: futex: Use asm-generic/futex.h instead of redefining
 the entire header
Date: Sun,  9 Oct 2016 17:03:08 -0700
Message-ID: <20161010000308.13212-3-joel@porquet.org>
References: <20161010000308.13212-1-joel@porquet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161010000308.13212-1-joel@porquet.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: arnd@arndb.de, linux@armlinux.org.uk
Cc: linux-arch@vger.kernel.org, Joel Porquet <joel@porquet.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

"asm-generic/futex.h" was refactored and now allows arch ports to only
define arch-specific macros instead of redefining the entire header
file.

This patch adapts "asm/futex.h" for ARM by only defining the macros
required by the generic header (ie __futex_atomic_op_inuser() and
__futex_atomic_cmpxchg_inatomic()).

Compiled (SMP and !SMP) and booted on QEMU with a minimal busybox-based
system.

Signed-off-by: Joel Porquet <joel@porquet.org>
---
 arch/arm/include/asm/futex.h | 203 ++++++++++++++++++-------------------------
 1 file changed, 84 insertions(+), 119 deletions(-)

diff --git a/arch/arm/include/asm/futex.h b/arch/arm/include/asm/futex.h
index 6795368..d3db562 100644
--- a/arch/arm/include/asm/futex.h
+++ b/arch/arm/include/asm/futex.h
@@ -39,41 +39,30 @@
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
 	: "cc", "memory");					\
 	uaccess_restore(__ua_flags);				\
+	smp_mb();						\
 })
 
-static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
-{
-	unsigned int __ua_flags;
-	int ret;
-	u32 val;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
-	smp_mb();
-	/* Prefetching cannot fault */
-	prefetchw(uaddr);
-	__ua_flags = uaccess_save_and_enable();
-	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
-	"1:	ldrex	%1, [%4]\n"
-	"	teq	%1, %2\n"
-	"	ite	eq	@ explicit IT needed for the 2b label\n"
-	"2:	strexeq	%0, %3, [%4]\n"
-	"	movne	%0, #0\n"
-	"	teq	%0, #0\n"
-	"	bne	1b\n"
-	__futex_atomic_ex_table("%5")
-	: "=&r" (ret), "=&r" (val)
-	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
-	: "cc", "memory");
-	uaccess_restore(__ua_flags);
-	smp_mb();
-
-	*uval = val;
-	return ret;
-}
+#define __futex_atomic_cmpxchg_op(ret, val, uaddr, oldval, newval)		\
+({										\
+	unsigned int __ua_flags;						\
+	smp_mb();								\
+	prefetchw(uaddr);							\
+	__ua_flags = uaccess_save_and_enable();					\
+	__asm__ __volatile__(							\
+	"1:	ldrex	%1, [%4]\n"						\
+	"	teq	%1, %2\n"						\
+	"	ite	eq	@ explicit IT needed for the 2b label\n"	\
+	"2:	strexeq	%0, %3, [%4]\n"						\
+	"	movne	%0, #0\n"						\
+	"	teq	%0, #0\n"						\
+	"	bne	1b\n"							\
+	__futex_atomic_ex_table("%5")						\
+	: "=&r" (ret), "=&r" (val)						\
+	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)		\
+	: "cc", "memory");							\
+	uaccess_restore(__ua_flags);						\
+	smp_mb();								\
+})
 
 #else /* !SMP, we can work around lack of atomic ops by disabling preemption */
 
@@ -82,7 +71,9 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 
 #define __futex_atomic_op(insn, ret, oldval, tmp, uaddr, oparg)	\
 ({								\
-	unsigned int __ua_flags = uaccess_save_and_enable();	\
+	unsigned int __ua_flags;				\
+	preempt_disable();					\
+	__ua_flags = uaccess_save_and_enable();			\
 	__asm__ __volatile__(					\
 	"1:	" TUSER(ldr) "	%1, [%3]\n"			\
 	"	" insn "\n"					\
@@ -93,98 +84,72 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 	: "r" (uaddr), "r" (oparg), "Ir" (-EFAULT)		\
 	: "cc", "memory");					\
 	uaccess_restore(__ua_flags);				\
+	preempt_disable();					\
 })
 
-static inline int
-futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
-			      u32 oldval, u32 newval)
-{
-	unsigned int __ua_flags;
-	int ret = 0;
-	u32 val;
-
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
-	preempt_disable();
-	__ua_flags = uaccess_save_and_enable();
-	__asm__ __volatile__("@futex_atomic_cmpxchg_inatomic\n"
-	"1:	" TUSER(ldr) "	%1, [%4]\n"
-	"	teq	%1, %2\n"
-	"	it	eq	@ explicit IT needed for the 2b label\n"
-	"2:	" TUSER(streq) "	%3, [%4]\n"
-	__futex_atomic_ex_table("%5")
-	: "+r" (ret), "=&r" (val)
-	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)
-	: "cc", "memory");
-	uaccess_restore(__ua_flags);
-
-	*uval = val;
-	preempt_enable();
-
-	return ret;
-}
+#define __futex_atomic_cmpxchg_op(ret, val, uaddr, oldval, newval)		\
+({										\
+	unsigned int __ua_flags;						\
+	preempt_disable();							\
+	__ua_flags = uaccess_save_and_enable();					\
+	__asm__ __volatile__(							\
+	"@futex_atomic_cmpxchg_inatomic\n"					\
+	"1:	" TUSER(ldr) "	%1, [%4]\n"					\
+	"	teq	%1, %2\n"						\
+	"	it	eq	@ explicit IT needed for the 2b label\n"	\
+	"2:	" TUSER(streq) "	%3, [%4]\n"				\
+	__futex_atomic_ex_table("%5")						\
+	: "+r" (ret), "=&r" (val)						\
+	: "r" (oldval), "r" (newval), "r" (uaddr), "Ir" (-EFAULT)		\
+	: "cc", "memory");							\
+	uaccess_restore(__ua_flags);						\
+	preempt_enable();							\
+})
 
 #endif /* !SMP */
 
-static inline int
-futex_atomic_op_inuser (int encoded_op, u32 __user *uaddr)
-{
-	int op = (encoded_op >> 28) & 7;
-	int cmp = (encoded_op >> 24) & 15;
-	int oparg = (encoded_op << 8) >> 20;
-	int cmparg = (encoded_op << 20) >> 20;
-	int oldval = 0, ret, tmp;
+#define __futex_atomic_op_inuser(op, oldval, uaddr, oparg)		\
+({									\
+	int __ret, tmp;							\
+	pagefault_disable();						\
+	switch (op) {							\
+	case FUTEX_OP_SET:						\
+		__futex_atomic_op("mov	%0, %4",			\
+				__ret, oldval, tmp, uaddr, oparg);	\
+		break;							\
+	case FUTEX_OP_ADD:						\
+		__futex_atomic_op("add	%0, %1, %4",			\
+				__ret, oldval, tmp, uaddr, oparg);	\
+		break;							\
+	case FUTEX_OP_OR:						\
+		__futex_atomic_op("orr	%0, %1, %4",			\
+				__ret, oldval, tmp, uaddr, oparg);	\
+		break;							\
+	case FUTEX_OP_ANDN:						\
+		__futex_atomic_op("and	%0, %1, %4",			\
+				__ret, oldval, tmp, uaddr, ~oparg);	\
+		break;							\
+	case FUTEX_OP_XOR:						\
+		__futex_atomic_op("eor	%0, %1, %4",			\
+				__ret, oldval, tmp, uaddr, oparg);	\
+		break;							\
+	default:							\
+		ret = -ENOSYS;						\
+	}								\
+	pagefault_enable();						\
+	__ret;								\
+})
 
-	if (encoded_op & (FUTEX_OP_OPARG_SHIFT << 28))
-		oparg = 1 << oparg;
+#define __futex_atomic_cmpxchg_inatomic(uval, uaddr, oldval, newval)	\
+({									\
+	int __ret;							\
+	u32 val;							\
+	__futex_atomic_cmpxchg_op(__ret, val, uaddr, oldval, newval);	\
+	*uval = val;							\
+	__ret;								\
+})
 
-	if (!access_ok(VERIFY_WRITE, uaddr, sizeof(u32)))
-		return -EFAULT;
-
-#ifndef CONFIG_SMP
-	preempt_disable();
-#endif
-	pagefault_disable();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-		__futex_atomic_op("mov	%0, %4", ret, oldval, tmp, uaddr, oparg);
-		break;
-	case FUTEX_OP_ADD:
-		__futex_atomic_op("add	%0, %1, %4", ret, oldval, tmp, uaddr, oparg);
-		break;
-	case FUTEX_OP_OR:
-		__futex_atomic_op("orr	%0, %1, %4", ret, oldval, tmp, uaddr, oparg);
-		break;
-	case FUTEX_OP_ANDN:
-		__futex_atomic_op("and	%0, %1, %4", ret, oldval, tmp, uaddr, ~oparg);
-		break;
-	case FUTEX_OP_XOR:
-		__futex_atomic_op("eor	%0, %1, %4", ret, oldval, tmp, uaddr, oparg);
-		break;
-	default:
-		ret = -ENOSYS;
-	}
-
-	pagefault_enable();
-#ifndef CONFIG_SMP
-	preempt_enable();
-#endif
-
-	if (!ret) {
-		switch (cmp) {
-		case FUTEX_OP_CMP_EQ: ret = (oldval == cmparg); break;
-		case FUTEX_OP_CMP_NE: ret = (oldval != cmparg); break;
-		case FUTEX_OP_CMP_LT: ret = (oldval < cmparg); break;
-		case FUTEX_OP_CMP_GE: ret = (oldval >= cmparg); break;
-		case FUTEX_OP_CMP_LE: ret = (oldval <= cmparg); break;
-		case FUTEX_OP_CMP_GT: ret = (oldval > cmparg); break;
-		default: ret = -ENOSYS;
-		}
-	}
-	return ret;
-}
+#include <asm-generic/futex.h>
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_ARM_FUTEX_H */
-- 
2.10.0
