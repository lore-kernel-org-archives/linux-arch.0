From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] fixmap: change temp variable name
Date: Mon, 12 Oct 2015 11:05:26 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1510121104180.6097@nanos>
References: <1444637308-23390-1-git-send-email-yalin.wang2010@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43468 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbbJLJGF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 Oct 2015 05:06:05 -0400
In-Reply-To: <1444637308-23390-1-git-send-email-yalin.wang2010@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: yalin wang <yalin.wang2010@gmail.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 12 Oct 2015, yalin wang wrote:
> Change temp variable name addr to ____addr,
> so that not conflict with the caller's variable name,
> it will build error if call like this:
> __set_fixmap_offset(idx, addr, flags)

Can't we just use inlines to avoid this kind of crap?

Thanks,

	tglx
 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  include/asm-generic/fixmap.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> index 1cbb833..91ecaed 100644
> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -72,10 +72,10 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
>  /* Return a pointer with offset calculated */
>  #define __set_fixmap_offset(idx, phys, flags)		      \
>  ({							      \
> -	unsigned long addr;				      \
> +	unsigned long ____addr;				      \
>  	__set_fixmap(idx, phys, flags);			      \
> -	addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
> -	addr;						      \
> +	____addr = fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1)); \
> +	____addr;						      \
>  })
>  
>  #define set_fixmap_offset(idx, phys) \
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
