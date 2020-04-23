From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v2 0/6] arm64: tlb: add support for TTL feature
Date: Thu, 23 Apr 2020 21:56:50 +0800
Message-ID: <20200423135656.2712-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

In order to reduce the cost of TLB invalidation, ARMv8.4 provides
the TTL field in TLBI instruction.  The TTL field indicates the
level of page table walk holding the leaf entry for the address
being invalidated.  This series provide support for this feature.

When ARMv8.4-TTL is implemented, the operand for TLBIs looks like
below:

* +----------+-------+----------------------+
* |   ASID   |  TTL  |        BADDR         |
* +----------+-------+----------------------+
* |63      48|47   44|43                   0|


This version updates some codes implementation according to Peter's
suggestion, and adds some commit msg.

See patches for details, Thanks.


--
ChangeList:
v2:
rebase series on Linux 5.7-rc1 and simplify the code implementation.

v1:
add support for TTL feature in arm64.

Marc Zyngier (2):
  arm64: Detect the ARMv8.4 TTL feature
  arm64: Add level-hinted TLB invalidation helper

Peter Zijlstra (Intel) (1):
  tlb: mmu_gather: add tlb_flush_*_range APIs

Zhenyu Ye (3):
  arm64: Add tlbi_user_level TLB invalidation helper
  mm: tlb: Provide flush_*_tlb_range wrappers
  arm64: tlb: Set the TTL field in flush_tlb_range

 arch/arm64/include/asm/cpucaps.h  |  3 +-
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/include/asm/tlb.h      | 29 +++++++++++++++-
 arch/arm64/include/asm/tlbflush.h | 54 +++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c    | 11 +++++++
 include/asm-generic/pgtable.h     | 12 +++++--
 include/asm-generic/tlb.h         | 55 ++++++++++++++++++++++---------
 mm/pgtable-generic.c              | 22 +++++++++++++
 8 files changed, 160 insertions(+), 27 deletions(-)

-- 
2.19.1
