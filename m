From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 39/52] clocksource,
 dummy-timer: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:28:05 +0530
Message-ID: <20140214075804.22701.19937.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
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


Fix the clocksource dummy-timer code by using this latter form of callback
registration.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/clocksource/dummy_timer.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/dummy_timer.c b/drivers/clocksource/dummy_timer.c
index b3eb582..ad35725 100644
--- a/drivers/clocksource/dummy_timer.c
+++ b/drivers/clocksource/dummy_timer.c
@@ -56,14 +56,19 @@ static struct notifier_block dummy_timer_cpu_nb = {
 
 static int __init dummy_timer_register(void)
 {
-	int err = register_cpu_notifier(&dummy_timer_cpu_nb);
+	int err = 0;
+
+	cpu_notifier_register_begin();
+	err = __register_cpu_notifier(&dummy_timer_cpu_nb);
 	if (err)
-		return err;
+		goto out;
 
 	/* We won't get a call on the boot CPU, so register immediately */
 	if (num_possible_cpus() > 1)
 		dummy_timer_setup();
 
-	return 0;
+out:
+	cpu_notifier_register_done();
+	return err;
 }
 early_initcall(dummy_timer_register);
