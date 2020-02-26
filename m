From: Dave Hansen <dave.hansen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH v9 10/27] x86/mm: Update pte_modify, pmd_modify, and
 _PAGE_CHG_MASK for _PAGE_DIRTY_SW
Date: Wed, 26 Feb 2020 14:02:06 -0800
Message-ID: <c215a795-1411-9ab0-10a6-520dd4771016@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-11-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200205181935.3712-11-yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yu-cheng Yu <yu-cheng.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andy Lutomirski <luto-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Balbir Singh <bsingharora-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>, Cyrill Gorcunov <gorcunov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dave Hansen <dave.hansen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Eugene Syromiatnikov <esyr-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H.J. Lu" <hjl.tools-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Mike Kravetz <mike.kravetz-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

The subject really needs work.  Could you think of a way to summarize
the changes here in english as opposed to just listing the symbols you
modified?

I think we could probably just auto-generate subjects for patches if the
existing one were sufficient.

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> After the introduction of _PAGE_DIRTY_SW, pte_modify and pmd_modify need to
> set the Dirty bit accordingly: if Shadow Stack is enabled and _PAGE_RW is
> cleared, use _PAGE_DIRTY_SW; otherwise _PAGE_DIRTY_HW.

You've basically gone and written the code's if() statement in english
here.  That doesn't really help me understand the patch.

> Since the Dirty bit is modify by pte_modify(), remove _PAGE_DIRTY_HW from
> PAGE_CHG_MASK.

			 ^ modified

This is a great example of a changelog that adds very little value.
It's following the comments and doing what they say, but it's pretty
obvious that the analysis stopped there.

What *kinds* of bits are in _PAGE_CHG_MASK or not?  What changed about
_PAGE_DIRTY_HW.  By this definition, shouldn't _PAGE_DIRTY_SW have
technically been in this mask before this patch?

> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 62aeb118bc36..2733e7ec16b3 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -702,6 +702,14 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	val &= _PAGE_CHG_MASK;
>  	val |= check_pgprot(newprot) & ~_PAGE_CHG_MASK;
>  	val = flip_protnone_guard(oldval, val, PTE_PFN_MASK);
> +
> +	if (pte_dirty(pte)) {
> +		if (static_cpu_has(X86_FEATURE_SHSTK) && !(val & _PAGE_RW))
> +			val |= _PAGE_DIRTY_SW;
> +		else
> +			val |= _PAGE_DIRTY_HW;
> +	}
> +
>  	return __pte(val);
>  }

OK, so this is a path we use for changing bunches of PTEs to 'newprot'.
 It doesn't use the pte_*() helpers that the previous patch fixed up, so
we need a new site.

Right?

Maybe that would make good changelog text.

Also, couldn't we just have a pte_fixup() function or something that did
this logic and could be shared?

> @@ -712,6 +720,14 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  	val &= _HPAGE_CHG_MASK;
>  	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
>  	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
> +
> +	if (pmd_dirty(pmd)) {
> +		if (static_cpu_has(X86_FEATURE_SHSTK) && !(val & _PAGE_RW))
> +			val |= _PAGE_DIRTY_SW;
> +		else
> +			val |= _PAGE_DIRTY_HW;
> +	}
> +
>  	return __pmd(val);
>  }
>  
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 826823df917f..e7e28bf7e919 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -150,8 +150,8 @@
>   * instance, and is *not* included in this mask since
>   * pte_modify() does modify it.
>   */
> -#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
> -			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY_HW |	\
> +#define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |	\
> +			 _PAGE_SPECIAL | _PAGE_ACCESSED |	\
>  			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
>  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
