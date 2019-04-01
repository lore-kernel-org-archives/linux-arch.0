From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 1/5] arm64: compat: Alloc separate pages for vectors and
 sigpage
Date: Mon, 1 Apr 2019 10:00:44 +0100
Message-ID: <725414ad-63a3-1d4f-1cd4-3c406bc809c5@arm.com>
References: <20190319151542.19557-1-vincenzo.frascino@arm.com>
 <20190319151542.19557-2-vincenzo.frascino@arm.com>
 <20190329121211.gv7i7fqt74h3rtls@mbp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190329121211.gv7i7fqt74h3rtls@mbp>
Content-Language: en-US
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
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Jann Horn <jannh@google.com>
List-Id: linux-arch.vger.kernel.org

Hi Catalin,

thank you for your review.

On 29/03/2019 12:12, Catalin Marinas wrote:
> On Tue, Mar 19, 2019 at 03:15:38PM +0000, Vincenzo Frascino wrote:
>> +static int __init aarch32_alloc_vdso_pages(void)
>>  {
>>  	extern char __kuser_helper_start[], __kuser_helper_end[];
>>  	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
>>  
>>  	int kuser_sz = __kuser_helper_end - __kuser_helper_start;
>>  	int sigret_sz = __aarch32_sigret_code_end - __aarch32_sigret_code_start;
>> -	unsigned long vpage;
>> +	unsigned long vdso_pages[2];
>>  
>> -	vpage = get_zeroed_page(GFP_ATOMIC);
>> +	vdso_pages[0] = get_zeroed_page(GFP_ATOMIC);
>> +	if (!vdso_pages[0])
>> +		return -ENOMEM;
>>  
>> -	if (!vpage)
>> +	vdso_pages[1] = get_zeroed_page(GFP_ATOMIC);
>> +	if (!vdso_pages[1])
>>  		return -ENOMEM;
>>  
>>  	/* kuser helpers */
>> -	memcpy((void *)vpage + 0x1000 - kuser_sz, __kuser_helper_start,
>> -		kuser_sz);
>> +	memcpy((void *)(vdso_pages[0] + 0x1000 - kuser_sz),
>> +	       __kuser_helper_start,
>> +	       kuser_sz);
>>  
>>  	/* sigreturn code */
>> -	memcpy((void *)vpage + AARCH32_KERN_SIGRET_CODE_OFFSET,
>> -               __aarch32_sigret_code_start, sigret_sz);
>> +	memcpy((void *)vdso_pages[1],
>> +	       __aarch32_sigret_code_start,
>> +	       sigret_sz);
>>  
>> -	flush_icache_range(vpage, vpage + PAGE_SIZE);
>> -	vectors_page[0] = virt_to_page(vpage);
>> +	flush_icache_range(vdso_pages[0], vdso_pages[0] + PAGE_SIZE);
>> +	flush_icache_range(vdso_pages[1], vdso_pages[1] + PAGE_SIZE);
> 
> I wonder whether we still need the flush_icache_range() calls here.
> Normally set_pte_at() handles cache maintenance automatically if
> PG_dcache_clean is not set. We could probably just call
> flush_dcache_page() here.
> 

I agree, I am going to update the code accordingly and re-post the set.

-- 
Regards,
Vincenzo
