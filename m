From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 00/11] test_user_copy improvements
Date: Tue, 11 Aug 2015 13:20:53 +0200
Message-ID: <CAMuHMdUzHwm5_TL7TNAOF+uqheJnKgsqF+_vzqGRzB_3eufKug@mail.gmail.com>
References: <1438960924-23628-1-git-send-email-james.hogan@imgtec.com>
	<20150810.152938.1076489414700359615.davem@redhat.com>
	<20150810.210804.1413406155445559341.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:36597 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933838AbbHKLVV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 11 Aug 2015 07:21:21 -0400
In-Reply-To: <20150810.210804.1413406155445559341.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: James Hogan <james.hogan@imgtec.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Simek <monstr@monstr.eu>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, nios2-dev@lists.rocketboards.org, linux <linux@lists.openrisc.net>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>

On Tue, Aug 11, 2015 at 6:08 AM, David Miller <davem@davemloft.net> wrote:
> From: David Miller <davem@redhat.com>
> Date: Mon, 10 Aug 2015 15:29:38 -0700 (PDT)
>
>> Also, I think the tests you added and protected with MIPS ifdefs could
>> equally be enabled on sparc64.
>
> James, as per this issue, I was thinking we could do something like this
> so that the tests don't get messy:
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index cee5f93..48d20c8 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1922,6 +1922,7 @@ config CPU_MIPSR6
>
>  config EVA
>         bool
> +       select ARCH_SPLIT_VA_SPACE
>
>  config XPA
>         bool
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 56442d2..4001d04 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -80,6 +80,7 @@ config SPARC64
>         select NO_BOOTMEM
>         select HAVE_ARCH_AUDITSYSCALL
>         select ARCH_SUPPORTS_ATOMIC_RMW
> +       select ARCH_SPLIT_VA_SPACE
>
>  config ARCH_DEFCONFIG
>         string
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 3a2ef67..149eb29 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -62,6 +62,9 @@ config ARCH_USE_CMPXCHG_LOCKREF
>  config ARCH_HAS_FAST_MULTIPLIER
>         bool
>
> +config ARCH_SPLIT_VA_SPACE
> +       def_bool n
> +
>  config CRC_CCITT
>         tristate "CRC-CCITT functions"
>         help

I think this applies to a few more architectures.

M68k already has a config symbol for his (CPU_HAS_ADDRESS_SPACES),
which is set by classic m68k (not Coldfire) that has the "moves" instruction.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
