From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 0/2] arm64: tlb: add support for TLBI RANGE instructions
Date: Fri, 10 Jul 2020 20:11:19 +0100
Message-ID: <159440712962.27784.4664678472466095995.b4-ty@arm.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJTLX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 15:11:23 -0400
In-Reply-To: <20200710094420.517-1-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: maz@kernel.org, steven.price@arm.com, guohanjun@huawei.com, Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org, olof@lixom.net, suzuki.poulose@arm.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zhangshaokun@hisilicon.com, prime.zeng@hisilicon.com, linux-arch@vger.kernel.org, kuhn.chenqun@huawei.com, xiexiangyou@huawei.com, linux-mm@kvack.org, arm@kernel.org

On Fri, 10 Jul 2020 17:44:18 +0800, Zhenyu Ye wrote:
> NOTICE: this series are based on the arm64 for-next/tlbi branch:
> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi
> 
> --
> ARMv8.4-TLBI provides TLBI invalidation instruction that apply to a
> range of input addresses. This series add support for this feature.
> 
> [...]

Applied to arm64 (for-next/tlbi), thanks!

[1/2] arm64: tlb: Detect the ARMv8.4 TLBI RANGE feature
      https://git.kernel.org/arm64/c/a2fd755f77ff
[2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
      https://git.kernel.org/arm64/c/db34a081d273

-- 
Catalin
