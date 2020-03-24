From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
Date: Tue, 24 Mar 2020 21:45:28 +0800
Message-ID: <20200324134534.1570-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
List-Id: linux-arch.vger.kernel.org

In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
feature allows TLBs to be issued with a level allowing for quicker
invalidation.  This series provide support for this feature. 

Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
which detect the TTL feature and add __tlbi_level interface.

See patches for details, Thanks.

[1] https://lore.kernel.org/linux-arm-kernel/20200211174938.27809-1-maz@kernel.org/


ChangeList:
v1:
add support for TTL feature in arm64.

v2:
build the patch on Marc's NV series[1].

v3:
use vma->vm_flags to replace mm->context.flags.

v4:
add Marc's patches into my series.


Marc Zyngier (2):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Add level-hinted TLB invalidation helper

Zhenyu Ye (4):
  arm64: Add level-hinted TLB invalidation helper to tlbi_user
  mm: Add page table level flags to vm_flags
  arm64: tlb: Use translation level hint in vm_flags
  mm: Set VM_LEVEL flags in some tlb_flush functions

 arch/arm64/include/asm/cpucaps.h  |  3 +-
 arch/arm64/include/asm/mmu.h      |  2 +
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/include/asm/tlb.h      | 12 +++++
 arch/arm64/include/asm/tlbflush.h | 74 ++++++++++++++++++++++++++++---
 arch/arm64/kernel/cpufeature.c    | 11 +++++
 arch/arm64/mm/hugetlbpage.c       |  4 +-
 arch/arm64/mm/mmu.c               | 14 ++++++
 include/asm-generic/pgtable.h     | 16 ++++++-
 include/linux/mm.h                | 10 +++++
 include/trace/events/mmflags.h    | 15 ++++++-
 mm/huge_memory.c                  |  8 +++-
 12 files changed, 157 insertions(+), 13 deletions(-)

-- 
2.19.1
