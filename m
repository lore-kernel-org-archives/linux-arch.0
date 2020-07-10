Return-Path: <SRS0=GDSS=AV=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga07-in.huawei.com ([45.249.212.35]:50678 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726664AbgGJJoj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 05:44:39 -0400
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date: Fri, 10 Jul 2020 17:44:18 +0800
Message-ID: <20200710094420.517-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Message-ID: <20200710094418.4QEN8iN7Tc0z4bY0YaK4-PQIgaRfQ3EznqujlVtnsFw@z>

NOTICE: this series are based on the arm64 for-next/tlbi branch:
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi

--
ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
v2:
- remove the __tlbi_last_level() macro.
- add check for parameters in __TLBI_VADDR_RANGE macro.

RFC patches:
- Link: https://lore.kernel.org/linux-arm-kernel/20200708124031.1414-1-yezhenyu2@huawei.com/

Zhenyu Ye (2):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   3 +
 arch/arm64/include/asm/tlbflush.h | 138 +++++++++++++++++++++++-------
 arch/arm64/kernel/cpufeature.c    |  10 +++
 4 files changed, 124 insertions(+), 30 deletions(-)

-- 
2.19.1
