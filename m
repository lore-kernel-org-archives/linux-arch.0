From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [patch 1/2]: x86: implement pte_special
Date: Thu, 27 Mar 2008 20:23:34 -0700 (PDT)
Message-ID: <20080327.202334.250213398.davem@davemloft.net>
References: <20080328025455.GA8083@wotan.suse.de>
	<20080328025541.GB8083@wotan.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080328025541.GB8083-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: npiggin-l3A5Bk7waGM@public.gmane.org
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, shaggy-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org, axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org

From: Nick Piggin <npiggin-l3A5Bk7waGM@public.gmane.org>
Date: Fri, 28 Mar 2008 03:55:41 +0100

> @@ -40,6 +41,8 @@
>  #define _PAGE_UNUSED3	(_AC(1, L)<<_PAGE_BIT_UNUSED3)
>  #define _PAGE_PAT	(_AC(1, L)<<_PAGE_BIT_PAT)
>  #define _PAGE_PAT_LARGE (_AC(1, L)<<_PAGE_BIT_PAT_LARGE)
> +#define _PAGE_SPECIAL	(_AC(1, L)<<_PAGE_BIT_SPECIAL)
> +#define __HAVE_ARCH_PTE_SPECIAL

What tests __HAVE_ARCH_PTE_SPECIAL?

> @@ -167,7 +170,7 @@ static inline pte_t pte_mkhuge(pte_t pte
>  static inline pte_t pte_clrhuge(pte_t pte)	{ return __pte(pte_val(pte) & ~(pteval_t)_PAGE_PSE); }
>  static inline pte_t pte_mkglobal(pte_t pte)	{ return __pte(pte_val(pte) | _PAGE_GLOBAL); }
>  static inline pte_t pte_clrglobal(pte_t pte)	{ return __pte(pte_val(pte) & ~(pteval_t)_PAGE_GLOBAL); }
> -static inline pte_t pte_mkspecial(pte_t pte)	{ return pte; }
> +static inline pte_t pte_mkspecial(pte_t pte)	{ return __pte(pte_val(pte) | _PAGE_SPECIAL); }

And what calls pte_mkspecial?

I don't see any code that sets the special bit anywhere
in these two patches.

What am I missing?
