From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 6/6] arm64: tlb: Set the TTL field in flush_tlb_range
Date: Tue, 26 May 2020 15:56:45 +0100
Message-ID: <20200526145644.GH17051@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-7-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:51886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgEZO4v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 May 2020 10:56:51 -0400
Content-Disposition: inline
In-Reply-To: <20200423135656.2712-7-yezhenyu2@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com

On Thu, Apr 23, 2020 at 09:56:56PM +0800, Zhenyu Ye wrote:
> This patch uses the cleared_* in struct mmu_gather to set the
> TTL field in flush_tlb_range().
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
