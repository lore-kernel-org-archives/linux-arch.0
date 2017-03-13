From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH] mm, gup: fix typo in gup_p4d_range()
Date: Mon, 13 Mar 2017 09:44:29 +0100
Message-ID: <20170313084429.GB31518@dhcp22.suse.cz>
References: <20170313052213.11411-1-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <20170313052213.11411-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon 13-03-17 08:22:13, Kirill A. Shutemov wrote:
> gup_p4d_range() should call gup_pud_range(), not itself.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Fixes: c2febafc6773 ("mm: convert generic code to 5-level paging")

Upps, missed this one during the review. Thanks for catching that up

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/gup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index c74bad1bf6e8..04aa405350dc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1455,7 +1455,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
>  			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
>  					 P4D_SHIFT, next, write, pages, nr))
>  				return 0;
> -		} else if (!gup_p4d_range(p4d, addr, next, write, pages, nr))
> +		} else if (!gup_pud_range(p4d, addr, next, write, pages, nr))
>  			return 0;
>  	} while (p4dp++, addr = next, addr != end);
>  
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
