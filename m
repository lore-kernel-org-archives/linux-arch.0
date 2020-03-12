From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v2 0/3] arm64: tlb: add support for TTL field
Date: Thu, 12 Mar 2020 12:10:15 +0800
Message-ID: <20200312041018.1927-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, maz@kernel.org, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
List-Id: linux-arch.vger.kernel.org

ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
the level of translation table walk holding the leaf entry for the
address that is being invalidated. Hardware can use this information
to determine if there was a risk of splintering.

The PATCH v2 is based on Marc's NV series[1].

[1] git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-5.6-rc1


Zhenyu Ye (3):
  arm64: tlb: use __tlbi_level replace __tlbi in Stage-1
  arm64: tlb: use mm_struct.context.flags to indicate TTL value
  arm64: tlb: add support for TTL in some functions

 arch/arm64/include/asm/mmu.h      | 11 +++++++++++
 arch/arm64/include/asm/tlb.h      |  3 +++
 arch/arm64/include/asm/tlbflush.h | 19 ++++++-------------
 arch/arm64/kernel/process.c       |  2 +-
 arch/arm64/mm/hugetlbpage.c       |  2 ++
 5 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.19.1
