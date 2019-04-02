From: Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH 1/4] arm64: compat: Alloc separate pages for vectors and
 sigpage
Date: Tue, 2 Apr 2019 11:01:04 +0100
Message-ID: <6c43e9f9-3500-b828-3cf9-1917b9de256a@arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-2-vincenzo.frascino@arm.com>
 <20190401142754.GF14874@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190401142754.GF14874@arrakis.emea.arm.com>
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
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On 01/04/2019 15:27, Catalin Marinas wrote:
> On Mon, Apr 01, 2019 at 12:20:22PM +0100, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
>> index 2d419006ad43..9556ad2036ef 100644
>> --- a/arch/arm64/kernel/vdso.c
>> +++ b/arch/arm64/kernel/vdso.c
>> @@ -1,5 +1,7 @@
>>  /*
>> - * VDSO implementation for AArch64 and vector page setup for AArch32.
>> + * VDSO implementation for AArch64 and for AArch32:
>> + * AArch64: vDSO implementation contains pages setup and data page update.
>> + * AArch32: vDSO implementation contains sigreturn and kuser pages setup.
>>   *
>>   * Copyright (C) 2012 ARM Limited
>>   *
>> @@ -53,61 +55,117 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
>>  /*
>>   * Create and map the vectors page for AArch32 tasks.
>>   */
>> -static struct page *vectors_page[1] __ro_after_init;
>> +/*
>> + * aarch32_vdso_pages:
>> + * 0 - kuser helpers
>> + * 1 - sigreturn code
>> + */
>> +static struct page *aarch32_vdso_pages[2] __ro_after_init;
> 
> More of a nitpick, the code may be easier to follow if we had two
> separate variables. Does the array buy us anything?
>

Even though it does not make much difference right now, it simplifies the
implementation of the compat vdso going forward.

But I agree with you, we can always make the code more readable hence I will
introduce some meaningful defines in v2 (instead of 0 and 1 indexes).

>> +static const struct vm_special_mapping aarch32_vdso_spec[2] = {
>> +	{
>> +		/* Must be named [vectors] for compatibility with arm. */
>> +		.name	= "[vectors]",
>> +		.pages	= &aarch32_vdso_pages[0],
>> +	},
>> +	{
>> +		/* Must be named [sigpage] for compatibility with arm. */
>> +		.name	= "[sigpage]",
>> +		.pages	= &aarch32_vdso_pages[1],
>> +	},
>> +};
> [...]
>> -int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
>> +static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>>  {
>> -	struct mm_struct *mm = current->mm;
>> -	unsigned long addr = AARCH32_VECTORS_BASE;
>> -	static const struct vm_special_mapping spec = {
>> -		.name	= "[vectors]",
>> -		.pages	= vectors_page,
>> +	void *ret;
>> +
>> +	/* The kuser helpers must be mapped at the ABI-defined high address */
>> +	ret = _install_special_mapping(mm, AARCH32_KUSER_BASE, PAGE_SIZE,
>> +				       VM_READ | VM_EXEC |
>> +				       VM_MAYREAD | VM_MAYEXEC,
>> +				       &aarch32_vdso_spec[0]);
>> +
>> +	return PTR_ERR_OR_ZERO(ret);
>> +}
>>  
>> -	};
>> +static int aarch32_sigreturn_setup(struct mm_struct *mm)
>> +{
>> +	unsigned long addr;
>>  	void *ret;
>>  
>> -	if (down_write_killable(&mm->mmap_sem))
>> -		return -EINTR;
>> -	current->mm->context.vdso = (void *)addr;
>> +	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
>> +	if (IS_ERR_VALUE(addr)) {
>> +		ret = ERR_PTR(addr);
>> +		goto out;
>> +	}
>>  
>> -	/* Map vectors page at the high address. */
>>  	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
>> -				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
>> -				       &spec);
>> +				       VM_READ | VM_EXEC | VM_MAYREAD |
>> +				       VM_MAYWRITE | VM_MAYEXEC,
>> +				       &aarch32_vdso_spec[1]);
> 
> Any reason for setting VM_MAYWRITE here?
> 

VM_MAYWRITE is required to allow gdb to Copy-on-Write and set breakpoints.

-- 
Regards,
Vincenzo
