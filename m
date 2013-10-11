From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 02/34] cris: fix potential NULL-pointer dereference
Date: Fri, 11 Oct 2013 11:58:13 +0200
Message-ID: <20131011095813.GH11028@axis.com>
References: <1381428359-14843-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1381428359-14843-3-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1381428359-14843-3-git-send-email-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 10, 2013 at 08:05:27PM +0200, Kirill A. Shutemov wrote:
> Add missing check for memory allocation fail.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> ---
>  arch/cris/include/asm/pgalloc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/cris/include/asm/pgalloc.h b/arch/cris/include/asm/pgalloc.h
> index 6da975db11..d9504d38c2 100644
> --- a/arch/cris/include/asm/pgalloc.h
> +++ b/arch/cris/include/asm/pgalloc.h
> @@ -32,6 +32,8 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addres
>  {
>  	struct page *pte;
>  	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
> +	if (!pte)
> +		return NULL;
>  	pgtable_page_ctor(pte);
>  	return pte;
>  }
> -- 
> 1.8.4.rc3

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
