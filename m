Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:44854 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbaBNIDY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 03:03:24 -0500
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 18:03:22 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 38/52] drivers/base/topology.c: Fix CPU hotplug callback
 registration
Date: Fri, 14 Feb 2014 13:27:51 +0530
Message-ID: <20140214075750.22701.57260.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075751.cpBwSYBSIHJNuyLpk9cjiUyduONmhOaWI6echo9dyT8@z>

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


Fix the topology code by using this latter form of callback registration.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/base/topology.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/base/topology.c b/drivers/base/topology.c
index 94ffee3..a738d10 100644
--- a/drivers/base/topology.c
+++ b/drivers/base/topology.c
@@ -161,16 +161,20 @@ static int topology_cpu_callback(struct notifier_block *nfb,
 static int topology_sysfs_init(void)
 {
 	int cpu;
-	int rc;
+	int rc = 0;
+
+	cpu_notifier_register_begin();
 
 	for_each_online_cpu(cpu) {
 		rc = topology_add_dev(cpu);
 		if (rc)
-			return rc;
+			goto out;
 	}
-	hotcpu_notifier(topology_cpu_callback, 0);
+	__hotcpu_notifier(topology_cpu_callback, 0);
 
-	return 0;
+out:
+	cpu_notifier_register_done();
+	return rc;
 }
 
 device_initcall(topology_sysfs_init);

