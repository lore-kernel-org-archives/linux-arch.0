Return-Path: <SRS0=05z6=56=kvack.org=owner-linux-mm@kernel.org>
From: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: [RFC PATCH v3 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date: Tue, 14 Apr 2020 19:28:33 +0800
Message-ID: <20200414112835.1121-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: will@kernel.org, catalin.marinas@arm.com, suzuki.poulose@arm.com, maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net
Cc: yezhenyu2@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200414112833.hpxvMWCSKxgM5Z_815BEbLgMPQVwVGJuYz23na6Ldfc@z>

ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
range of input addresses. This series add support for this feature.

--
ChangeList:
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

--=20
2.19.1
