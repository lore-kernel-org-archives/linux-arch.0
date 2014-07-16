From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH 4/4] mips: dma: Add cma support
Date: Wed, 16 Jul 2014 18:39:05 +0200
Message-ID: <xa1t7g3db6mu.fsf@mina86.com>
References: <1405525892-60383-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1405525892-60383-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:64296 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbaGPQjJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jul 2014 12:39:09 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so1192364wgh.6
        for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2014 09:39:08 -0700 (PDT)
In-Reply-To: <1405525892-60383-5-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, ralf@linux-mips.org, catalin.marinas@arm.com, will.deacon@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, gregkh@linuxfoundation.org, m.szyprowski@samsung.com
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org

On Wed, Jul 16 2014, Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.=
com> wrote:
> Adds cma support to the mips architecture.
>
> cma uses memblock. However, mips uses bootmem.

Does cma_early_percent_memory work correctly then?

> bootmem is informed about any regions reserved by memblock

Alternatively maybe it would make sense to create a new definition of
dma_contiguous_reserve_area that uses bootmem and choose it based on
some CONFIG_CMA_USE_BOOTMEM which would be selected by MIPS.

> dma api is modified to use cma reserved memory regions when available
>
> Tested using cma_test. cma_test is a simple driver that assigns block=
s
> of memory from cma reserved sections.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  arch/mips/Kconfig            |  1 +
>  arch/mips/include/asm/Kbuild |  1 +
>  arch/mips/kernel/setup.c     |  9 +++++++++
>  arch/mips/mm/dma-default.c   | 37 +++++++++++++++++++++++++---------=
---
>  4 files changed, 36 insertions(+), 12 deletions(-)
>

--=20
Best regards,                                         _     _
=2Eo. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
=2E.o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarew=
icz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
