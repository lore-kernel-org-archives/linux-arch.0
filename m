From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH 3/4] x86: use generic dma-contiguous.h
Date: Wed, 16 Jul 2014 18:20:49 +0200
Message-ID: <xa1ta989b7ha.fsf@mina86.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35969 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965485AbaGPQUy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jul 2014 12:20:54 -0400
Received: by mail-wi0-f173.google.com with SMTP id f8so5617798wiw.12
        for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2014 09:20:53 -0700 (PDT)
In-Reply-To: <1405525892-60383-4-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.=
com> wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in x86.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

But to be honest, I would fold the three into a single commit.

> ---
>  arch/x86/include/asm/Kbuild           |  1 +
>  arch/x86/include/asm/dma-contiguous.h | 12 ------------
>  2 files changed, 1 insertion(+), 12 deletions(-)
>  delete mode 100644 arch/x86/include/asm/dma-contiguous.h
>
> diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuil=
d
> index 3bf000f..d55a210 100644
> --- a/arch/x86/include/asm/Kbuild
> +++ b/arch/x86/include/asm/Kbuild
> @@ -6,6 +6,7 @@ genhdr-y +=3D unistd_x32.h
> =20
>  generic-y +=3D clkdev.h
>  generic-y +=3D cputime.h
> +generic-y +=3D dma-contiguous.h
>  generic-y +=3D early_ioremap.h
>  generic-y +=3D mcs_spinlock.h
>  generic-y +=3D scatterlist.h
> diff --git a/arch/x86/include/asm/dma-contiguous.h b/arch/x86/include=
/asm/dma-contiguous.h
> deleted file mode 100644
> index b4b38ba..0000000
> --- a/arch/x86/include/asm/dma-contiguous.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -#ifndef ASMX86_DMA_CONTIGUOUS_H
> -#define ASMX86_DMA_CONTIGUOUS_H
> -
> -#ifdef __KERNEL__
> -
> -#include <linux/types.h>
> -
> -static inline void
> -dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> -
> -#endif
> -#endif
> --=20
> 1.9.1
>

--=20
Best regards,                                         _     _
=2Eo. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
=2E.o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarew=
icz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
