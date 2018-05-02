From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 5/5] asm-generic: fix build error in fix_to_virt with
 CONFIG_DEBUG_EXPERIENCE
Date: Wed, 2 May 2018 10:19:30 -0400
Message-ID: <20180502101930.25a5437d@gandalf.local.home>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
        <1525268700-10631-6-git-send-email-changbin.du@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525268700-10631-6-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: changbin.du@intel.com
Cc: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed,  2 May 2018 21:45:00 +0800
changbin.du@intel.com wrote:

> From: Changbin Du <changbin.du@intel.com>
> 
> With '-Og' optimization level, GCC would not optimize a count for a loop
> as a constant value. But BUILD_BUG_ON() only accept compile-time constant
> values.
> 
> arch/arm/mm/mmu.o: In function `fix_to_virt':
> /home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
> Makefile:1051: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
> 
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  include/asm-generic/fixmap.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
> index 827e4d3..a6576d4 100644
> --- a/include/asm-generic/fixmap.h
> +++ b/include/asm-generic/fixmap.h
> @@ -28,7 +28,8 @@
>   */
>  static __always_inline unsigned long fix_to_virt(const unsigned int idx)
>  {
> -	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
> +	BUILD_BUG_ON(__builtin_constant_p(idx) &&
> +		     idx >= __end_of_fixed_addresses);

Hmm, this changes the check slightly. Perhaps we should only do this
when your config is active:

{
	BUILD_BUG_ON(
/* CONFIG_DEBUG_OPTIMIZE may cause idx not to be constant */
#ifdef CONFIG_DEBUG_OPTIMIZE
		__builtin_constant_p(idx) &&
#endif
		idx >= __end_of_fixed_addresses);

}

-- Steve

>  	return __fix_to_virt(idx);
>  }
>  
