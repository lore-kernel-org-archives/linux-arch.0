Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:60984 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbaBNH5P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2014 02:57:15 -0500
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 14 Feb 2014 17:56:57 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 10/52] arm, kvm: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:21:23 +0530
Message-ID: <20140214075122.22701.18462.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org, oleg@redhat.com, mingo@kernel.org, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Christoffer Dall <christoffer.dall@linaro.org>, Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>Russell King <linux@arm.linux.org.uk>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Message-ID: <20140214075123.Ij3qeoIdkwFE1hrptOutR5yk_rSmOfILu-m1lTRla5k@z>

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


Fix the kvm code in arm by using this latter form of callback registration.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: kvmarm@lists.cs.columbia.edu
Cc: kvm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm/kvm/arm.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 1d8248e..147b917 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1050,21 +1050,26 @@ int kvm_arch_init(void *opaque)
 		}
 	}
 
+	cpu_notifier_register_begin();
+
 	err = init_hyp_mode();
 	if (err)
 		goto out_err;
 
-	err = register_cpu_notifier(&hyp_init_cpu_nb);
+	err = __register_cpu_notifier(&hyp_init_cpu_nb);
 	if (err) {
 		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
 		goto out_err;
 	}
 
+	cpu_notifier_register_done();
+
 	hyp_cpu_pm_init();
 
 	kvm_coproc_table_init();
 	return 0;
 out_err:
+	cpu_notifier_register_done();
 	return err;
 }
 

