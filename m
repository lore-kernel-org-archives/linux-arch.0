Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:54957 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeKWNV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Nov 2018 08:21:57 -0500
MIME-Version: 1.0
References: <20181115190538.17016-1-hch@lst.de> <20181115190538.17016-3-hch@lst.de>
In-Reply-To: <20181115190538.17016-3-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 23 Nov 2018 11:38:55 +0900
Message-ID: <CAK7LNAQrOHhd-=BHtc1PQ4SCo=fUPaqOQsbxzv+VF8Zu4bJohA@mail.gmail.com>
Subject: Re: [PATCH 2/9] alpha: force PCI on for non-jensen configs
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: mporter@kernel.crashing.org, Alex Bounine <alex.bou9@gmail.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-pci@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-alpha@vger.kernel.org, Linux-MIPS <linux-mips@linux-mips.org>
Message-ID: <20181123023855.Z2lwbNfreVLI3_VOe-bP6_v3R_BbstLyKWBLwTKWEs4@z>

On Fri, Nov 16, 2018 at 4:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Without PCI support the kernel won't even compile, so force it on.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---


I do not understand this patch
because alpha already enables PCI forcibly.

'No prompt' + 'default y' means always on.

config PCI
        bool
        depends on !ALPHA_JENSEN
        select GENERIC_PCI_IOMAP
        default y


I squashed this patch to "PCI: consolidate PCI config entry ..."
because you will replace it to FORCE_PCI anyway.







>  arch/alpha/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> index 5b4f88363453..65f6d0bf69d4 100644
> --- a/arch/alpha/Kconfig
> +++ b/arch/alpha/Kconfig
> @@ -6,6 +6,7 @@ config ALPHA
>         select ARCH_MIGHT_HAVE_PC_SERIO
>         select ARCH_NO_PREEMPT
>         select ARCH_USE_CMPXCHG_LOCKREF
> +       select PCI if !ALPHA_JENSEN
>         select HAVE_AOUT
>         select HAVE_IDE
>         select HAVE_OPROFILE
> --
> 2.19.1
>


--
Best Regards
Masahiro Yamada
