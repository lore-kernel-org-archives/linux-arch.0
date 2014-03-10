From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 24/52] x86, intel,
 rapl: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:08:09 +0530
Message-ID: <20140310203809.10746.41940.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: oleg@redhat.com, rjw@rjwysocki.net, rusty@rustcorp.com.au, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Peter Zijlstra <peterz@infradead.org>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

Subsystems that want to register CPU hotplug callbacks, as well as perform
initialization for the CPUs that are already online, often do it as shown
below:

	get_online_cpus();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	register_cpu_notifier(&foobar_cpu_notifier);

	put_online_cpus();

This is wrong, since it is prone to ABBA deadlocks involving the
cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
with CPU hotplug operations).

Instead, the correct and race-free way of performing the callback
registration is:

	cpu_notifier_register_begin();

	for_each_online_cpu(cpu)
		init_cpu(cpu);

	/* Note the use of the double underscored version of the API */
	__register_cpu_notifier(&foobar_cpu_notifier);

	cpu_notifier_register_done();


Fix the intel rapl code in x86 by using this latter form of callback
registration.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/cpu/perf_event_intel_rapl.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel_rapl.c b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
index 5ad35ad..059218e 100644
--- a/arch/x86/kernel/cpu/perf_event_intel_rapl.c
+++ b/arch/x86/kernel/cpu/perf_event_intel_rapl.c
@@ -646,19 +646,20 @@ static int __init rapl_pmu_init(void)
 		/* unsupported */
 		return 0;
 	}
-	get_online_cpus();
+
+	cpu_notifier_register_begin();
 
 	for_each_online_cpu(cpu) {
 		rapl_cpu_prepare(cpu);
 		rapl_cpu_init(cpu);
 	}
 
-	perf_cpu_notifier(rapl_cpu_notifier);
+	__perf_cpu_notifier(rapl_cpu_notifier);
 
 	ret = perf_pmu_register(&rapl_pmu_class, "power", -1);
 	if (WARN_ON(ret)) {
 		pr_info("RAPL PMU detected, registration failed (%d), RAPL PMU disabled\n", ret);
-		put_online_cpus();
+		cpu_notifier_register_done();
 		return -1;
 	}
 
@@ -672,7 +673,7 @@ static int __init rapl_pmu_init(void)
 		hweight32(rapl_cntr_mask),
 		ktime_to_ms(pmu->timer_interval));
 
-	put_online_cpus();
+	cpu_notifier_register_done();
 
 	return 0;
 }
