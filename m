Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51104 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbeGYIb1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jul 2018 04:31:27 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1618794wmc.0
        for <linux-arch@vger.kernel.org>; Wed, 25 Jul 2018 00:21:04 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <542827d9-38fe-b145-234b-764ab6b7f612@monstr.eu>
Date: Wed, 25 Jul 2018 09:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Message-ID: <20180725072050.oTN24CDNBkkP-RLwqIIk1h_0IEGeN5uYfXz5Nq3SXs4@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w
Content-Type: multipart/mixed; boundary="URYShIJJvvPdHwILoi2Ar08YEf3Fni66X";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Russell King <rmk+kernel@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-arch <linux-arch@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Nicholas Piggin <npiggin@gmail.com>,
 linux-kernel@vger.kernel.org
Message-ID: <542827d9-38fe-b145-234b-764ab6b7f612@monstr.eu>
Subject: Re: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead
 of LD
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
 <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>

--URYShIJJvvPdHwILoi2Ar08YEf3Fni66X
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 3.7.2018 03:22, Masahiro Yamada wrote:
> With the recent syntax extension, Kconfig is now able to evaluate the
> compiler / toolchain capability.
>=20
> However, accumulating flags to 'LD' is not compatible with the way
> it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
> from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
> CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
> between Makefile and Kconfig.
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>=20
>  arch/microblaze/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index d269dd4b..7333036 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=
) +=3D -mxl-pattern-compare
>  ifdef CONFIG_CPU_BIG_ENDIAN
>  KBUILD_CFLAGS +=3D -mbig-endian
>  KBUILD_AFLAGS +=3D -mbig-endian
> -LD +=3D -EB
> +LDFLAGS +=3D -EB
>  else
>  KBUILD_CFLAGS +=3D -mlittle-endian
>  KBUILD_AFLAGS +=3D -mlittle-endian
> -LD +=3D -EL
> +LDFLAGS +=3D -EL
>  endif
> =20
>  CPUFLAGS-1 +=3D $(call cc-option,-mcpu=3Dv$(CPU_VER))
>=20

Applied to next.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--URYShIJJvvPdHwILoi2Ar08YEf3Fni66X--

--prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAltYJNYACgkQykllyylKDCExXwCfb/M/wFP3UNuWZh5i33DCMcSJ
k7gAoJRmsvI0sJl5abkcJf+2VuJw3gQi
=8EBp
-----END PGP SIGNATURE-----

--prFilB0ZdgGesCmeZF6lzp3U4xWu5jI4w--
