Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:38238 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbaBNIEe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 03:04:34 -0500
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 13:34:31 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 43/52] thermal,
 x86-pkg-temp: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:28:59 +0530
Message-ID: <20140214075858.22701.51893.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075859.BYPPzfT2FDDlSeh9zX_xdvGQZ6HxtPGn7gVPO9-P2Qg@z>

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


Fix the thermal x86-pkg-temp code by using this latter form of callback
registration.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/thermal/x86_pkg_temp_thermal.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/x86_pkg_temp_thermal.c b/drivers/thermal/x86_pkg_temp_thermal.c
index 972e1c7..7592048 100644
--- a/drivers/thermal/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/x86_pkg_temp_thermal.c
@@ -589,12 +589,12 @@ static int __init pkg_temp_thermal_init(void)
 	platform_thermal_package_rate_control =
 			pkg_temp_thermal_platform_thermal_rate_control;
 
-	get_online_cpus();
+	cpu_notifier_register_begin();
 	for_each_online_cpu(i)
 		if (get_core_online(i))
 			goto err_ret;
-	register_hotcpu_notifier(&pkg_temp_thermal_notifier);
-	put_online_cpus();
+	__register_hotcpu_notifier(&pkg_temp_thermal_notifier);
+	cpu_notifier_register_done();
 
 	pkg_temp_debugfs_init(); /* Don't care if fails */
 
@@ -603,7 +603,7 @@ static int __init pkg_temp_thermal_init(void)
 err_ret:
 	for_each_online_cpu(i)
 		put_core_offline(i);
-	put_online_cpus();
+	cpu_notifier_register_done();
 	kfree(pkg_work_scheduled);
 	platform_thermal_package_notify = NULL;
 	platform_thermal_package_rate_control = NULL;
@@ -616,8 +616,8 @@ static void __exit pkg_temp_thermal_exit(void)
 	struct phy_dev_entry *phdev, *n;
 	int i;
 
-	get_online_cpus();
-	unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
+	cpu_notifier_register_begin();
+	__unregister_hotcpu_notifier(&pkg_temp_thermal_notifier);
 	mutex_lock(&phy_dev_list_mutex);
 	list_for_each_entry_safe(phdev, n, &phy_dev_list, list) {
 		/* Retore old MSR value for package thermal interrupt */
@@ -635,7 +635,7 @@ static void __exit pkg_temp_thermal_exit(void)
 	for_each_online_cpu(i)
 		cancel_delayed_work_sync(
 			&per_cpu(pkg_temp_thermal_threshold_work, i));
-	put_online_cpus();
+	cpu_notifier_register_done();
 
 	kfree(pkg_work_scheduled);
 

