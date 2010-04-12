From: David VomLehn <dvomlehn@cisco.com>
Subject: [PATCH 3/23] Make register values available to ARM panic notifiers
Date: Sun, 11 Apr 2010 23:06:16 -0700
Message-ID: <20100412060616.GA25334@dvomlehn-lnx2.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: to@dvomlehn-lnx2.corp.sa.net, "linux-arch@vger.kernel.org"@cisco.comlinux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, maint_arch@dvomlehn-lnx2.corp.sa.net
List-Id: linux-arch.vger.kernel.org

The save_ptregs() functions compiles cleanly, but has not been tested.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/arm/include/asm/ptrace.h |   75 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/traps.c       |    4 +-
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 9dcb11e..b9a0488 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -184,6 +184,81 @@ extern unsigned long profile_pc(struct pt_regs *regs);
 #define predicate(x)		((x) & 0xf0000000)
 #define PREDICATE_ALWAYS	0xe0000000
 
+/* Macros for saving the contents of registers and for the output constraint
+ * for those registers */
+#include <linux/ptreg.h>
+#define PTREG_SAVE(r, name)	"str	" #r ", %[" #name "]\n"
+#define PTREG_SAVE_R(i)		_PTREG_SAVE_IDX(r, r, i)
+
+#define PTREG_OUT_R(regs, i)	_PTREG_OUT_IDX(regs, uregs, r, i)
+
+#define arch_has_save_ptregs	1
+
+/**
+ * save_ptregs - save processor registers for backtracing
+ * @regs:	Pointer to &struct pt_regs structure in which to save the
+ *		registers
+ *
+ * Returns a constant pointer to @regs.
+ *
+ * This function must be called first in a function. There must be no
+ * auto variables defined that are initialized before calling this function.
+ */
+static __always_inline
+const struct pt_regs *save_ptregs(struct pt_regs *regs)
+{
+	__asm__ __volatile__ (
+			/*
+			 * I think ARM has an instruction to store multiple
+			 * registers it would be nice to use that
+			 */
+			PTREG_SAVE_R(0)
+			PTREG_SAVE_R(1)
+			PTREG_SAVE_R(2)
+			PTREG_SAVE_R(3)
+			PTREG_SAVE_R(4)
+			PTREG_SAVE_R(5)
+			PTREG_SAVE_R(6)
+			PTREG_SAVE_R(7)
+			PTREG_SAVE_R(8)
+			PTREG_SAVE_R(9)
+			PTREG_SAVE_R(10)
+			PTREG_SAVE(fp, fp)
+			PTREG_SAVE(ip, ip)
+			PTREG_SAVE(sp, sp)
+			PTREG_SAVE(lr, lr)
+
+			"mrs	r0, cpsr\n"
+			PTREG_SAVE(r0, cpsr)
+
+		"1:\n"
+			"adr	r0, 1b\n"
+			PTREG_SAVE(r0, pc)
+	:
+		PTREG_OUT_R(regs, 0),
+		PTREG_OUT_R(regs, 1),
+		PTREG_OUT_R(regs, 2),
+		PTREG_OUT_R(regs, 3),
+		PTREG_OUT_R(regs, 4),
+		PTREG_OUT_R(regs, 5),
+		PTREG_OUT_R(regs, 6),
+		PTREG_OUT_R(regs, 7),
+		PTREG_OUT_R(regs, 8),
+		PTREG_OUT_R(regs, 9),
+		PTREG_OUT_R(regs, 10),
+		PTREG_OUT(regs, ARM_fp, fp),
+		PTREG_OUT(regs, ARM_ip, ip),
+		PTREG_OUT(regs, ARM_sp, sp),
+		PTREG_OUT(regs, ARM_lr, lr),
+		PTREG_OUT(regs, ARM_pc, pc),
+		PTREG_OUT(regs, ARM_cpsr, cpsr)
+	:
+	:
+		"r0"
+	);
+
+	return regs;
+}
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1621e53..128be0f 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -282,9 +282,9 @@ void die(const char *str, struct pt_regs *regs, int err)
 	oops_exit();
 
 	if (in_interrupt())
-		panic("Fatal exception in interrupt");
+		panic_with_regs(regs, "Fatal exception in interrupt");
 	if (panic_on_oops)
-		panic("Fatal exception");
+		panic_with_regs(regs, "Fatal exception");
 	if (ret != NOTIFY_STOP)
 		do_exit(SIGSEGV);
 }
