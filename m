From: Firoz Khan <firoz.khan@linaro.org>
Subject: Re: [PATCH v5 0/7] mips: system call table generation support
Date: Mon, 24 Dec 2018 10:50:21 +0530
Message-ID: <CALxhOngUrF5+hFwt5-hhivATQTUc9eqjP=oPjOH5vwA33hTa1A@mail.gmail.com>
References: <1544692059-9728-1-git-send-email-firoz.khan@linaro.org>
 <MWHPR2201MB1277088F42DB7C2850037098C1BA0@MWHPR2201MB1277.namprd22.prod.outlook.com>
 <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181223162108.c6tzowjcgii5f3ev@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, "y2038@lists.linaro.org" <y2038@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Sun, 23 Dec 2018 at 21:51, Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Sun, Dec 23, 2018 at 08:15:48AM -0800, Paul Burton wrote:
> > Hello,
> >
> > Firoz Khan wrote:
> > > The purpose of this patch series is, we can easily
> > > add/modify/delete system call table support by cha-
> > > nging entry in syscall.tbl file instead of manually
> > > changing many files. The other goal is to unify the
> > > system call table generation support implementation
> > > across all the architectures.
> >%
> > Series applied to mips-fixes.
> >
> > Thanks,
> >     Paul
> >
> > [ This message was auto-generated; if you believe anything is incorrect
> >   then please email paul.burton@mips.com to report it. ]
>
> FYI this was actually applied to mips-next on the 14th & is part of the
> pull request I'm about to send for 4.21, but running my ack-email script
> is still a manual step & clearly still could be improved :)

Thanks Paul!

Firoz
