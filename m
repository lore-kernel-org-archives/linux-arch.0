Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr1300137.outbound.protection.outlook.com ([40.107.130.137]:5032
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729158AbfI3UoQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Sep 2019 16:44:16 -0400
From: Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v5 1/3] x86/hyper-v: Suspend/resume the hypercall page for
 hibernation
Date: Mon, 30 Sep 2019 18:49:33 +0000
Message-ID: <PU1P153MB0169804D32B95E0A145CD0B9BF820@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-2-git-send-email-decui@microsoft.com>
 <87ef0372wv.fsf@vitty.brq.redhat.com>
 <PU1P153MB01695A159E9843B4E1EC13AEBF810@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <877e5u6re3.fsf@vitty.brq.redhat.com>
In-Reply-To: <877e5u6re3.fsf@vitty.brq.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: vkuznets <vkuznets@redhat.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Message-ID: <20190930184933.CzRh33AjLXfSgfvzvMfux1vGETgSwutYW0b2YQQ0usg@z>

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, September 27, 2019 2:05 AM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> Dexuan Cui <decui@microsoft.com> writes:
> ...
> > So, I'm pretty sure no IPI can happen between hv_suspend() and
> hv_resume().
> > self-IPI is not supposed to happen either, since interrupts are disable=
d.
> >
> > IMO TLB flush should not be an issue either, unless the kernel changes =
page
> > tables between hv_suspend() and hv_resume(), which is not the case as I
> > checked the related code, but it looks in theory that might happen, say=
, in
> > the future, so if you insist we should save the variable "hv_hypercall_=
pg"
> > to a temporary variable and set the "hv_hypercall_pg" to NULL before we
> > disable the hypercall page
>=20
> Let's do it as a future proof so we can keep relying on !hv_hypercall_pg
> everywhere we need. No need to change this patch IMO, a follow-up would
> do.
> Vitaly

Now I think it would be better to do it in this patch. :-)
I'll post a v6 to follow your suggestion.

Thanks,
-- Dexuan
