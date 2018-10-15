Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:51131 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJOOWO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Oct 2018 10:22:14 -0400
MIME-Version: 1.0
References: <20181013151016.31674-1-hch@lst.de> <20181013151016.31674-8-hch@lst.de>
In-Reply-To: <20181013151016.31674-8-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Oct 2018 15:37:37 +0900
Message-ID: <CAK7LNAT8QhVhSiv1bNnp_HbFdLGd_y-YUQqSevZ5eSp4=ZRqhQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] eisa: consolidate EISA Kconfig entry in drivers/eisa
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-pci@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Message-ID: <20181015063737.fCrCMPr9te0adb4M60QFUNHQjW8RcDntphiliRYAXoM@z>

On Sun, Oct 14, 2018 at 12:11 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Let architectures opt into EISA support by selecting HAS_EISA and
> handle everything else in drivers/eisa.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


How about HAVE_EISA ?


You forgot to add
source "drivers/eisa/Kconfig" to drivers/Kconfig


You forgot to delete the one
from arch/alpha/Kconfig


>  arch/alpha/Kconfig     |  8 +++-----
>  arch/arm/Kconfig       | 16 +---------------
>  arch/mips/Kconfig      | 31 +++++--------------------------
>  arch/powerpc/Kconfig   |  3 ---
>  arch/x86/Kconfig       | 19 +------------------
>  drivers/eisa/Kconfig   | 21 ++++++++++++++++++++-
>  drivers/parisc/Kconfig | 11 +----------
>  7 files changed, 31 insertions(+), 78 deletions(-)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 73a7558c71bd..6a9be9cb74e6 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,9 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select HAS_EISA if ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || \
> +                               ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || \
> +                               ALPHA_NORITAKE || ALPHA_RAWHIDE
>         select HAS_PCI if !ALPHA_JENSEN
>         select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
> @@ -518,11 +521,6 @@ config ALPHA_SRM
>
>           If unsure, say N.
>
> -config EISA
> -       bool
> -       depends on ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_RAWHIDE
> -       default y
> -


Better to add CONFIG_EISA=y to arch/alpha/defconfig
to not flip the default?



--
Best Regards
Masahiro Yamada
