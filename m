Return-Path: <SRS0=qMZt=5K=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 25 Mar 2020 17:41:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 0/6] arm64: tlb: add support for TTL feature
Message-ID: <20200325164144.GB20696@hirez.programming.kicks-ass.net>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf017a8-3658-fe4d-c0cf-2f45656020af@arm.com>
Sender: owner-linux-mm@kvack.org
To: James Morse <james.morse@arm.com>
Cc: Zhenyu Ye <yezhenyu2@huawei.com>, will@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org, npiggin@gmail.com, arnd@arndb.de, rostedt@goodmis.org, maz@kernel.org, suzuki.poulose@arm.com, tglx@linutronix.de, yuzhao@google.com, Dave.Martin@arm.com, steven.price@arm.com, broonie@kernel.org, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org, xiexiangyou@huawei.com, prime.zeng@hisilicon.com, zhangshaokun@hisilicon.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200325164144.cpsUjBVGFx3YBrydwWWbsSI8I51LqI2oaFD7vVcsBoQ@z>

On Wed, Mar 25, 2020 at 04:15:58PM +0000, James Morse wrote:
> Hi Zhenyu,
> 
> On 3/24/20 1:45 PM, Zhenyu Ye wrote:
> > In order to reduce the cost of TLB invalidation, the ARMv8.4 TTL
> > feature allows TLBs to be issued with a level allowing for quicker
> > invalidation.  This series provide support for this feature. 
> > 
> > Patch 1 and Patch 2 was provided by Marc on his NV series[1] patches,
> > which detect the TTL feature and add __tlbi_level interface.
> 
> How does this interact with THP?
> (I don't see anything on that in the series.)
> 
> With THP, there is no one answer to the size of mapping in a VMA.
> This is a problem because the arm-arm has in "Translation table level
> hints" in D5.10.2 of DDI0487E.a:
> | If an incorrect value for the entry being invalidated by the
> | instruction is specified in the TTL field, then no entries are
> | required by the architecture to be invalidated from the TLB.
> 
> If we get it wrong, not TLB maintenance occurs!
> 
> Unless THP leaves its fingerprints on the vma, I think you can only do
> this for VMA types that THP can't mess with. (see
> transparent_hugepage_enabled())

The convention way to deal with that is to issue the TBLI for all
possible sizes.

Power9 has all this, please look there.
