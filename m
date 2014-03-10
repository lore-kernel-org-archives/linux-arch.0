From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 50/52] mm, zswap: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:12:40 +0530
Message-ID: <20140310204239.10746.94222.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
Sender: owner-linux-mm@kvack.org
To: paulus@samba.org, oleg@redhat.com, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
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


Fix the zswap code by using this latter form of callback registration.

Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-mm@kvack.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 mm/zswap.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index e55bab9..d7337fb 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -387,18 +387,18 @@ static int zswap_cpu_init(void)
 {
 	unsigned long cpu;
 
-	get_online_cpus();
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu)
 		if (__zswap_cpu_notifier(CPU_UP_PREPARE, cpu) != NOTIFY_OK)
 			goto cleanup;
-	register_cpu_notifier(&zswap_cpu_notifier_block);
-	put_online_cpus();
+	__register_cpu_notifier(&zswap_cpu_notifier_block);
+	cpu_notifier_register_done();
 	return 0;
 
 cleanup:
 	for_each_online_cpu(cpu)
 		__zswap_cpu_notifier(CPU_UP_CANCELED, cpu);
-	put_online_cpus();
+	cpu_notifier_register_done();
 	return -ENOMEM;
 }
 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
