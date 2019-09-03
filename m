Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr760102.outbound.protection.outlook.com ([40.107.76.102]:62180
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728854AbfICNwZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 09:52:25 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
Date: Tue, 3 Sep 2019 13:52:19 +0000
Message-ID: <20190903134335.uxxf5kvp3afe7rfr@pburton-laptop>
References: <20190830135902.20861-1-vincenzo.frascino@arm.com>
 <20190830135902.20861-4-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-4-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3823FA0127B0C948AAF60B176567B40D@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "salyzyn@android.com" <salyzyn@android.com>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "luto@kernel.org" <luto@kernel.org>
Message-ID: <20190903135219.n44nMWJW4bs8q2ZMPLyydS7CznRufcfdVr01ajQaoU4@z>

Hi Vincenzo,

On Fri, Aug 30, 2019 at 02:58:57PM +0100, Vincenzo Frascino wrote:
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
>=20
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
>=20
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

How would you like this to be applied? I'd be happy to apply this one to
mips-next, where commit 24640f233b46 ("mips: Add support for generic
vDSO") added the file being modified here. Otherwise:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> ---
>  arch/mips/include/asm/vdso/gettimeofday.h | 45 +++++++++++++++++++++++
>  arch/mips/vdso/config-n32-o32-env.c       |  1 +
>  2 files changed, 46 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/includ=
e/asm/vdso/gettimeofday.h
> index c59fe08b0347..e78462e8ca2e 100644
> --- a/arch/mips/include/asm/vdso/gettimeofday.h
> +++ b/arch/mips/include/asm/vdso/gettimeofday.h
> @@ -105,6 +105,51 @@ static __always_inline int clock_getres_fallback(
>  	return error ? -ret : ret;
>  }
> =20
> +#if _MIPS_SIM !=3D _MIPS_SIM_ABI64
> +
> +#define VDSO_HAS_32BIT_FALLBACK	1
> +
> +static __always_inline long clock_gettime32_fallback(
> +					clockid_t _clkid,
> +					struct old_timespec32 *_ts)
> +{
> +	register struct old_timespec32 *ts asm("a1") =3D _ts;
> +	register clockid_t clkid asm("a0") =3D _clkid;
> +	register long ret asm("v0");
> +	register long nr asm("v0") =3D __NR_clock_gettime;
> +	register long error asm("a3");
> +
> +	asm volatile(
> +	"       syscall\n"
> +	: "=3Dr" (ret), "=3Dr" (error)
> +	: "r" (clkid), "r" (ts), "r" (nr)
> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
> +
> +	return error ? -ret : ret;
> +}
> +
> +static __always_inline int clock_getres32_fallback(
> +					clockid_t _clkid,
> +					struct old_timespec32 *_ts)
> +{
> +	register struct old_timespec32 *ts asm("a1") =3D _ts;
> +	register clockid_t clkid asm("a0") =3D _clkid;
> +	register long ret asm("v0");
> +	register long nr asm("v0") =3D __NR_clock_getres;
> +	register long error asm("a3");
> +
> +	asm volatile(
> +	"       syscall\n"
> +	: "=3Dr" (ret), "=3Dr" (error)
> +	: "r" (clkid), "r" (ts), "r" (nr)
> +	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
> +	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
> +
> +	return error ? -ret : ret;
> +}
> +#endif
> +
>  #ifdef CONFIG_CSRC_R4K
> =20
>  static __always_inline u64 read_r4k_count(void)
> diff --git a/arch/mips/vdso/config-n32-o32-env.c b/arch/mips/vdso/config-=
n32-o32-env.c
> index 7f8d957abd4a..0011a632aef2 100644
> --- a/arch/mips/vdso/config-n32-o32-env.c
> +++ b/arch/mips/vdso/config-n32-o32-env.c
> @@ -10,6 +10,7 @@
>   */
>  #undef CONFIG_64BIT
> =20
> +#define BUILD_VDSO32
>  #define CONFIG_32BIT 1
>  #define CONFIG_GENERIC_ATOMIC64 1
>  #define BUILD_VDSO32_64
> --=20
> 2.23.0
>=20
