Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw> <1582726340.7365.124.camel@lca.pw>
 <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
 <52db1e9b-83b3-c41f-ef03-0f43e2159a83@arm.com>
 <20200226200353.ea5c8ec2efacfb1192f3f3f4@linux-foundation.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <6a4518d5-9306-8f84-b676-26a40c594bd9@arm.com>
Date: Thu, 27 Feb 2020 09:37:07 +0530
MIME-Version: 1.0
In-Reply-To: <20200226200353.ea5c8ec2efacfb1192f3f3f4@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, James Morse <james.morse@arm.com>, linux-snps-arc@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>, Qian Cai <cai@lca.pw>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200227040707.4koIwRiN448BJv7dKb1Nai7ok0JDj9-M8pmEoSQGrng@z>



On 02/27/2020 09:33 AM, Andrew Morton wrote:
> On Thu, 27 Feb 2020 08:04:05 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>>> Must be something wrong with the following in debug_vm_pgtable()
>>>
>>>     paddr = __pa(&start_kernel);
>>>
>>> Is there any explaination why start_kernel() is not in linear memory on ARM64 ?
>>
>>
>> Cc: + James Morse <james.morse@arm.com>
>>
>> This warning gets exposed with DEBUG_VIRTUAL due to __pa() on a kernel symbol
>> i.e 'start_kernel' which might be outside the linear map. This happens due to
>> kernel mapping position randomization with KASLR. Adding James here in case he
>> might like to add more.
>>
>> __pa_symbol() should have been used instead, for accessing the physical address
>> here. On arm64 __pa() does check for linear address with __is_lm_address() and
>> switch accordingly if it is a kernel text symbol. Nevertheless, its much better
>> to use __pa_symbol() here rather than __pa().
>>
>> Rather than respining the patch once more, will just send a fix replacing this
>> helper __pa() with __pa_symbol() for Andrew to pick up as this patch is already
>> part of linux-next (next-20200226). But can definitely respin if that will be
>> preferred.
> 
> I didn't see this fix?  I assume it's this?  If so, are we sure it's OK to be
> added to -next without testing??

My patch just missed your response here within a minute :) Please consider this.
It has been tested on x86 and arm64.

https://patchwork.kernel.org/patch/11407715/

> 
> 
> 
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-debug-add-tests-validating-architecture-page-table-helpers-fix
> 
> A warning gets exposed with DEBUG_VIRTUAL due to __pa() on a kernel symbol
> i.e 'start_kernel' which might be outside the linear map.  This happens
> due to kernel mapping position randomization with KASLR.
> 
> __pa_symbol() should have been used instead, for accessing the physical
> address here.  On arm64 __pa() does check for linear address with
> __is_lm_address() and switch accordingly if it is a kernel text symbol. 
> Nevertheless, its much better to use __pa_symbol() here rather than
> __pa().
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/debug_vm_pgtable.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/mm/debug_vm_pgtable.c~mm-debug-add-tests-validating-architecture-page-table-helpers-fix
> +++ a/mm/debug_vm_pgtable.c
> @@ -331,7 +331,7 @@ void __init debug_vm_pgtable(void)
>  	 * helps avoid large memory block allocations to be used for mapping
>  	 * at higher page table levels.
>  	 */
> -	paddr = __pa(&start_kernel);
> +	paddr = __pa_symbol(&start_kernel);
>  
>  	pte_aligned = (paddr & PAGE_MASK) >> PAGE_SHIFT;
>  	pmd_aligned = (paddr & PMD_MASK) >> PAGE_SHIFT;
> _
> 
> 
