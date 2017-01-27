Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:34099 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933655AbdA0LGQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Jan 2017 06:06:16 -0500
Subject: Re: [PATCHv2 02/29] asm-generic: introduce 5level-fixup.h
References: <20161227015413.187403-1-kirill.shutemov@linux.intel.com>
 <20161227015413.187403-3-kirill.shutemov@linux.intel.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <0183120a-5e8b-5da9-0bad-cc0295bb8337@suse.cz>
Date: Fri, 27 Jan 2017 12:06:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161227015413.187403-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170127110602.kM4LEXLi5hE3I5rpCPj4kYX75Eg-ZJdKQUE81poGwqQ@z>

On 12/27/2016 02:53 AM, Kirill A. Shutemov wrote:
> We are going to switch core MM to 5-level paging abstraction.
>
> This is preparation step which adds <asm-generic/5level-fixup.h>
> As with 4level-fixup.h, the new header allows quickly make all
> architectures compatible with 5-level paging in core MM.
>
> In long run we would like to switch architectures to properly folded p4d
> level by using <asm-generic/pgtable-nop4d.h>, but it requires more
> changes to arch-specific code.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/asm-generic/4level-fixup.h |  3 ++-
>  include/asm-generic/5level-fixup.h | 41 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mm.h                 |  3 +++
>  3 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 include/asm-generic/5level-fixup.h
>
> diff --git a/include/asm-generic/4level-fixup.h b/include/asm-generic/4level-fixup.h
> index 5bdab6bffd23..928fd66b1271 100644
> --- a/include/asm-generic/4level-fixup.h
> +++ b/include/asm-generic/4level-fixup.h
> @@ -15,7 +15,6 @@
>  	((unlikely(pgd_none(*(pud))) && __pmd_alloc(mm, pud, address))? \
>   		NULL: pmd_offset(pud, address))
>
> -#define pud_alloc(mm, pgd, address)	(pgd)

This...

>  #define pud_offset(pgd, start)		(pgd)
>  #define pud_none(pud)			0
>  #define pud_bad(pud)			0
> @@ -35,4 +34,6 @@
>  #undef  pud_addr_end
>  #define pud_addr_end(addr, end)		(end)
>
> +#include <asm-generic/5level-fixup.h>

... plus this...

> +
>  #endif
> diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
> new file mode 100644
> index 000000000000..b5ca82dc4175
> --- /dev/null
> +++ b/include/asm-generic/5level-fixup.h
> @@ -0,0 +1,41 @@
> +#ifndef _5LEVEL_FIXUP_H
> +#define _5LEVEL_FIXUP_H
> +
> +#define __ARCH_HAS_5LEVEL_HACK
> +#define __PAGETABLE_P4D_FOLDED
> +
> +#define P4D_SHIFT			PGDIR_SHIFT
> +#define P4D_SIZE			PGDIR_SIZE
> +#define P4D_MASK			PGDIR_MASK
> +#define PTRS_PER_P4D			1
> +
> +#define p4d_t				pgd_t
> +
> +#define pud_alloc(mm, p4d, address) \
> +	((unlikely(pgd_none(*(p4d))) && __pud_alloc(mm, p4d, address)) ? \
> +		NULL : pud_offset(p4d, address))

... and this, makes me wonder if that broke pud_alloc() for architectures that 
use the 4level-fixup.h. Don't those need to continue having pud_alloc() as (pgd)?

