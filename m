From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RESEND PATCH v5 0/6] arm64: tlb: add support for TTL feature
Date: Thu, 25 Jun 2020 16:03:08 +0800
Message-ID: <20200625080314.230-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:6317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390531AbgFYIDg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 04:03:36 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

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

See patches for details, Thanks.

--
ChangeList:
v5:
rebase the series on Linux 5.8-rc2.

v4:
implement flush_*_tlb_range only on arm64.

v3:
minor changes: reduce the indentation levels of __tlbi_level().

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
  arm64: tlb: Set the TTL field in flush_tlb_range
  arm64: tlb: Set the TTL field in flush_*_tlb_range

 arch/arm64/include/asm/cpucaps.h  |  3 +-
 arch/arm64/include/asm/pgtable.h  | 10 ++++++
 arch/arm64/include/asm/sysreg.h   |  1 +
 arch/arm64/include/asm/tlb.h      | 29 +++++++++++++++-
 arch/arm64/include/asm/tlbflush.h | 54 +++++++++++++++++++++++++-----
 arch/arm64/kernel/cpufeature.c    | 11 +++++++
 include/asm-generic/tlb.h         | 55 ++++++++++++++++++++++---------
 7 files changed, 138 insertions(+), 25 deletions(-)

-- 
2.26.2
