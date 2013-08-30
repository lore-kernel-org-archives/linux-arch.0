From: Will Deacon <will.deacon@arm.com>
Subject: Re: [gcv v3 27/35] arm: Replace __get_cpu_var uses
Date: Fri, 30 Aug 2013 11:01:05 +0100
Message-ID: <20130830100105.GF25628@mudshark.cambridge.arm.com>
References: <20130828193457.140443630@linux.com>
 <00000140c67834c9-cc2bec76-2d70-48d1-a35b-6e2d5dedf22b-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42602 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754102Ab3H3KB2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Aug 2013 06:01:28 -0400
Content-Disposition: inline
In-Reply-To: <00000140c67834c9-cc2bec76-2d70-48d1-a35b-6e2d5dedf22b-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Christoph,

Sorry for the delay in looking at this, I've been on holiday for a week=
=2E
Comments inline.

On Wed, Aug 28, 2013 at 08:48:23PM +0100, Christoph Lameter wrote:
> Transformations done to __get_cpu_var()
>=20
>=20
> 1. Determine the address of the percpu instance of the current proces=
sor.
>=20
>         DEFINE_PER_CPU(int, y);
>         int *x =3D &__get_cpu_var(y);
>=20
>     Converts to
>=20
>         int *x =3D this_cpu_ptr(&y);
>=20
>=20
> 2. Same as #1 but this time an array structure is involved.
>=20
>         DEFINE_PER_CPU(int, y[20]);
>         int *x =3D __get_cpu_var(y);
>=20
>     Converts to
>=20
>         int *x =3D this_cpu_ptr(y);

This is the flavour we have for ARM's hw_breakpoint code, where we have=
 an
array of perf_event * instead of int...

> Index: linux/arch/arm/kernel/hw_breakpoint.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/arch/arm/kernel/hw_breakpoint.c  2013-08-26 13:48:40.9=
56794980 -0500
> +++ linux/arch/arm/kernel/hw_breakpoint.c       2013-08-26 13:48:40.9=
52795024 -0500
> @@ -344,13 +344,13 @@ int arch_install_hw_breakpoint(struct pe
>                 /* Breakpoint */
>                 ctrl_base =3D ARM_BASE_BCR;
>                 val_base =3D ARM_BASE_BVR;
> -               slots =3D (struct perf_event **)__get_cpu_var(bp_on_r=
eg);
> +               slots =3D (struct perf_event **)__this_cpu_read(bp_on=
_reg);

=2E..so I don't think this is quite right, and indeed, we get a bunch o=
f errors
from GCC:

arch/arm/kernel/hw_breakpoint.c: In function =E2=80=98arch_install_hw_b=
reakpoint=E2=80=99:
arch/arm/kernel/hw_breakpoint.c:347:33: error: incompatible types when =
assigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from type =E2=
=80=98struct perf_event **=E2=80=99
arch/arm/kernel/hw_breakpoint.c:347:1: error: incompatible types when a=
ssigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from type =E2=
=80=98struct perf_event **=E2=80=99
arch/arm/kernel/hw_breakpoint.c:347:1: error: incompatible types when a=
ssigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from type =E2=
=80=98struct perf_event **=E2=80=99
arch/arm/kernel/hw_breakpoint.c:347:1: error: incompatible types when a=
ssigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from type =E2=
=80=98struct perf_event **=E2=80=99

changing to match your recipe still doesn't work, however:

arch/arm/kernel/hw_breakpoint.c: In function =E2=80=98arch_install_hw_b=
reakpoint=E2=80=99:
arch/arm/kernel/hw_breakpoint.c:347:33: error: cast specifies array typ=
e

> Index: linux/arch/arm64/kernel/debug-monitors.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/arch/arm64/kernel/debug-monitors.c       2013-08-26 13=
:48:40.956794980 -0500
> +++ linux/arch/arm64/kernel/debug-monitors.c    2013-08-26 13:48:40.9=
52795024 -0500
> @@ -98,11 +98,11 @@ void enable_debug_monitors(enum debug_el
>=20
>         WARN_ON(preemptible());
>=20
> -       if (local_inc_return(&__get_cpu_var(mde_ref_count)) =3D=3D 1)
> +       if (this_cpu_inc_return(mde_ref_count) =3D=3D 1)
>                 enable =3D DBG_MDSCR_MDE;

I'm not sure that this is safe. We rely on local_inc_return to be atomi=
c
with respect to the current CPU, which will end up being a wrapper arou=
nd
atomic64_inc_return. However, this_cpu_inc_return simply uses a lock, s=
o
other people accessing the count in a different manner (local_dec_and_t=
est
below) may break local atomicity unless we start disabling interrupts o=
r
something horrible like that.
=20
>         if (el =3D=3D DBG_ACTIVE_EL1 &&
> -           local_inc_return(&__get_cpu_var(kde_ref_count)) =3D=3D 1)
> +           this_cpu_inc_return(kde_ref_count) =3D=3D 1)
>                 enable |=3D DBG_MDSCR_KDE;
>=20
>         if (enable && debug_enabled) {
> @@ -118,11 +118,11 @@ void disable_debug_monitors(enum debug_e
>=20
>         WARN_ON(preemptible());
>=20
> -       if (local_dec_and_test(&__get_cpu_var(mde_ref_count)))
> +       if (local_dec_and_test(this_cpu_ptr(&mde_ref_count)))
>                 disable =3D ~DBG_MDSCR_MDE;
>=20
>         if (el =3D=3D DBG_ACTIVE_EL1 &&
> -           local_dec_and_test(&__get_cpu_var(kde_ref_count)))
> +           local_dec_and_test(this_cpu_ptr(&kde_ref_count)))
>                 disable &=3D ~DBG_MDSCR_KDE;
>=20
>         if (disable) {

Will
