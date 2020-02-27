From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 16/27] mm: Update can_follow_write_pte() for Shadow
 Stack
Date: Wed, 26 Feb 2020 16:34:49 -0800
Message-ID: <fc4f65ef-ce4b-9410-5586-5f4637c249bc@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-17-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200205181935.3712-17-yu-cheng.yu@intel.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

> +inline bool pte_exclusive(pte_t pte, struct vm_area_struct *vma)
> +{
> +	if (vma->vm_flags & VM_SHSTK)
> +		return pte_dirty_hw(pte);
> +	else
> +		return pte_dirty(pte);
> +}

I'm not really getting the naming.  What is exclusive?

> diff --git a/mm/gup.c b/mm/gup.c
> index 7646bf993b25..d1dbfbde8443 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -164,10 +164,12 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>   * FOLL_FORCE can write to even unwritable pte's, but only
>   * after we've gone through a COW cycle and they are dirty.
>   */
> -static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> +static inline bool can_follow_write(pte_t pte, unsigned int flags,
> +				    struct vm_area_struct *vma)

Having two identically named functions in two files in the same
subsystem seems like a recipe for confusion when I grep or cscope for
things.  It hardly seems worth the 4 characters of space savings IMNHO.

>  {
>  	return pte_write(pte) ||
> -		((flags & FOLL_FORCE) && (flags & FOLL_COW) && pte_dirty(pte));
> +		((flags & FOLL_FORCE) && (flags & FOLL_COW) &&
> +		 pte_exclusive(pte, vma));
>  }

FWIW, this is the hunk that fixed DirtyCOW.

The least this deserves is acknowledgement of that in the changelog and
a missive about how you're sure you didn't just introduce
ShadowDirtyCOW.  Don't bother.  I already registered the domain. ;)
