From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: TLB and PTE coherency during munmap
Date: Tue, 28 May 2013 11:10:25 +0400
Message-ID: <51A45861.1010008@gmail.com>
References: <CAMo8BfL4QfJrfejNKmBDhAVdmE=_Ys6MVUH5Xa3w_mU41hwx0A@mail.gmail.com> <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:48060 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650Ab3E1HLk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2013 03:11:40 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so7157502lab.12
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2013 00:11:38 -0700 (PDT)
In-Reply-To: <CAMo8BfJie1Y49QeSJ+JTQb9WsYJkMMkb1BkKz2Gzy3T7V6ogHA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org
Cc: Ralf Baechle <ralf@linux-mips.org>, Chris Zankel <chris@zankel.net>, Marc Gauthier <Marc.Gauthier@tensilica.com>, linux-xtensa@linux-xtensa.org, Hugh Dickins <hughd@google.com>

On Sun, May 26, 2013 at 6:50 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hello arch and mm people.
>
> Is it intentional that threads of a process that invoked munmap syscall
> can see TLB entries pointing to already freed pages, or it is a bug?
>
> I'm talking about zap_pmd_range and zap_pte_range:
>
>       zap_pmd_range
>         zap_pte_range
>           arch_enter_lazy_mmu_mode
>             ptep_get_and_clear_full
>             tlb_remove_tlb_entry
>             __tlb_remove_page
>           arch_leave_lazy_mmu_mode
>         cond_resched
>
> With the default arch_{enter,leave}_lazy_mmu_mode, tlb_remove_tlb_entry
> and __tlb_remove_page there is a loop in the zap_pte_range that clears
> PTEs and frees corresponding pages, but doesn't flush TLB, and
> surrounding loop in the zap_pmd_range that calls cond_resched. If a thread
> of the same process gets scheduled then it is able to see TLB entries
> pointing to already freed physical pages.
>
> I've noticed that with xtensa arch when I added a test before returning to
> userspace checking that TLB contents agrees with page tables of the
> current mm. This check reliably fires with the LTP test mtest05 that
> maps, unmaps and accesses memory from multiple threads.
>
> Is there anything wrong in my description, maybe something specific to
> my arch, or this issue really exists?

Hi,

I've made similar checking function for MIPS (because qemu is my only choice
and it simulates MIPS TLB) and ran my tests on mips-malta machine in qemu.
With MIPS I can also see this issue. I hope I did it right, the patch at the
bottom is for the reference. The test I run and the diagnostic output are as
follows:

# ./runltp -p -q -T 100 -s mtest05
...
mmstress    0  TINFO  :  test2: Test case tests the race condition between simultaneous write faults in the same address space.
[  439.010000] 14: 70d68000: 03178000/00000000
mmstress    2  TPASS  :  TEST 2 Passed
...
mmstress    0  TINFO  :  test2: Test case tests the race condition between simultaneous write faults in the same address space.
[  947.390000] 10: 6f9d2000: 03639000/00000000
[  947.390000] 10: 6f9d3000: 03638000/00000000
mmstress    2  TPASS  :  TEST 2 Passed
...
mmstress    0  TINFO  :  test1: Test case tests the race condition between simultaneous read faults in the same address space.
[ 1922.680000] 10: 68e12000: 03b59000/00000000
[ 1922.680000] 10: 68e13000: 03b58000/00000000
mmstress    1  TPASS  :  TEST 1 Passed
...

To me it looks like the cond_resched in the zap_pmd_range is the root cause
of this issue (let alone SMP case for now). It was introduced in the commit

commit 97a894136f29802da19a15541de3c019e1ca147e
Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date:   Tue May 24 17:12:04 2011 -0700

    mm: Remove i_mmap_lock lockbreak

Peter, Kamezawa, other reviewers of that commit, could you please comment?


------8<------
From 29324d01c0c95b11fbfe509d9b0eae42cab6d380 Mon Sep 17 00:00:00 2001
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 28 May 2013 08:06:03 +0400
Subject: [PATCH] mips: check TLB sanity on return to userspace

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/mips/kernel/entry.S |    1 +
 arch/mips/lib/dump_tlb.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/entry.S b/arch/mips/kernel/entry.S
