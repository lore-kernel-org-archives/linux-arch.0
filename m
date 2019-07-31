Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr750099.outbound.protection.outlook.com ([40.107.75.99]:26831
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbfGaSht (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Jul 2019 14:37:49 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 1/2] mips: remove nargs from __SYSCALL
Date: Wed, 31 Jul 2019 18:37:45 +0000
Message-ID: <CY4PR2201MB12725431D0D757F50CBDC1EBC1DF0@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <1546440978-19569-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1546440978-19569-2-git-send-email-firoz.khan@linaro.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Paul Burton <pburton@wavecomp.com>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190731183745.xZfEgCUPfeV--YqTja8ZG3ZECqs2oPzixuwxUEo2dMk@z>

Hello,

Firoz Khan wrote:
> The __SYSCALL macro's arguments are system call number,
> system call entry name and number of arguments for the
> system call.
>=20
> Argument- nargs in __SYSCALL(nr, entry, nargs) is neither
> calculated nor used anywhere. So it would be better to
> keep the implementaion as  __SYSCALL(nr, entry). This will
> unifies the implementation with some other architetures
> too.
>=20
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
