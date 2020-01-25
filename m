From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Date: Sat, 25 Jan 2020 01:44:31 +0000
Message-ID: <HK0P153MB0148ED41CE96B637019DF26ABF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
References: <1578350559-130275-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:1883
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387542AbgAYBoq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Jan 2020 20:44:46 -0500
In-Reply-To: <1578350559-130275-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, vkuznets <vkuznets@redhat.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

> From: Dexuan Cui <decui@microsoft.com>
> Sent: Monday, January 6, 2020 2:43 PM
>=20
> This is needed for hibernation, e.g. when we resume the old kernel, we ne=
ed
> to disable the "current" kernel's hypercall page and then resume the old
> kernel's.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
>=20
> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
>=20
> Please review.
>=20
> If it looks good, can you please pick it up through the tip.git tree?
>=20
>  arch/x86/hyperv/hv_init.c | 48
> +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Hi, Vitaly and x86 maintainers,
Can you please take a look at this patch?

Thanks,
-- Dexuan
