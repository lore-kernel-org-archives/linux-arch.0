Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:44383 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbaBNH6g (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 02:58:36 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 13:28:33 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 17/52] x86, vsyscall: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:22:58 +0530
Message-ID: <20140214075258.22701.21926.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075258.h3m2JXWGVhxtIt1xj43sb3BXSB6FUOcP8tmzu2m0jm4@z>

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


Fix the vsyscall code in x86 by using this latter form of callback
registration.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/kernel/vsyscall_64.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vsyscall_64.c b/arch/x86/kernel/vsyscall_64.c
index 1f96f93..556eaf2 100644
--- a/arch/x86/kernel/vsyscall_64.c
+++ b/arch/x86/kernel/vsyscall_64.c
@@ -393,9 +393,13 @@ static int __init vsyscall_init(void)
 {
 	BUG_ON(VSYSCALL_ADDR(0) != __fix_to_virt(VSYSCALL_FIRST_PAGE));
 
+	cpu_notifier_register_begin();
+
 	on_each_cpu(cpu_vsyscall_init, NULL, 1);
 	/* notifier priority > KVM */
-	hotcpu_notifier(cpu_vsyscall_notifier, 30);
+	__hotcpu_notifier(cpu_vsyscall_notifier, 30);
+
+	cpu_notifier_register_done();
 
 	return 0;
 }

