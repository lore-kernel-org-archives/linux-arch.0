Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr720126.outbound.protection.outlook.com ([40.107.72.126]:55459
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfGZFPr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 26 Jul 2019 01:15:47 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 21/25] mips: Add clock_gettime64 entry point
Date: Fri, 26 Jul 2019 05:15:45 +0000
Message-ID: <MWHPR2201MB1277BCA61ED6CC494A4DB937C1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190621095252.32307-22-vincenzo.frascino@arm.com>
In-Reply-To: <20190621095252.32307-22-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>, Shijith Thotton <sthotton@marvell.com>, Andre Przywara <andre.przywara@arm.com>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190726051545.OOfjugz9szoFK3ZUPO98Sze9gHqSIwFvu_5fJIbon44@z>

Hello,

Vincenzo Frascino wrote:
> With the release of Linux 5.1 has been added a new syscall,
> clock_gettime64, that provided a 64 bit time value for a specified
> clock_ID to make the kernel Y2038 safe on 32 bit architectures.
>=20
> Update the mips32 specific vDSO library accordingly with what it has
> been done for the kernel syscall exposing the clock_gettime64 entry
> point.
>=20
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
