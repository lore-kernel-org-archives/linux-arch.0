Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr810109.outbound.protection.outlook.com ([40.107.81.109]:14213
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727624AbfICOqw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 10:46:52 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 7/8] mips: vdso: Remove unused VDSO_HAS_32BIT_FALLBACK
Date: Tue, 3 Sep 2019 14:46:45 +0000
Message-ID: <20190903143801.7upetfqe6upouzlh@pburton-laptop>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-8-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-8-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC316F9566DBF246B86E082AA7B4F9C9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "salyzyn@android.com" <salyzyn@android.com>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "luto@kernel.org" <luto@kernel.org>
Message-ID: <20190903144645.lGid3xVGKW6fKlecTm5cWXFbJChD4PafNlFEfk1IgaE@z>

Hi Vincenzo,

On Fri, Aug 30, 2019 at 02:59:01PM +0100, Vincenzo Frascino wrote:
> VDSO_HAS_32BIT_FALLBACK has been removed from the core since
> the architectures that support the generic vDSO library have
> been converted to support the 32 bit fallbacks.
>=20
> Remove unused VDSO_HAS_32BIT_FALLBACK from mips vdso.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Do you want this one in mips-next too, or applied somewhere else along
with the rest of the series? If the latter:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/vdso/gettimeofday.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/includ=
e/asm/vdso/gettimeofday.h
> index e78462e8ca2e..5ad2b086626d 100644
> --- a/arch/mips/include/asm/vdso/gettimeofday.h
> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
> @@ -107,8 +107,6 @@ static __always_inline int clock_getres_fallback(
> =20
>  #if _MIPS_SIM !=3D _MIPS_SIM_ABI64
> =20
> -#define VDSO_HAS_32BIT_FALLBACK	1
> -
>  static __always_inline long clock_gettime32_fallback(
>  					clockid_t _clkid,
>  					struct old_timespec32 *_ts)
> --=20
> 2.23.0
>=20
