Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr690111.outbound.protection.outlook.com ([40.107.69.111]:49380
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbeLWQVU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 23 Dec 2018 11:21:20 -0500
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
Date: Sun, 23 Dec 2018 16:21:14 +0000
Message-ID: <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
 <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
In-Reply-To: <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <80E09EDBADDB7148B4CE25727F5ADD02@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Message-ID: <20181223162114.7wGx3NT9mYCCmnANSqAfWp4kStgdba9CGEu6bPPtw4s@z>

Hi Firoz,

On Sun, Dec 23, 2018 at 08:15:48AM -0800, Paul Burton wrote:
> Hello,
>=20
> Firoz Khan wrote:
> > The purpose of this patch series is, we can easily
> > add/modify/delete system call table support by cha-
> > nging entry in syscall.tbl file instead of manually
> > changing many files. The other goal is to unify the
> > system call table generation support implementation
> > across all the architectures.
>%
> Series applied to mips-fixes.
>=20
> Thanks,
>     Paul
>=20
> [ This message was auto-generated; if you believe anything is incorrect
>   then please email paul.burton@mips.com to report it. ]

FYI this was actually applied to mips-next on the 14th & is part of the
pull request I'm about to send for 4.21, but running my ack-email script
is still a manual step & clearly still could be improved :)

Thanks,
    Paul
