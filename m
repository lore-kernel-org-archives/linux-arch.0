From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 14/34] cris: handle pgtable_page_ctor() fail
Date: Fri, 11 Oct 2013 11:57:52 +0200
Message-ID: <20131011095752.GG11028@axis.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1381428359-14843-15-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1381428359-14843-15-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 10, 2013 at 08:05:39PM +0200, Kirill A. Shutemov wrote:
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/include/asm/pgalloc.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/cris/include/asm/pgalloc.h b/arch/cris/include/asm/pgalloc.h
> index d9504d38c2..235ece437d 100644
> --- a/arch/cris/include/asm/pgalloc.h
> +++ b/arch/cris/include/asm/pgalloc.h
> @@ -34,7 +34,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addres
>  	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
>  	if (!pte)
>  		return NULL;
> -	pgtable_page_ctor(pte);
> +	if (!pgtable_page_ctor(pte)) {
> +		__free_page(pte);
> +		return NULL;
> +	}
>  	return pte;
>  }
>  
> -- 
> 1.8.4.rc3

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
