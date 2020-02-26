From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 12/27] x86/mm: Modify ptep_set_wrprotect and
 pmdp_set_wrprotect for _PAGE_DIRTY_SW
Date: Wed, 26 Feb 2020 14:20:38 -0800
Message-ID: <c8ad93b2-878f-1d90-e054-970f251efc71@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-13-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32725 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBZWUk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 17:20:40 -0500
In-Reply-To: <20200205181935.3712-13-yu-cheng.yu@intel.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> When Shadow Stack (SHSTK) is enabled, the [R/O + PAGE_DIRTY_HW] setting is
> reserved only for SHSTK.

Got it.

> Non-Shadow Stack R/O PTEs are [R/O + PAGE_DIRTY_SW].

This is only true for *dirty* PTEs, right?

> When a PTE goes from [R/W + PAGE_DIRTY_HW] to [R/O + PAGE_DIRTY_SW], it
> could become a transient SHSTK PTE in two cases.
> 
> The first case is that some processors can start a write but end up seeing
> a read-only PTE by the time they get to the Dirty bit, creating a transient
> SHSTK PTE.  However, this will not occur on processors supporting SHSTK
> therefore we don't need a TLB flush here.
> 
> The second case is that when the software, without atomic, tests & replaces
> PAGE_DIRTY_HW with PAGE_DIRTY_SW, a transient SHSTK PTE can exist.  This is
> prevented with cmpxchg.
> 
> Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
> insights to the issue.  Jann Horn provided the cmpxchg solution.
> 
> v9:
> - Change compile-time conditionals to runtime checks.
> - Fix parameters of try_cmpxchg(): change pte_t/pmd_t to
>   pte_t.pte/pmd_t.pmd.
> 
> v4:
> - Implement try_cmpxchg().
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/pgtable.h | 66 ++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index 2733e7ec16b3..43cb27379208 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1253,6 +1253,39 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>  				      unsigned long addr, pte_t *ptep)
>  {
> +	/*
> +	 * Some processors can start a write, but end up seeing a read-only
> +	 * PTE by the time they get to the Dirty bit.  In this case, they
> +	 * will set the Dirty bit, leaving a read-only, Dirty PTE which
> +	 * looks like a Shadow Stack PTE.
> +	 *
> +	 * However, this behavior has been improved and will not occur on
> +	 * processors supporting Shadow Stack.  Without this guarantee, a
> +	 * transition to a non-present PTE and flush the TLB would be
> +	 * needed.
> +	 *
> +	 * When changing a writable PTE to read-only and if the PTE has
> +	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_DIRTY_SW so that
> +	 * the PTE is not a valid Shadow Stack PTE.
> +	 */
> +#ifdef CONFIG_X86_64
> +	if (static_cpu_has(X86_FEATURE_SHSTK)) {

Judicious application of arch/x86/include/asm/disabled-features.h should
be able to get rid of the #ifdef.  See pkeys in there for another example.

> +		pte_t new_pte, pte = READ_ONCE(*ptep);
> +
> +		do {
> +			/*
> +			 * This is the same as moving _PAGE_DIRTY_HW
> +			 * to _PAGE_DIRTY_SW.
> +			 */
> +			new_pte = pte_wrprotect(pte);
> +			new_pte.pte |= (new_pte.pte & _PAGE_DIRTY_HW) >>
> +					_PAGE_BIT_DIRTY_HW << _PAGE_BIT_DIRTY_SW;
> +			new_pte.pte &= ~_PAGE_DIRTY_HW;
> +		} while (!try_cmpxchg(&ptep->pte, &pte.pte, new_pte.pte));

Have you tried to test this code?

This is trying to transition the value at '&ptep->pte' from the
'pte.pte' value to 'new_pte.pte'.  If the value at '&ptep->pte' does not
match 'pte.pte', the cmpxchg will fail and we'll run through the loop again.

What terminates that loop?

The "old" value (pte.pte) never gets updated since it is read outside
the loop.  There's no guarantee that the contents (&ptep->pte) will ever
match pte.pte.

Doesn't the READ_ONCE() need to be inside the loop?
