Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:49832 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754386AbaCJUk3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Mar 2014 16:40:29 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Mar 2014 06:40:27 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 38/52] drivers/base/topology.c: Fix CPU hotplug callback
 registration
Date: Tue, 11 Mar 2014 02:10:12 +0530
Message-ID: <20140310204012.10746.6803.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140310204012.1Tj30oonIk_LJ1Wb3-TF-V3ZbUVlF-54kGXTY8UNd_E@z>

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

Cc: Ingo Molnar <mingo@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

