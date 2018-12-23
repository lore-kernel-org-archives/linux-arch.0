From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
Date: Sun, 23 Dec 2018 16:21:14 +0000
Message-ID: <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
 <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
Content-Language: en-US
Content-ID: <80E09EDBADDB7148B4CE25727F5ADD02@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

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
