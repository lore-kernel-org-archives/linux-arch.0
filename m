Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16889.43580.716149.901314@cargo.ozlabs.ibm.com>
Date: Fri, 28 Jan 2005 13:58:04 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: TASK_SIZE is variable.
In-Reply-To: <20050126000117.62fff2a7.akpm@osdl.org>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050125155239.4bc469e6.davem@davemloft.net>
	<20050126063627.GA7198@wotan.suse.de>
	<20050125224112.306cd1ea.davem@davemloft.net>
	<20050126071359.GD7198@wotan.suse.de>
	<20050126074306.GE7198@wotan.suse.de>
	<20050126000117.62fff2a7.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Here is a patch that I did recently to reduce the overhead of
clear_page_tables() when using 64k pages on ppc64.  It keeps a record
of the maximum address that has been used in each mm_struct.  With
this we can kill MM_VM_SIZE.

Andrew - could this go in -mm perhaps?

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.6.10/include/asm-ia64/processor.h g5-64k/include/asm-ia64/processor.h
--- linux-2.6.10/include/asm-ia64/processor.h	2004-11-11 09:57:35.000000000 +1100
+++ g5-64k/include/asm-ia64/processor.h	2005-01-28 13:52:42.000000000 +1100
@@ -43,14 +43,6 @@
 #define TASK_SIZE		(current->thread.task_size)
 
 /*
- * MM_VM_SIZE(mm) gives the maximum address (plus 1) which may contain a mapping for
- * address-space MM.  Note that with 32-bit tasks, this is still DEFAULT_TASK_SIZE,
- * because the kernel may have installed helper-mappings above TASK_SIZE.  For example,
- * for x86 emulation, the LDT and GDT are mapped above TASK_SIZE.
- */
-#define MM_VM_SIZE(mm)		DEFAULT_TASK_SIZE
-
-/*
  * This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
diff -urN linux-2.6.10/include/linux/mm.h g5-64k/include/linux/mm.h
--- linux-2.6.10/include/linux/mm.h	2004-11-25 17:42:43.000000000 +1100
+++ g5-64k/include/linux/mm.h	2005-01-28 13:52:14.848021352 +1100
@@ -37,10 +37,6 @@
 #include <asm/processor.h>
 #include <asm/atomic.h>
 
-#ifndef MM_VM_SIZE
-#define MM_VM_SIZE(mm)	TASK_SIZE
-#endif
-
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
 /*
diff -urN linux-2.6.10/include/linux/sched.h g5-64k/include/linux/sched.h
--- linux-2.6.10/include/linux/sched.h	2004-12-03 18:31:57.000000000 +1100
+++ g5-64k/include/linux/sched.h	2004-12-26 16:21:37.000000000 +1100
@@ -228,6 +228,7 @@
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags, nr_ptes;
+	unsigned long max_addr;
 
 	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
 
diff -urN linux-2.6.10/mm/mmap.c g5-64k/mm/mmap.c
--- linux-2.6.10/mm/mmap.c	2004-12-13 21:47:27.000000000 +1100
+++ g5-64k/mm/mmap.c	2005-01-28 13:47:33.000000000 +1100
@@ -317,6 +317,8 @@
 	if (mapping)
 		spin_unlock(&mapping->i_mmap_lock);
 
+	if (vma->vm_end && vma->vm_end - 1 > mm->max_addr)
+		mm->max_addr = vma->vm_end - 1;
 	mm->map_count++;
 	validate_mm(mm);
 }
@@ -496,6 +498,8 @@
 		}
 	}
 
+	if (vma->vm_end && vma->vm_end - 1 > mm->max_addr)
+		mm->max_addr = vma->vm_end - 1;
 	validate_mm(mm);
 }
 
@@ -1832,6 +1836,7 @@
 	struct mmu_gather *tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted = 0;
+	int nr_pgds;
 
 	lru_add_drain();
 
@@ -1844,8 +1849,10 @@
 					~0UL, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_tables(tlb, FIRST_USER_PGD_NR, USER_PTRS_PER_PGD);
-	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
+	nr_pgds = pgd_index(mm->max_addr) - FIRST_USER_PGD_NR + 1;
+	if (nr_pgds > 0)
+		clear_page_tables(tlb, FIRST_USER_PGD_NR, nr_pgds);
+	tlb_finish_mmu(tlb, 0, mm->max_addr + 1);
 
 	vma = mm->mmap;
 	mm->mmap = mm->mmap_cache = NULL;
