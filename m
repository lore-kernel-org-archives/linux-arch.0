Return-Path: <SRS0=fdYI=3T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-eopbgr1320123.outbound.protection.outlook.com ([40.107.132.123]:16224
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726671AbgA3BCS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 29 Jan 2020 20:02:18 -0500
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page
 for hibernation
Date: Thu, 30 Jan 2020 01:02:06 +0000
Message-ID: <PU1P153MB01552D8E75E152C3F3FB9C65BF040@PU1P153MB0155.APCP153.PROD.OUTLOOK.COM>
References: <1578350559-130275-1-git-send-email-decui@microsoft.com>
 <HK0P153MB0148ED41CE96B637019DF26ABF090@HK0P153MB0148.APCP153.PROD.OUTLOOK.COM>
 <20200130000552.GD2896@sasha-vm>
In-Reply-To: <20200130000552.GD2896@sasha-vm>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sasha Levin <sashal@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>
Cc: "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, vkuznets <vkuznets@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20200130010206.FrgdXPSsv856u09XsmjA48MX09NoBRNA2-M28OFUYfY@z>

> From: linux-hyperv-owner@vger.kernel.org
> <linux-hyperv-owner@vger.kernel.org> On Behalf Of Sasha Levin
> Sent: Wednesday, January 29, 2020 4:06 PM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: arnd@arndb.de; bp@alien8.de; daniel.lezcano@linaro.org; Haiyang Zhang
> <haiyangz@microsoft.com>; hpa@zytor.com; KY Srinivasan
> <kys@microsoft.com>; linux-hyperv@vger.kernel.org;
> linux-kernel@vger.kernel.org; mingo@redhat.com; Stephen Hemminger
> <sthemmin@microsoft.com>; tglx@linutronix.de; x86@kernel.org; Michael
> Kelley <mikelley@microsoft.com>; Sasha Levin
> <Alexander.Levin@microsoft.com>; vkuznets <vkuznets@redhat.com>;
> linux-arch@vger.kernel.org
> Subject: Re: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall
> page for hibernation
>=20
> On Sat, Jan 25, 2020 at 01:44:31AM +0000, Dexuan Cui wrote:
> >> From: Dexuan Cui <decui@microsoft.com>
> >> Sent: Monday, January 6, 2020 2:43 PM
> >>
> >> This is needed for hibernation, e.g. when we resume the old kernel, we
> need
> >> to disable the "current" kernel's hypercall page and then resume the o=
ld
> >> kernel's.
> >>
> >> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> >> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> >> ---
> >>
> >> This is a RESEND of https://lkml.org/lkml/2019/11/20/68
> >>
> >> Please review.
> >>
> >> If it looks good, can you please pick it up through the tip.git tree?
> >>
> >>  arch/x86/hyperv/hv_init.c | 48
> >> +++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 48 insertions(+)
> >
> >Hi, Vitaly and x86 maintainers,
> >Can you please take a look at this patch?
>=20
> Ping?
>=20
> This patch has been floating around in it's current form for the past 2
> months. I'll happily take Hyper-V patches under arch/x86/hyperv/ via the
> Hyper-V tree rather than tip if the x86 folks don't want to deal with
> them.
>=20
> --
> Thanks,
> Sasha

This straightforward patch is the only pending patch for v5.6 for the
hibernation functionality of Linux VM on Hyper-V. It would be really great
if we could merge it for v5.6-rc1. The patch is safe in that it only runs w=
hen=20
the VM hibernates, and the hibernation functionality of Linux VM on
Hyper-V never worked before. I'm pretty sure the patch can not cause any
merge conflict since nobody else tries to modify the file recently.

Thanks,
-- Dexuan
