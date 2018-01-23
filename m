From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 09/10] mm/memory_failure: Remove unused trapno from memory_failure
Date: Tue, 23 Jan 2018 15:07:18 -0600
Message-ID: <20180123210719.10456-9-ebiederm@xmission.com>
References: <87607s5lra.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:51935 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932312AbeAWVJU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Jan 2018 16:09:20 -0500
In-Reply-To: <87607s5lra.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, Ram Pai <linuxram@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>

Today 4 architectures set ARCH_SUPPORTS_MEMORY_FAILURE (arm64, parisc,
powerpc, and x86), while 4 other architectures set __ARCH_SI_TRAPNO
(alpha, metag, sparc, and tile).  These two sets of architectures do
not interesect so remove the trapno paramater to remove confusion.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/parisc/kernel/pdt.c                           |  2 +-
 .../powerpc/platforms/powernv/opal-memory-errors.c |  2 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |  6 ++--
 drivers/acpi/apei/ghes.c                           |  2 +-
 drivers/base/memory.c                              |  2 +-
 drivers/ras/cec.c                                  |  2 +-
 include/linux/mm.h                                 |  4 +--
 mm/hwpoison-inject.c                               |  2 +-
 mm/madvise.c                                       |  2 +-
 mm/memory-failure.c                                | 33 +++++++++-------------
 10 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index e07eb34c8750..36434d4da381 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -325,7 +325,7 @@ static int pdt_mainloop(void *unused)
 #ifdef CONFIG_MEMORY_FAILURE
 			if ((pde & PDT_ADDR_PERM_ERR) ||
 			    ((pde & PDT_ADDR_SINGLE_ERR) == 0))
-				memory_failure(pde >> PAGE_SHIFT, 0, 0);
+				memory_failure(pde >> PAGE_SHIFT, 0);
 			else
 				soft_offline_page(
 					pfn_to_page(pde >> PAGE_SHIFT), 0);
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index d9916ea62305..8ddc1accf199 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -60,7 +60,7 @@ static void handle_memory_error_event(struct OpalMemoryErrorData *merr_evt)
 	}
 
 	for (; paddr_start < paddr_end; paddr_start += PAGE_SIZE) {
-		memory_failure(paddr_start >> PAGE_SHIFT, 0, 0);
+		memory_failure(paddr_start >> PAGE_SHIFT, 0);
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index b1d616d08eee..3b7319e25168 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -582,7 +582,7 @@ static int srao_decode_notifier(struct notifier_block *nb, unsigned long val,
 
 	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
 		pfn = mce->addr >> PAGE_SHIFT;
-		memory_failure(pfn, MCE_VECTOR, 0);
+		memory_failure(pfn, 0);
 	}
 
 	return NOTIFY_OK;
@@ -1046,7 +1046,7 @@ static int do_memory_failure(struct mce *m)
 	pr_err("Uncorrected hardware memory error in user-access at %llx", m->addr);
 	if (!(m->mcgstatus & MCG_STATUS_RIPV))
 		flags |= MF_MUST_KILL;
-	ret = memory_failure(m->addr >> PAGE_SHIFT, MCE_VECTOR, flags);
+	ret = memory_failure(m->addr >> PAGE_SHIFT, flags);
 	if (ret)
 		pr_err("Memory error not recovered");
 	return ret;
@@ -1325,7 +1325,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 EXPORT_SYMBOL_GPL(do_machine_check);
 
 #ifndef CONFIG_MEMORY_FAILURE
-int memory_failure(unsigned long pfn, int vector, int flags)
+int memory_failure(unsigned long pfn, int flags)
 {
 	/* mce_severity() should not hand us an ACTION_REQUIRED error */
 	BUG_ON(flags & MF_ACTION_REQUIRED);
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 6402f7fad3bb..bb5f9c643e0e 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -410,7 +410,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
 		flags = 0;
 
 	if (flags != -1)
-		memory_failure_queue(pfn, 0, flags);
+		memory_failure_queue(pfn, flags);
 #endif
 }
 
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 1d60b58a8c19..fe4b24f05f6a 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -569,7 +569,7 @@ store_hard_offline_page(struct device *dev,
 	if (kstrtoull(buf, 0, &pfn) < 0)
 		return -EINVAL;
 	pfn >>= PAGE_SHIFT;
-	ret = memory_failure(pfn, 0, 0);
+	ret = memory_failure(pfn, 0);
 	return ret ? ret : count;
 }
 
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index ca44e6977cf2..2d9ec378a8bc 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -327,7 +327,7 @@ int cec_add_elem(u64 pfn)
 		} else {
 			/* We have reached max count for this page, soft-offline it. */
 			pr_err("Soft-offlining pfn: 0x%llx\n", pfn);
-			memory_failure_queue(pfn, 0, MF_SOFT_OFFLINE);
+			memory_failure_queue(pfn, MF_SOFT_OFFLINE);
 			ca->pfns_poisoned++;
 		}
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ea818ff739cd..7fc92384977e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2570,8 +2570,8 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 };
-extern int memory_failure(unsigned long pfn, int trapno, int flags);
-extern void memory_failure_queue(unsigned long pfn, int trapno, int flags);
+extern int memory_failure(unsigned long pfn, int flags);
+extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int unpoison_memory(unsigned long pfn);
 extern int get_hwpoison_page(struct page *page);
 #define put_hwpoison_page(page)	put_page(page)
