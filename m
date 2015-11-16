From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH 4/4] m68knommu: Add missing initialization of max_pfn and
 {min,max}_low_pfn
Date: Tue, 17 Nov 2015 09:54:12 +1000
Message-ID: <564A6CA4.9000206@uclinux.org>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
 <1447585455-19671-5-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:47602
	"EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751236AbbKPXyN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Nov 2015 18:54:13 -0500
In-Reply-To: <1447585455-19671-5-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Geert,

On 15/11/15 21:04, Geert Uytterhoeven wrote:
> If max_pfn is not initialized, the block layer may use wrong DMA masks.
> 
> Replace open-coded shifts by PFN_DOWN() while we're at it.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Tested and working fine on m68knommu. So:

Tested-By: Greg Ungerer <gerg@uclinux.org>

If you respin this patch for any reason I wouldn't object
to removing the "/* 0 on coldfire */" comment...

Regards
Greg



> ---
> Compile-tested only.
> ---
>  arch/m68k/kernel/setup_no.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index 88c27d94a7214c95..29b44e69f0f47375 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -238,11 +238,14 @@ void __init setup_arch(char **cmdline_p)
>  	 * Give all the memory to the bootmap allocator, tell it to put the
>  	 * boot mem_map at the start of memory.
>  	 */
> +	min_low_pfn = PFN_DOWN(memory_start);
> +	max_pfn = max_low_pfn = PFN_DOWN(memory_end);
> +
>  	bootmap_size = init_bootmem_node(
>  			NODE_DATA(0),
> -			memory_start >> PAGE_SHIFT, /* map goes here */
> -			PAGE_OFFSET >> PAGE_SHIFT,	/* 0 on coldfire */
> -			memory_end >> PAGE_SHIFT);
> +			min_low_pfn,		/* map goes here */
> +			PFN_DOWN(PAGE_OFFSET),	/* 0 on coldfire */
> +			max_pfn);
>  	/*
>  	 * Free the usable memory, we have to make sure we do not free
>  	 * the bootmem bitmap so we then reserve it after freeing it :-)
> 
