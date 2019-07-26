From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 21/25] mips: Add clock_gettime64 entry point
Date: Fri, 26 Jul 2019 05:15:45 +0000
Message-ID: <MWHPR2201MB1277BCA61ED6CC494A4DB937C1C00@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190621095252.32307-22-vincenzo.frascino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621095252.32307-22-vincenzo.frascino@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <pburton@wavecomp.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c>
List-Id: linux-arch.vger.kernel.org

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
