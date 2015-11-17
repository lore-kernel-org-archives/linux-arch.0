From: Greg Ungerer <gerg@uclinux.org>
Subject: Re: [PATCH 2/4] m68k/mm: m54xx - Add missing initialization of
 max_pfn
Date: Tue, 17 Nov 2015 10:16:07 +1000
Message-ID: <564A71C7.1070902@uclinux.org>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org>
 <1447585455-19671-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <1447585455-19671-3-git-send-email-geert@linux-m68k.org>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Geert,

On 15/11/15 21:04, Geert Uytterhoeven wrote:
> If max_pfn is not initialized, the various /proc/kpage* files are empty,
> and selftests/vm/mlock2-tests will fail. max_pfn is also used by the
> block layer to calculate DMA masks.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only.

Tested and seems to work fine on MMU ColdFire (I didn't check
the actual entries for accuracy - but /proc/kpageflags and
/proc/kpagecount look to be reporting correctly now).

Tested-by: Greg Ungerer <gerg@uclinux.org>

Regards
Greg



> ---
>  arch/m68k/coldfire/m54xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/coldfire/m54xx.c b/arch/m68k/coldfire/m54xx.c
> index f7836c6a6b60eb24..c32f76791f488ae1 100644
> --- a/arch/m68k/coldfire/m54xx.c
> +++ b/arch/m68k/coldfire/m54xx.c
> @@ -98,7 +98,7 @@ static void __init mcf54xx_bootmem_alloc(void)
>  	memstart = PAGE_ALIGN(_ramstart);
>  	min_low_pfn = PFN_DOWN(_rambase);
>  	start_pfn = PFN_DOWN(memstart);
> -	max_low_pfn = PFN_DOWN(_ramend);
> +	max_pfn = max_low_pfn = PFN_DOWN(_ramend);
>  	high_memory = (void *)_ramend;
>  
>  	m68k_virt_to_node_shift = fls(_ramend - _rambase - 1) - 6;
> 
