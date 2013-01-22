Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6]:54344 "EHLO
	e28smtp06.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308Ab3AVHnL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jan 2013 02:43:11 -0500
Received: from /spool/local
	by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 22 Jan 2013 13:11:14 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v5 30/45] alpha/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Date: Tue, 22 Jan 2013 13:11:18 +0530
Message-ID: <20130122074113.13822.3018.stgit@srivatsabhat.in.ibm.com>
In-Reply-To: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, peterz@infradead.org, tj@kernel.org, oleg@redhat.com, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, akpm@linux-foundation.org, namhyung@kernel.org
Cc: rostedt@goodmis.org, wangyun@linux.vnet.ibm.com, xiaoguangrong@linux.vnet.ibm.com, rjw@sisk.pl, sbw@mit.edu, fweisbec@gmail.com, linux@arm.linux.org.uk, nikunj@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130122074118.z3NzH5Iru7sF9Nv63T8eRtu1Y0OJ7aHlQ4AtOpfhSsU@z>

Once stop_machine() is gone from the CPU offline path, we won't be able to
depend on preempt_disable() or local_irq_disable() to prevent CPUs from
going offline from under us.

Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going offline,
while invoking from atomic context.

Also, remove the non-ASCII character present in this file!

Cc: linux-alpha@vger.kernel.org
Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

 arch/alpha/kernel/smp.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 9603bc2..9213d5d 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -498,7 +498,6 @@ smp_cpus_done(unsigned int max_cpus)
 	       ((bogosum + 2500) / (5000/HZ)) % 100);
 }
 
-
 void
 smp_percpu_timer_interrupt(struct pt_regs *regs)
 {
@@ -682,7 +681,7 @@ ipi_flush_tlb_mm(void *x)
 void
 flush_tlb_mm(struct mm_struct *mm)
 {
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		flush_tlb_current(mm);
@@ -694,7 +693,7 @@ flush_tlb_mm(struct mm_struct *mm)
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -703,7 +702,7 @@ flush_tlb_mm(struct mm_struct *mm)
 		printk(KERN_CRIT "flush_tlb_mm: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(flush_tlb_mm);
 
@@ -731,7 +730,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 	struct flush_tlb_page_struct data;
 	struct mm_struct *mm = vma->vm_mm;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		flush_tlb_current_page(mm, vma, addr);
@@ -743,7 +742,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -756,7 +755,7 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 		printk(KERN_CRIT "flush_tlb_page: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }
 EXPORT_SYMBOL(flush_tlb_page);
 
@@ -787,7 +786,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 	if ((vma->vm_flags & VM_EXEC) == 0)
 		return;
 
-	preempt_disable();
+	get_online_cpus_atomic();
 
 	if (mm == current->active_mm) {
 		__load_new_mm_context(mm);
@@ -799,7 +798,7 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 				if (mm->context[cpu])
 					mm->context[cpu] = 0;
 			}
-			preempt_enable();
+			put_online_cpus_atomic();
 			return;
 		}
 	}
@@ -808,5 +807,5 @@ flush_icache_user_range(struct vm_area_struct *vma, struct page *page,
 		printk(KERN_CRIT "flush_icache_page: timed out\n");
 	}
 
-	preempt_enable();
+	put_online_cpus_atomic();
 }

