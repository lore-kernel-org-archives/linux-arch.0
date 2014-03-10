From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 26/52] x86, hpet: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:08:36 +0530
Message-ID: <20140310203836.10746.23134.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulus@samba.org, oleg@redhat.com, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
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


Fix the hpet code in x86 by using this latter form of callback registration.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/hpet.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index da85a8e..d89382b 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -943,12 +943,14 @@ static __init int hpet_late_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARAT))
 		return 0;
 
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu) {
 		hpet_cpuhp_notify(NULL, CPU_ONLINE, (void *)(long)cpu);
 	}
 
 	/* This notifier should be called after workqueue is ready */
-	hotcpu_notifier(hpet_cpuhp_notify, -20);
+	__hotcpu_notifier(hpet_cpuhp_notify, -20);
+	cpu_notifier_register_done();
 
 	return 0;
 }
