Return-Path: <SRS0=e/bK=4N=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Tue, 25 Feb 2020 13:10:14 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v9 18/27] x86/cet/shstk: Introduce WRUSS instruction
Message-ID: <202002251309.E238DFEEB4@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-19-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-19-yu-cheng.yu@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200225211014.Hr0z8e6QPzlrCptI9GFcgydjLDEBXb8lPeJRpCoc8qI@z>

On Wed, Feb 05, 2020 at 10:19:26AM -0800, Yu-cheng Yu wrote:
> WRUSS is a new kernel-mode instruction but writes directly to user Shadow
> Stack (SHSTK) memory.  This is used to construct a return address on SHSTK
> for the signal handler.
> 
> This instruction can fault if the user SHSTK is not valid SHSTK memory.
> In that case, the kernel does a fixup.

Since these functions aren't used in this patch, should this get merged
with patch 19?

-Kees

> 
> v4:
> - Change to asm goto.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/asm/special_insns.h | 32 ++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 6d37b8fcfc77..1b9b2e79c353 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -222,6 +222,38 @@ static inline void clwb(volatile void *__p)
>  		: [pax] "a" (p));
>  }
>  
> +#ifdef CONFIG_X86_INTEL_CET
> +#if defined(CONFIG_IA32_EMULATION) || defined(CONFIG_X86_X32)
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	asm_volatile_goto("1: wrussd %1, (%0)\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: "r" (addr), "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EPERM;
> +}
> +#else
> +static inline int write_user_shstk_32(unsigned long addr, unsigned int val)
> +{
> +	WARN_ONCE(1, "%s used but not supported.\n", __func__);
> +	return -EFAULT;
> +}
> +#endif
> +
> +static inline int write_user_shstk_64(unsigned long addr, unsigned long val)
> +{
> +	asm_volatile_goto("1: wrussq %1, (%0)\n"
> +			  _ASM_EXTABLE(1b, %l[fail])
> +			  :: "r" (addr), "r" (val)
> +			  :: fail);
> +	return 0;
> +fail:
> +	return -EPERM;
> +}
> +#endif /* CONFIG_X86_INTEL_CET */
> +
>  #define nop() asm volatile ("nop")
>  
>  
> -- 
> 2.21.0
> 

-- 
Kees Cook
