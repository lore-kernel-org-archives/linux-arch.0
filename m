From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m68k: include: asm: define 'VM_DATA_DEFAULT_FLAGS'
 no matter whether has 'NOMMU' or not.
Date: Mon, 01 Jul 2013 10:43:14 +0800
Message-ID: <51D0ECC2.3020101@asianux.com>
References: <51C548E2.1060104@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <51C548E2.1060104@asianux.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>, "dhowells@redhat.com" <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, davej@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-m68k <linux-m68k@lists.linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello Maintainers:

Please help check the patch whether OK or not, when you have time.

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
>   security/selinux/hooks.c: In function =E2=80=98selinux_init=E2=80=99=
:
>   security/selinux/hooks.c:5821:21: error: =E2=80=98VM_DATA_DEFAULT_F=
LAGS=E2=80=99 undeclared (first use in this function)
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
