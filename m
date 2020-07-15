From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v3 0/3] arm64: tlb: add support for TLBI RANGE instructions
Date: Wed, 15 Jul 2020 15:19:42 +0800
Message-ID: <20200715071945.897-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:7317 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728876AbgGOHUD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 03:20:03 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

NOTICE: this series are based on the arm64 for-next/tlbi branch:
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
v3:
- add check on whether binutils supports ARMv8.4-a instructions.
- pass -march=armv8.4-a to KBUILD_CFLAGS.
- make __TLBI_RANGE_PAGES to be 'unsigned long' explicitly.

v2:
- remove the __tlbi_last_level() macro.
- add check for parameters in __TLBI_VADDR_RANGE macro.

RFC patches:
- Link: https://lore.kernel.org/linux-arm-kernel/20200708124031.1414-1-yezhenyu2@huawei.com/


Zhenyu Ye (3):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: enable tlbi range instructions
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/Kconfig                |  14 +++
 arch/arm64/Makefile               |   7 ++
 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/asm/tlbflush.h | 156 ++++++++++++++++++++++++------
 arch/arm64/kernel/cpufeature.c    |  10 ++
 6 files changed, 163 insertions(+), 30 deletions(-)

-- 
2.19.1
