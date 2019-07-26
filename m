Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720115.outbound.protection.outlook.com ([40.107.72.115]:27348
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725878AbfGZFPp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 01:15:45 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 20/25] mips: Add clock_getres entry point
Date: Fri, 26 Jul 2019 05:15:41 +0000
Message-ID: <MWHPR2201MB1277885B5C1F41C1563B4B5AC1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190621095252.32307-21-vincenzo.frascino@arm.com>
In-Reply-To: <20190621095252.32307-21-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190726051541.hX34SZgNPuu9pJZib30QDSmH95NIKTRSFhTF3trlrKw@z>

Hello,

Vincenzo Frascino wrote:
> The generic vDSO library provides an implementation of clock_getres()
> that can be leveraged by each architecture.
>=20
> Add clock_getres() entry point on mips.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
