Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp07.in.ibm.com ([122.248.162.7]:37804 "EHLO
	e28smtp07.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab2FAJMW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 05:12:22 -0400
Received: from /spool/local
	by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Fri, 1 Jun 2012 14:42:20 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 05/27] xen,
 cpu hotplug: Don't call cpu_bringup() in xen_play_dead()
Date: Fri, 01 Jun 2012 14:41:31 +0530
Message-ID: <20120601091124.31979.91984.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com
Cc: rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jeremy Fitzhardinge <jeremy@goop.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org
Message-ID: <20120601091131.utPHTiGZacsoH_iQhSXuXTh-aI1WFe8ffa7C3k_h3CE@z>

xen_play_dead calls cpu_bringup() which looks weird, because xen_play_dead()
is invoked in the cpu down path, whereas cpu_bringup() (as the name suggests)
is useful in the cpu bringup path.

Getting rid of xen_play_dead()'s dependency on cpu_bringup() helps in hooking
on to the generic SMP booting framework.

Also remove the extra call to preempt_enable() added by commit 41bd956
(xen/smp: Fix CPU online/offline bug triggering a BUG: scheduling while
atomic) because it becomes unnecessary after this change.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xensource.com
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/x86/xen/smp.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 09a7199..602d6b7 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -417,14 +417,6 @@ static void __cpuinit xen_play_dead(void) /* used only with HOTPLUG_CPU */
 {
 	play_dead_common();
 	HYPERVISOR_vcpu_op(VCPUOP_down, smp_processor_id(), NULL);
-	cpu_bringup();
-	/*
-	 * Balance out the preempt calls - as we are running in cpu_idle
-	 * loop which has been called at bootup from cpu_bringup_and_idle.
-	 * The cpucpu_bringup_and_idle called cpu_bringup which made a
-	 * preempt_disable() So this preempt_enable will balance it out.
-	 */
-	preempt_enable();
 }
 
 #else /* !CONFIG_HOTPLUG_CPU */

