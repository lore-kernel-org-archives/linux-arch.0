From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/13] mm: preemptibility -v2
Date: Thu, 08 Apr 2010 21:17:37 +0200
Message-ID: <20100408191737.296180458@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fou
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-arch.vger.kernel.org

Hi,

This (still incomplete) patch-set makes part of the mm a lot more preemptible.
It converts i_mmap_lock and anon_vma->lock to mutexes.  On the way there it
also makes mmu_gather preemptible.

The main motivation was making mm_take_all_locks() preemptible, since it
appears people are nesting hundreds of spinlocks there.

The side-effects are that we can finally make mmu_gather preemptible, something
which lots of people have wanted to do for a long time.

It also gets us anon_vma refcounting which seems to be wanted by KSM as well as
Mel's compaction work.

This patch-set seems to build and boot on my x86_64 machines and even builds a
kernel. I've also attempted powerpc and sparc, which I've compile tested with
their respective defconfigs, remaining are (afaikt the rest uses the generic
tlb bits):

 - s390
 - ia64
 - arm
 - superh
 - um

From those, s390 and ia64 look 'interesting', arm and superh seem very similar
and should be relatively easy (-rt has a patchlet for arm iirc).

What kind of performance tests would people have me run on this to satisfy
their need for numbers? I've done a kernel build on x86_64 and if anything that
was slightly faster with these patches, but it was well within the noise
levels so it might be heat noise I'm looking at ;-)
