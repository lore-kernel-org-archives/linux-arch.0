From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/20] mm: Preemptibility -v4
Date: Sat, 28 Aug 2010 16:16:37 +0200
Message-ID: <20100828141637.421594670@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

This patch-set makes part of the mm a lot more preemptible. It converts
i_mmap_lock and anon_vma->lock to mutexes and makes mmu_gather fully
preemptible.

The main motivation was making mm_take_all_locks() preemptible, since it
appears people are nesting hundreds of spinlocks there.

The side-effects are that can finally make mmu_gather preemptible,
something which lots of people have wanted to do for a long time.

It also gets us anon_vma refcounting, which seems to result in a nice
cleanup of the anon_vma lifetime rules wrt KSM and compaction.

This patch-set it build and boot-tested on x86_64 (a previous version was
also tested on Dave's Niagra2 machines, and I suppose s390 did too when
Martin provided the conversion patch for his arch).

There are no known architectures left unconverted, although some arch code
never did see a compiler (superh and ia64 come to mind, I'll try and 
update my toolchains next week).

Yanmin ran the last posting through the comprehensive Intel test farm
and didn't find any regressions.

( Not included in this posting are the 4 Sparc64 patches that implement
  gup_fast, those can be applied separately after this series gets 
  anywhere. )

Full series (including the Sparc64 gup_fast bits) also available in -git
form from (against Linus' tree as of about an hour ago):

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/linux-2.6-mmu_preempt.git mmu_preempt

Do people feel its ready to get added to -next?
