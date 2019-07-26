Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr790122.outbound.protection.outlook.com ([40.107.79.122]:37888
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725815AbfGZFPo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 01:15:44 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 19/25] mips: Add support for generic vDSO
Date: Fri, 26 Jul 2019 05:15:35 +0000
Message-ID: <MWHPR2201MB1277C33D971A9C8945812CFCC1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190621095252.32307-20-vincenzo.frascino@arm.com>
In-Reply-To: <20190621095252.32307-20-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190726051535.D2VjBfy_oqT-rYVpk0lFNSDvGZucFpbn3PX4tW5L63s@z>

Hello,

Vincenzo Frascino wrote:
> The mips vDSO library requires some adaptations to take advantage of the
> newly introduced generic vDSO library.
>=20
> Introduce the following changes:
> - Modification of vdso.c to be compliant with the common vdso datapage
> - Use of lib/vdso for gettimeofday
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
