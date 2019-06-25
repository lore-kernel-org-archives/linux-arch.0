From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v7 00/25] Unify vDSOs across more architectures
Date: Tue, 25 Jun 2019 17:11:20 +0000
Message-ID: <20190625171118.wznk5nva3h3jetky@pburton-laptop>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
 <alpine.DEB.2.21.1906240142000.32342@nanos.tec.linutronix.de>
 <20190624184157.mu6n74a7qqa4z5z5@pburton-laptop>
 <3ae7f595-0a15-0584-198e-b32fe3e3ea57@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ae7f595-0a15-0584-198e-b32fe3e3ea57@arm.com>
Content-Language: en-US
Content-ID: <FD39DF5A3ADB314EAA7DACEAAC30B7A9@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, LAK <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
List-Id: linux-arch.vger.kernel.org

Hi Vincenzo,

On Tue, Jun 25, 2019 at 12:16:55AM +0100, Vincenzo Frascino wrote:
> In the end I concluded that all the errors seen here depend on the fact t=
hat I
> tested my vdso implementation on MIPS32el only (as stated in the cover le=
tter)
> and that when I tried to compile a 32BIT binary on a 64BIT configuration =
I did
> it wrongly for two reasons, for N32 and O32 binaries:
>  - we need to undefine CONFIG_64BIT and define CONFIG_32BIT
>  - we need to define CONFIG_GENERIC_ATOMIC64
>=20
> I have a fix for this (patch in attachment), but I do not have the hardwa=
re to
> test it. If you could provide some feedback would be appreciated (really =
want to
> see MIPS merged with the other archs in 5.3 :) ).

Thanks for the quick turnaround on your patch!

I'm certainly willing to test it, but in a few hours I'll be spending
the bulk of a day on airplanes[1] so it might take a few days until I
get to it.

Thanks,
    Paul

[1] ...and travel isn't the hackathon it used to be with my 9 month old
    son around :)
