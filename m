From: Jiang Liu <liuj97@gmail.com>
Subject: [RFC PATCH v2 21/25] smp,
	tile: kill SMP single function call interrupt
Date: Thu, 12 Sep 2013 00:07:25 +0800
Message-ID: <1378915649-16395-22-git-send-email-liuj97@gmail.com>
References: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1378915649-16395-1-git-send-email-liuj97@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Shaohua Li <shli@kernel.org>
Cc: linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, Jiri Kosina <trivial@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, x86@kernel.org, Wang YanQing <udknight@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>
List-Id: linux-arch.vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Commit 9a46ad6d6df3b54 "smp: make smp_call_function_many() use logic
similar to smp_call_function_single()" has unified the way to handle
single and multiple cross-CPU function calls. Now only one interrupt
is needed for architecture specific code to support generic SMP function
call interfaces, so kill the redundant single function call interrupt.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/x86/include/asm/xen/events.h |  1 -
 arch/x86/xen/smp.c                | 38 ++------------------------------------
 2 files changed, 2 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/xen/events.h b/arch/x86/include/asm/xen/events.h
index ca842f2..b1ba559 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -4,7 +4,6 @@
 enum ipi_vector {
 	XEN_RESCHEDULE_VECTOR,
 	XEN_CALL_FUNCTION_VECTOR,
-	XEN_CALL_FUNCTION_SINGLE_VECTOR,
 	XEN_SPIN_UNLOCK_VECTOR,
 	XEN_IRQ_WORK_VECTOR,
 
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index ca92754..6a75302 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -46,12 +46,10 @@ struct xen_common_irq {
 };
 static DEFINE_PER_CPU(struct xen_common_irq, xen_resched_irq) = { .irq = -1 };
 static DEFINE_PER_CPU(struct xen_common_irq, xen_callfunc_irq) = { .irq = -1 };
-static DEFINE_PER_CPU(struct xen_common_irq, xen_callfuncsingle_irq) = { .irq = -1 };
 static DEFINE_PER_CPU(struct xen_common_irq, xen_irq_work) = { .irq = -1 };
 static DEFINE_PER_CPU(struct xen_common_irq, xen_debug_irq) = { .irq = -1 };
 
 static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id);
-static irqreturn_t xen_call_function_single_interrupt(int irq, void *dev_id);
 static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id);
 
 /*
@@ -123,13 +121,6 @@ static void xen_smp_intr_free(unsigned int cpu)
 		kfree(per_cpu(xen_debug_irq, cpu).name);
 		per_cpu(xen_debug_irq, cpu).name = NULL;
 	}
-	if (per_cpu(xen_callfuncsingle_irq, cpu).irq >= 0) {
-		unbind_from_irqhandler(per_cpu(xen_callfuncsingle_irq, cpu).irq,
-				       NULL);
-		per_cpu(xen_callfuncsingle_irq, cpu).irq = -1;
-		kfree(per_cpu(xen_callfuncsingle_irq, cpu).name);
-		per_cpu(xen_callfuncsingle_irq, cpu).name = NULL;
-	}
 	if (xen_hvm_domain())
 		return;
 
@@ -178,18 +169,6 @@ static int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_debug_irq, cpu).irq = rc;
 	per_cpu(xen_debug_irq, cpu).name = debug_name;
 
-	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
-	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
-				    cpu,
-				    xen_call_function_single_interrupt,
-				    IRQF_DISABLED|IRQF_PERCPU|IRQF_NOBALANCING,
-				    callfunc_name,
-				    NULL);
-	if (rc < 0)
-		goto fail;
-	per_cpu(xen_callfuncsingle_irq, cpu).irq = rc;
-	per_cpu(xen_callfuncsingle_irq, cpu).name = callfunc_name;
-
 	/*
 	 * The IRQ worker on PVHVM goes through the native path and uses the
 	 * IPI mechanism.
@@ -551,8 +530,7 @@ static void xen_smp_send_call_function_ipi(const struct cpumask *mask)
 
 static void xen_smp_send_call_function_single_ipi(int cpu)
 {
-	__xen_send_IPI_mask(cpumask_of(cpu),
-			  XEN_CALL_FUNCTION_SINGLE_VECTOR);
+	__xen_send_IPI_mask(cpumask_of(cpu), XEN_CALL_FUNCTION_VECTOR);
 }
 
 static inline int xen_map_vector(int vector)
@@ -564,10 +542,8 @@ static inline int xen_map_vector(int vector)
 		xen_vector = XEN_RESCHEDULE_VECTOR;
 		break;
 	case CALL_FUNCTION_VECTOR:
-		xen_vector = XEN_CALL_FUNCTION_VECTOR;
-		break;
 	case CALL_FUNCTION_SINGLE_VECTOR:
-		xen_vector = XEN_CALL_FUNCTION_SINGLE_VECTOR;
+		xen_vector = XEN_CALL_FUNCTION_VECTOR;
 		break;
 	case IRQ_WORK_VECTOR:
 		xen_vector = XEN_IRQ_WORK_VECTOR;
@@ -639,16 +615,6 @@ static irqreturn_t xen_call_function_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t xen_call_function_single_interrupt(int irq, void *dev_id)
-{
-	irq_enter();
-	generic_smp_call_function_single_interrupt();
-	inc_irq_stat(irq_call_count);
-	irq_exit();
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t xen_irq_work_interrupt(int irq, void *dev_id)
 {
 	irq_enter();
-- 
1.8.1.2
