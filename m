Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr710137.outbound.protection.outlook.com ([40.107.71.137]:35616
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbfFXBsn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Jun 2019 21:48:43 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Mon, 24 Jun 2019 00:04:06 +0000
Message-ID: <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Sasha Levin <sashal@kernel.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20190624000406.4MXK1IBLZ_TOaV9r_MEgfwpVep335h66KWQ7z-7AIls@z>

From: Thomas Gleixner <tglx@linutronix.de> Sent: Sunday, June 23, 2019 3:13=
 PM
>=20
> I have no objections if you collect hyper-v stuff, quite the contrary, bu=
t
> changes which touch other subsystems need to be coordinated upfront. That=
's
> all I'm asking for.
>=20
> Btw, that clocksource stuff looks good code wise, just the change logs ne=
ed
> some care and after the VDSO stuff hits next we need to sort out the
> logistics. I hope these changes are completely self contained. If not we'=
ll
> find a solution.
>

In my view, the only thing that potentially needs a solution is where the
Hyper-V clock code used by VDSO ends up in the code tree.  I think the
right long term place is include/clocksource/hyperv_timer.h.   That locatio=
n
is architecture neutral, and the same Hyper-V clock code will be shared by
the Hyper-V on ARM64 support that's in process.

Vincenzo's patch set creates a new file arch/x86/include/asm/mshyperv-tsc.h=
,
which I will want to move when creating the separate Hyper-V clocksource
driver.   If you're OK with that file existing for a release and then going=
 away,
that's fine.  Alternatively, put the code in include/clocksource/hyperv_tim=
er.h
now as part of the VDSO patch set so it's in the right place from the start=
.  My
subsequent patch set will add a few additional tweaks to remove x86-isms
and fully integrate with the separate Hyper-V clocksource driver.

Michael=20