index e578685..82881ac 100644
--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -49,6 +49,7 @@ resume_userspace:
 	local_irq_disable		# make sure we dont miss an
 					# interrupt setting need_resched
 					# between sampling and return
+	jal	check_tlb_all
 	LONG_L	a2, TI_FLAGS($28)	# current->work
 	andi	t0, a2, _TIF_WORK_MASK	# (ignoring syscall_trace)
 	bnez	t0, work_pending
diff --git a/arch/mips/lib/dump_tlb.c b/arch/mips/lib/dump_tlb.c
index 32b9f21..629e38b 100644
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -6,6 +6,8 @@
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/mm_types.h>

 #include <asm/mipsregs.h>
 #include <asm/page.h>
@@ -111,3 +113,82 @@ void dump_tlb_all(void)
 {
 	dump_tlb(0, current_cpu_data.tlbsize - 1);
 }
+
+static inline pte_t *get_pte_for_vaddr(unsigned vaddr)
+{
+	struct task_struct *task = get_current();
+	struct mm_struct *mm = task->mm;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	if (!mm)
+		mm = task->active_mm;
+	pgd = pgd_offset(mm, vaddr);
+	if (pgd_none_or_clear_bad(pgd))
+		return NULL;
+	pud = pud_offset(pgd, vaddr);
+	if (pud_none_or_clear_bad(pud))
+		return NULL;
+	pmd = pmd_offset(pud, vaddr);
+	if (pmd_none_or_clear_bad(pmd))
+		return NULL;
+	pte = pte_offset_map(pmd, vaddr);
+	return pte;
+}
+
+static inline void check_tlb_entry(unsigned i, unsigned long va,
+		unsigned long long entrylo)
+{
+	if (entrylo & 2) {
+		pte_t *pte = get_pte_for_vaddr(va);
+		unsigned long pte_pa = pte ? (pte_pfn(*pte) << PAGE_SHIFT) : 0;
+		unsigned long tlb_pa = (entrylo << 6) & PAGE_MASK;
+		if (pte_pa != tlb_pa)
+			pr_err("%d: %08lx: %08lx/%08lx\n",
+					i, va, tlb_pa, pte_pa);
+	}
+}
+static void check_tlb(unsigned last)
+{
+	unsigned long s_entryhi, asid;
+	unsigned int s_index, s_pagemask, i;
+	struct {
+		unsigned long entryhi;
+		unsigned long entrylo0, entrylo1;
+	} c[64];
+
+	BUG_ON(last > ARRAY_SIZE(c));
+	s_pagemask = read_c0_pagemask();
+	s_entryhi = read_c0_entryhi();
+	s_index = read_c0_index();
+	asid = s_entryhi & 0xff;
+
+	for (i = 0; i < last; ++i) {
+		write_c0_index(i);
+		BARRIER();
+		tlb_read();
+		BARRIER();
+		c[i].entryhi = read_c0_entryhi();
+		c[i].entrylo0 = read_c0_entrylo0();
+		c[i].entrylo1 = read_c0_entrylo1();
+	}
+	for (i = 0; i < last; ++i) {
+		/* Unused entries have a virtual address of CKSEG0.  */
+		if ((c[i].entryhi & ~0x1ffffUL) != CKSEG0
+		    && (c[i].entryhi & 0xff) == asid) {
+			unsigned long va = c[i].entryhi & ~0x1fffUL;
+			check_tlb_entry(i, va, c[i].entrylo0);
+			check_tlb_entry(i, va + PAGE_SIZE, c[i].entrylo1);
+		}
+	}
+	write_c0_entryhi(s_entryhi);
+	write_c0_index(s_index);
+	write_c0_pagemask(s_pagemask);
+}
+
+void check_tlb_all(void)
+{
+	check_tlb(current_cpu_data.tlbsize);
+}
-- 
1.7.7.6


-- 
Thanks.
-- Max
