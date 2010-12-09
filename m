From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCHv1 008/211] unicore32: new file arch/unicore32/boot/compressed/misc.c
Date: Thu, 9 Dec 2010 19:33:26 +0100
Message-ID: <AANLkTimDWHGsL+1H_VSevSjpFW0-h53NzRynANnayTRm@mail.gmail.com>
References: <01da01cb9784$d44c0460$7ce40d20$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:42449 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756554Ab0LISd2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Dec 2010 13:33:28 -0500
In-Reply-To: <01da01cb9784$d44c0460$7ce40d20$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, some trivial tips...

On Thu, Dec 9, 2010 at 10:38 AM, Guan Xuetao <guanxuetao@mprc.pku.edu.c=
n> wrote:
> From: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
>
> =A0 =A0 =A0 =A0decompress_kernel call wrapper in c function
>
> Signed-off-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> ---
> =A0arch/unicore32/boot/compressed/misc.c | =A0143
> +++++++++++++++++++++++++++++++++
> =A01 files changed, 143 insertions(+), 0 deletions(-)
>
> diff --git a/arch/unicore32/boot/compressed/misc.c
> b/arch/unicore32/boot/compressed/misc.c
> new file mode 100644
> index 0000000..28dda37
> --- /dev/null
> +++ b/arch/unicore32/boot/compressed/misc.c
> @@ -0,0 +1,143 @@
> +/*
> + * linux/arch/unicore32/boot/compressed/misc.c
> + *
> + * Code specific to PKUnity SoC and UniCore ISA
> + *
> + * Copyright (C) 2001-2010 GUAN Xue-tao
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/unaligned.h>
> +#include <asm/mach/uncompress.h>
> +
> +/*
> + * gzip delarations
> + */
> +unsigned char *output_data;
> +unsigned long output_ptr;
> +
> +unsigned int free_mem_ptr;
> +unsigned int free_mem_end_ptr;
> +
> +#define STATIC static
> +#define STATIC_RW_DATA /* non-static please */
> +
> +/*
> + * arch-dependent implementations
> + */
> +#ifndef ARCH_HAVE_DECOMP_ERROR
> +#define arch_decomp_error(x)
> +#endif
> +
> +#ifndef ARCH_HAVE_DECOMP_SETUP
> +#define =A0 =A0 =A0 =A0arch_decomp_setup()

Whitespace

> +#endif
> +
> +#ifndef ARCH_HAVE_DECOMP_PUTS
> +#define arch_decomp_puts(p)
> +#endif
> +
> +/* Diagnostic functions */
> +#ifdef DEBUG
> +# =A0define Assert(cond, msg) =A0 =A0{ if (!(cond)) error(msg); }
> +# =A0define Trace(x) =A0 =A0 =A0 =A0 =A0 =A0 fprintf x
> +# =A0define Tracev(x) =A0 =A0 =A0 =A0 =A0 =A0{ if (verbose) =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0fprintf x; }
> +# =A0define Tracevv(x) =A0 =A0 =A0 =A0 =A0 { if (verbose > 1) =A0 =A0=
 =A0 =A0 =A0 =A0 =A0fprintf x; }
> +# =A0define Tracec(c, x) =A0 =A0 =A0 =A0 { if (verbose && (c)) =A0 =A0=
 =A0 =A0 =A0 fprintf x; }
> +# =A0define Tracecv(c, x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ if ((verb=
ose > 1) && (c))
> fprintf x; }

Maybe uppercase? Maybe do { ... } while(0)?

> +#else
> +# =A0define Assert(cond, msg)
> +# =A0define Trace(x)
> +# =A0define Tracev(x)
> +# =A0define Tracevv(x)
> +# =A0define Tracec(c, x)
> +# =A0define Tracecv(c, x)
> +#endif
> +
> +void *memcpy(void *__dest, __const void *__src, size_t __n)

Why are they underscored?

> +{
> + =A0 =A0 =A0 int i =3D 0;
> + =A0 =A0 =A0 unsigned char *d =3D (unsigned char *)__dest, *s =3D (u=
nsigned char
> *)__src;
> +
> + =A0 =A0 =A0 for (i =3D __n >> 3; i > 0; i--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (__n & 1 << 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (__n & 1 << 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (__n & 1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *d++ =3D *s++;
> +
> + =A0 =A0 =A0 return __dest;
> +}
> +
> +void error(char *x)
> +{
> +

Newline

> + =A0 =A0 =A0 arch_decomp_puts("\n\n");
> + =A0 =A0 =A0 arch_decomp_puts(x);
> + =A0 =A0 =A0 arch_decomp_puts("\n\n -- System halted");
> +
> + =A0 =A0 =A0 arch_decomp_error(x);
> +
> + =A0 =A0 =A0 do { } while (1); /* Halt */

for (;;);?

> +}
> +
> +/* Heap size should be adjusted for different decompress method */
> +#ifdef CONFIG_KERNEL_GZIP
> +#include "../../../../lib/decompress_inflate.c"
> +#endif
> +
> +#ifdef CONFIG_KERNEL_BZIP2
> +#include "../../../../lib/decompress_bunzip2.c"
> +#endif
> +
> +#ifdef CONFIG_KERNEL_LZO
> +#include "../../../../lib/decompress_unlzo.c"
> +#endif
> +
> +#ifdef CONFIG_KERNEL_LZMA
> +#include "../../../../lib/decompress_unlzma.c"
> +#endif
> +
> +unsigned long

I think that, for new code, no newlines should be written after the ret=
urn type.

> +decompress_kernel(unsigned long output_start, unsigned long free_mem=
_ptr_p,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long free_mem_ptr_end_p)
> +{
> + =A0 =A0 =A0 unsigned char *tmp;
> +
> + =A0 =A0 =A0 output_data =A0 =A0 =A0 =A0 =A0 =A0 =3D (unsigned char =
*)output_start;
> + =A0 =A0 =A0 free_mem_ptr =A0 =A0 =A0 =A0 =A0 =A0=3D free_mem_ptr_p;
> + =A0 =A0 =A0 free_mem_end_ptr =A0 =A0 =A0 =A0=3D free_mem_ptr_end_p;
> +
> + =A0 =A0 =A0 arch_decomp_setup();
> +
> + =A0 =A0 =A0 tmp =3D (unsigned char *) (((unsigned long)input_data_e=
nd) - 4);
> + =A0 =A0 =A0 output_ptr =3D get_unaligned_le32(tmp);
> +
> + =A0 =A0 =A0 arch_decomp_puts("Uncompressing Linux...");
> + =A0 =A0 =A0 decompress(input_data, input_data_end - input_data, NUL=
L, NULL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 output_data, NULL, erro=
r);
> + =A0 =A0 =A0 arch_decomp_puts(" done, booting the kernel.\n");
> + =A0 =A0 =A0 return output_ptr;
> +}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
