Return-Path: <SRS0=oITL=4O=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [RFC PATCH v9 09/27] x86/mm: Introduce _PAGE_DIRTY_SW
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-10-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <325d3a25-0016-ea19-c0c9-7958066fc94e@intel.com>
Date: Wed, 26 Feb 2020 13:35:15 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-10-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226213515.RifGumj13TTQFYmxfN-BxL5a_mtOpaa25CoVfPvWJnQ@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> When Shadow Stack (SHSTK) is introduced, a R/O and Dirty PTE exists in the
> following cases:
> 
> (a) A modified, copy-on-write (COW) page;
> (b) A R/O page that has been COW'ed;
> (c) A SHSTK page.

I really like to begin these patches with a problem statement:

	There is essentially no room left in the x86 hardware PTEs on
	some OSes (not Linux).  That left the hardware architects
	looking for a way to represent a new memory type (shadow stack)
	within the existing bits.  They chose to repurpose a lightly-
	used state: Write=0,Dirty=1.

	The reason it's lightly used is that Dirty=1 is normally set by
	hardware and can not normally be set by hardware on a Write=0
	PTE.  Software must normally be involved to create one of these
	PTEs, so software can simply opt to not create them.

But that leaves us with a Linux problem: we need to ensure we never
create Write=0,Dirty=1 PTEs.  In places where we do create them, we need
to find an alternative way to represent them _without_ using the same
hardware bit combination.  Thus, enter _PAGE_DIRTY_SW.

... back to the list:
> (a) A modified, copy-on-write (COW) page;
> (b) A R/O page that has been COW'ed;

(a) is pretty clear to me.  We had a Write=1,Dirty=1 PTE and fork()'d.
The fork() code set Write=0, but left Dirty=1.  In this case, we have a
read-only PTE underneath a VM_WRITE VMA.

(b) is not clear to me.  Could you please differentiate between the
permissions of the PTE and the permissions of the VMA, and also include
the steps needed to create it?

I think you also forgot a state:

(d) a page where the processor observed a Write=1 PTE, started a write,
    set Dirty=1, but then observed a Write=0 PTE.

That's possible today.

> To separate non-SHSTK memory from SHSTK, introduce a spare bit of the
> 64-bit PTE as _PAGE_BIT_DIRTY_SW and use that for case (a) and (b).
> This results in the following possible settings:
> 
> Modified PTE:         (R/W + DIRTY_HW)
> Modified and COW PTE: (R/O + DIRTY_SW)
> R/O PTE COW'ed:       (R/O + DIRTY_SW)
> SHSTK PTE:            (R/O + DIRTY_HW)
> SHSTK shared PTE[1]:  (R/O + DIRTY_SW)
> SHSTK PTE COW'ed:     (R/O + DIRTY_HW)
> 
> [1] When a SHSTK page is being shared among threads,

I think you mean processes.  You can probably even mention here that
this happens at fork().

>     its PTE is cleared of
>     _PAGE_DIRTY_HW, so the next SHSTK access causes a fault, and the page
>     is duplicated and _PAGE_DIRTY_HW is set again.

It's worth noting here that this is the COW equivalent for shadow stack
pages, even though it's copy-on-any-access rather than copy-on-write.


>  static inline pte_t pte_mkold(pte_t pte)
> @@ -322,6 +322,17 @@ static inline pte_t pte_mkold(pte_t pte)
>  
>  static inline pte_t pte_wrprotect(pte_t pte)
>  {
> +	/*
> +	 * Use _PAGE_DIRTY_SW on a R/O PTE to set it apart from
> +	 * a Shadow Stack PTE, which is R/O + _PAGE_DIRTY_HW.
> +	 */

I think we can do better here than this comment.  Maybe:

	/*
	 * Blindly clearing _PAGE_RW might accidentally create
	 * A shadow stack PTE (RW=0,Dirty=1).  Move the hardware
	 * dirty value to the software bit.
	 */
	

> +	if (static_cpu_has(X86_FEATURE_SHSTK)) {

Do we need to check cpuid, or do we need to check whether shadow stacks
are enabled?  What if X86_FEATURE_SHSTK is set, but cr4.X86_CR4_CET=0?

I think you've gone and tried to clear X86_FEATURE_SHSTK whenever the
feature is not enabled.  That's a _bit_ funky, but I guess it works.  I
think I'd rather have some common helper like: shadow_stacks_enabled()
that gets called so that you at least have a single place in the code to
point out this convention.

> +		if (pte_flags(pte) & _PAGE_DIRTY_HW) {
> +			pte = pte_clear_flags(pte, _PAGE_DIRTY_HW);
> +			pte = pte_set_flags(pte, _PAGE_DIRTY_SW);
> +		}
> +	}
> +
>  	return pte_clear_flags(pte, _PAGE_RW);
>  }

Just curious, but how clean does the assembly look after this change?
Does this really blow up the code?

