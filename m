Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr680096.outbound.protection.outlook.com ([40.107.68.96]:59556
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfF1Sli (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Jun 2019 14:41:38 -0400
From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 18/19] x86: Add support for generic vDSO
Date: Fri, 28 Jun 2019 18:40:56 +0000
Message-ID: <BL0PR2101MB1348C26A569D83E9D7BB03CDD7FC0@BL0PR2101MB1348.namprd21.prod.outlook.com>
References: <20190530141531.43462-1-vincenzo.frascino@arm.com>
 <20190530141531.43462-19-vincenzo.frascino@arm.com>
 <BYAPR21MB1221D54FCEC97509EEF7395CD7180@BYAPR21MB1221.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906141313150.1722@nanos.tec.linutronix.de>
 <20190614211710.GQ1513@sasha-vm>
 <alpine.DEB.2.21.1906221542270.5503@nanos.tec.linutronix.de>
 <20190623190929.GL2226@sasha-vm>
 <alpine.DEB.2.21.1906240006090.32342@nanos.tec.linutronix.de>
 <BYAPR21MB135202F46C4B023B51EBBFD0D7E00@BYAPR21MB1352.namprd21.prod.outlook.com>
 <alpine.DEB.2.21.1906240221550.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906240221550.32342@nanos.tec.linutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sasha Levin <sashal@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20190628184056.-ZXZHSfRSFs6xl0gMxQnOwYPP_OnrlhfKW6G4sV_vWc@z>

From: Thomas Gleixner <tglx@linutronix.de> Sent: Sunday, June 23, 2019 5:25=
 PM
>=20
> I don't care whether this goes into 5.3 or later. If you can provide me
> rebased self contained patches on top of
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
>=20
> I'm happy to pull them in on top.
>=20

I've sent out "v4" of the patch set to create a Hyper-V clocksource, based
on the above tree.  It is contained to Hyper-V code, plus updating a #inclu=
de
statement in two of the VDSO files and in one KVM file.  If the KVM file
update is problematic, the patch set can just wait until 5.3-rc1.

Michael
