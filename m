Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr800122.outbound.protection.outlook.com ([40.107.80.122]:61504
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbfHLSkB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Aug 2019 14:40:01 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page
 statically
Date: Mon, 12 Aug 2019 18:39:52 +0000
Message-ID: <DM5PR21MB0137DBE06D9E8667311AFAF0D7D30@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
 <20190729075243.22745-2-Tianyu.Lan@microsoft.com>
In-Reply-To: <20190729075243.22745-2-Tianyu.Lan@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "lantianyu1986@gmail.com" <lantianyu1986@gmail.com>, "luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>"ashal@kernel.org" <ashal@kernel.org>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190812183952.gOYtTnqt97KOE3MtZKQWQra_GEHPSe8jcs9YzjB8BWA@z>

From: lantianyu1986@gmail.com <lantianyu1986@gmail.com> Sent: Monday, July =
29, 2019 12:53 AM
>=20
> This is to prepare to add Hyper-V sched clock callback and move
> Hyper-V reference TSC initialization much earlier in the boot
> process when timestamp is 0. So no discontinuity is observed
> when pv_ops.time.sched_clock to calculate its offset. This earlier
> initialization requires that the Hyper-V TSC page be allocated
> statically instead of with vmalloc(), so fixup the references
> to the TSC page and the method of getting its physical address.

I'd suggest tweaking the commit message wording a bit:

Prepare to add Hyper-V sched clock callback and move Hyper-V
Reference TSC initialization much earlier in the boot process.  Earlier
initialization is needed so that it happens while the timestamp value
is still 0 and no discontinuity in the timestamp will occur when=20
pv_ops.time.sched_clock calculates its offset.  The earlier
initialization requires that the Hyper-V TSC page be allocated
statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  arch/x86/entry/vdso/vma.c          |  2 +-
>  drivers/clocksource/hyperv_timer.c | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
>=20
> @@ -280,12 +280,8 @@ static bool __init hv_init_tsc_clocksource(void)
>  	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
>  		return false;
>=20
> -	tsc_pg =3D vmalloc(PAGE_SIZE);
> -	if (!tsc_pg)
> -		return false;
> -
>  	hyperv_cs =3D &hyperv_cs_tsc;
> -	phys_addr =3D page_to_phys(vmalloc_to_page(tsc_pg));
> +	phys_addr =3D virt_to_phys(&tsc_pg) & PAGE_MASK;

The and'ing with PAGE_MASK isn't needed.  You've set up tsc_pg
to ensure it is page aligned, so there's no need to mask out any
low order bits.  That's why the previous code didn't do the masking
either.

>=20
>  	/*
>  	 * The Hyper-V TLFS specifies to preserve the value of reserved
> --
> 2.14.5
