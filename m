From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 06/28] nios2: Memory management
Date: Tue, 22 Apr 2014 12:35:22 -0300
Message-ID: <20140422153522.GF15745@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-5-git-send-email-lftan@altera.com>
 <20140422142443.GB15745@arch.cereza>
 <20140422151458.GC1053@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140422151458.GC1053@distanz.ch>
Sender: linux-doc-owner@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Apr 22, Tobias Klauser wrote:
> On 2014-04-22 at 16:24:43 +0200, Ezequiel Garcia <ezequiel.garcia@fre=
e-electrons.com> wrote:
> > Hi Ley Foon,
> >=20
> > On Apr 18, Ley Foon Tan wrote:
> > > +/*
> > > + * PAGE_SHIFT determines the page size
> > > + */
> > > +#define PAGE_SHIFT	12
> > > +#define PAGE_SIZE	4096
> > > +#define PAGE_MASK	(~(PAGE_SIZE - 1))
> > > +
> >=20
> > How about something like this:
> >=20
> > /* PAGE_SHIFT determines the page size */
> > #define PAGE_SHIFT              12
> > #define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)
> > #define PAGE_MASK               (~((1 << PAGE_SHIFT) - 1))
> >=20
> > Otherwise, the PAGE_SIZE macro above produces some warnings, IIRC.
>=20
> AFAIR old nios2 GCC versions (the 4.1 version from Windriver, IIRC)
> would complain about something like the above, that's the reason I ad=
ded
> an explicit value for PAGE_SIZE back then.
>=20

Other than being "pretty" the above fix is to remove a mismatch type
warning. You can get rid of the warning in different ways:

ifdef __ASSEMBLY__
define PAGE_SIZE       4096
else
define PAGE_SIZE       4096UL
endif

> I assume with the new nios2 GCC this should no longer be necessary an=
d
> Ezequiel's fix should be fine.

Speaking of GCC... is there a libc available to test this kernel port?
(which I assume uses the generic syscall ABI)
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
