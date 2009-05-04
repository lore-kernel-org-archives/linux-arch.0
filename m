From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 11/27] asm-generic: add generic page.h
Date: Mon, 4 May 2009 09:11:33 +0200
Message-ID: <10f740e80905040011u57e17420w9df8758f87027328@mail.gmail.com>
References: <cover.1241105648.git.arnd@arndb.de>
	 <821a570574a4dadc0c0c838f90f41dd5df81f090.1241105648.git.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:47836 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752243AbZEDHLe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 03:11:34 -0400
In-Reply-To: <821a570574a4dadc0c0c838f90f41dd5df81f090.1241105648.git.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Wed, Apr 29, 2009 at 16:55, Arnd Bergmann <arnd@arndb.de> wrote:
> Architectures that have no mmu should not have to
> describe their page tables. This adds a new page.h
> file based on the existing nommu architectures
> that adds a lot of dummy definitions to let you
> correctly compile a nommu kernel.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> =C2=A0include/asm-generic/page.h | =C2=A0 99 ++++++++++++++++++++++++=
++++++++++++++++++++
> =C2=A01 files changed, 99 insertions(+), 0 deletions(-)
> =C2=A0create mode 100644 include/asm-generic/page.h
>
> diff --git a/include/asm-generic/page.h b/include/asm-generic/page.h
> new file mode 100644
> index 0000000..75fec18
> --- /dev/null
> +++ b/include/asm-generic/page.h
> @@ -0,0 +1,99 @@
> +#ifndef __ASM_GENERIC_PAGE_H
> +#define __ASM_GENERIC_PAGE_H
> +/*
> + * Generic page.h implementation, for NOMMU architectures.
> + * This provides the dummy definitions for the memory management.
> + */
> +
> +#ifdef CONFIG_MMU
> +#error need to prove a real asm/page.h
> +#endif
> +
> +
> +/* PAGE_SHIFT determines the page size */
> +
> +#define PAGE_SHIFT =C2=A0 =C2=A0 12
> +#ifdef __ASSEMBLY__
> +#define PAGE_SIZE =C2=A0 =C2=A0 =C2=A0(1 << PAGE_SHIFT)
> +#else
> +#define PAGE_SIZE =C2=A0 =C2=A0 =C2=A0(1UL << PAGE_SHIFT)
> +#endif

#include <linux/const.h> and use (_AC(1, UL) << PAGE_SHIFT)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
