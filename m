Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:60016 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab3FYUf3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 16:35:29 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Wed, 26 Jun 2013 01:59:12 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 34/45] hexagon/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Date: Wed, 26 Jun 2013 02:02:04 +0530
Message-ID: <20130625203204.16593.61516.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
References: <20130625202452.16593.22810.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org, walken@google.com, vincent.guittot@linaro.org, laijs@cn.fujitsu.com
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, sbw@mit.edu, fweisbec@gmail.com, zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20130625203204.xdO2EB5zqE33N9d54lyBbYdoPT8AAjvwz-AegAKLtKk@z>

Once stop_machine() is gone from the CPU offline path, we won't be able
to depend on disabling preemption to prevent CPUs from going offline
from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
offline, while invoking from atomic context.

Cc: Richard Kuo <rkuo@codeaurora.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hexagon@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/hexagon/kernel/smp.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index 0e364ca..30d4318 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -241,9 +241,12 @@ void smp_send_reschedule(int cpu)
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

