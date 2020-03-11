From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v1 0/3] arm64: tlb: add support for TTL field
Date: Wed, 11 Mar 2020 10:53:06 +0800
Message-ID: <20200311025309.1743-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, maz@kernel.org, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com
List-Id: linux-arch.vger.kernel.org

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated. Hardware can use this information
to determine if there was a risk of splintering.

This set of patches adds TTL field to __TLBI_ADDR, and uses
Architecture-specific MM context to pass the TTL value to tlb interface.

The default value of TTL is 0, which will not have any impact on the
TLB maintenance instructions. The last patch trys to use TTL field in
some obviously tlb-flush interface.

Zhenyu Ye (3):
  arm64: tlb: add TTL field to __TLBI_ADDR
  arm64: tlb: use mm_struct.context.flags to indicate TTL
  arm64: tlb: add support for TTL in some functions

 arch/arm64/include/asm/cpucaps.h  |  3 ++-
 arch/arm64/include/asm/mmu.h      | 11 ++++++++++
 arch/arm64/include/asm/sysreg.h   |  4 ++++
 arch/arm64/include/asm/tlb.h      |  3 +++
 arch/arm64/include/asm/tlbflush.h | 35 +++++++++++++++++++++++--------
 arch/arm64/kernel/cpufeature.c    | 10 +++++++++
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/mm/hugetlbpage.c       |  2 ++
 8 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.19.1
