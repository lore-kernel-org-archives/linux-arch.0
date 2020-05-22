From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/6] arm64: Detect the ARMv8.4 TTL feature
Date: Fri, 22 May 2020 16:50:02 +0100
Message-ID: <20200522155002.GF26492@gaia>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-2-yezhenyu2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200423135656.2712-2-yezhenyu2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: peterz@infradead.org, mark.rutland@arm.com, will@kernel.org, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 23, 2020 at 09:56:51PM +0800, Zhenyu Ye wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.
> 
> The TTL field indicates the level of page table walk
> holding the leaf entry for the address being invalidated.
> 
> Let's detect the feature for now. Further patches will implement
> its actual usage.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
