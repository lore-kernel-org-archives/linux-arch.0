From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m68k: include: asm: define 'VM_DATA_DEFAULT_FLAGS'
 no matter whether has 'NOMMU' or not.
Date: Sat, 22 Jun 2013 14:56:27 +0800
Message-ID: <51C54A9B.9060009@asianux.com>
References: <51C548E2.1060104@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:45726 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab3FVG5Z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jun 2013 02:57:25 -0400
In-Reply-To: <51C548E2.1060104@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, "dhowells@redhat.com" <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, davej@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


The same .config file, also report the compiling error below:

drivers/i2c/busses/i2c-ocores.c:81:2: error: implicit declaration of fu=
nction =E2=80=98iowrite8=E2=80=99 [-Werror=3Dimplicit-function-declarat=
ion]
drivers/i2c/busses/i2c-ocores.c:86:2: error: implicit declaration of fu=
nction =E2=80=98iowrite16=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
drivers/i2c/busses/i2c-ocores.c:91:2: error: implicit declaration of fu=
nction =E2=80=98iowrite32=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
drivers/i2c/busses/i2c-ocores.c:96:2: error: implicit declaration of fu=
nction =E2=80=98ioread8=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
drivers/i2c/busses/i2c-ocores.c:101:2: error: implicit declaration of f=
unction =E2=80=98ioread16=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
drivers/i2c/busses/i2c-ocores.c:106:2: error: implicit declaration of f=
unction =E2=80=98ioread32=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]

Excuse me, I am not quite familiar with the related hardware and m68k,
I guess under m68k architecture, we need not this drivers, is it correc=
t ?

Thanks.


On 06/22/2013 02:49 PM, Chen Gang wrote:
>=20
> Define 'VM_DATA_DEFAULT_FLAGS' when 'NOMMU' to pass compiling.
>=20
> So move it from "include/asm/page_mm.h to "include/asm/page.h"
>=20
> The related make:
>=20
>   make ARCH=3Dm68k randconfig
>   make ARCH=3Dm68k menuconfig
>     choose cross compiler
>     disable MMU support
>   make ARCH=3Dm68k V=3D1 EXTRA_CFLAGS=3D-W
>=20
> The related error:
>=20
>   security/selinux/hooks.c: In function =EF=BF=BDselinux_init=EF=BF=BD=
:
>   security/selinux/hooks.c:5821:21: error: =EF=BF=BDVM_DATA_DEFAULT_F=
LAGS=EF=BF=BD undeclared (first use in this function)
>=20
> (the attachment is the related .config file)
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/m68k/include/asm/page.h    |    3 +++
>  arch/m68k/include/asm/page_mm.h |    3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/pag=
e.h
> index 7c360da..38b024a 100644
> --- a/arch/m68k/include/asm/page.h
> +++ b/arch/m68k/include/asm/page.h
> @@ -48,6 +48,9 @@ extern unsigned long _ramend;
>  #include <asm/page_no.h>
>  #endif
> =20
> +#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
> +				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> +
>  #include <asm-generic/getorder.h>
> =20
>  #endif /* _M68K_PAGE_H */
> diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/=
page_mm.h
> index 89f2014..5029f73 100644
> --- a/arch/m68k/include/asm/page_mm.h
> +++ b/arch/m68k/include/asm/page_mm.h
> @@ -173,7 +173,4 @@ static inline __attribute_const__ int __virt_to_n=
ode_shift(void)
> =20
>  #endif /* __ASSEMBLY__ */
> =20
> -#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
> -				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
> -
>  #endif /* _M68K_PAGE_MM_H */
>=20


--=20
Chen Gang

Asianux Corporation
