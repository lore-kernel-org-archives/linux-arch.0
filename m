From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 16/20] m68knommu: use generic show_mem()
Date: Sun, 06 Jul 2008 13:34:43 +1000
Message-ID: <48703D53.7000402@snapgear.com>
References: <20080704160737.750988999@saeurebad.de> <20080704161457.056057813@saeurebad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756140AbYGFDgf@vger.kernel.org>
In-Reply-To: <20080704161457.056057813@saeurebad.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-arch.vger.kernel.org


Johannes Weiner wrote:
> Remove arch-specific show_mem() in favor of the generic version.
> 
> This also removes the following redundant information display:
> 
> 	- free pages, printed by show_free_areas()
> 	- pages in swapcache, printed by show_swap_cache_info()
> 
> where show_mem() calls show_free_areas(), which calls
> show_swap_cache_info().
> 
> Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
> CC: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Greg Ungerer <gerg@uclinux.org>



> ---
>  arch/m68knommu/mm/init.c |   27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> --- a/arch/m68knommu/mm/init.c
> +++ b/arch/m68knommu/mm/init.c
> @@ -62,33 +62,6 @@ static unsigned long empty_bad_page;
>  
>  unsigned long empty_zero_page;
>  
> -void show_mem(void)
> -{
> -    unsigned long i;
> -    int free = 0, total = 0, reserved = 0, shared = 0;
> -    int cached = 0;
> -
> -    printk(KERN_INFO "\nMem-info:\n");
> -    show_free_areas();
> -    i = max_mapnr;
> -    while (i-- > 0) {
> -	total++;
> -	if (PageReserved(mem_map+i))
> -	    reserved++;
> -	else if (PageSwapCache(mem_map+i))
> -	    cached++;
> -	else if (!page_count(mem_map+i))
> -	    free++;
> -	else
> -	    shared += page_count(mem_map+i) - 1;
> -    }
> -    printk(KERN_INFO "%d pages of RAM\n",total);
> -    printk(KERN_INFO "%d free pages\n",free);
> -    printk(KERN_INFO "%d reserved pages\n",reserved);
> -    printk(KERN_INFO "%d pages shared\n",shared);
> -    printk(KERN_INFO "%d pages swap cached\n",cached);
> -}
> -
>  extern unsigned long memory_start;
>  extern unsigned long memory_end;
>  

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
Secure Computing Corporation                PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
