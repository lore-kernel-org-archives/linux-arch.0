From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [PATCH 4/6] x86/kasan: Prepare clear_pgds() to switch to
 <asm-generic/pgtable-nop4d.h>
Date: Mon, 20 Mar 2017 19:21:20 +0300
Message-ID: <218853b4-3498-dab9-d1e9-02caed4d9322@virtuozzo.com>
References: <20170317185515.8636-1-kirill.shutemov@linux.intel.com>
 <20170317185515.8636-5-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170317185515.8636-5-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
List-Id: linux-arch.vger.kernel.org



On 03/17/2017 09:55 PM, Kirill A. Shutemov wrote:
> With folded p4d, pgd_clear() is nop. Change clear_pgds() to use
> p4d_clear() instead.
> 

You could probably just use set_pgd(pgd_offset_k(start), __pgd(0)); instead of pgd_clear()
as we already do in arm64.
It's basically pgd_clear() except it's not a nop wih p4d folded.


> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  arch/x86/mm/kasan_init_64.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/kasan_init_64.c b/arch/x86/mm/kasan_init_64.c
> index 0a56059a95c7..b775ffd7989d 100644
> --- a/arch/x86/mm/kasan_init_64.c
> +++ b/arch/x86/mm/kasan_init_64.c
> @@ -35,8 +35,19 @@ static int __init map_range(struct range *range)
>  static void __init clear_pgds(unsigned long start,
>  			unsigned long end)
>  {
> -	for (; start < end; start += PGDIR_SIZE)
> -		pgd_clear(pgd_offset_k(start));
> +	pgd_t *pgd;
> +
> +	for (; start < end; start += PGDIR_SIZE) {
> +		pgd = pgd_offset_k(start);
> +		/*
> +		 * With folded p4d, pgd_clear() is nop, use p4d_clear()
> +		 * instead.
> +		 */
> +		if (CONFIG_PGTABLE_LEVELS < 5)
> +			p4d_clear(p4d_offset(pgd, start));
> +		else
> +			pgd_clear(pgd);
> +	}
>  }
>  
>  static void __init kasan_map_early_shadow(pgd_t *pgd)
> 

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
