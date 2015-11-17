From: Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH 1/4] m68k/mm: motorola - Add missing initialization of
 max_pfn
Date: Tue, 17 Nov 2015 17:42:34 +1300
Message-ID: <564AB03A.80303@gmail.com>
References: <1447585455-19671-1-git-send-email-geert@linux-m68k.org> <1447585455-19671-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35534 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbKQEms (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 16 Nov 2015 23:42:48 -0500
Received: by pacej9 with SMTP id ej9so91435194pac.2
        for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2015 20:42:48 -0800 (PST)
In-Reply-To: <1447585455-19671-2-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@uclinux.org>, Sam Creasey <sammy@sammy.net>, linux-m68k@lists.linux-m68k.org
Cc: linux-arch@vger.kernel.org

Hi Geert,


Am 16.11.2015 um 00:04 schrieb Geert Uytterhoeven:
> If max_pfn is not initialized, the various /proc/kpage* files are empty,
> and selftests/vm/mlock2-tests will fail. max_pfn is also used by the
> block layer to calculate DMA masks.

What about platforms where the DMA can't address all available physical
memory?

Cheers,

	Michael


> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  arch/m68k/mm/motorola.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index b958916e5eac96b2..8f37fdd80be9e9cc 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -250,7 +250,7 @@ void __init paging_init(void)
>  	high_memory = phys_to_virt(max_addr);
>  
>  	min_low_pfn = availmem >> PAGE_SHIFT;
> -	max_low_pfn = max_addr >> PAGE_SHIFT;
> +	max_pfn = max_low_pfn = max_addr >> PAGE_SHIFT;
>  
>  	for (i = 0; i < m68k_num_memory; i++) {
>  		addr = m68k_memory[i].addr;
> 
