Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:54435 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145Ab3AVHoO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2013 02:44:14 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 22 Jan 2013 13:12:25 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 33/45] hexagon/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Date: Tue, 22 Jan 2013 13:12:17 +0530
Message-ID: <20130122074213.13822.71590.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130122074217.C2vnTuEAsOMh0x9E3O4uUhxnaqGc97zHZ-8xKbwMaQE@z>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/hexagon/kernel/smp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 8e095df..ec87de9 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -112,6 +112,7 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	unsigned long cpu;
 	unsigned long retval;
 
+	get_online_cpus_atomic();
 	local_irq_save(flags);
 
 	for_each_cpu(cpu, cpumask) {
@@ -128,6 +129,7 @@ void send_ipi(const struct cpumask *cpumask, enum ipi_message_type msg)
 	}
 
 	local_irq_restore(flags);
+	put_online_cpus_atomic();
 }
 
 static struct irqaction ipi_intdesc = {
@@ -241,9 +243,12 @@ void smp_send_reschedule(int cpu)
 void smp_send_stop(void)
 {
 	struct cpumask targets;
+
+	get_online_cpus_atomic();
 	cpumask_copy(&targets, cpu_online_mask);
 	cpumask_clear_cpu(smp_processor_id(), &targets);
 	send_ipi(&targets, IPI_CPU_STOP);
+	put_online_cpus_atomic();
 }
 
 void arch_send_call_function_single_ipi(int cpu)

