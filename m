Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49070 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1727722AbfLPNOi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Mon, 16 Dec 2019 08:14:38 -0500
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org> <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
Date: Mon, 16 Dec 2019 18:43:53 +0530
MIME-Version: 1.0
In-Reply-To: <20191216123752.GM2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <20191216131353.nmoN0inRWWwp2Qq2n5qAhqhQkL0Rpq4khA8qBhZoUek@z>

On 12/16/19 6:07 PM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 06:01:58PM +0530, Aneesh Kumar K.V wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>>
>>> Towards a more consistent naming scheme.
>>>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>> ---
>>>   arch/Kconfig              |    3 ++-
>>>   arch/powerpc/Kconfig      |    2 +-
>>>   arch/sparc/Kconfig        |    2 +-
>>>   include/asm-generic/tlb.h |    2 +-
>>>   mm/mmu_gather.c           |    2 +-
>>>   5 files changed, 6 insertions(+), 5 deletions(-)
>>>
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -396,8 +396,9 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
>>>   config MMU_GATHER_RCU_TABLE_FREE
>>>   	bool
>>>   
>>> -config HAVE_RCU_TABLE_NO_INVALIDATE
>>> +config MMU_GATHER_NO_TABLE_INVALIDATE
>>>   	bool
>>> +	depends on MMU_GATHER_RCU_TABLE_FREE
>>
>>
>> Can we drop this Kernel config option instead use
>> MMU_GATHER_RCU_TABLE_FREE? IMHO reducing the kernel config related to
>> mmu_gather can reduce the complexity.
> 
> I'm confused, are you saing you're happy to have PowerPC eat the extra
> TLB invalidates? I thought you cared about PPC performance :-)
> 
> 

Instead can we do

static inline void tlb_table_invalidate(struct mmu_gather *tlb)
{
#ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
	 * Invalidate page-table caches used by hardware walkers. Then we still
	 * need to RCU-sched wait while freeing the pages because software
	 * walkers can still be in-flight.
	 */
	tlb_flush_mmu_tlbonly(tlb);
#endif
}

-aneesh
