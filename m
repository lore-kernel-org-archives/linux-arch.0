From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/3] arm64: add endianness option to LDFLAGS instead of LD
Date: Wed, 4 Jul 2018 17:30:37 +0100
Message-ID: <20180704163036.GA8370@arm.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-3-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1530580921-23340-3-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Simek <monstr@monstr.eu>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 03, 2018 at 10:22:00AM +0900, Masahiro Yamada wrote:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
> 
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

But note that this will conflict with:

http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/587726.html

Catalin -- I'm assuming you're taking both of these and will resolve the
conflict in the arm64 for-next/fixes branch.

Cheers,

Will

>  arch/arm64/Makefile | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4527226..8f73da3 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,15 +60,13 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN), y)
>  KBUILD_CPPFLAGS	+= -mbig-endian
>  CHECKFLAGS	+= -D__AARCH64EB__
>  AS		+= -EB
> -LD		+= -EB
> -LDFLAGS		+= -maarch64linuxb
> +LDFLAGS		+= -EB -maarch64linuxb
>  UTS_MACHINE	:= aarch64_be
>  else
>  KBUILD_CPPFLAGS	+= -mlittle-endian
>  CHECKFLAGS	+= -D__AARCH64EL__
>  AS		+= -EL
> -LD		+= -EL
> -LDFLAGS		+= -maarch64linux
> +LDFLAGS		+= -EL -maarch64linux
>  UTS_MACHINE	:= aarch64
>  endif
>  
> -- 
> 2.7.4
> 
