From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 05/17] asm-generic/tlb: Rename
 HAVE_RCU_TABLE_NO_INVALIDATE
Date: Mon, 16 Dec 2019 19:10:30 +0530
Message-ID: <a9ae27c8-aa84-cda3-355c-7abb3b450d38@linux.ibm.com>
References: <20191211120713.360281197@infradead.org>
 <20191211122955.940455408@infradead.org> <87woawzc1t.fsf@linux.ibm.com>
 <20191216123752.GM2844@hirez.programming.kicks-ass.net>
 <d52ea890-c2ea-88f3-9d62-b86e60ee77ae@linux.ibm.com>
 <20191216132004.GO2844@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191216132004.GO2844@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paulburton@kernel.org>, Tony Luck <tony.luck@intel.com>, Richard Henderson <rth@twiddle.net>, Nick Hu <nickhu@andestech.com>, Paul Walmsley <paul.walmsley@sifive.com>
List-Id: linux-arch.vger.kernel.org

On 12/16/19 6:50 PM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 06:43:53PM +0530, Aneesh Kumar K.V wrote:
>> On 12/16/19 6:07 PM, Peter Zijlstra wrote:
> 
>>> I'm confused, are you saing you're happy to have PowerPC eat the extra
>>> TLB invalidates? I thought you cared about PPC performance :-)
>>>
>>>
>>
>> Instead can we do
>>
>> static inline void tlb_table_invalidate(struct mmu_gather *tlb)
>> {
>> #ifndef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>> 	 * Invalidate page-table caches used by hardware walkers. Then we still
>> 	 * need to RCU-sched wait while freeing the pages because software
>> 	 * walkers can still be in-flight.
>> 	 */
>> 	tlb_flush_mmu_tlbonly(tlb);
>> #endif
>> }
> 
> How does that not break ARM/ARM64/s390 and x86 ?
> 

Hmm I missed that usage of RCU_TABLE_NO_INVALIDATE.

Ok I guess we need to revert this change that went upstream this merge 
window then

commit 52162ec784fa05f3a4b1d8e84421279998be3773
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Thu Oct 24 13:28:00 2019 +0530

     powerpc/mm/book3s64/radix: Use freed_tables instead of need_flush_all



I will review the change closely.

-aneesh
