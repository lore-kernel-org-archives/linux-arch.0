From: Oskar Andero <oskar.andero@sonymobile.com>
Subject: Re: [PATCH 0/4] kprobes: split blacklist into common and arch
Date: Thu, 4 Apr 2013 13:41:29 +0200
Message-ID: <20130404114129.GC2481@caracas.corpusers.net>
References: <1364977734-32267-1-git-send-email-oskar.andero@sonymobile.com>
 <515D64C6.9050903@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <515D64C6.9050903@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "masami.hiramatsu.pt@hitachi.com" <masami.hiramatsu.pt@hitachi.com>, "davem@davemloft.net" <davem@davemloft.net>, "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>, "ananth@in.ibm.com" <ananth@in.ibm.com>, "Lekanovic, Radovan" <Radovan.Lekanovic@sonymobile.com>, =?iso-8859-1?Q?Davidsson=2C_Bj=F6rn?= <Bjorn.Davidsson@sonymobile.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 13:32 Thu 04 Apr     , Vineet Gupta wrote:
> Hi Oskar,
>=20
> On 04/03/2013 01:58 PM, oskar.andero@sonymobile.com wrote:
> > Hi,
> >=20
> > This is a slight rework of the following patches which I posted ear=
lier:
> > [PATCH] Kprobes blacklist: Conditionally add x86-specific symbols
> > [PATCH] delay blacklist symbol lookup until we actually need it
> >=20
> > This serie includes a patch that moves the architecture dependent b=
lack points
> > to the arch/ directory and the x86 patch was modified to follow tha=
t patch.
> >=20
> > -Oskar
> >=20
> > Bj=F6rn Davidsson (1):
> >   kprobes: move x86-specific blacklist symbols to arch directory
> >=20
> > Oskar Andero (2):
> >   kprobes: split blacklist into common and arch
> >   kprobes: replace printk with pr_-functions
> >=20
> > Toby Collett (1):
> >   kprobes: delay blacklist symbol lookup until we actually need it
> >=20
> >  arch/arc/kernel/kprobes.c      |   3 +
> >  arch/arm/kernel/kprobes.c      |   2 +
> >  arch/avr32/kernel/kprobes.c    |   3 +
> >  arch/ia64/kernel/kprobes.c     |   3 +
> >  arch/mips/kernel/kprobes.c     |   3 +
> >  arch/mn10300/kernel/kprobes.c  |   2 +
> >  arch/powerpc/kernel/kprobes.c  |   3 +
> >  arch/s390/kernel/kprobes.c     |   3 +
> >  arch/sh/kernel/kprobes.c       |   3 +
> >  arch/sparc/kernel/kprobes.c    |   3 +
> >  arch/x86/kernel/kprobes/core.c |   7 ++
> >  kernel/kprobes.c               | 149 ++++++++++++++++++++++++++---=
------------
> >  12 files changed, 130 insertions(+), 54 deletions(-)
> >=20
>=20
> For any arch changes, however trivial they might be, you need to CC t=
he respective
> maintainers, or atleast post the patches on linux-arch so we know wha=
t's going on !

Thanks Vineet! I will make sure to add linux-arch on CC for version 2.

-Oskar
