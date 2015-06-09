From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 14/28] ARCv2: SMP: ARConnect debug/robustness
Date: Tue, 9 Jun 2015 17:18:14 +0530
Message-ID: <1433850508-26317-15-git-send-email-vgupta@synopsys.com>
References: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433850508-26317-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, arc-linux-dev@synopsys.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>
List-Id: linux-arch.vger.kernel.org

- Handle possible interrupt coalescing from MCIP
- chk if prev IPI ack before sending new

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig       | 15 ++++++++++++---
 arch/arc/kernel/mcip.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 arch/arc/kernel/smp.c  | 20 ++++++++++++++++----
 3 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 301525020af7..ef5ca5969eaf 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -448,9 +448,10 @@ menuconfig ARC_DBG
 	bool "ARC debugging"
 	default y
 
+if ARC_DBG
+
 config ARC_DW2_UNWIND
 	bool "Enable DWARF specific kernel stack unwind"
-	depends on ARC_DBG
 	default y
 	select KALLSYMS
 	help
@@ -464,18 +465,26 @@ config ARC_DW2_UNWIND
 
 config ARC_DBG_TLB_PARANOIA
 	bool "Paranoia Checks in Low Level TLB Handlers"
-	depends on ARC_DBG
 	default n
 
 config ARC_DBG_TLB_MISS_COUNT
 	bool "Profile TLB Misses"
 	default n
 	select DEBUG_FS
-	depends on ARC_DBG
 	help
 	  Counts number of I and D TLB Misses and exports them via Debugfs
 	  The counters can be cleared via Debugfs as well
 
+if SMP
+
+config ARC_IPI_DBG
+	bool "Debug Inter Core interrupts"
+	default n
+
+endif
+
+endif
+
 config ARC_UBOOT_SUPPORT
 	bool "Support uboot arg Handling"
 	default n
diff --git a/arch/arc/kernel/mcip.c b/arch/arc/kernel/mcip.c
index e6ad6e64440a..35921c3ab394 100644
--- a/arch/arc/kernel/mcip.c
+++ b/arch/arc/kernel/mcip.c
@@ -33,27 +33,67 @@ void mcip_init_smp(unsigned int cpu)
 static void mcip_ipi_send(int cpu)
 {
 	unsigned long flags;
+	int ipi_was_pending;
+
+	/*
+	 * NOTE: We must spin here if the other cpu hasn't yet
+	 * serviced a previous message. This can burn lots
+	 * of time, but we MUST follows this protocol or
+	 * ipi messages can be lost!!!
+	 * Also, we must release the lock in this loop because
+	 * the other side may get to this same loop and not
+	 * be able to ack -- thus causing deadlock.
+	 */
+
+	do {
+		raw_spin_lock_irqsave(&mcip_lock, flags);
+		__mcip_cmd(CMD_INTRPT_READ_STATUS, cpu);
+		ipi_was_pending = read_aux_reg(ARC_REG_MCIP_READBACK);
+		if (ipi_was_pending == 0)
+			break; /* break out but keep lock */
+		raw_spin_unlock_irqrestore(&mcip_lock, flags);
+	} while (1);
 
-	raw_spin_lock_irqsave(&mcip_lock, flags);
 	__mcip_cmd(CMD_INTRPT_GENERATE_IRQ, cpu);
 	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+
+#ifdef CONFIG_ARC_IPI_DBG
+	if (ipi_was_pending)
+		pr_info("IPI ACK delayed from cpu %d\n", cpu);
+#endif
 }
 
 static void mcip_ipi_clear(int irq)
 {
-	unsigned int cpu;
+	unsigned int cpu, c;
 	unsigned long flags;
+	unsigned int __maybe_unused copy;
 
 	raw_spin_lock_irqsave(&mcip_lock, flags);
 
 	/* Who sent the IPI */
 	__mcip_cmd(CMD_INTRPT_CHECK_SOURCE, 0);
 
-	cpu = read_aux_reg(ARC_REG_MCIP_READBACK);	/* 1,2,4,8... */
+	copy = cpu = read_aux_reg(ARC_REG_MCIP_READBACK);	/* 1,2,4,8... */
 
-	__mcip_cmd(CMD_INTRPT_GENERATE_ACK, __ffs(cpu)); /* 0,1,2,3... */
+	/*
+	 * In rare case, multiple concurrent IPIs sent to same target can
+	 * possibly be coalesced by MCIP into 1 asserted IRQ, so @cpus can be
+	 * "vectored" (multiple bits sets) as opposed to typical single bit
+	 */
+	do {
+		c = __ffs(cpu);			/* 0,1,2,3 */
+		__mcip_cmd(CMD_INTRPT_GENERATE_ACK, c);
+		cpu &= ~(1U << c);
+	} while (cpu);
 
 	raw_spin_unlock_irqrestore(&mcip_lock, flags);
+
+#ifdef CONFIG_ARC_IPI_DBG
+	if (c != __ffs(copy))
+		pr_info("IPIs from %x coalesced to %x\n",
+			copy, raw_smp_processor_id());
+#endif
 }
 
 volatile int wake_flag;
diff --git a/arch/arc/kernel/smp.c b/arch/arc/kernel/smp.c
index d07cb53d7641..be13d12420ba 100644
--- a/arch/arc/kernel/smp.c
+++ b/arch/arc/kernel/smp.c
@@ -278,8 +278,10 @@ static void ipi_cpu_stop(void)
 	machine_halt();
 }
 
-static inline void __do_IPI(unsigned long msg)
+static inline int __do_IPI(unsigned long msg)
 {
+	int rc = 0;
+
 	switch (msg) {
 	case IPI_RESCHEDULE:
 		scheduler_ipi();
@@ -294,8 +296,10 @@ static inline void __do_IPI(unsigned long msg)
 		break;
 
 	default:
-		pr_warn("IPI with unexpected msg %ld\n", msg);
+		rc = 1;
 	}
+
+	return rc;
 }
 
 /*
@@ -305,6 +309,7 @@ static inline void __do_IPI(unsigned long msg)
 irqreturn_t do_IPI(int irq, void *dev_id)
 {
 	unsigned long pending;
+	unsigned long __maybe_unused copy;
 
 	pr_debug("IPI [%ld] received on cpu %d\n",
 		 *this_cpu_ptr(&ipi_data), smp_processor_id());
@@ -316,11 +321,18 @@ irqreturn_t do_IPI(int irq, void *dev_id)
 	 * "dequeue" the msg corresponding to this IPI (and possibly other
 	 * piggybacked msg from elided IPIs: see ipi_send_msg_one() above)
 	 */
-	pending = xchg(this_cpu_ptr(&ipi_data), 0);
+	copy = pending = xchg(this_cpu_ptr(&ipi_data), 0);
 
 	do {
 		unsigned long msg = __ffs(pending);
-		__do_IPI(msg);
+		int rc;
+
+		rc = __do_IPI(msg);
+#ifdef CONFIG_ARC_IPI_DBG
+		/* IPI received but no valid @msg */
+		if (rc)
+			pr_info("IPI with bogus msg %ld in %ld\n", msg, copy);
+#endif
 		pending &= ~(1U << msg);
 	} while (pending);
 
-- 
1.9.1
