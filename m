Return-Path: <SRS0=JYYx=A2=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgGORFa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:05:30 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 0/3] arm64: tlb: add support for TLBI RANGE instructions
Date: Wed, 15 Jul 2020 18:05:25 +0100
Message-ID: <159483264095.31859.17352107236921556251.b4-ty@arm.com>
In-Reply-To: <20200715071945.897-1-yezhenyu2@huawei.com>
References: <20200715071945.897-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: olof@lixom.net, guohanjun@huawei.com, maz@kernel.org, Zhenyu Ye <yezhenyu2@huawei.com>, suzuki.poulose@arm.com, will@kernel.org, steven.price@arm.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kuhn.chenqun@huawei.com, zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org, xiexiangyou@huawei.com, arm@kernel.org, prime.zeng@hisilicon.com, linux-arch@vger.kernel.org
Message-ID: <20200715170525.vnuBv7gSYp8348yj6sivqXrsqNREKjwQc0IWViV2WgM@z>

On Wed, 15 Jul 2020 15:19:42 +0800, Zhenyu Ye wrote:
> NOTICE: this series are based on the arm64 for-next/tlbi branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> 
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This series add support for this feature.
> 
> --
> ChangeList:
> v3:
> - add check on whether binutils supports ARMv8.4-a instructions.
> - pass -march=armv8.4-a to KBUILD_CFLAGS.
> - make __TLBI_RANGE_PAGES to be 'unsigned long' explicitly.
> 
> [...]

Applied to arm64 (for-next/tlbi), thanks!

[1/3] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
      https://git.kernel.org/arm64/c/b620ba54547c
[2/3] arm64: enable tlbi range instructions
      https://git.kernel.org/arm64/c/7c78f67e9bd9
[3/3] arm64: tlb: Use the TLBI RANGE feature in arm64
      https://git.kernel.org/arm64/c/d1d3aa98b1d4

(I introduced a system_supports_tlb_range() to avoid the IS_ENABLED
twice)

-- 
Catalin
