Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:41668 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932413Ab2FAJwh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 05:52:37 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 1 Jun 2012 09:10:12 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 18/27] powerpc, smpboot: Use generic SMP booting infrastructure
Date: Fri, 01 Jun 2012 14:44:23 +0530
Message-ID: <20120601091417.31979.6433.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com"Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>Yong Zhang <yong.zhang0@gmail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20120601091423.vEucJk4mQT_4aVymfm5Igbs-mS_JoxLSNBjJRopS-P0@z>

From: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>

Convert powerpc to use the generic framework to boot secondary CPUs.

Signed-off-by: Nikunj A. Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yong Zhang <yong.zhang0@gmail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/smp.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 1928058a..96c3718 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -544,16 +544,18 @@ static struct device_node *cpu_to_l2cache(int cpu)
 /* Activate a secondary processor. */
 void __devinit start_secondary(void *unused)
 {
+	smpboot_start_secondary(unused);
+}
+
+void __cpuinit __cpu_pre_starting(void *unused)
+{
 	unsigned int cpu = smp_processor_id();
-	struct device_node *l2_cache;
-	int i, base;
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
 
 	smp_store_cpu_info(cpu);
 	set_dec(tb_ticks_per_jiffy);
-	preempt_disable();
 	cpu_callin_map[cpu] = 1;
 
 	if (smp_ops->setup_cpu)
@@ -567,8 +569,16 @@ void __devinit start_secondary(void *unused)
 	if (system_state == SYSTEM_RUNNING)
 		vdso_data->processorCount++;
 #endif
-	notify_cpu_starting(cpu);
-	set_cpu_online(cpu, true);
+}
+
+void __cpuinit __cpu_post_online(void *unused)
+{
+	unsigned int cpu;
+	struct device_node *l2_cache;
+	int i, base;
+
+	cpu = smp_processor_id();
+
 	/* Update sibling maps */
 	base = cpu_first_thread_sibling(cpu);
 	for (i = 0; i < threads_per_core; i++) {
@@ -596,12 +606,6 @@ void __devinit start_secondary(void *unused)
 		of_node_put(np);
 	}
 	of_node_put(l2_cache);
-
-	local_irq_enable();
-
-	cpu_idle();
-
-	BUG();
 }
 
 int setup_profiling_timer(unsigned int multiplier)

