Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:30614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261918AbUELW31 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 May 2004 18:29:27 -0400
Date: Wed, 12 May 2004 15:32:03 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Fw: Re: Reduce TLB flushing during process migration
Message-Id: <20040512153203.5ac1b196.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-arch@vger.kernel.org
Cc: steiner@sgi.com, mort@wildopensource.com, jbarnes@sgi.com
List-ID: <linux-arch.vger.kernel.org>


fyi, we're planning on pulling out the tlb_migrate_prepare() stuff
again - apparently it's not welcome on ia64 in its present form.

davem, you expressed interest in this previously.  The question is whether
we should remove the whole thing, or just the ia64 component?



Begin forwarded message:

Date: Wed, 12 May 2004 15:08:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: davidm@hpl.hp.com
Cc: steiner@sgi.com, mort@wildopensource.com, jbarnes@sgi.com
Subject: Re: Reduce TLB flushing during process migration


David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> Please remove it until a proper solution exists.

I'll submit this on Friday, when bugalugs returns.


David Mosberger asked that this be backed out:

"I do not believe that flushing the TLB before migration is be the right thing
to do on ia64 machines which support global TLB purges (i.e., all but SGI's
machines)."

It was of huge benefit for the SGI machines, so work is ongoing.


---

 25-akpm/include/asm-generic/tlb.h |    2 --
 25-akpm/include/asm-ia64/tlb.h    |    2 --
 25-akpm/kernel/sched.c            |   10 ----------
 3 files changed, 14 deletions(-)

diff -puN include/asm-generic/tlb.h~revert-process-migration-speedup include/asm-generic/tlb.h
--- 25/include/asm-generic/tlb.h~revert-process-migration-speedup	Wed May 12 15:04:55 2004
+++ 25-akpm/include/asm-generic/tlb.h	Wed May 12 15:05:24 2004
@@ -146,6 +146,4 @@ static inline void tlb_remove_page(struc
 		__pmd_free_tlb(tlb, pmdp);			\
 	} while (0)
 
-#define tlb_migrate_prepare(mm) do { } while(0)
-
 #endif /* _ASM_GENERIC__TLB_H */
diff -puN include/asm-ia64/tlb.h~revert-process-migration-speedup include/asm-ia64/tlb.h
--- 25/include/asm-ia64/tlb.h~revert-process-migration-speedup	Wed May 12 15:04:55 2004
+++ 25-akpm/include/asm-ia64/tlb.h	Wed May 12 15:05:24 2004
@@ -211,8 +211,6 @@ __tlb_remove_tlb_entry (struct mmu_gathe
 	tlb->end_addr = address + PAGE_SIZE;
 }
 
-#define tlb_migrate_prepare(mm) flush_tlb_mm(mm)
-
 #define tlb_start_vma(tlb, vma)			do { } while (0)
 #define tlb_end_vma(tlb, vma)			do { } while (0)
 
diff -puN kernel/sched.c~revert-process-migration-speedup kernel/sched.c
--- 25/kernel/sched.c~revert-process-migration-speedup	Wed May 12 15:04:55 2004
+++ 25-akpm/kernel/sched.c	Wed May 12 15:05:24 2004
@@ -26,8 +26,6 @@
 #include <linux/highmem.h>
 #include <linux/smp_lock.h>
 #include <asm/mmu_context.h>
-#include <linux//pagemap.h>
-#include <asm/tlb.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
@@ -1302,14 +1300,6 @@ static void sched_migrate_task(task_t *p
 		wake_up_process(mt);
 		put_task_struct(mt);
 		wait_for_completion(&req.done);
-
-		/*
-		 * we want a new context here. This eliminates TLB
-		 * flushes on the cpus where the process executed prior to
-		 * the migration.
-		 */
-		tlb_migrate_prepare(current->mm);
-
 		return;
 	}
 out:

_
