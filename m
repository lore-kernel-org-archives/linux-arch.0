From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM pagetable setting in Linux
Date: Wed, 26 Jun 2013 18:54:30 +0100
Message-ID: <20130626175430.GH2718@n2100.arm.linux.org.uk>
References: <35FD53F367049845BC99AC72306C23D19441BF5863@CNBJMBX05.corpusers.net> <20130626171649.GG10333@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46605 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383Ab3FZRyo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 13:54:44 -0400
Content-Disposition: inline
In-Reply-To: <20130626171649.GG10333@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Wang, Yalin" <Yalin.Wang@sonymobile.com>, "'linux-arch@vger.kernel.org'" <linux-arch@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

As I don't have the original mail (because it wasn't copied to the righ=
t
list) I can't reply to the original author, so I'll do it like this
instead.

On Wed, Jun 26, 2013 at 06:16:49PM +0100, Will Deacon wrote:
> [adding the ARM list -- please try and remember to do that in future]
>=20
> On Wed, Jun 26, 2013 at 03:41:40AM +0100, Wang, Yalin wrote:
> > Hi  Will,
>=20
> Hello,
>=20
> > I have a question about  arm pagetable setting in Linux .
> >=20
> > From armV6,  there is TTBR0 and TTBR1  translation base address reg=
isters  in mmu .
> > But I  found linux only use TTBR0 for translation base address ,
> > Could we use TTBR0 and TTBR1 to split user task and kernel pagetabl=
es (swapper_pg_dir)=EF=BC=9F=20

We don't use TTBR1 because the configurable page table splits between
TTBR0 and TTBR1 are not appropriate for Linux kernels.  The common
configuration is to have 3GB of userspace and 1GB of kernel space.

However, the TTBR splits supported are 2GB, 1GB, 512MB etc.  As I had
prior knowledge of ARMv6 before it was released, I raised this point
with ARM Ltd because I knew that it would not be appropriate for Linux.
Unfortunately, the response was basically that they didn't want to know=
=2E
So, as the hardware provided support mismatches what we want, we don't
use the feature.

It's as simple as that; had we been listened to and the architecture
altered to do what we required, then we'd be using it...

> > 1. Because we don=E2=80=99t need copy kernel first =E2=80=93level p=
agetables into every=20
> > User task=E2=80=99s pagetables and flush tlb (for example fork() a =
new process).
>=20
> Well, you still need the TLB maintenance for setting up CoW, so this =
win is
> probably not very big.
>=20
> > 2. And don=E2=80=99t need handle kernel page fault because that use=
r task=E2=80=99s kernel=20
> > Pagetable when it is not set up , need copy again( for example vmal=
loc()  ioremap()  kmap()  will change=20
> > Kernel pagetables and need update to every task pagetables ) .
>=20
> Is that really a fastpath?

No it isn't, because for all of the above cases we're talking about cop=
ying
L1 page table entries, not the individual L2 page table entries between
threads.

Every page table above TASK_SIZE gets shared between processes, and onc=
e
it's been shared to a process, any new process forked from that gets it=
s
own pointer to that 2nd level page table immediately.

So, during the initial boot there will be a number of the L1 copies, bu=
t
the system will stabilize and there will be no further L1 faulted copie=
s
needed.
