From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/13] mm: mmu_gather rework -v2
Date: Wed, 02 Mar 2011 18:50:04 +0100
Message-ID: <20110302175004.222724818@chello.nl>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Andrea Arcangeli <aarcange@redhat.com>, Avi Kivity <avi@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@elte.hu>, akpm@linux-fo
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Mel Gorman <mel@csn.ul.ie>, Nick Piggin <npiggin@kernel.dk>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

Rework the existing mmu_gather infrastructure.

The direct purpose of these patches was to allow preemptible mmu_gather,
but even without that I think these patches provide an improvement to the
status quo.

The first 10 patches rework the mmu_gather infrastructure. For review purpose
I've split them into generic and per-arch patches with the last of those a
generic cleanup.

For the final commit I would provide a roll-up of these patches so as not
to wreck bisectability of non generic archs.

The next patch provides generic RCU page-table freeing, and the follow up
is a patch converting s390 to use this. I've also got 4 patches from
DaveM lined up (not included in this series) that uses this to implement
gup_fast() for sparc64.

Then there is one patch that extends the generic mmu_gather batching.


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
