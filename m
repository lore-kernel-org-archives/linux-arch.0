Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr800104.outbound.protection.outlook.com ([40.107.80.104]:7800
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfICVBA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 3 Sep 2019 17:01:00 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v2 3/8] mips: compat: vdso: Use legacy syscalls as
 fallback
Date: Tue, 3 Sep 2019 21:00:57 +0000
Message-ID: <MWHPR2201MB1277ED2AD21C031201F749EAC1B90@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190830135902.20861-4-vincenzo.frascino@arm.com>
In-Reply-To: <20190830135902.20861-4-vincenzo.frascino@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Paul Burton <pburton@wavecomp.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "salyzyn@android.com" <salyzyn@android.com>, "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>, "luto@kernel.org" <luto@kernel.org>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190903210057.NRU5fO-6EVjk-04w0zsepraEknCjcubFeuLH3EIohaI@z>

Hello,

Vincenzo Frascino wrote:
> The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
> clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
> seccomp setups because these syscalls might be not (yet) allowed.
>=20
> Implement the 32bit variants which use the legacy syscalls and select the
> variant in the core library.
>=20
> The 64bit time variants are not removed because they are required for the
> time64 based vdso accessors.

Applied to mips-next.

> commit 932bb934ed4d
> https://git.kernel.org/mips/c/932bb934ed4d
>=20
> Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
