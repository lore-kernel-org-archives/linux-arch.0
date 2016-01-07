From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 15/17] x86/kexec: Remove walk_iomem_res() call with
 GART
Date: Thu, 7 Jan 2016 20:37:38 +0800
Message-ID: <20160107123738.GA2870@dhcp-128-65.nay.redhat.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
 <1452020081-26534-15-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44779 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254AbcAGMhy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 7 Jan 2016 07:37:54 -0500
Content-Disposition: inline
In-Reply-To: <1452020081-26534-15-git-send-email-toshi.kani@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Minfei Huang <mhuang@redhat.com>, x86@kernel.org, kexec@lists.infradead.org

On 01/05/16 at 11:54am, Toshi Kani wrote:
> There is no longer any driver inserting a "GART" region in the kernel
> since 'commit 707d4eefbdb3 ("Revert "[PATCH] Insert GART region into
> resource map"")' was made.
> 
> Remove the call to walk_iomem_res() with "GART", its callback function,
> and GART-specific variables set by the callback.
> 
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Minfei Huang <mhuang@redhat.com>
> Cc: x86@kernel.org
> Cc: kexec@lists.infradead.org
> Link: http://lkml.kernel.org/r/<20160104110427.GA2965@dhcp-128-65.nay.redhat.com>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> ---
>  arch/x86/kernel/crash.c |   37 +------------------------------------
>  1 file changed, 1 insertion(+), 36 deletions(-)
> 
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index 082373b..f5069e7 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -56,10 +56,9 @@ struct crash_elf_data {
>  	struct kimage *image;
>  	/*
>  	 * Total number of ram ranges we have after various adjustments for
> -	 * GART, crash reserved region etc.
> +	 * crash reserved region, etc.
>  	 */
>  	unsigned int max_nr_ranges;
> -	unsigned long gart_start, gart_end;
>  
>  	/* Pointer to elf header */
>  	void *ehdr;
> @@ -190,17 +189,6 @@ static int get_nr_ram_ranges_callback(u64 start, u64 end, void *arg)
>  	return 0;
>  }
>  
> -static int get_gart_ranges_callback(u64 start, u64 end, void *arg)
> -{
> -	struct crash_elf_data *ced = arg;
> -
> -	ced->gart_start = start;
> -	ced->gart_end = end;
> -
> -	/* Not expecting more than 1 gart aperture */
> -	return 1;
> -}
> -
>  
>  /* Gather all the required information to prepare elf headers for ram regions */
>  static void fill_up_crash_elf_data(struct crash_elf_data *ced,
> @@ -215,22 +203,6 @@ static void fill_up_crash_elf_data(struct crash_elf_data *ced,
>  
>  	ced->max_nr_ranges = nr_ranges;
>  
> -	/*
> -	 * We don't create ELF headers for GART aperture as an attempt
> -	 * to dump this memory in second kernel leads to hang/crash.
> -	 * If gart aperture is present, one needs to exclude that region
> -	 * and that could lead to need of extra phdr.
> -	 */
> -	walk_iomem_res("GART", IORESOURCE_MEM, 0, -1,
> -				ced, get_gart_ranges_callback);
> -
> -	/*
> -	 * If we have gart region, excluding that could potentially split
> -	 * a memory range, resulting in extra header. Account for  that.
> -	 */
> -	if (ced->gart_end)
> -		ced->max_nr_ranges++;
> -
>  	/* Exclusion of crash region could split memory ranges */
>  	ced->max_nr_ranges++;
>  
> @@ -339,13 +311,6 @@ static int elf_header_exclude_ranges(struct crash_elf_data *ced,
>  			return ret;
>  	}
>  
> -	/* Exclude GART region */
> -	if (ced->gart_end) {
> -		ret = exclude_mem_range(cmem, ced->gart_start, ced->gart_end);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	return ret;
>  }
>  

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