diff --git a/mm/hwpoison-inject.c b/mm/hwpoison-inject.c
index 356df057a2a8..b6ac70616c32 100644
--- a/mm/hwpoison-inject.c
+++ b/mm/hwpoison-inject.c
@@ -52,7 +52,7 @@ static int hwpoison_inject(void *data, u64 val)
 
 inject:
 	pr_info("Injecting memory failure at pfn %#lx\n", pfn);
-	return memory_failure(pfn, 18, MF_COUNT_INCREASED);
+	return memory_failure(pfn, MF_COUNT_INCREASED);
 put_out:
 	put_hwpoison_page(p);
 	return 0;
diff --git a/mm/madvise.c b/mm/madvise.c
index 751e97aa2210..4d3c922ea1a1 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -661,7 +661,7 @@ static int madvise_inject_error(int behavior,
 		pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
 						page_to_pfn(page), start);
 
-		ret = memory_failure(page_to_pfn(page), 0, MF_COUNT_INCREASED);
+		ret = memory_failure(page_to_pfn(page), MF_COUNT_INCREASED);
 		if (ret)
 			return ret;
 	}
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 4acdf393a801..c5f5f31bd979 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -178,7 +178,7 @@ EXPORT_SYMBOL_GPL(hwpoison_filter);
  * ``action optional'' if they are not immediately affected by the error
  * ``action required'' if error happened in current execution context
  */
