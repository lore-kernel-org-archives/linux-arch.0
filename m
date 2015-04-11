From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 06/24] blackfin: Autogenerate offsets in struct thread_info
Date: Sat, 11 Apr 2015 22:47:45 +0200
Message-ID: <1428785283-20501-7-git-send-email-richard@nod.at>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalter@redhat.com, a-jacquiot@ti.com, starvik@axis.com, jesper.nilsson@axis.com, dhowells@redhat.com, rkuo@codeaurora.org, tony.luck@intel.com, fenghua.yu@intel.com, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, yasutake.koichi@jp.panasonic.com, lftan@altera.com, jonas@southpole.se, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, liqin.linux@gmail.com, lennox.wu@gmail.com, davem@davemloft.net, cmetcalf@ezchip.com, jdike@addtoit.com, akpm@linux-foundation.org, oleg@redhat.com, hch@inf
List-Id: linux-arch.vger.kernel.org

Maintaining offsets by hand is no fun.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/blackfin/include/asm/thread_info.h | 9 ---------
 arch/blackfin/kernel/asm-offsets.c      | 6 ++++++
 arch/blackfin/kernel/traps.c            | 1 +
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/blackfin/include/asm/thread_info.h b/arch/blackfin/include/asm/thread_info.h
index 57c3a8b..962be3f 100644
--- a/arch/blackfin/include/asm/thread_info.h
+++ b/arch/blackfin/include/asm/thread_info.h
@@ -76,15 +76,6 @@ static inline struct thread_info *current_thread_info(void)
 #endif				/* __ASSEMBLY__ */
 
 /*
- * Offsets in thread_info structure, used in assembly code
- */
-#define TI_TASK		0
-#define TI_EXECDOMAIN	4
-#define TI_FLAGS	8
-#define TI_CPU		12
-#define TI_PREEMPT	16
-
-/*
  * thread information flag bit numbers
  */
 #define TIF_SYSCALL_TRACE	0	/* syscall trace active */
diff --git a/arch/blackfin/kernel/asm-offsets.c b/arch/blackfin/kernel/asm-offsets.c
index 37fcae9..486560a 100644
--- a/arch/blackfin/kernel/asm-offsets.c
+++ b/arch/blackfin/kernel/asm-offsets.c
@@ -42,6 +42,12 @@ int main(void)
 	DEFINE(THREAD_PC, offsetof(struct thread_struct, pc));
 	DEFINE(KERNEL_STACK_SIZE, THREAD_SIZE);
 
+	/* offsets in thread_info struct */
+	OFFSET(TI_TASK, thread_info, task);
+	OFFSET(TI_FLAGS, thread_info, flags);
+	OFFSET(TI_CPU, thread_info, cpu);
+	OFFSET(TI_PREEMPT, thread_info, preempt_count);
+
 	/* offsets into the pt_regs */
 	DEFINE(PT_ORIG_R0, offsetof(struct pt_regs, orig_r0));
 	DEFINE(PT_ORIG_P0, offsetof(struct pt_regs, orig_p0));
diff --git a/arch/blackfin/kernel/traps.c b/arch/blackfin/kernel/traps.c
index de5c2c3..1ed85dd 100644
--- a/arch/blackfin/kernel/traps.c
+++ b/arch/blackfin/kernel/traps.c
@@ -18,6 +18,7 @@
 #include <asm/fixed_code.h>
 #include <asm/pseudo_instructions.h>
 #include <asm/pda.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_KGDB
 # include <linux/kgdb.h>
-- 
1.8.4.5
