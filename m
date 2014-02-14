Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:38959 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbaBNH5j (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 02:57:39 -0500
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 13:27:34 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 13/52] sparc, sysfs: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:22:05 +0530
Message-ID: <20140214075204.22701.72009.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075205.dI_JpBbMQGgDURSTr5gT8Ys8YIxFQLf-7Ohw9Ptsz0s@z>

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


Fix the sysfs code in sparc by using this latter form of callback
registration.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/sparc/kernel/sysfs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sysfs.c b/arch/sparc/kernel/sysfs.c
index c21c673..a364000 100644
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -300,7 +300,7 @@ static int __init topology_init(void)
 
 	check_mmu_stats();
 
-	register_cpu_notifier(&sysfs_cpu_nb);
+	cpu_notifier_register_begin();
 
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -310,6 +310,10 @@ static int __init topology_init(void)
 			register_cpu_online(cpu);
 	}
 
+	__register_cpu_notifier(&sysfs_cpu_nb);
+
+	cpu_notifier_register_done();
+
 	return 0;
 }
 

