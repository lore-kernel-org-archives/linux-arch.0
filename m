Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:58457 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753101AbaCJUgE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 10 Mar 2014 16:36:04 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 11 Mar 2014 06:36:02 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 11/52] s390,
 cacheinfo: Fix CPU hotplug callback registration
Date: Tue, 11 Mar 2014 02:05:46 +0530
Message-ID: <20140310203545.10746.78648.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rjw@rjwysocki.net, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-pm@vger.kernel.org, linuxppc-dev@ozlabs.org, srivatsa.bhat@linux.vnet.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140310203546.SARvj0XJZvR01HoopwuQEP2-pNJxp4HcTJ_M-BPnA_E@z>

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


Fix the cacheinfo code in s390 by using this latter form of callback
registration.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/s390/kernel/cache.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/cache.c b/arch/s390/kernel/cache.c
index 3a414c0..c0b03c2 100644
--- a/arch/s390/kernel/cache.c
+++ b/arch/s390/kernel/cache.c
@@ -378,9 +378,12 @@ static int __init cache_init(void)
 	if (!test_facility(34))
 		return 0;
 	cache_build_info();
+
+	cpu_notifier_register_begin();
 	for_each_online_cpu(cpu)
 		cache_add_cpu(cpu);
-	hotcpu_notifier(cache_hotplug, 0);
+	__hotcpu_notifier(cache_hotplug, 0);
+	cpu_notifier_register_done();
 	return 0;
 }
 device_initcall(cache_init);

