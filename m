Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3XmJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Aug 2018 19:42:09 -0400
Subject: Re: [RFC PATCH v3 1/8] x86/cet/ibt: Add Kconfig option for user-mode
 Indirect Branch Tracking
References: <20180830144009.3314-1-yu-cheng.yu@intel.com>
 <20180830144009.3314-2-yu-cheng.yu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb30d63a-3eb9-a713-7129-6823a6d799cf@infradead.org>
Date: Thu, 30 Aug 2018 12:38:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180830144009.3314-2-yu-cheng.yu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@amacapital.net>, Balbir Singh <bsingharora@gmail.com>, Cyrill Gorcunov <gorcunov@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, Florian Weimer <fweimer@redhat.com>, "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromiun.org>, Mike Kravetz <mike.kravetz@oracle.com>, Nadav Amit <nadav.amit@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>, Peter Zijlstra <peterz@infradead.org>, "Ravi V. Shankar" <ravi.v.shankar@intel.com>, Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Message-ID: <20180830193806.fl4ndZ--ocdzqkqjJAgmYIBud4RGW8XFpBquh3VF9lQ@z>

On 08/30/2018 07:40 AM, Yu-cheng Yu wrote:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 2cfe11e1cf7f..0d97b03f35f6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1941,6 +1941,18 @@ config X86_INTEL_SHADOW_STACK_USER
>  
>  	  If unsure, say y.
>  
> +config X86_INTEL_BRANCH_TRACKING_USER
> +	prompt "Intel Indirect Branch Tracking for user-mode"
> +	def_bool n
> +	depends on CPU_SUP_INTEL && X86_64
> +	select X86_INTEL_CET
> +	select ARCH_HAS_PROGRAM_PROPERTIES
> +	---help---
> +	  Indirect Branch Tracking provides hardware protection against return-/jmp-
> +	  oriented programing attacks.

	           programming

> +
> +	  If unsure, say y
> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI


-- 
~Randy
