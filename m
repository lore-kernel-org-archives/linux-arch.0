Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:35303 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab3BRMqC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2013 07:46:02 -0500
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Mon, 18 Feb 2013 22:36:54 +1000
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 40/46] powerpc: Use get/put_online_cpus_atomic() to prevent
 CPU offline
Date: Mon, 18 Feb 2013 18:13:51 +0530
Message-ID: <20130218124350.26245.49623.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, walken@google.com, vincent.guittot@linaro.org
Message-ID: <20130218124351.k5NC5-w__mnm80icC1dkd2OTLI68Wc4D5CLsg8UNtuE@z>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/powerpc/mm/mmu_context_nohash.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index e779642..29f58cf 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -196,6 +196,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 
 	/* No lockless fast path .. yet */
 	raw_spin_lock(&context_lock);
+	get_online_cpus_atomic();
 
 	pr_hard("[%d] activating context for mm @%p, active=%d, id=%d",
 		cpu, next, next->context.active, next->context.id);
@@ -279,6 +280,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 	/* Flick the MMU and release lock */
 	pr_hardcont(" -> %d\n", id);
 	set_context(id, next->pgd);
+	put_online_cpus_atomic();
 	raw_spin_unlock(&context_lock);
 }
 

