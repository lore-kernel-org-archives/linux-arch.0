Return-Path: <SRS0=oITL=4O=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [RFC PATCH v9 13/27] x86/mm: Shadow Stack page fault error
 checking
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-14-yu-cheng.yu@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <1c8946d0-7934-3485-aa82-d37d41021dc7@intel.com>
Date: Wed, 26 Feb 2020 14:47:16 -0800
MIME-Version: 1.0
In-Reply-To: <20200205181935.3712-14-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226224716.3-B1mjDrQgXSbi7_jOnXDJ8FS5ka4nhYOB837MFzalk@z>

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
> If a page fault is triggered by a Shadow Stack (SHSTK) access
> (e.g. CALL/RET) or SHSTK management instructions (e.g. WRUSSQ), then bit[6]
> of the page fault error code is set.

How about starting with a definition:

	Shadow stack accesses are those that are performed by the CPU
	where it expects to encounter a shadow stack mapping.  These
	accesses are performed implicitly by CALL/RET at the site of the
	shadow stack pointer.  These accesses are made explicitly by
	shadow stack management instructions like WRUSSQ.

> In access_error(), verify a SHSTK page fault is within a SHSTK memory area.
> It is always an error otherwise.

How about: Shadow stacks accesses to shadow-stack mapping can see faults
in normal, valid operation just like regular accesses to regular
mappings.  Shadow stacks need some of the same features like delayed
allocation, swap and copy-on-write.

Shadow stack accesses can also result in errors, such as when a shadow
stack overflows, or if a shadow stack access occurs to a
non-shadow-stack mapping.

> For a valid SHSTK access, set FAULT_FLAG_WRITE to effect copy-on-write.

It seems rather odd to want copy-on-write behavior for read faults.
Could you elaborate on why, please?

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

Nit: there was an access that caused the fault.  We can be a bit more
broad in the implications from the comment if we say "access" instead of
"fault".

> +	if (error_code & X86_PF_SHSTK) {
> +		if (!(vma->vm_flags & VM_SHSTK))
> +			return 1;
> +		return 0;
> +	}
> +
>  	if (error_code & X86_PF_WRITE) {
>  		/* write, present and write, not present: */
>  		if (unlikely(!(vma->vm_flags & VM_WRITE)))

Is there an analogous check for !X86_PF_SHSTK faults to VM_SHSTK VMAs?

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

It would be great if you could also include the *why*.  *Why* do read
faults need copy-on-write semantics?