-static int kill_proc(struct task_struct *t, unsigned long addr, int trapno,
+static int kill_proc(struct task_struct *t, unsigned long addr,
 			unsigned long pfn, struct page *page, int flags)
 {
 	struct siginfo si;
@@ -189,9 +189,6 @@ static int kill_proc(struct task_struct *t, unsigned long addr, int trapno,
 	si.si_signo = SIGBUS;
 	si.si_errno = 0;
 	si.si_addr = (void *)addr;
-#ifdef __ARCH_SI_TRAPNO
-	si.si_trapno = trapno;
-#endif
 	si.si_addr_lsb = compound_order(compound_head(page)) + PAGE_SHIFT;
 
 	if ((flags & MF_ACTION_REQUIRED) && t->mm == current->mm) {
@@ -323,7 +320,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
  * Also when FAIL is set do a force kill because something went
  * wrong earlier.
  */
-static void kill_procs(struct list_head *to_kill, int forcekill, int trapno,
+static void kill_procs(struct list_head *to_kill, int forcekill,
 			  bool fail, struct page *page, unsigned long pfn,
 			  int flags)
 {
@@ -348,7 +345,7 @@ static void kill_procs(struct list_head *to_kill, int forcekill, int trapno,
 			 * check for that, but we need to tell the
 			 * process anyways.
 			 */
-			else if (kill_proc(tk->tsk, tk->addr, trapno,
+			else if (kill_proc(tk->tsk, tk->addr,
 					      pfn, page, flags) < 0)
 				pr_err("Memory failure: %#lx: Cannot send advisory machine check signal to %s:%d\n",
 				       pfn, tk->tsk->comm, tk->tsk->pid);
@@ -927,7 +924,7 @@ EXPORT_SYMBOL_GPL(get_hwpoison_page);
  * the pages and send SIGBUS to the processes if the data was dirty.
  */
 static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
-				  int trapno, int flags, struct page **hpagep)
+				  int flags, struct page **hpagep)
 {
 	enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
 	struct address_space *mapping;
@@ -1017,7 +1014,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
 	 * any accesses to the poisoned memory.
 	 */
 	forcekill = PageDirty(hpage) || (flags & MF_MUST_KILL);
-	kill_procs(&tokill, forcekill, trapno, !unmap_success, p, pfn, flags);
+	kill_procs(&tokill, forcekill, !unmap_success, p, pfn, flags);
 
 	return unmap_success;
 }
@@ -1045,7 +1042,7 @@ static int identify_page_state(unsigned long pfn, struct page *p,
 	return page_action(ps, p, pfn);
 }
 
-static int memory_failure_hugetlb(unsigned long pfn, int trapno, int flags)
+static int memory_failure_hugetlb(unsigned long pfn, int flags)
 {
 	struct page *p = pfn_to_page(pfn);
 	struct page *head = compound_head(p);
@@ -1090,7 +1087,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int trapno, int flags)
 		return 0;
 	}
 
-	if (!hwpoison_user_mappings(p, pfn, trapno, flags, &head)) {
+	if (!hwpoison_user_mappings(p, pfn, flags, &head)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
 		goto out;
@@ -1105,7 +1102,6 @@ static int memory_failure_hugetlb(unsigned long pfn, int trapno, int flags)
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
- * @trapno: Trap number reported in the signal to user space.
  * @flags: fine tune action taken
  *
  * This function is called by the low level machine check code
@@ -1120,7 +1116,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int trapno, int flags)
  * Must run in process context (e.g. a work queue) with interrupts
  * enabled and no spinlocks hold.
  */
-int memory_failure(unsigned long pfn, int trapno, int flags)
+int memory_failure(unsigned long pfn, int flags)
 {
 	struct page *p;
 	struct page *hpage;
@@ -1129,7 +1125,7 @@ int memory_failure(unsigned long pfn, int trapno, int flags)
 	unsigned long page_flags;
 
 	if (!sysctl_memory_failure_recovery)
-		panic("Memory failure from trap %d on page %lx", trapno, pfn);
+		panic("Memory failure on page %lx", pfn);
 
 	if (!pfn_valid(pfn)) {
 		pr_err("Memory failure: %#lx: memory outside kernel control\n",
@@ -1139,7 +1135,7 @@ int memory_failure(unsigned long pfn, int trapno, int flags)
 
 	p = pfn_to_page(pfn);
 	if (PageHuge(p))
-		return memory_failure_hugetlb(pfn, trapno, flags);
+		return memory_failure_hugetlb(pfn, flags);
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
@@ -1268,7 +1264,7 @@ int memory_failure(unsigned long pfn, int trapno, int flags)
 	 * When the raw error page is thp tail page, hpage points to the raw
 	 * page after thp split.
 	 */
-	if (!hwpoison_user_mappings(p, pfn, trapno, flags, &hpage)) {
+	if (!hwpoison_user_mappings(p, pfn, flags, &hpage)) {
 		action_result(pfn, MF_MSG_UNMAP_FAILED, MF_IGNORED);
 		res = -EBUSY;
 		goto out;
@@ -1296,7 +1292,6 @@ EXPORT_SYMBOL_GPL(memory_failure);
 
 struct memory_failure_entry {
 	unsigned long pfn;
-	int trapno;
 	int flags;
 };
 
@@ -1312,7 +1307,6 @@ static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
 /**
  * memory_failure_queue - Schedule handling memory failure of a page.
  * @pfn: Page Number of the corrupted page
- * @trapno: Trap number reported in the signal to user space.
  * @flags: Flags for memory failure handling
  *
  * This function is called by the low level hardware error handler
@@ -1326,13 +1320,12 @@ static DEFINE_PER_CPU(struct memory_failure_cpu, memory_failure_cpu);
  *
  * Can run in IRQ context.
  */
-void memory_failure_queue(unsigned long pfn, int trapno, int flags)
+void memory_failure_queue(unsigned long pfn, int flags)
 {
 	struct memory_failure_cpu *mf_cpu;
 	unsigned long proc_flags;
 	struct memory_failure_entry entry = {
 		.pfn =		pfn,
-		.trapno =	trapno,
 		.flags =	flags,
 	};
 
@@ -1365,7 +1358,7 @@ static void memory_failure_work_func(struct work_struct *work)
 		if (entry.flags & MF_SOFT_OFFLINE)
 			soft_offline_page(pfn_to_page(entry.pfn), entry.flags);
 		else
-			memory_failure(entry.pfn, entry.trapno, entry.flags);
+			memory_failure(entry.pfn, entry.flags);
 	}
 }
 
-- 
2.14.1
