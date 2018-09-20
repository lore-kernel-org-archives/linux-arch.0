Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-co1nam03on0113.outbound.protection.outlook.com ([104.47.40.113]:11008
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733291AbeIUCeC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 22:34:02 -0400
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 0/3] System call table generation support
Date: Thu, 20 Sep 2018 20:48:37 +0000
Message-ID: <20180920204833.gpypjjxcmxjupls6@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
 <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
In-Reply-To: <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-2"
Content-ID: <574F09FB11710046BB4B89F6CAD92D8D@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Firoz Khan <firoz.khan@linaro.org>, Hauke Mehrtens <hauke@hauke-m.de>, =?iso-8859-2?Q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180920204837.L-AsC-Z58FeLIFe_MBSkMG-o0G9wmMN0icFqEef9X4g@z>

Hi Arnd,

On Thu, Sep 20, 2018 at 07:52:03AM -0700, Arnd Bergmann wrote:
> On Mon, Sep 17, 2018 at 10:17 AM Paul Burton <paul.burton@mips.com> wrote=
:
> > On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
> > > The purpose of this patch series is:
> > > 1. We can easily add/modify/delete system call by changing entry
> > > in syscall.tbl file. No need to manually edit many files.
> > >
> > > 2. It is easy to unify the system call implementation across all
> > > the architectures.
> > >
> > > The system call tables are in different format in all architecture
> > > and it will be difficult to manually add or modify the system calls
> > > in the respective files manually. To make it easy by keeping a script
> > > and which'll generate the header file and syscall table file so this
> > > change will unify them across all architectures.
> >
> > Interesting :)
> >
> > I actually started on something similar recently with the goals of
> > reducing the need to adjust both asm/unistd.h & the syscall entry table=
s
> > when adding syscalls, clean up asm/unistd.h a bit & make it
> > easier/cleaner to add support for nanoMIPS & the P32 ABI.
> >
> > My branch still needed some work but it's here if you're interested:
> >
> >     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mi=
ps-syscalls
> >
> >     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/=
?h=3Dwip-mips-syscalls
>=20
> This looks like a very nice approach that we would probably prefer if we =
wanted
> to do it only for mips. The way Firoz did it makes sense in the context o=
f doing
> it the same way on all architectures, where usually the information is mo=
re
> accessible to human readers by using the number as the primary key.

Yup, I completely agree that moving all this towards being common
infrastructure for all architectures is a worthy goal :)

> Speaking of nanoMIPS, what is your plan for the syscall ABI there?
> I can see two ways of approaching it:
>=20
> a) keep all the MIPSisms in the data structures, and just use a subset of
>     o32 that drops all the obsolete entry points
> b) start over and stay as close as possible to the generic ABI, using the
>     asm-generic versions of both the syscall table and the uapi header
>     files instead of the traditional version.

We've taken option b in our current downstream kernel & that's what I
hope we'll get upstream too. There's no expectation that we'll ever need
to mix pre-nanoMIPS & nanoMIPS ISAs or their associated ABIs across the
kernel/user boundary so it's felt like a great opportunity to clean up &
standardise.

Getting nanoMIPS/p32 support submitted upstream is on my to-do list, but
there's a bunch of prep work to get in first & of course that to-do list
is forever growing. Hopefully in the next couple of cycles.

Thanks,
    Paul
