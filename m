From: akpm@linux-foundation.org
Subject: [patch 051/176] mm: retry page fault when blocking on disk transfer
Date: Tue, 26 Oct 2010 14:21:57 -0700
Message-ID: <201010262121.o9QLLvlL016512@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59454 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758169Ab0JZVXB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 26 Oct 2010 17:23:01 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, walken@google.com, a.p.zijlstra@chello.nl, fengguang.wu@intel.com, hpa@zytor.com, linux-arch@vger.kernel.org, mingo@elte.hu, nickpiggin@yahoo.com.au, riel@redhat.com, tglx@linutronix.de, yinghan@google.com

From: Michel Lespinasse <walken@google.com>

This change reduces mmap_sem hold times that are caused by waiting for
disk transfers when accessing file mapped VMAs.

It introduces the VM_FAULT_ALLOW_RETRY flag, which indicates that the call
site wants mmap_sem to be released if blocking on a pending disk transfer.
In that case, filemap_fault() returns the VM_FAULT_RETRY status bit and
do_page_fault() will then re-acquire mmap_sem and retry the page fault.

It is expected that the retry will hit the same page which will now be
cached, and thus it will complete with a low mmap_sem hold time.

Tests:

- microbenchmark: thread A mmaps a large file and does random read accesses
  to the mmaped area - achieves about 55 iterations/s. Thread B does
  mmap/munmap in a loop at a separate location - achieves 55 iterations/s
  before, 15000 iterations/s after.

- We are seeing related effects in some applications in house, which show
  significant performance regressions when running without this change.

[akpm@linux-foundation.org: fix warning & crash]
Signed-off-by: Michel Lespinasse <walken@google.com>
Acked-by: Rik van Riel <riel@redhat.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>
Reviewed-by: Wu Fengguang <fengguang.wu@intel.com>
Cc: Ying Han <yinghan@google.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Acked-by: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/mm/fault.c     |   38 ++++++++++++++++++++++++++------------
 include/linux/mm.h      |    2 ++
 include/linux/pagemap.h |   13 +++++++++++++
 mm/filemap.c            |   16 +++++++++++++++-
 mm/memory.c             |   10 ++++++++--
 5 files changed, 64 insertions(+), 15 deletions(-)

diff -puN arch/x86/mm/fault.c~mm-retry-page-fault-when-blocking-on-disk-transfer arch/x86/mm/fault.c
--- a/arch/x86/mm/fault.c~mm-retry-page-fault-when-blocking-on-disk-transfer
+++ a/arch/x86/mm/fault.c
@@ -956,8 +956,10 @@ do_page_fault(struct pt_regs *regs, unsi
 	struct task_struct *tsk;
 	unsigned long address;
 	struct mm_struct *mm;
-	int write;
 	int fault;
+	int write = error_code & PF_WRITE;
+	unsigned int flags = FAULT_FLAG_ALLOW_RETRY |
+					(write ? FAULT_FLAG_WRITE : 0);
 
 	tsk = current;
 	mm = tsk->mm;
@@ -1068,6 +1070,7 @@ do_page_fault(struct pt_regs *regs, unsi
 			bad_area_nosemaphore(regs, error_code, address);
 			return;
 		}
+retry:
 		down_read(&mm->mmap_sem);
 	} else {
 		/*
@@ -1111,8 +1114,6 @@ do_page_fault(struct pt_regs *regs, unsi
 	 * we can handle it..
 	 */
 good_area:
-	write = error_code & PF_WRITE;
-
 	if (unlikely(access_error(error_code, write, vma))) {
 		bad_area_access_error(regs, error_code, address);
 		return;
@@ -1123,21 +1124,34 @@ good_area:
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault:
 	 */
-	fault = handle_mm_fault(mm, vma, address, write ? FAULT_FLAG_WRITE : 0);
+	fault = handle_mm_fault(mm, vma, address, flags);
 
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		mm_fault_error(regs, error_code, address, fault);
 		return;
 	}
 
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0,
-				     regs, address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0,
-				     regs, address);
+	/*
+	 * Major/minor page fault accounting is only done on the
+	 * initial attempt. If we go through a retry, it is extremely
+	 * likely that the page will be found in page cache at that point.
+	 */
+	if (flags & FAULT_FLAG_ALLOW_RETRY) {
+		if (fault & VM_FAULT_MAJOR) {
+			tsk->maj_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, 0,
+				      regs, address);
+		} else {
+			tsk->min_flt++;
+			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, 0,
+				      regs, address);
+		}
+		if (fault & VM_FAULT_RETRY) {
+			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
+			 * of starvation. */
+			flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			goto retry;
+		}
 	}
 
 	check_v8086_mode(regs, address, tsk);
