Return-Path: <SRS0=T3Fa=7O=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:5833 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726017AbgFAOrb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 10:47:31 -0400
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v3 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date: Mon, 1 Jun 2020 22:47:11 +0800
Message-ID: <20200601144713.2222-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Message-ID: <20200601144711.j1KwvCe9Nseb7qXHf8Y2YaI94s2YCSBFEJ-dX-V2ufI@z>

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
v4:
combine the __flush_tlb_range() and the __directly into the same function
with a single loop for both.

v3:
rebase this series on Linux 5.7-rc1.

v2:
Link: https://lkml.org/lkml/2019/11/11/348

Zhenyu Ye (2):
  arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
  arm64: tlb: Use the TLBI RANGE feature in arm64

 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/include/asm/sysreg.h   |   4 ++
 arch/arm64/include/asm/tlbflush.h | 108 +++++++++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c    |  11 +++
 4 files changed, 124 insertions(+), 2 deletions(-)

-- 
2.19.1
