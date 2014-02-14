Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:39908 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbaBNH6I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 02:58:08 -0500
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 17:57:49 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 14/52] powerpc, sysfs: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:22:15 +0530
Message-ID: <20140214075215.22701.23653.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Olof Johansson <olof@lixom.net>, Wang Dongsheng <dongsheng.wang@freescale.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075215.7d-SFeTNgbZAuG9YezTl-Z1RmNVNGjbDcYTUOpD1ZIU@z>

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


Fix the sysfs code in powerpc by using this latter form of callback
registration.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Wang Dongsheng <dongsheng.wang@freescale.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/sysfs.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 97e1dc9..d90d4b7 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -975,7 +975,8 @@ static int __init topology_init(void)
 	int cpu;
 
 	register_nodes();
-	register_cpu_notifier(&sysfs_cpu_nb);
+
+	cpu_notifier_register_begin();
 
 	for_each_possible_cpu(cpu) {
 		struct cpu *c = &per_cpu(cpu_devices, cpu);
@@ -999,6 +1000,11 @@ static int __init topology_init(void)
 		if (cpu_online(cpu))
 			register_cpu_online(cpu);
 	}
+
+	__register_cpu_notifier(&sysfs_cpu_nb);
+
+	cpu_notifier_register_done();
+
 #ifdef CONFIG_PPC64
 	sysfs_create_dscr_default();
 #endif /* CONFIG_PPC64 */

