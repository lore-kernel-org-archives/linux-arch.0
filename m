Return-Path: <SRS0=ZEfg=4N=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39085 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbgBYUQH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Feb 2020 15:16:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so203771pjr.4
        for <linux-arch@vger.kernel.org>; Tue, 25 Feb 2020 12:16:07 -0800 (PST)
Date: Tue, 25 Feb 2020 12:16:04 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v9 13/27] x86/mm: Shadow Stack page fault error
 checking
Message-ID: <202002251216.EB9BEDD9D0@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-14-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-14-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Message-ID: <20200225201604.y4LiNLceKpJSEjaUwCPK1d3m0emxzJh3kw9ty4kFHFA@z>

On Wed, Feb 05, 2020 at 10:19:21AM -0800, Yu-cheng Yu wrote:
> If a page fault is triggered by a Shadow Stack (SHSTK) access
> (e.g. CALL/RET) or SHSTK management instructions (e.g. WRUSSQ), then bit[6]
> of the page fault error code is set.
> 
> In access_error(), verify a SHSTK page fault is within a SHSTK memory area.
> It is always an error otherwise.
> 
> For a valid SHSTK access, set FAULT_FLAG_WRITE to effect copy-on-write.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/traps.h |  2 ++
>  arch/x86/mm/fault.c          | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 7ac26bbd0bef..8023d177fcd8 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -169,6 +169,7 @@ enum {
>   *   bit 3 ==				1: use of reserved bit detected
>   *   bit 4 ==				1: fault was an instruction fetch
>   *   bit 5 ==				1: protection keys block access
> + *   bit 6 ==				1: shadow stack access fault
>   */
>  enum x86_pf_error_code {
>  	X86_PF_PROT	=		1 << 0,
> @@ -177,5 +178,6 @@ enum x86_pf_error_code {
>  	X86_PF_RSVD	=		1 << 3,
>  	X86_PF_INSTR	=		1 << 4,
>  	X86_PF_PK	=		1 << 5,
> +	X86_PF_SHSTK	=		1 << 6,
>  };
>  #endif /* _ASM_X86_TRAPS_H */
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 304d31d8cbbc..9c1243302663 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1187,6 +1187,17 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>  				       (error_code & X86_PF_INSTR), foreign))
>  		return 1;
>  
> +	/*
> +	 * Verify X86_PF_SHSTK is within a Shadow Stack VMA.
> +	 * It is always an error if there is a Shadow Stack
> +	 * fault outside a Shadow Stack VMA.
> +	 */
> +	if (error_code & X86_PF_SHSTK) {
> +		if (!(vma->vm_flags & VM_SHSTK))
> +			return 1;
> +		return 0;
> +	}
> +
>  	if (error_code & X86_PF_WRITE) {
>  		/* write, present and write, not present: */
>  		if (unlikely(!(vma->vm_flags & VM_WRITE)))
> @@ -1344,6 +1355,13 @@ void do_user_addr_fault(struct pt_regs *regs,
>  
>  	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
>  
> +	/*
> +	 * If the fault is caused by a Shadow Stack access,
> +	 * i.e. CALL/RET/SAVEPREVSSP/RSTORSSP, then set
> +	 * FAULT_FLAG_WRITE to effect copy-on-write.
> +	 */
> +	if (hw_error_code & X86_PF_SHSTK)
> +		flags |= FAULT_FLAG_WRITE;
>  	if (hw_error_code & X86_PF_WRITE)
>  		flags |= FAULT_FLAG_WRITE;
>  	if (hw_error_code & X86_PF_INSTR)
> -- 
> 2.21.0
> 

-- 
Kees Cook
