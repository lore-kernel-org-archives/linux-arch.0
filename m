From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 18/27] powerpc, smpboot: Use generic SMP booting infrastructure
Date: Fri, 01 Jun 2012 14:44:23 +0530
Message-ID: <20120601091417.31979.6433.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
To: peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Nikunj A. Dadhania" <nikunj@linux.vnet.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, rusty@rustcorp.com.au, vatsa@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, rjw@sisk.pl, Yong Zhang <yong.zhang0@gmail.com>, Paul Mackerras <paulus@samba.org>, srivatsa.bhat@linux.vnet.ibm.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

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
