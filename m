From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 42/52] octeon,
 watchdog: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:28:42 +0530
Message-ID: <20140214075841.22701.62831.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Wim Van Sebroeck <wim@iguana.be>, Ingo Molnar <mingo@kernel.org>, linux-watchdog@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
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


Fix the watchdog code in octeon by using this latter form of callback
registration.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/watchdog/octeon-wdt-main.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 4612088..4baf2d7 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -708,10 +708,13 @@ static int __init octeon_wdt_init(void)
 
 	cpumask_clear(&irq_enabled_cpus);
 
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu)
 		octeon_wdt_setup_interrupt(cpu);
 
-	register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
+	__register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
+	cpu_notifier_register_done();
+
 out:
 	return ret;
 }
@@ -725,7 +728,8 @@ static void __exit octeon_wdt_cleanup(void)
 
 	misc_deregister(&octeon_wdt_miscdev);
 
-	unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
+	cpu_notifier_register_begin();
+	__unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
 
 	for_each_online_cpu(cpu) {
 		int core = cpu2core(cpu);
@@ -734,6 +738,9 @@ static void __exit octeon_wdt_cleanup(void)
 		/* Free the interrupt handler */
 		free_irq(OCTEON_IRQ_WDOG0 + core, octeon_wdt_poke_irq);
 	}
+
+	cpu_notifier_register_done();
+
 	/*
 	 * Disable the boot-bus memory, the code it points to is soon
 	 * to go missing.
