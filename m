From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 0/3] Fix arm_arch_timer clockmode when vDSO disabled
Date: Sat, 22 Feb 2020 10:40:05 +0000
Message-ID: <20200222104005.6fc4019d@why>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgBVKkJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Feb 2020 05:40:09 -0500
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org, m.szyprowski@samsung.com, Mark.Rutland@arm.com

On Fri, 21 Feb 2020 18:18:46 +0000
Vincenzo Frascino <vincenzo.frascino@arm.com> wrote:

> The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
> defined to compile correctly. On arm the vDSO can be disabled and when
> this is the case the compilation ends prematurely with an error:
>=20
>  $ make ARCH=3Darm multi_v7_defconfig
>  $ ./scripts/config -d VDSO
>  $ make
>=20
>  drivers/clocksource/arm_arch_timer.c:73:44: error:
>  =E2=80=98VDSO_CLOCKMODE_ARCHTIMER=E2=80=99 undeclared here (not in a fun=
ction)
>  static enum vdso_clock_mode vdso_default =3D VDSO_CLOCKMODE_ARCHTIMER;
>                                             ^
>  scripts/Makefile.build:267: recipe for target
>  'drivers/clocksource/arm_arch_timer.o' failed
>  make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
>  make[2]: *** Waiting for unfinished jobs....
>  scripts/Makefile.build:505: recipe for target 'drivers/clocksource' fail=
ed
>  make[1]: *** [drivers/clocksource] Error 2
>  make[1]: *** Waiting for unfinished jobs....
>  Makefile:1683: recipe for target 'drivers' failed
>  make: *** [drivers] Error 2
>=20
> This patch series addresses the issue defining a default arch clockmode
> for arm and arm64 and using it to initialize the arm_arch_timer.

arm only. arm64 is just fine.

>=20
> Changes:
> --------
> v2:
>   - Addressed Marc Zyngier comments.
>   - Rebased on 5.6-rc2.

This doesn't apply to -rc2, and is rather against next.

>=20
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <Mark.Rutland@arm.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>=20
> Vincenzo Frascino (3):
>   arm: clocksource: Add VDSO default clockmode
>   arm64: clocksource: Add VDSO default clockmode
>   clocksource: Fix arm_arch_timer clockmode when vDSO disabled

Please squash the three patches into a single one. There is zero point
in having 3 patches for something that small.

	M.
--=20
Jazz is not dead. It just smells funny...
