From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 2/4] m68k: Setup CROSS_COMPILE at the top
Date: Sun, 13 May 2012 21:38:39 +1000
Message-ID: <4FAF9D3F.4010804@snapgear.com>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org> <1336855148-18817-2-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336855148-18817-2-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org
List-Id: linux-arch.vger.kernel.org

On 05/13/2012 06:39 AM, Geert Uytterhoeven wrote:
> CROSS_COMPILE must be setup before using e.g. cc-option (and a few other
> as-*, cc-*, ld-* macros), else they will check against the wrong compiler
> when cross-compiling, and may invoke the cross compiler with wrong or
> suboptimal compiler options.
>
> Signed-off-by: Geert Uytterhoeven<geert@linux-m68k.org>
> Cc: Greg Ungerer<gerg@uclinux.org>

Acked-by: Greg Ungerer<gerg@uclinux.org>

Regards
Greg


> Cc: linux-m68k@lists.linux-m68k.org
> ---
>   arch/m68k/Makefile |   13 +++++++------
>   1 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
> index 804f139..b7f2e2d 100644
> --- a/arch/m68k/Makefile
> +++ b/arch/m68k/Makefile
> @@ -16,6 +16,13 @@
>
>   KBUILD_DEFCONFIG := multi_defconfig
>
> +ifneq ($(SUBARCH),$(ARCH))
> +	ifeq ($(CROSS_COMPILE),)
> +		CROSS_COMPILE := $(call cc-cross-prefix, \
> +			m68k-linux-gnu- m68k-linux- m68k-unknown-linux-gnu-)
> +	endif
> +endif
> +
>   #
>   #	Enable processor type. Ordering of these is important - we want to
>   #	use the minimum processor type of the range we support. The logic
> @@ -62,12 +69,6 @@ endif
>
>   LDFLAGS := -m m68kelf
>   KBUILD_LDFLAGS_MODULE += -T $(srctree)/arch/m68k/kernel/module.lds
> -ifneq ($(SUBARCH),$(ARCH))
> -	ifeq ($(CROSS_COMPILE),)
> -		CROSS_COMPILE := $(call cc-cross-prefix, \
> -			m68k-linux-gnu- m68k-linux- m68k-unknown-linux-gnu-)
> -	endif
> -endif
>
>   ifdef CONFIG_SUN3
>   LDFLAGS_vmlinux = -N


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close,                            FAX:         +61 7 3891 3630
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