This code is used in fork() which we care deeply about.  Did you go
looking for any performance impact from this?

> @@ -332,9 +343,25 @@ static inline pte_t pte_mkexec(pte_t pte)
>  
>  static inline pte_t pte_mkdirty(pte_t pte)
>  {
> +	pteval_t dirty = _PAGE_DIRTY_HW;
> +
> +	if (static_cpu_has(X86_FEATURE_SHSTK) && !pte_write(pte))
> +		dirty = _PAGE_DIRTY_SW;
> +
> +	return pte_set_flags(pte, dirty | _PAGE_SOFT_DIRTY);
> +}

Comment, please.

	/* Avoid creating (HW)Dirty=1,Write=0 PTEs */

> +static inline pte_t pte_mkdirty_shstk(pte_t pte)
> +{
> +	pte = pte_clear_flags(pte, _PAGE_DIRTY_SW);
>  	return pte_set_flags(pte, _PAGE_DIRTY_HW | _PAGE_SOFT_DIRTY);
>  }

I've already forgotten what the right thing here is and why you _need_
_PAGE_DIRTY_SW clear.  That's a bad sign. :)

Could you please enlighten us by adding a comment?

> +static inline bool pte_dirty_hw(pte_t pte)
> +{
> +	return pte_flags(pte) & _PAGE_DIRTY_HW;
> +}

There's at least one open-coded instance of this above.  Why not just
move this up so you can use it?
...

All of those comments pretty much go for the pmd and pud variants too,
of course.

> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index e647e3c75578..826823df917f 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -23,7 +23,8 @@
>  #define _PAGE_BIT_SOFTW2	10	/* " */
>  #define _PAGE_BIT_SOFTW3	11	/* " */
>  #define _PAGE_BIT_PAT_LARGE	12	/* On 2MB or 1GB pages */
> -#define _PAGE_BIT_SOFTW4	58	/* available for programmer */
> +#define _PAGE_BIT_SOFTW4	57	/* available for programmer */
> +#define _PAGE_BIT_SOFTW5	58	/* available for programmer */
>  #define _PAGE_BIT_PKEY_BIT0	59	/* Protection Keys, bit 1/4 */
>  #define _PAGE_BIT_PKEY_BIT1	60	/* Protection Keys, bit 2/4 */
>  #define _PAGE_BIT_PKEY_BIT2	61	/* Protection Keys, bit 3/4 */
> @@ -35,6 +36,12 @@
>  #define _PAGE_BIT_SOFT_DIRTY	_PAGE_BIT_SOFTW3 /* software dirty tracking */
>  #define _PAGE_BIT_DEVMAP	_PAGE_BIT_SOFTW4
>  
> +/*
> + * This bit indicates a copy-on-write page, and is different from
> + * _PAGE_BIT_SOFT_DIRTY, which tracks which pages a task writes to.
> + */
> +#define _PAGE_BIT_DIRTY_SW	_PAGE_BIT_SOFTW5 /* was written to */

Does it *only* indicate a copy-on-write (or copy-on-access) page?  If
so, haven't we misnamed it?

>  /* If _PAGE_BIT_PRESENT is clear, we use these: */
>  /* - if the user mapped it with PROT_NONE; pte_present gives true */
>  #define _PAGE_BIT_PROTNONE	_PAGE_BIT_GLOBAL
> @@ -108,6 +115,28 @@
>  #define _PAGE_DEVMAP	(_AT(pteval_t, 0))
>  #endif
>  
> +/* A R/O and dirty PTE exists in the following cases:

Which dirty is this talking about?  DIRTY_HW?  DIRTY_SW?

> + *	(a) A modified, copy-on-write (COW) page;
> + *	(b) A R/O page that has been COW'ed;
> + *	(c) A SHSTK page.

Don't forget (d).

> + * _PAGE_DIRTY_SW is used to separate case (c) from others.
> + * This results in the following settings:
> + *
> + *	Modified PTE:         (R/W + DIRTY_HW)
> + *	Modified and COW PTE: (R/O + DIRTY_SW)
> + *	R/O PTE COW'ed:       (R/O + DIRTY_SW)
> + *	SHSTK PTE:            (R/O + DIRTY_HW)
> + *	SHSTK PTE COW'ed:     (R/O + DIRTY_HW)
> + *	SHSTK PTE being shared among threads: (R/O + DIRTY_SW)
> + */
> +#ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +#define _PAGE_DIRTY_SW	(_AT(pteval_t, 1) << _PAGE_BIT_DIRTY_SW)
> +#else
> +#define _PAGE_DIRTY_SW	(_AT(pteval_t, 0))
> +#endif
> +
> +#define _PAGE_DIRTY_BITS (_PAGE_DIRTY_HW | _PAGE_DIRTY_SW)
> +
>  #define _PAGE_PROTNONE	(_AT(pteval_t, 1) << _PAGE_BIT_PROTNONE)
>  
>  #define _PAGE_TABLE_NOENC	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |\
> 
