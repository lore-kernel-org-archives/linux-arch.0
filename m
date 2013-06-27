From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] include/asm-generic/pci.h: include generic "pci-dma-compat.h"
Date: Thu, 27 Jun 2013 18:14:09 +0800
Message-ID: <51CC1071.5040802@asianux.com>
References: <51CBB98D.3040304@asianux.com> <20130627082920.GA14335@darko.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130627082920.GA14335@darko.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hirokazu Takata <takata@linux-m32r.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>
List-Id: linux-arch.vger.kernel.org

On 06/27/2013 04:29 PM, Catalin Marinas wrote:
> On Thu, Jun 27, 2013 at 05:03:25AM +0100, Chen Gang wrote:
>> > If an architecture need "generic pci.h", it also need generic "pci=
-dma-
>> > compat.h",  so recommend to include it in asm-generic directly.
>> >=20
>> > And now, for arm64 and m32r, may cause compiling error about it.
>> >=20
>> > The related error (with allmodconfig):
>> >=20
>> >   drivers/media/usb/b2c2/flexcop-usb.c: In function =E2=80=98flexc=
op_usb_transfer_exit=E2=80=99:
>> >   drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit decl=
aration of function =E2=80=98pci_free_consistent=E2=80=99 [-Werror=3Dim=
plicit-function-declaration]
>> >   drivers/media/usb/b2c2/flexcop-usb.c: In function =E2=80=98flexc=
op_usb_transfer_init=E2=80=99:
>> >   drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit decl=
aration of function =E2=80=98pci_alloc_consistent=E2=80=99 [-Werror=3Di=
mplicit-function-declaration]
>> >   drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment=
 makes pointer from integer without a cast [enabled by default]
>> >   cc1: some warnings being treated as errors
>> >=20
>> >=20
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> From the arm64 perspective:
>=20
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>=20

Thanks.

> (but make sure it doesn't break other archs)

I will try to check all related archs with allmodconfig (which can also
find more another patches, and can let me familiar the compiler step by
step).  ;-)


Thanks.
--=20
Chen Gang
