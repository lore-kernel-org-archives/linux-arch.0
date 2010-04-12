From: David VomLehn <dvomlehn@cisco.com>
Subject: [PATCH 8/23] Make register values available to H8300 panic
	notifiers
Date: Sun, 11 Apr 2010 23:06:32 -0700
Message-ID: <20100412060632.GA25482@dvomlehn-lnx2.corp.sa.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: to@dvomlehn-lnx2.corp.sa.net, "linux-arch@vger.kernel.org"@cisco.comlinux-arch@vger.kernel.org
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, maint_arch@dvomlehn-lnx2.corp.sa.net
List-Id: linux-arch.vger.kernel.org

The save_ptregs() function has not been tested or even built. I will need
help to complete this.

Signed-off-by: David VomLehn <dvomlehn@cisco.com>
---
 arch/h8300/include/asm/ptrace.h |   64 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/h8300/include/asm/ptrace.h b/arch/h8300/include/asm/ptrace.h
index d866c0e..09d6f3f 100644
--- a/arch/h8300/include/asm/ptrace.h
+++ b/arch/h8300/include/asm/ptrace.h
@@ -61,6 +61,70 @@ struct pt_regs {
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
 extern void show_regs(struct pt_regs *);
+
+/* Macros for saving the contents of registers and for the output constraint
+ * for those registers */
+#include "/home/vomlehn/git/kernel.org/ptreg.h"
+#define PTREG_SAVE(r, name)	"mov.l	" #r ", %[" #name "]\n"
+#define PTREG_SAVE_ER(i)	PTREG_SAVE_I(er, er, i)
+
+#define PTREG_OUT_ER(regs, i)	PTREG_OUT_I(regs, er, er, i)
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
+			PTREG_SAVE(retpc, retpc)
+			PTREG_SAVE_ER(4)
+			PTREG_SAVE_ER(5)
+			PTREG_SAVE_ER(6)
+			PTREG_SAVE_ER(3)
+			PTREG_SAVE_ER(2)
+			PTREG_SAVE_ER(1)
+			PTREG_SAVE(orig_er0, orig_er0)
+			PTREG_SAVE(ccr, ccr)
+			PTREG_SAVE_ER(0)
+			PTREG_SAVE(vector, vector)
+#if defined(CONFIG_CPU_H8S)
+			PTREG_SAVE(exr, exr)
+#endif
+		"1:\n"
+			"mov.l	#1b, er0\n"
+			PTREG_SAVE(er0, pc)
+	:
+		PTREG_OUT(regs, retpc, retpc)
+		PTREG_OUT(regs, 4)
+		PTREG_OUT(regs, 5)
+		PTREG_OUT(regs, 6)
+		PTREG_OUT(regs, 3)
+		PTREG_OUT(regs, 2)
+		PTREG_OUT(regs, 1)
+		PTREG_OUT(regs, orig_er0, orig_er0)
+		PTREG_OUT(regs, ccr, ccr)
+		PTREG_OUT(regs, 0)
+		PTREG_OUT(regs, vector, vector)
+#if defined(CONFIG_CPU_H8S)
+		PTREG_OUT(regs, exr, exr)
+#endif
+		PTREG_OUT(regs, pc, pc)
+	:
+		"er0"
+	);
+
+	return regs;
+}
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 #endif /* _H8300_PTRACE_H */
