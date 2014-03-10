From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 28/52] x86, oprofile,
 nmi: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:08:49 +0530
Message-ID: <20140310203849.10746.36718.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulus@samba.org, oleg@redhat.com, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Robert Richter <rric@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
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


Fix the oprofile code in x86 by using this latter form of callback
registration. But retain the calls to get/put_online_cpus(), since they are
used in other places as well, to protect the variables 'nmi_enabled' and
'ctr_running'. Strictly speaking, this is not necessary since
cpu_notifier_register_begin/done() provide a stronger synchronization
with CPU hotplug than get/put_online_cpus(). However, let's retain the
calls to get/put_online_cpus() to be consistent with the other call-sites.

By nesting get/put_online_cpus() *inside* cpu_notifier_register_begin/done(),
we avoid the ABBA deadlock possibility mentioned above.

Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/oprofile/nmi_int.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 6890d84..379e8bd 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -494,14 +494,19 @@ static int nmi_setup(void)
 	if (err)
 		goto fail;
 
+	cpu_notifier_register_begin();
+
+	/* Use get/put_online_cpus() to protect 'nmi_enabled' */
 	get_online_cpus();
-	register_cpu_notifier(&oprofile_cpu_nb);
 	nmi_enabled = 1;
 	/* make nmi_enabled visible to the nmi handler: */
 	smp_mb();
 	on_each_cpu(nmi_cpu_setup, NULL, 1);
+	__register_cpu_notifier(&oprofile_cpu_nb);
 	put_online_cpus();
 
+	cpu_notifier_register_done();
+
 	return 0;
 fail:
 	free_msrs();
@@ -512,12 +517,18 @@ static void nmi_shutdown(void)
 {
 	struct op_msrs *msrs;
 
+	cpu_notifier_register_begin();
+
+	/* Use get/put_online_cpus() to protect 'nmi_enabled' & 'ctr_running' */
 	get_online_cpus();
-	unregister_cpu_notifier(&oprofile_cpu_nb);
 	on_each_cpu(nmi_cpu_shutdown, NULL, 1);
 	nmi_enabled = 0;
 	ctr_running = 0;
+	__unregister_cpu_notifier(&oprofile_cpu_nb);
 	put_online_cpus();
+
+	cpu_notifier_register_done();
+
 	/* make variables visible to the nmi handler: */
 	smp_mb();
 	unregister_nmi_handler(NMI_LOCAL, "oprofile");
