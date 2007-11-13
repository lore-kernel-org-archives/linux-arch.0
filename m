Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate7.uk.ibm.com ([195.212.29.140]:31339 "EHLO
	mtagate7.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753803AbXKMRRy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2007 12:17:54 -0500
Received: from d06nrmr1407.portsmouth.uk.ibm.com (d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lADHHoPt158998
	for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2007 17:17:50 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com [9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id lADHHoxe2756748
	for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2007 17:17:50 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lADHHYKm013250
	for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2007 17:17:34 GMT
Received: from localhost (dyn-9-152-198-41.boeblingen.de.ibm.com [9.152.198.41])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id lADHHYAn012756
	for <linux-arch@vger.kernel.org>; Tue, 13 Nov 2007 17:17:34 GMT
Date: Tue, 13 Nov 2007 18:17:20 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Preemption and BKL
Message-ID: <20071113171720.GA5229@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This might be broken on several other architectures as well therefore
posting here:

We had a bug on s390 when preemption is enabled and preemption of the BKL
is enabled as well. If returning from an interrupt to kernel context we
check for TIF_NEED_RESCHED and if that is true we just call schedule().

However this is broken. Instead of schedule we must call
preempt_schedule_irq() otherwise the BKL will be unlocked and somebody else
might grab it.
This bug explains some strange list corruptions we've seen in fs/locks.c
where all the locking is done with the BKL. And probably a bunch of other
unexplainable bugs.

Patch below is more or less what is needed on s390.

---
 arch/s390/kernel/entry.S   |    8 +++-----
 arch/s390/kernel/entry64.S |    7 +------
 2 files changed, 4 insertions(+), 11 deletions(-)

Index: linux-2.6/arch/s390/kernel/entry64.S
===================================================================
--- linux-2.6.orig/arch/s390/kernel/entry64.S
+++ linux-2.6/arch/s390/kernel/entry64.S
@@ -583,12 +583,7 @@ io_preempt:
 io_resume_loop:
 	tm	__TI_flags+7(%r9),_TIF_NEED_RESCHED
 	jno	io_leave
-	larl	%r1,.Lc_pactive
-	mvc	__TI_precount(4,%r9),0(%r1)
-	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
-	brasl	%r14,schedule		# call schedule
-	stnsm	__SF_EMPTY(%r15),0xfc	# disable I/O and ext. interrupts
-	xc	__TI_precount(4,%r9),__TI_precount(%r9)
+	brasl	%r14,preempt_schedule_irq	# call schedule
 	j	io_resume_loop
 #endif
 
Index: linux-2.6/arch/s390/kernel/entry.S
===================================================================
--- linux-2.6.orig/arch/s390/kernel/entry.S
+++ linux-2.6/arch/s390/kernel/entry.S
@@ -597,12 +597,8 @@ io_preempt:
 io_resume_loop:
 	tm	__TI_flags+3(%r9),_TIF_NEED_RESCHED
 	bno	BASED(io_leave)
-	mvc	__TI_precount(4,%r9),BASED(.Lc_pactive)
-	stosm	__SF_EMPTY(%r15),0x03  # reenable interrupts
-	l	%r1,BASED(.Lschedule)
+	l	%r1,BASED(.Lpreempt_schedule_irq)
 	basr	%r14,%r1	       # call schedule
-	stnsm	__SF_EMPTY(%r15),0xfc  # disable I/O and ext. interrupts
-	xc	__TI_precount(4,%r9),__TI_precount(%r9)
 	b	BASED(io_resume_loop)
 #endif
 
@@ -1043,6 +1039,8 @@ cleanup_io_leave_insn:
 .Lexecve_tail:	.long	execve_tail
 .Ljump_table:	.long	pgm_check_table
 .Lschedule:	.long	schedule
+.Lpreempt_schedule_irq:
+		.long	preempt_schedule_irq
 .Ltrace:	.long	syscall_trace
 .Lschedtail:	.long	schedule_tail
 .Lsysc_table:	.long	sys_call_table
