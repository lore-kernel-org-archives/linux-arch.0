From: Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v9 05/27] x86/cet/shstk: Add Kconfig option for
 user-mode Shadow Stack protection
Date: Wed, 26 Feb 2020 09:03:08 -0800
Message-ID: <597fb45a-cb94-e8e7-8e80-45a26766d32a@intel.com>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-6-yu-cheng.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200205181935.3712-6-yu-cheng.yu@intel.com>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, Balbir Singh <bsingharora@gmail.com>, Borislav Petkov <bp@alien8.de>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Eugene Syromiatnikov <esyr@redhat.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Mike Kravetz <mike.kravetz@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 2/5/20 10:19 AM, Yu-cheng Yu wrote:
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

I think what you're trying to say here is that the hardware supports
shadow stacks with 32-bit kernels.  However, this series does not
include that support and we have no plans to add it.

Right?

I'll let others weigh in, but I rather dislike the use of acronyms here.
 I'd much rather see the english "shadow stack" everywhere than SHSTK.

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

Nit: this whole thing is to support more than a single stack.  I'd make
this plural at least in the text: "shadow stacks".

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

This is missing a *lot* of information.

What matters to someone turning this on?

1. It's a hardware feature.  This only matters if you have the right
   hardware
2. It's a security hardening feature.  You dance around this, but need
   to come out and say it.
3. Apps must be enabled to use it.  You get no protection "for free" on
   old userspace.
4. The hardware supports user and kernel, but this option is for
   userspace only.
