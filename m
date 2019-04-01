Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35710 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfDAO17 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Apr 2019 10:27:59 -0400
Date: Mon, 1 Apr 2019 15:27:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/4] arm64: compat: Alloc separate pages for vectors and
 sigpage
Message-ID: <20190401142754.GF14874@arrakis.emea.arm.com>
References: <20190401112025.40807-1-vincenzo.frascino@arm.com>
 <20190401112025.40807-2-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401112025.40807-2-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Message-ID: <20190401142755.6IkXWUYB6jSFH-yqraFNRG3sn4ZLVIhAuxJLyNb-g2A@z>

On Mon, Apr 01, 2019 at 12:20:22PM +0100, Vincenzo Frascino wrote:
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 2d419006ad43..9556ad2036ef 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -1,5 +1,7 @@
>  /*
> - * VDSO implementation for AArch64 and vector page setup for AArch32.
> + * VDSO implementation for AArch64 and for AArch32:
> + * AArch64: vDSO implementation contains pages setup and data page update.
> + * AArch32: vDSO implementation contains sigreturn and kuser pages setup.
>   *
>   * Copyright (C) 2012 ARM Limited
>   *
> @@ -53,61 +55,117 @@ struct vdso_data *vdso_data = &vdso_data_store.data;
>  /*
>   * Create and map the vectors page for AArch32 tasks.
>   */
> -static struct page *vectors_page[1] __ro_after_init;
> +/*
> + * aarch32_vdso_pages:
> + * 0 - kuser helpers
> + * 1 - sigreturn code
> + */
> +static struct page *aarch32_vdso_pages[2] __ro_after_init;

More of a nitpick, the code may be easier to follow if we had two
separate variables. Does the array buy us anything?

> +static const struct vm_special_mapping aarch32_vdso_spec[2] = {
> +	{
> +		/* Must be named [vectors] for compatibility with arm. */
> +		.name	= "[vectors]",
> +		.pages	= &aarch32_vdso_pages[0],
> +	},
> +	{
> +		/* Must be named [sigpage] for compatibility with arm. */
> +		.name	= "[sigpage]",
> +		.pages	= &aarch32_vdso_pages[1],
> +	},
> +};
[...]
> -int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
> +static int aarch32_kuser_helpers_setup(struct mm_struct *mm)
>  {
> -	struct mm_struct *mm = current->mm;
> -	unsigned long addr = AARCH32_VECTORS_BASE;
> -	static const struct vm_special_mapping spec = {
> -		.name	= "[vectors]",
> -		.pages	= vectors_page,
> +	void *ret;
> +
> +	/* The kuser helpers must be mapped at the ABI-defined high address */
> +	ret = _install_special_mapping(mm, AARCH32_KUSER_BASE, PAGE_SIZE,
> +				       VM_READ | VM_EXEC |
> +				       VM_MAYREAD | VM_MAYEXEC,
> +				       &aarch32_vdso_spec[0]);
> +
> +	return PTR_ERR_OR_ZERO(ret);
> +}
>  
> -	};
> +static int aarch32_sigreturn_setup(struct mm_struct *mm)
> +{
> +	unsigned long addr;
>  	void *ret;
>  
> -	if (down_write_killable(&mm->mmap_sem))
> -		return -EINTR;
> -	current->mm->context.vdso = (void *)addr;
> +	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
> +	if (IS_ERR_VALUE(addr)) {
> +		ret = ERR_PTR(addr);
> +		goto out;
> +	}
>  
> -	/* Map vectors page at the high address. */
>  	ret = _install_special_mapping(mm, addr, PAGE_SIZE,
> -				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
> -				       &spec);
> +				       VM_READ | VM_EXEC | VM_MAYREAD |
> +				       VM_MAYWRITE | VM_MAYEXEC,
> +				       &aarch32_vdso_spec[1]);

Any reason for setting VM_MAYWRITE here?

-- 
Catalin