diff -puN include/linux/mm.h~mm-retry-page-fault-when-blocking-on-disk-transfer include/linux/mm.h
--- a/include/linux/mm.h~mm-retry-page-fault-when-blocking-on-disk-transfer
+++ a/include/linux/mm.h
@@ -144,6 +144,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_WRITE	0x01	/* Fault was a write access */
 #define FAULT_FLAG_NONLINEAR	0x02	/* Fault was via a nonlinear mapping */
 #define FAULT_FLAG_MKWRITE	0x04	/* Fault was mkwrite of existing pte */
+#define FAULT_FLAG_ALLOW_RETRY	0x08	/* Retry fault if blocking */
 
 /*
  * This interface is used by x86 PAT code to identify a pfn mapping that is
@@ -723,6 +724,7 @@ static inline int page_mapped(struct pag
 
 #define VM_FAULT_NOPAGE	0x0100	/* ->fault installed the pte, not return page */
 #define VM_FAULT_LOCKED	0x0200	/* ->fault locked the returned page */
+#define VM_FAULT_RETRY	0x0400	/* ->fault blocked, must retry */
 
 #define VM_FAULT_HWPOISON_LARGE_MASK 0xf000 /* encodes hpage index for large hwpoison */
 
diff -puN include/linux/pagemap.h~mm-retry-page-fault-when-blocking-on-disk-transfer include/linux/pagemap.h
--- a/include/linux/pagemap.h~mm-retry-page-fault-when-blocking-on-disk-transfer
+++ a/include/linux/pagemap.h
@@ -299,6 +299,8 @@ static inline pgoff_t linear_page_index(
 extern void __lock_page(struct page *page);
 extern int __lock_page_killable(struct page *page);
 extern void __lock_page_nosync(struct page *page);
+extern int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+				unsigned int flags);
 extern void unlock_page(struct page *page);
 
 static inline void __set_page_locked(struct page *page)
@@ -351,6 +353,17 @@ static inline void lock_page_nosync(stru
 }
 	
 /*
+ * lock_page_or_retry - Lock the page, unless this would block and the
+ * caller indicated that it can handle a retry.
+ */
+static inline int lock_page_or_retry(struct page *page, struct mm_struct *mm,
+				     unsigned int flags)
+{
+	might_sleep();
+	return trylock_page(page) || __lock_page_or_retry(page, mm, flags);
+}
+
+/*
  * This is exported only for wait_on_page_locked/wait_on_page_writeback.
  * Never use this directly!
  */
diff -puN mm/filemap.c~mm-retry-page-fault-when-blocking-on-disk-transfer mm/filemap.c
--- a/mm/filemap.c~mm-retry-page-fault-when-blocking-on-disk-transfer
+++ a/mm/filemap.c
@@ -612,6 +612,19 @@ void __lock_page_nosync(struct page *pag
 							TASK_UNINTERRUPTIBLE);
 }
 
+int __lock_page_or_retry(struct page *page, struct mm_struct *mm,
+			 unsigned int flags)
+{
+	if (!(flags & FAULT_FLAG_ALLOW_RETRY)) {
+		__lock_page(page);
+		return 1;
+	} else {
+		up_read(&mm->mmap_sem);
+		wait_on_page_locked(page);
+		return 0;
+	}
+}
+
 /**
  * find_get_page - find and get a page reference
  * @mapping: the address_space to search
@@ -1550,7 +1563,8 @@ retry_find:
 			goto no_cached_page;
 	}
 
-	lock_page(page);
+	if (!lock_page_or_retry(page, vma->vm_mm, vmf->flags))
+		return ret | VM_FAULT_RETRY;
 
 	/* Did it get truncated? */
 	if (unlikely(page->mapping != mapping)) {
diff -puN mm/memory.c~mm-retry-page-fault-when-blocking-on-disk-transfer mm/memory.c
--- a/mm/memory.c~mm-retry-page-fault-when-blocking-on-disk-transfer
+++ a/mm/memory.c
@@ -2627,6 +2627,7 @@ static int do_swap_page(struct mm_struct
 	struct page *page, *swapcache = NULL;
 	swp_entry_t entry;
 	pte_t pte;
+	int locked;
 	struct mem_cgroup *ptr = NULL;
 	int exclusive = 0;
 	int ret = 0;
@@ -2677,8 +2678,12 @@ static int do_swap_page(struct mm_struct
 		goto out_release;
 	}
 
-	lock_page(page);
+	locked = lock_page_or_retry(page, mm, flags);
 	delayacct_clear_flag(DELAYACCT_PF_SWAPIN);
+	if (!locked) {
+		ret |= VM_FAULT_RETRY;
+		goto out_release;
+	}
 
 	/*
 	 * Make sure try_to_free_swap or reuse_swap_page or swapoff did not
@@ -2927,7 +2932,8 @@ static int __do_fault(struct mm_struct *
 	vmf.page = NULL;
 
 	ret = vma->vm_ops->fault(vma, &vmf);
-	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
+	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE |
+			    VM_FAULT_RETRY)))
 		return ret;
 
 	if (unlikely(PageHWPoison(vmf.page))) {
_
