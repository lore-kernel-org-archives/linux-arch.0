Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shinybook.infradead.org ([81.187.226.99])
	by canuck.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1CtZCz-0004co-Jn
	for linux-arch@vger.kernel.org; Tue, 25 Jan 2005 17:30:51 -0500
Subject: TASK_SIZE is variable.
From: David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 22:26:52 +0000
Message-Id: <1106692012.6480.158.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Bad things can happen if a 32-bit process is the last user of a 64-bit
mm. TASK_SIZE isn't a constant, and we can end up clearing page tables
only up to the 32-bit TASK_SIZE instead of all the way. We should
probably double-check every instance of TASK_SIZE or USER_PTRS_PER_PGD
for this kind of problem.

We should also double-check that MM_VM_SIZE() and other such things are
correctly defined on all architectures. I already fixed ppc64 which let
it stay as TASK_SIZE, and hence dependent on the _current_ context
instead of the mm in the argument.

--- mm/mmap.c.orig	2005-01-25 22:23:02.030427272 +0000
+++ mm/mmap.c	2005-01-25 22:23:55.627279312 +0000
@@ -1612,8 +1612,8 @@ static void free_pgtables(struct mmu_gat
 	unsigned long last = end + PGDIR_SIZE - 1;
 	struct mm_struct *mm = tlb->mm;
 
-	if (last > TASK_SIZE || last < end)
-		last = TASK_SIZE;
+	if (last > MM_VM_SIZE(mm) || last < end)
+		last = MM_VM_SIZE(mm);
 
 	if (!prev) {
 		prev = mm->mmap;
@@ -1996,7 +1996,7 @@ void exit_mmap(struct mm_struct *mm)
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
 	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE,
-			(TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK);
+			(MM_VM_SIZE(mm) + PGDIR_SIZE - 1) & PGDIR_MASK);
 	
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 

-- 
dwmw2
