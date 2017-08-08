From: Minchan Kim <minchan@kernel.org>
Subject: Re: [lkp-robot] [mm]  7674270022:  will-it-scale.per_process_ops
 -19.3% regression
Date: Tue, 8 Aug 2017 17:08:21 +0900
Message-ID: <20170808080821.GA31730@bbox>
References: <20170802000818.4760-7-namit@vmware.com>
 <20170808011923.GE25554@yexl-desktop>
 <20170808022830.GA28570@bbox>
 <93CA4B47-95C2-43A2-8E92-B142CAB1DAF7@gmail.com>
 <970B5DC5-BFC2-461E-AC46-F71B3691D301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <970B5DC5-BFC2-461E-AC46-F71B3691D301@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nadav Amit <nadav.amit@gmail.com>
Cc: kernel test robot <xiaolong.ye@intel.com>, "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Tony Luck <tony.luck@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, lkp@01.org
List-Id: linux-arch.vger.kernel.org

On Mon, Aug 07, 2017 at 10:51:00PM -0700, Nadav Amit wrote:
> Nadav Amit <nadav.amit@gmail.com> wrote:
> 
> > Minchan Kim <minchan@kernel.org> wrote:
> > 
> >> Hi,
> >> 
> >> On Tue, Aug 08, 2017 at 09:19:23AM +0800, kernel test robot wrote:
> >>> Greeting,
> >>> 
> >>> FYI, we noticed a -19.3% regression of will-it-scale.per_process_ops due to commit:
> >>> 
> >>> 
> >>> commit: 76742700225cad9df49f05399381ac3f1ec3dc60 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss problem")
> >>> url: https://github.com/0day-ci/linux/commits/Nadav-Amit/mm-migrate-prevent-racy-access-to-tlb_flush_pending/20170802-205715
> >>> 
> >>> 
> >>> in testcase: will-it-scale
> >>> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> >>> with following parameters:
> >>> 
> >>> 	nr_task: 16
> >>> 	mode: process
> >>> 	test: brk1
> >>> 	cpufreq_governor: performance
> >>> 
> >>> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> >>> test-url: https://github.com/antonblanchard/will-it-scale
> >> 
> >> Thanks for the report.
> >> Could you explain what kinds of workload you are testing?
> >> 
> >> Does it calls frequently madvise(MADV_DONTNEED) in parallel on multiple
> >> threads?
> > 
> > According to the description it is "testcase:brk increase/decrease of one
> > page”. According to the mode it spawns multiple processes, not threads.
> > 
> > Since a single page is unmapped each time, and the iTLB-loads increase
> > dramatically, I would suspect that for some reason a full TLB flush is
> > caused during do_munmap().
> > 
> > If I find some free time, I’ll try to profile the workload - but feel free
> > to beat me to it.
> 
> The root-cause appears to be that tlb_finish_mmu() does not call
> dec_tlb_flush_pending() - as it should. Any chance you can take care of it?

Oops, but with second looking, it seems it's not my fault. ;-)
https://marc.info/?l=linux-mm&m=150156699114088&w=2

Anyway, thanks for the pointing out.
xiaolong.ye, could you retest with this fix?

From 83012114c9cd9304f0d55d899bb4b9329d0e22ac Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Tue, 8 Aug 2017 17:05:19 +0900
Subject: [PATCH] mm: decrease tlb flush pending count in tlb_finish_mmu

The tlb pending count increased by tlb_gather_mmu should be decreased
at tlb_finish_mmu. Otherwise, A lot of TLB happens which makes
performance regression.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 mm/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memory.c b/mm/memory.c
index 34b1fcb829e4..ad2617552f55 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -423,6 +423,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb,
 	bool force = mm_tlb_flush_nested(tlb->mm);
 
 	arch_tlb_finish_mmu(tlb, start, end, force);
+	dec_tlb_flush_pending(tlb->mm);
 }
 
 /*
-- 
2.7.4
