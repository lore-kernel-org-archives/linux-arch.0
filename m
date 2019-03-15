Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr680090.outbound.protection.outlook.com ([40.107.68.90]:26431
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbfCOWjS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Mar 2019 18:39:18 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: Remove custom MIPS32 __kernel_fsid_t type
Date: Fri, 15 Mar 2019 22:39:12 +0000
Message-ID: <MWHPR2201MB1277D4B4E3CE45B3AC1870F3C1440@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190314173900.25454-1-paul.burton@mips.com>
In-Reply-To: <20190314173900.25454-1-paul.burton@mips.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <pburton@wavecomp.com>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Message-ID: <20190315223912.Vvg0Zx4oRrReIHFJi8zg64s2kZN2wPjmFu3BLvW9nZ8@z>

Hello,

Paul Burton wrote:
> For MIPS32 kernels we have a custom definition of __kernel_fsid_t. This
> differs from the asm-generic version used by all other architectures &
> MIPS64 in one way - it declares the val field as an array of long,
> rather than an array of int. Since int & long have identical size &
> alignment when targeting MIPS32 anyway, this makes little sense.
>=20
> Beyond the pointlessness this causes problems for code which prints
> entries from the val array, for example the fanotify_encode_fid()
> function [1]. If such code uses a format specified suited to an int then
> it encounters compiler warnings when building for MIPS32, such as:
>=20
> In file included from include/linux/kernel.h:14:0,
> from include/linux/list.h:9,
> from include/linux/preempt.h:11,
> from include/linux/spinlock.h:51,
> from include/linux/fdtable.h:11,
> from fs/notify/fanotify/fanotify.c:3:
> fs/notify/fanotify/fanotify.c: In function 'fanotify_encode_fid':
> include/linux/kern_levels.h:5:18: warning: format '%x' expects argument
> of type 'unsigned int', but argument 2 has type 'long int' [-Wformat=3D]
>=20
> Remove the custom __kernel_fsid_t definition & make use of the
> asm-generic version which will have an identical layout in memory
> anyway, in order to remove the inconsistency with other architectures.
>=20
> One possible regression this could cause if is any code is attempting to
> print entries from the val array with a long-sized format specifier, in
> which case it would begin seeing compiler warnings when built against
> kernel headers including this change. Since such code is exceedingly
> rare, and would have to be MIPS32-specific to expect a long, this seems
> to be a problem that it's extremely unlikely anyone will encounter.
>=20
> [1] https://lore.kernel.org/linux-mips/CAOQ4uxiEkczB7PNCXegFC-eYb9zAGaio_=
o=3DOgHAJHFd7eavBxA@mail.gmail.com/T/#mb43103277c79ef06b884359209e817db1c13=
6140
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@vger.kernel.org

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
