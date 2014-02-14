Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp01.in.ibm.com ([122.248.162.1]:60257 "EHLO
	e28smtp01.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594AbaBNIDx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 03:03:53 -0500
Received: from /spool/local
	by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 13:33:51 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 40/52] intel-idle: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:28:15 +0530
Message-ID: <20140214075814.22701.67329.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Len Brown <lenb@kernel.org>"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075815.iHie9CjX1ELXWmQjdbc2Rkcllmo2P7oYODQL8UFjrRY@z>

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


Fix the intel-idle code by using this latter form of callback registration.

Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/idle/intel_idle.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 8e1939f..51493ed 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -681,14 +681,19 @@ static int __init intel_idle_init(void)
 	if (intel_idle_cpuidle_devices == NULL)
 		return -ENOMEM;
 
+	cpu_notifier_register_begin();
+
 	for_each_online_cpu(i) {
 		retval = intel_idle_cpu_init(i);
 		if (retval) {
+			cpu_notifier_register_done();
 			cpuidle_unregister_driver(&intel_idle_driver);
 			return retval;
 		}
 	}
-	register_cpu_notifier(&cpu_hotplug_notifier);
+	__register_cpu_notifier(&cpu_hotplug_notifier);
+
+	cpu_notifier_register_done();
 
 	return 0;
 }
@@ -698,10 +703,13 @@ static void __exit intel_idle_exit(void)
 	intel_idle_cpuidle_devices_uninit();
 	cpuidle_unregister_driver(&intel_idle_driver);
 
+	cpu_notifier_register_begin();
 
 	if (lapic_timer_reliable_states != LAPIC_TIMER_ALWAYS_RELIABLE)
 		on_each_cpu(__setup_broadcast_timer, (void *)false, 1);
-	unregister_cpu_notifier(&cpu_hotplug_notifier);
+	__unregister_cpu_notifier(&cpu_hotplug_notifier);
+
+	cpu_notifier_register_done();
 
 	return;
 }

