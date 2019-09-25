Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr1320130.outbound.protection.outlook.com ([40.107.132.130]:22541
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729604AbfIYWtk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Sep 2019 18:49:40 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v5 0/3] Enhance Hyper-V for hibernation
Date: Wed, 25 Sep 2019 22:49:35 +0000
Message-ID: <PU1P153MB01692C8EC435F7F108564BAEBF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1567723581-29088-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dexuan Cui <decui@microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190925224935.yjU91LNjHe_VHkhgClz2Wd_3396hASPvljeHYhioTSc@z>

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Thursday, September 5, 2019 3:47 PM
>=20
> This patchset (consisting of 3 patches) was part of the v4 patchset (cons=
isting
> of 12 patches): https://lkml.org/lkml/2019/9/2/894
>=20
> I realized these 3 patches must go through the tip.git tree, because I ha=
ve
> to rebase 2 of the 3 patches due to recent changes from others in the tip
> tree.
>=20
> All the 3 patches are now rebased to the tip tree's timers/core branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dtime=
rs/core
> , and all the 3 patches have Michael Kelley's Signed-off-by's.
>=20
> Please review.
>=20
> Thanks!
> Dexuan
>=20
> Dexuan Cui (3):
>   x86/hyper-v: Suspend/resume the hypercall page for hibernation
>   x86/hyper-v: Implement hv_is_hibernation_supported()
>   clocksource/drivers: Suspend/resume Hyper-V clocksource for
>     hibernation
>=20
>  arch/x86/hyperv/hv_init.c          | 40
> ++++++++++++++++++++++++++++++++++++++
>  drivers/clocksource/hyperv_timer.c | 25 ++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h     |  2 ++
>  3 files changed, 67 insertions(+)

Hi tglx and all,
Can you please take a look at this patchset (3 patches in total)?

IMO it's better for the 3 patches to go through the tip.git tree, but if yo=
u
(the x86 maintainers) have no objection, the patches can also go through
Saha Levin's Hyper-V tree, because the dependent patches have landed
in Linus's tree now.

Thanks,
-- Dexuan
