Return-Path: <SRS0=e/bK=4N=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Tue, 25 Feb 2020 12:07:07 -0800
From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Message-ID: <202002251206.43C6B6DA@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-6-yu-cheng.yu@intel.com>
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>, Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200225200707.rDusB7-BtFxbpRzgvBI58kxk6TL8dfVkYPRqhk3LV9k@z>

On Wed, Feb 05, 2020 at 10:19:13AM -0800, Yu-cheng Yu wrote:
> Introduce Kconfig option: X86_INTEL_SHADOW_STACK_USER.
> 
> Shadow Stack (SHSTK) provides protection against function return address
> corruption.  It is active when the kernel has this feature enabled, and
> both the processor and the application support it.  When this feature is
> enabled, legacy non-SHSTK applications continue to work, but without SHSTK
> protection.
> 
> The user-mode SHSTK protection is only implemented for the 64-bit kernel.
> IA32 applications are supported under the compatibility mode.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/Kconfig  | 22 ++++++++++++++++++++++
>  arch/x86/Makefile |  7 +++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5e8949953660..6c34b701c588 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1974,6 +1974,28 @@ config X86_INTEL_TSX_MODE_AUTO
>  	  side channel attacks- equals the tsx=auto command line parameter.
>  endchoice
>  
> +config X86_INTEL_CET
> +	def_bool n
> +
> +config ARCH_HAS_SHSTK
> +	def_bool n
> +
> +config X86_INTEL_SHADOW_STACK_USER
> +	prompt "Intel Shadow Stack for user-mode"
> +	def_bool n
> +	depends on CPU_SUP_INTEL && X86_64
> +	select ARCH_USES_HIGH_VMA_FLAGS
> +	select X86_INTEL_CET
> +	select ARCH_HAS_SHSTK
> +	---help---
> +	  Shadow Stack (SHSTK) provides protection against program
> +	  stack corruption.  It is active when the kernel has this
> +	  feature enabled, and the processor and the application
> +	  support it.  When this feature is enabled, legacy non-SHSTK
> +	  applications continue to work, but without SHSTK protection.
> +
> +	  If unsure, say y.
> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 94df0868804b..c34f5befa4c8 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -149,6 +149,13 @@ ifdef CONFIG_X86_X32
>  endif
>  export CONFIG_X86_X32_ABI
>  
> +# Check assembler Shadow Stack suppot
> +ifdef CONFIG_X86_INTEL_SHADOW_STACK_USER
> +  ifeq ($(call as-instr, saveprevssp, y),)

This test needs to happen in the Kconfig rather than the Makefile; the
CONFIG should be unavailable if AS doesn't support the feature.

-Kees

> +      $(error CONFIG_X86_INTEL_SHADOW_STACK_USER not supported by the assembler)
> +  endif
> +endif
> +
>  #
>  # If the function graph tracer is used with mcount instead of fentry,
>  # '-maccumulate-outgoing-args' is needed to prevent a GCC bug
> -- 
> 2.21.0
> 

-- 
Kees Cook
