From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH -mmotm] mm: unify some pmd_*() functions fix
Date: Mon, 02 Feb 2009 14:48:46 +0100
Message-ID: <1233582526.18006.31.camel@localhost>
References: <1233183874-26066-1-git-send-email-righi.andrea@gmail.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate3.de.ibm.com ([195.212.29.152]:41663 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZBBNst (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2009 08:48:49 -0500
In-Reply-To: <1233183874-26066-1-git-send-email-righi.andrea@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Righi <righi.andrea@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>

On Thu, 2009-01-29 at 00:04 +0100, Andrea Righi wrote:
> Also unify implementations of pmd_*() functions in arch/*.
> 
> This patch must be applied on top of mm-unify-some-pmd_-functions.patch.
> 
> Signed-off-by: Andrea Righi <righi.andrea@gmail.com>

> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index b2658b9..6a85281 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -63,8 +63,7 @@ static inline unsigned long pgd_entry_type(struct mm_struct *mm)
>  #define pud_alloc_one(mm,address)		({ BUG(); ((pud_t *)2); })
>  #define pud_free(mm, x)				do { } while (0)
> 
> -#define pmd_alloc_one(mm,address)		({ BUG(); ((pmd_t *)2); })
> -#define pmd_free(mm, x)				do { } while (0)
> +#define pmd_alloc_one	pmd_alloc_one_bug
> 
>  #define pgd_populate(mm, pgd, pud)		BUG()
>  #define pgd_populate_kernel(mm, pgd, pud)	BUG()

This does not compile for 32 bit s390. With the patches for 'dynamic
page tables' and '1K/2k page tables' I decided to get completely
independent from the nopmd/nopud #ifdef hell. The include files from
asm-generic are simply not used for s390. Please drop the above hunk
from your patch and leave s390 as it is.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
