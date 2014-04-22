From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/28] nios2: Memory management
Date: Tue, 22 Apr 2014 13:27:37 -0300
Message-ID: <20140422162737.GA13859@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-5-git-send-email-lftan@altera.com>
 <20140422142443.GB15745@arch.cereza>
 <20140422151458.GC1053@distanz.ch>
 <20140422153522.GF15745@arch.cereza>
 <5356924E.7020605@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50347 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756130AbaDVQ2Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Apr 2014 12:28:24 -0400
Content-Disposition: inline
In-Reply-To: <5356924E.7020605@codesourcery.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chung-Lin Tang <cltang@codesourcery.com>
Cc: Tobias Klauser <tklauser@distanz.ch>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com

On Apr 23, Chung-Lin Tang wrote:
> On 2014/4/22 =E4=B8=8B=E5=8D=88 11:35, Ezequiel Garcia wrote:
> > On Apr 22, Tobias Klauser wrote:
> >> On 2014-04-22 at 16:24:43 +0200, Ezequiel Garcia <ezequiel.garcia@=
free-electrons.com> wrote:
> >>> Hi Ley Foon,
> >>>
> >>> On Apr 18, Ley Foon Tan wrote:
> >>>> +/*
> >>>> + * PAGE_SHIFT determines the page size
> >>>> + */
> >>>> +#define PAGE_SHIFT	12
> >>>> +#define PAGE_SIZE	4096
> >>>> +#define PAGE_MASK	(~(PAGE_SIZE - 1))
> >>>> +
> >>>
> >>> How about something like this:
> >>>
> >>> /* PAGE_SHIFT determines the page size */
> >>> #define PAGE_SHIFT              12
> >>> #define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
> >>> #define PAGE_MASK               (~((1 << PAGE_SHIFT) - 1))
> >>>
> >>> Otherwise, the PAGE_SIZE macro above produces some warnings, IIRC=
=2E
> >>
> >> AFAIR old nios2 GCC versions (the 4.1 version from Windriver, IIRC=
)
> >> would complain about something like the above, that's the reason I=
 added
> >> an explicit value for PAGE_SIZE back then.
> >>
> >=20
> > Other than being "pretty" the above fix is to remove a mismatch typ=
e
> > warning. You can get rid of the warning in different ways:
> >=20
> > ifdef __ASSEMBLY__
> > define PAGE_SIZE       4096
> > else
> > define PAGE_SIZE       4096UL
> > endif
> >=20
> >> I assume with the new nios2 GCC this should no longer be necessary=
 and
> >> Ezequiel's fix should be fine.
> >=20
> > Speaking of GCC... is there a libc available to test this kernel po=
rt?
> > (which I assume uses the generic syscall ABI)
>=20
> It's submitted to libc-alpha, also still review in progress.
>=20

Do you plan to support uclibc?

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
