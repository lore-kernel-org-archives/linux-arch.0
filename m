From: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 0/3] couple of TLB flush optimisations
Date: Tue, 12 Jun 2018 17:16:18 +1000
Message-ID: <20180612071621.26775-1-npiggin@gmail.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linux-mm@kvack.org
Cc: linux-arch@vger.kernel.org, Nadav Amit <nadav.amit@gmail.com>, Mel Gorman <mgorman@techsingularity.net>, Linus Torvalds <torvalds@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Minchan Kim <minchan@kernel.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

I'm just looking around TLB flushing and noticed a few issues with
the core code. The first one seems pretty straightforward, unless I
missed something, but the TLB flush pattern after the revert seems
okay.

The second one might be a bit more interesting for other architectures
and the big comment in include/asm-generic/tlb.h and linked mail from
Linus gives some good context.

I suspect mmu notifiers should use this precise TLB range too, because
I don't see how they could care about the page table structure under
the mapping. Although I only use it in powerpc so far.

Comments?

Thanks,
Nick

Nicholas Piggin (3):
  Revert "mm: always flush VMA ranges affected by zap_page_range"
  mm: mmu_gather track of invalidated TLB ranges explicitly for more
    precise flushing
  powerpc/64s/radix: optimise TLB flush with precise TLB ranges in
    mmu_gather

 arch/powerpc/mm/tlb-radix.c |  7 +++++--
 include/asm-generic/tlb.h   | 27 +++++++++++++++++++++++++--
 mm/memory.c                 | 18 ++++--------------
 3 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.17.0
