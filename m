From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH 2/4] arm64: use generic dma-contiguous.h
Date: Wed, 16 Jul 2014 18:20:29 +0200
Message-ID: <xa1td2d5b7hu.fsf@mina86.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1405525892-60383-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.=
com> wrote:
> dma-contiguous.h is now in asm-generic. Use that to avoid code
> repetition in arm64.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/arm64/include/asm/Kbuild           |  1 +
>  arch/arm64/include/asm/dma-contiguous.h | 28 -----------------------=
-----
>  2 files changed, 1 insertion(+), 28 deletions(-)
>  delete mode 100644 arch/arm64/include/asm/dma-contiguous.h
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/K=
build
> index 0b3fcf8..92bf7cb 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -9,6 +9,7 @@ generic-y +=3D current.h
>  generic-y +=3D delay.h
>  generic-y +=3D div64.h
>  generic-y +=3D dma.h
> +generic-y +=3D dma-contiguous.h
>  generic-y +=3D emergency-restart.h
>  generic-y +=3D early_ioremap.h
>  generic-y +=3D errno.h
> diff --git a/arch/arm64/include/asm/dma-contiguous.h b/arch/arm64/inc=
lude/asm/dma-contiguous.h
> deleted file mode 100644
> index 14c4c0c..0000000
> --- a/arch/arm64/include/asm/dma-contiguous.h
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -/*
> - * Copyright (c) 2013, The Linux Foundation. All rights reserved.
> - *
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License version 2 an=
d
> - * only version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -#ifndef _ASM_DMA_CONTIGUOUS_H
> -#define _ASM_DMA_CONTIGUOUS_H
> -
> -#ifdef __KERNEL__
> -#ifdef CONFIG_DMA_CMA
> -
> -#include <linux/types.h>
> -
> -static inline void
> -dma_contiguous_early_fixup(phys_addr_t base, unsigned long size) { }
> -
> -#endif
> -#endif
> -
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
