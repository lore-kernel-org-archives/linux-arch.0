Return-Path: <SRS0=1/KV=5J=kvack.org=owner-linux-mm@kernel.org>
Date: Tue, 24 Mar 2020 16:01:55 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
Message-ID: <20200324150155.GH20713@hirez.programming.kicks-ass.net>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324134534.1570-1-yezhenyu2@huawei.com>
Sender: owner-linux-mm@kvack.org
To: Zhenyu Ye <yezhenyu2@huawei.com>
Cc: will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200324150155.LxC1_vVu2UKJkDrc4x3zbgMPYIRzYX-Ylbh3G7o7v58@z>

On Tue, Mar 24, 2020 at 09:45:28PM +0800, Zhenyu Ye wrote:
> In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> feature allows TLBs to be issued with a level allowing for quicker
> invalidation.  This series provide support for this feature. 
> 
> Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
> which detect the TTL feature and add __tlbi_level interface.

I realy hate how it makes vma->vm_flags more important for tlbi.
