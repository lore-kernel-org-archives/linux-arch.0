Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 29 Jan 2005 12:23:21 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: TASK_SIZE is variable.
Message-Id: <20050129122321.0cac707c.akpm@osdl.org>
In-Reply-To: <1106692012.6480.158.camel@localhost.localdomain>
References: <1106692012.6480.158.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


Guys, could I get a bit of clarity on how we want to proceed with all of
this?

I have the below two patches queued.  Speak now or forever stfu!



From: David Woodhouse <dwmw2@infradead.org>

Bad things can happen if a 32-bit process is the last user of a 64-bit mm. 
TASK_SIZE isn't a constant, and we can end up clearing page tables only up
to the 32-bit TASK_SIZE instead of all the way.  We should probably
double-check every instance of TASK_SIZE or USER_PTRS_PER_PGD for this kind
of problem.

We should also double-check that MM_VM_SIZE() and other such things are
correctly defined on all architectures.  I already fixed ppc64 which let it
stay as TASK_SIZE, and hence dependent on the _current_ context instead of
the mm in the argument.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/mmap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN mm/mmap.c~task_size-is-variable mm/mmap.c
--- 25/mm/mmap.c~task_size-is-variable	2005-01-25 22:08:40.903785456 -0800
+++ 25-akpm/mm/mmap.c	2005-01-25 22:08:40.908784696 -0800
@@ -1612,8 +1612,8 @@ static void free_pgtables(struct mmu_gat
 	unsigned long last = end + PGDIR_SIZE - 1;
 	struct mm_struct *mm = tlb->mm;
 
-	if (last > TASK_SIZE || last < end)
-		last = TASK_SIZE;
+	if (last > MM_VM_SIZE(mm) || last < end)
+		last = MM_VM_SIZE(mm);
 
 	if (!prev) {
 		prev = mm->mmap;
_



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
