From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to
 apply GCC -Og optimization
Date: Wed, 2 May 2018 12:26:30 -0700
Message-ID: <34ba017d-2e94-7411-a675-0e3e2a6b0682@infradead.org>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
 <1525268700-10631-5-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525268700-10631-5-git-send-email-changbin.du@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com, yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 05/02/2018 06:44 AM, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 

Sorry, I missed one:

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ab55801..e264199 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -216,6 +216,27 @@ config NO_AUTO_INLINE
>  
>  	  If unsure, select N.
>  
> +config DEBUG_EXPERIENCE
> +	bool "Optimize for better debugging experience (-Og)"
> +	default n
> +	select NO_AUTO_INLINE
> +	depends on !CC_OPTIMIZE_FOR_SIZE
> +	help
> +	  This will apply GCC '-Og' optimization level which is supported
> +	  since GCC 4.8. This optimization level offers a reasonable level
> +	  of optimization while maintaining fast compilation and a good
> +	  debugging experience. It is similar to '-O1' while preferring to
> +	  keep debug ability over runtime speed. The overall performance
> +	  will drop a bit (~6%).
> +
> +	  Use only if you want to debug the kernel, especially if you want
> +	  to have better kernel debugging experience with gdb facilities
> +	  like kgdb or qemu. If enabling this option breaks your kernel,
> +	  you should either disable this or find a fix (mostly in the arch
> +	  code). Currently this option has only be tested on x86_64 platform.

	                                        been tested

> +
> +	  If unsure, select N.
> +
>  config ENABLE_WARN_DEPRECATED
>  	bool "Enable __deprecated logic"
>  	default y
> 


-- 
~Randy
