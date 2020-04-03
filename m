From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v1 0/6] arm64: tlb: add support for TTL feature
Date: Fri, 3 Apr 2020 17:00:42 +0800
Message-ID: <20200403090048.938-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
feature allows TLBs to be issued with a level allowing for quicker
invalidation.  This series provide support for this feature.

Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
which detect the TTL feature and add __tlbi_level interface.  Patch 3
added __tlbi_user_level interface.  Patch 4 was provided by Peter and
added some mmu_gather APIs.  Patch 5 provided flush_*_tlb_range wrappers
so we can do the tlb invalidation according to the information in
struct mmu_gather.  Finally, we supported TTL feature in ARM64 by using
tlb->cleared_* in struct mmu_gather.

See patches for details, Thanks.

Marc Zyngier (2):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Add level-hinted TLB invalidation helper

Peter Zijlstra (Intel) (1):
  tlb: mmu_gather: add tlb_set_*_range APIs

Zhenyu Ye (3):
  arm64: Add tlbi_user_level TLB invalidation helper
  mm: tlb: Provide flush_*_tlb_range wrappers
  arm64: tlb: Set the TTL field in flush_tlb_range

 arch/arm64/include/asm/cpucaps.h  |  3 +-
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/include/asm/tlb.h      | 26 ++++++++++++++-
 arch/arm64/include/asm/tlbflush.h | 53 ++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c    | 11 +++++++
 include/asm-generic/pgtable.h     | 12 +++++--
 include/asm-generic/tlb.h         | 55 ++++++++++++++++++++++---------
 mm/pgtable-generic.c              | 50 ++++++++++++++++++++++++++++
 8 files changed, 184 insertions(+), 27 deletions(-)

-- 
2.19.1
