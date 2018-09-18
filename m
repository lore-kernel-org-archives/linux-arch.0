From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [RFC][PATCH 0/2] convert s390 to generic mmu_gather
Date: Tue, 18 Sep 2018 14:51:49 +0200
Message-ID: <20180918125151.31744-1-schwidefsky@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: will.deacon@arm.com, aneesh.kumar@linux.vnet.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, heiko.carstens@de.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hi Peter,

as an add-on for the TLB flushing changes two patches to make
s390 use the generic mmu_gather code as well. I let it run for
a few hours with several TLB stress tests, no fallout so far.
It certainly can use more testing but it looks ok to me.

Martin Schwidefsky (2):
  asm-generic/tlb: introduce HAVE_MMU_GATHER_NO_GATHER
  s390/tlb: convert to generic mmu_gather

 arch/Kconfig                |   3 +
 arch/s390/Kconfig           |   3 +
 arch/s390/include/asm/tlb.h | 130 ++++++++++++++------------------------------
 arch/s390/mm/pgalloc.c      |  63 +--------------------
 include/asm-generic/tlb.h   |   9 ++-
 mm/mmu_gather.c             | 114 ++++++++++++++++++++++----------------
 6 files changed, 121 insertions(+), 201 deletions(-)

-- 
2.16.4
