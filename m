From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: generic page.h problem
Date: Wed, 23 Mar 2011 20:53:40 +0100
Message-ID: <201103232053.40057.arnd@arndb.de>
References: <1300907573.15255.224.camel@deneb.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55060 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932366Ab1CWTxo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Mar 2011 15:53:44 -0400
In-Reply-To: <1300907573.15255.224.camel@deneb.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 23 March 2011 20:12:53 Mark Salter wrote:
> I'm working with a new architecture port (nommu) and was wanting to use
> the generic page.h but there is a problem. I'm using CONFIG_FLATMEM with
> a non-zero CONFIG_KERNEL_RAM_BASE_ADDRESS. The hardware uses this same
> address to access RAM from code and for DMA purposes. The generic page.h
> has:
> 
> #ifdef CONFIG_KERNEL_RAM_BASE_ADDRESS
> #define PAGE_OFFSET		(CONFIG_KERNEL_RAM_BASE_ADDRESS)
> #else
> #define PAGE_OFFSET		(0)
> #endif
> 
> #ifndef __ASSEMBLY__
> 
> #define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
> #define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
> 
> The problem I have is that __va(x) and __pa(x) should do nothing on
> this architecture. If I use the following, then everything seems to
> work as it should.
> 
> 
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> index 75fec18..4dc4a81 100644
> --- a/include/asm-generic/page.h
> +++ b/include/asm-generic/page.h
> @@ -73,8 +73,8 @@ extern unsigned long memory_end;
>  
>  #ifndef __ASSEMBLY__
>  
> -#define __va(x) ((void *)((unsigned long)(x) + PAGE_OFFSET))
> -#define __pa(x) ((unsigned long) (x) - PAGE_OFFSET)
> +#define __va(x) ((void *)((unsigned long) (x)))
> +#define __pa(x) ((unsigned long) (x))
>  
>  #define virt_to_pfn(kaddr)     (__pa(kaddr) >> PAGE_SHIFT)
>  #define pfn_to_virt(pfn)       __va((pfn) << PAGE_SHIFT)
> 
> 
> Am I missing something here? The only other arch using the generic
> page.h is blackfin, but it uses a zero PAGE_OFFSET, so my patch
> would have no effect there.

I don't think the handling of nonzero PAGE_OFFSET in asm-generic/page.h
was intentional. When Remis worked on the patch to introduce this file,
the idea was to take the common parts from all related architectures
and come up with a way that works on most of them.

Maybe one of the other arch maintainers has an opinion on this. If
not, I don't mind your patch, just add that to your series when submitting
the architecture for review.

	Arnd
