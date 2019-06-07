Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47308 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGHoX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jun 2019 03:44:23 -0400
Date: Fri, 7 Jun 2019 09:43:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 18/27] mm: Introduce do_mmap_locked()
Message-ID: <20190607074322.GP3419@hirez.programming.kicks-ass.net>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
 <20190606200646.3951-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606200646.3951-19-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>
Message-ID: <20190607074322.Dn2C2Oc6iwiyIC6icwgkG0A5nMCr1dZrmGrfnoPepUs@z>

On Thu, Jun 06, 2019 at 01:06:37PM -0700, Yu-cheng Yu wrote:
> There are a few places that need do_mmap() with mm->mmap_sem held.
> Create an in-line function for that.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  include/linux/mm.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 398f1e1c35e5..7cf014604848 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2411,6 +2411,24 @@ static inline void mm_populate(unsigned long addr, unsigned long len)
>  static inline void mm_populate(unsigned long addr, unsigned long len) {}
>  #endif
>  
> +static inline unsigned long do_mmap_locked(unsigned long addr,
> +	unsigned long len, unsigned long prot, unsigned long flags,
> +	vm_flags_t vm_flags)
> +{
> +	struct mm_struct *mm = current->mm;
> +	unsigned long populate;
> +
> +	down_write(&mm->mmap_sem);
> +	addr = do_mmap(NULL, addr, len, prot, flags, vm_flags, 0,
> +		       &populate, NULL);

Funny thing how do_mmap() takes a file pointer as first argument and
this thing explicitly NULLs that. That more or less invalidates the name
do_mmap_locked().

> +	up_write(&mm->mmap_sem);
> +
> +	if (populate)
> +		mm_populate(addr, populate);
> +
> +	return addr;
> +}
