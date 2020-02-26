Return-Path: <SRS0=ZbOS=4O=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH v9 10/27] x86/mm: Update pte_modify, pmd_modify, and
 _PAGE_CHG_MASK for _PAGE_DIRTY_SW
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-11-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <c215a795-1411-9ab0-10a6-520dd4771016@intel.com>
Date: Wed, 26 Feb 2020 14:02:06 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-11-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226220206.jwj1249DQNNvdPCYzVWsCpRs-KwlehQe4PLPIpZq730@z>

The subject really needs work.  Could you think of a way to summarize
the changes here in english as opposed to just listing the symbols you
modified?

I think we could probably just auto-generate subjects for patches if the
existing one were sufficient.

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> After the introduction of _PAGE_DIRTY_SW, pte_modify and pmd_modify nee=
d to
> set the Dirty bit accordingly: if Shadow Stack is enabled and _PAGE_RW =
is
> cleared, use _PAGE_DIRTY_SW; otherwise _PAGE_DIRTY_HW.

You've basically gone and written the code's if() statement in english
here.  That doesn't really help me understand the patch.

> Since the Dirty bit is modify by pte_modify(), remove _PAGE_DIRTY_HW fr=
om
> PAGE_CHG_MASK.

			 ^ modified

This is a great example of a changelog that adds very little value.
It's following the comments and doing what they say, but it's pretty
obvious that the analysis stopped there.

What *kinds* of bits are in _PAGE_CHG_MASK or not?  What changed about
_PAGE_DIRTY_HW.  By this definition, shouldn't _PAGE_DIRTY_SW have
technically been in this mask before this patch?

> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgta=
ble.h
> index 62aeb118bc36..2733e7ec16b3 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -702,6 +702,14 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t=
 newprot)
>  	val &=3D _PAGE_CHG_MASK;
>  	val |=3D check_pgprot(newprot) & ~_PAGE_CHG_MASK;
>  	val =3D flip_protnone_guard(oldval, val, PTE_PFN_MASK);
> +
> +	if (pte_dirty(pte)) {
> +		if (static_cpu_has(X86_FEATURE_SHSTK) && !(val & _PAGE_RW))
> +			val |=3D _PAGE_DIRTY_SW;
> +		else
> +			val |=3D _PAGE_DIRTY_HW;
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

> @@ -712,6 +720,14 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t=
 newprot)
>  	val &=3D _HPAGE_CHG_MASK;
>  	val |=3D check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
>  	val =3D flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
> +
> +	if (pmd_dirty(pmd)) {
> +		if (static_cpu_has(X86_FEATURE_SHSTK) && !(val & _PAGE_RW))
> +			val |=3D _PAGE_DIRTY_SW;
> +		else
> +			val |=3D _PAGE_DIRTY_HW;
> +	}
> +
>  	return __pmd(val);
>  }
> =20
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/as=
m/pgtable_types.h
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
