Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 27 Jan 2005 19:17:38 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050127191738.13d65896.akpm@osdl.org>
In-Reply-To: <16889.44363.612523.453157@cargo.ozlabs.ibm.com>
References: <1106692012.6480.158.camel@localhost.localdomain>
	<20050125155239.4bc469e6.davem@davemloft.net>
	<20050126063627.GA7198@wotan.suse.de>
	<20050125224112.306cd1ea.davem@davemloft.net>
	<20050126071359.GD7198@wotan.suse.de>
	<20050126074306.GE7198@wotan.suse.de>
	<20050126000117.62fff2a7.akpm@osdl.org>
	<16889.43580.716149.901314@cargo.ozlabs.ibm.com>
	<16889.44363.612523.453157@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Paul Mackerras <paulus@samba.org>
Cc: ak@suse.de, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Paul Mackerras <paulus@samba.org> wrote:
>
> > Here is a patch that I did recently to reduce the overhead of
>  > clear_page_tables() when using 64k pages on ppc64.  It keeps a record
>  > of the maximum address that has been used in each mm_struct.  With
>  > this we can kill MM_VM_SIZE.
> 
>  And I sent the 2.6.10 version of the patch, unfortunately.  Here is a
>  patch against current BK.

OK..  I'll drop Anton's patch:


From: Anton Blanchard <anton@samba.org>

The 4 level pagetable code changed the exit_mmap code to rely on TASK_SIZE.
 On some architectures (eg ppc64 and ia64), this is a per task property and
bad things can happen in certain circumstances when using it.

It is possible for one task to end up "owning" an mm from another - we have
seen this with the procfs code when process 1 accesses /proc/pid/cmdline of
process 2 while it is exiting.  Process 2 exits but does not tear its mm
down.  Later on process 1 finishes with the proc file and the mm gets torn
down at this point.

Now if process 1 was 32bit and process 2 was 64bit then we end up using a
bad value for TASK_SIZE in exit_mmap.  We only tear down part of the
address space and leave half initialised pagetables and entries in the MMU
etc.

MM_VM_SIZE() was created for this purpose (and is used in the next line for
tlb_finish_mmu), so use it.  I moved the PGD round up of TASK_SIZE into the
default MM_VM_SIZE.

As an aside, all architectures except one define FIRST_USER_PGD_NR as 0:

include/asm-arm26/pgtable.h:#define FIRST_USER_PGD_NR       1

It would be nice to get rid of one more magic constant and just clear from
0 ...  MM_VM_SIZE().  That would make it consistent with the tlb_flush_mmu
call below it too.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/mm.h |    2 +-
 25-akpm/mm/mmap.c          |    3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff -puN include/linux/mm.h~use-mm_vm_size-in-exit_mmap include/linux/mm.h
--- 25/include/linux/mm.h~use-mm_vm_size-in-exit_mmap	2005-01-25 21:41:44.365536624 -0800
+++ 25-akpm/include/linux/mm.h	2005-01-25 21:41:44.371535712 -0800
@@ -38,7 +38,7 @@ extern int sysctl_legacy_va_layout;
 #include <asm/atomic.h>
 
 #ifndef MM_VM_SIZE
-#define MM_VM_SIZE(mm)	TASK_SIZE
+#define MM_VM_SIZE(mm)	((TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK)
 #endif
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
diff -puN mm/mmap.c~use-mm_vm_size-in-exit_mmap mm/mmap.c
--- 25/mm/mmap.c~use-mm_vm_size-in-exit_mmap	2005-01-25 21:41:44.367536320 -0800
+++ 25-akpm/mm/mmap.c	2005-01-25 21:41:44.373535408 -0800
@@ -1980,8 +1980,7 @@ void exit_mmap(struct mm_struct *mm)
 					~0UL, &nr_accounted, NULL);
 	vm_unacct_memory(nr_accounted);
 	BUG_ON(mm->map_count);	/* This is just debugging */
-	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE,
-			(TASK_SIZE + PGDIR_SIZE - 1) & PGDIR_MASK);
+	clear_page_range(tlb, FIRST_USER_PGD_NR * PGDIR_SIZE, MM_VM_SIZE(mm));
 	
 	tlb_finish_mmu(tlb, 0, MM_VM_SIZE(mm));
 
_
