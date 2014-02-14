From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2 31/52] arm64,
 debug-monitors: Fix CPU hotplug callback registration
Date: Fri, 14 Feb 2014 13:26:13 +0530
Message-ID: <20140214075612.22701.36819.stgit@srivatsabhat.in.ibm.com>
References: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140214074750.22701.47330.stgit@srivatsabhat.in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paulus@samba.org, oleg@redhat.com, rusty@rustcorp.com.au, peterz@infradead.org, tglx@linutronix.de, akpm@linux-foundation.org
Cc: paulmck@linux.vnet.ibm.com, tj@kernel.org, walken@google.com, ego@linux.vnet.ibm.com, linux@arm.linux.org.uk, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Ingo Molnar <mingo@kernel.org>, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>"Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
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


Fix the debug-monitors code in arm64 by using this latter form of callback
registration.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/arm64/kernel/debug-monitors.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 636ba8b..c985531 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -155,12 +155,16 @@ static struct notifier_block os_lock_nb = {
 
 static int debug_monitors_init(void)
 {
+	cpu_notifier_register_begin();
+
 	/* Clear the OS lock. */
 	smp_call_function(clear_os_lock, NULL, 1);
 	clear_os_lock(NULL);
 
 	/* Register hotplug handler. */
-	register_cpu_notifier(&os_lock_nb);
+	__register_cpu_notifier(&os_lock_nb);
+
+	cpu_notifier_register_done();
 	return 0;
 }
 postcore_initcall(debug_monitors_init);
