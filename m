From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 5/8] export.h: remove code for prefixing symbols with
 underscore
Date: Wed, 9 May 2018 18:07:27 +0200
Message-ID: <20180509160727.GA7459@ravnborg.org>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
 <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi Masahiro

On Wed, May 09, 2018 at 04:23:49PM +0900, Masahiro Yamada wrote:
> CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
> They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
> commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.
> 
> No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX.
> Clean up the export.h headers.  I am keeping VMLINUX_SYMBOL() and
> VMLINUX_SYMBOL_STR() because they are widely used.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> diff --git a/include/linux/export.h b/include/linux/export.h
> index 1a1dfdb..b768d6d 100644
> --- a/include/linux/export.h
> +++ b/include/linux/export.h
> @@ -10,14 +10,8 @@
>   * hackers place grumpy comments in header files.
>   */
>  
> -/* Some toolchains use a `_' prefix for all user symbols. */
> -#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> -#define __VMLINUX_SYMBOL(x) _##x
> -#define __VMLINUX_SYMBOL_STR(x) "_" #x
> -#else
>  #define __VMLINUX_SYMBOL(x) x
>  #define __VMLINUX_SYMBOL_STR(x) #x
> -#endif
>  
>  /* Indirect, so macros are expanded before pasting. */
>  #define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)

Since we no longer need any expansion, then the indirection
seems unnessesary.

I think we can reduce this to just:
#define VMLINUX_SYMBOL(x) x

Likewise for __VMLINUX_SYMBOL_STR

	Sam
