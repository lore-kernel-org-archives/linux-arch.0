Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr710092.outbound.protection.outlook.com ([40.107.71.92]:19728
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfG1WUV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Jul 2019 18:20:21 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 0/2] mips: vdso: Fix Makefile
Date: Sun, 28 Jul 2019 22:20:18 +0000
Message-ID: <MWHPR2201MB1277BCF195D341D7AB3FA5EBC1C20@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190726162944.12149-1-vincenzo.frascino@arm.com>
In-Reply-To: <20190726162944.12149-1-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "ralf@linux-mips.org" <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "salyzyn@android.com" <salyzyn@android.com>, "pcc@google.com" <pcc@google.com>, "shuah@kernel.org" <shuah@kernel.org>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>, "huw@codeweavers.com" <huw@codeweavers.com>, "sthotton@marvell.com" <sthotton@marvell.com>, "andre.przywara@arm.com" <andre.przywara@arm.com>, "luto@kernel.org" <luto@kernel.org>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190728222018.QnKzkBa2yxWTKkCbGrWrXVC8yuko2GCH92oNrMzdZoM@z>

Hello,

Vincenzo Frascino wrote:
> Consequently to the unified vDSO transition of the MIPS architecture few
> compilation issues appeared due to:
> - A wrong source path for the configuration environment settings for
> the O32 and N32 vDSO library generation.
> - A flip/flop vDSO building bug that would cause to rebuild the vDSO
> library every second time.
>=20
> This patch series addresses both the issues providing the respective
> fixes.
>=20
> This patchset is rebased on top of mips-next.
>=20
> Cc: Paul Burton <paul.burton@mips.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>=20
> Vincenzo Frascino (2):
> mips: vdso: Fix source path
> mips: vdso: Fix flip/flop vdso building bug
>=20
> arch/mips/vdso/Makefile | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)

Series applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
