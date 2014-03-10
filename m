Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4]:48233 "EHLO
	e28smtp04.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155AbaCJUkF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Mar 2014 16:40:05 -0400
Received: from /spool/local
	by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Mar 2014 02:10:03 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 35/52] scsi, fcoe: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:09:52 +0530
Message-ID: <20140310203952.10746.35946.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Robert Love <robert.w.love@intel.com>, "James E.J. Bottomley" <JBottomley@parallels.com>, fcoe-devel@open-fcoe.org, linux-scsi@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140310203952.4CXZiWtybJr4xePwXh1iCTajcN6kSn4BO8BOgd2QNhg@z>

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


Fix the fcoe code in scsi by using this latter form of callback registration.

Cc: Robert Love <robert.w.love@intel.com>
Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: fcoe-devel@open-fcoe.org
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 drivers/scsi/fcoe/fcoe.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f317000..d5e105b 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -2633,14 +2633,18 @@ static int __init fcoe_init(void)
 		skb_queue_head_init(&p->fcoe_rx_list);
 	}
 
+	cpu_notifier_register_begin();
+
 	for_each_online_cpu(cpu)
 		fcoe_percpu_thread_create(cpu);
 
 	/* Initialize per CPU interrupt thread */
-	rc = register_hotcpu_notifier(&fcoe_cpu_notifier);
+	rc = __register_hotcpu_notifier(&fcoe_cpu_notifier);
 	if (rc)
 		goto out_free;
 
+	cpu_notifier_register_done();
+
 	/* Setup link change notification */
 	fcoe_dev_setup();
 
@@ -2655,6 +2659,9 @@ out_free:
 	for_each_online_cpu(cpu) {
 		fcoe_percpu_thread_destroy(cpu);
 	}
+
+	cpu_notifier_register_done();
+
 	mutex_unlock(&fcoe_config_mutex);
 	destroy_workqueue(fcoe_wq);
 	return rc;
@@ -2687,11 +2694,15 @@ static void __exit fcoe_exit(void)
 	}
 	rtnl_unlock();
 
-	unregister_hotcpu_notifier(&fcoe_cpu_notifier);
+	cpu_notifier_register_begin();
 
 	for_each_online_cpu(cpu)
 		fcoe_percpu_thread_destroy(cpu);
 
+	__unregister_hotcpu_notifier(&fcoe_cpu_notifier);
+
+	cpu_notifier_register_done();
+
 	mutex_unlock(&fcoe_config_mutex);
 
 	/*

