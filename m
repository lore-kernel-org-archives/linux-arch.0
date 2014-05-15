From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 01/27] arm64: Override defaults from generic/tlb.h
Date: Thu, 15 May 2014 11:37:07 +0200
Message-ID: <53748AC3.9080709@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
 <1400093999-18703-2-git-send-email-richard@nod.at>
 <20140515093430.GE11117@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140515093430.GE11117@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steve Capper <steve.capper@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Am 15.05.2014 11:34, schrieb Catalin Marinas:
> On Wed, May 14, 2014 at 07:59:33PM +0100, Richard Weinberger wrote:
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -19,7 +19,14 @@
>>  #ifndef __ASM_TLB_H
>>  #define __ASM_TLB_H
>>  
>> +/* These defines are needed to override the defaults from asm-generic/tlb.h */
>>  #define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
>> +#define tlb_start_vma tlb_start_vma
>> +#define tlb_end_vma tlb_end_vma
>> +#define __tlb_remove_tlb_entry __tlb_remove_tlb_entry
>> +#define tlb_flush tlb_flush
>> +#define __pte_free_tlb __pte_free_tlb
>> +#define __pmd_free_tlb __pmd_free_tlb
>>  
>>  #include <asm-generic/tlb.h>
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> I hope subsequent series would consolidate some more of the above (for
> example tlb_start_vma() is not really arm64 specific.

Yes, peterz pointed me to a not jet merged series which consolidates
much more.
I'll revive it.

Thanks,
//richard
