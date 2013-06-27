From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] include/asm-generic/pci.h: include generic
 "pci-dma-compat.h"
Date: Thu, 27 Jun 2013 09:29:20 +0100
Message-ID: <20130627082920.GA14335@darko.cambridge.arm.com>
References: <51CBB98D.3040304@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:42884 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752569Ab3F0IaW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 27 Jun 2013 04:30:22 -0400
Content-Disposition: inline
In-Reply-To: <51CBB98D.3040304@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hirokazu Takata <takata@linux-m32r.org>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-m32r-ja@ml.linux-m32r.org" <linux-m32r-ja@ml.linux-m32r.org>, "linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>

On Thu, Jun 27, 2013 at 05:03:25AM +0100, Chen Gang wrote:
> If an architecture need "generic pci.h", it also need generic "pci-dm=
a-
> compat.h",  so recommend to include it in asm-generic directly.
>=20
> And now, for arm64 and m32r, may cause compiling error about it.
>=20
> The related error (with allmodconfig):
>=20
>   drivers/media/usb/b2c2/flexcop-usb.c: In function =E2=80=98flexcop_=
usb_transfer_exit=E2=80=99:
>   drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit declara=
tion of function =E2=80=98pci_free_consistent=E2=80=99 [-Werror=3Dimpli=
cit-function-declaration]
>   drivers/media/usb/b2c2/flexcop-usb.c: In function =E2=80=98flexcop_=
usb_transfer_init=E2=80=99:
>   drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit declara=
tion of function =E2=80=98pci_alloc_consistent=E2=80=99 [-Werror=3Dimpl=
icit-function-declaration]
>   drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment ma=
kes pointer from integer without a cast [enabled by default]
>   cc1: some warnings being treated as errors
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

=46rom the arm64 perspective:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(but make sure it doesn't break other archs)
