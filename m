From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] STAGING: Comedi: Build only on arches providing
 PAGE_KERNEL_NOCACHE
Date: Fri, 24 Jun 2011 08:01:39 +1000
Message-ID: <1308866499.32158.216.camel@pasglop>
References: <20110623114536.GA14011@linux-mips.org>
	 <4E032940.5010205@ge.com>  <20110623120234.GA22524@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:48753 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752885Ab1FWWCh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Jun 2011 18:02:37 -0400
In-Reply-To: <20110623120234.GA22524@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Martyn Welch <martyn.welch@ge.com>, Greg Kroah-Hartman <gregkh@suse.de>, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, linux-am33-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Thu, 2011-06-23 at 13:02 +0100, Ralf Baechle wrote:
> On Thu, Jun 23, 2011 at 12:53:36PM +0100, Martyn Welch wrote:
>=20
> > On 23/06/11 12:45, Ralf Baechle wrote:
> > > On architectures that don't define PAGE_KERNEL_NOCACHE, the Comed=
i driver turns
> > > into tragedy:
> > >=20
> > >   CC [M]  drivers/staging/comedi/drivers.o
> > > drivers/staging/comedi/drivers.c: In function =E2=80=98comedi_buf=
_alloc=E2=80=99:
> > > drivers/staging/comedi/drivers.c:505:41: error: =E2=80=98PAGE_KER=
NEL_NOCACHE=E2=80=99 undeclared (first use in this function)
> > > drivers/staging/comedi/drivers.c:505:41: note: each undeclared id=
entifier is rep orted only once for each function it appears in
> > > make[3]: *** [drivers/staging/comedi/drivers.o] Error 1
> > >=20
> > > Restrict the driver to only those architectures that define PAGE_=
KERNEL_NOCACHE.
> > >=20
> > > PAGE_KERNEL_NOCACHE is a kludge - some system architectures such =
as SGI IP27
> > > are even uable to offer uncached operation - at least in the way =
an unwitting
> > > driver might assume.  I haven't looked in details how the driver =
is using
> > > the area vmaped with PAGE_KERNEL_NOCACHE but maybe doing it XFS-s=
tyle using
> > > cached memory and the flush_kernel_vmap_range / invalidate_kernel=
_vmap_range
> > > APIs in conjunction with the DMA API is a practical alternative.
> > >=20
> > > Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> > >=20
> > >  drivers/staging/comedi/Kconfig |    1 +
> > >  1 files changed, 1 insertions(+), 0 deletions(-)
> > >=20
> > > diff --git a/drivers/staging/comedi/Kconfig b/drivers/staging/com=
edi/Kconfig
> > > index 1502d80..bccdc12 100644
> > > --- a/drivers/staging/comedi/Kconfig
> > > +++ b/drivers/staging/comedi/Kconfig
> > > @@ -2,6 +2,7 @@ config COMEDI
> > >  	tristate "Data acquisition support (comedi)"
> > >  	default N
> > >  	depends on m
> > > +	depends on BROKEN || FRV || M32R || MN10300 || SUPERH || TILE |=
| X86
> >=20
> > I'm sure I got comedi to compile on a 32-bit PPC board not that lon=
g ago. Has
> > something changed, or is this just not an exhaustive list?

It went away. There's a proper API (pgprot_noncached), but it depends
what this is used for and it's likely to be broken anyways... what is
that driver trying to map non-cached ?

Cheers,
Ben.

> (Adding the PPC folks to cc.)
>=20
> A "git grep -w PAGE_KERNEL_NOCACHE arch/powerpc/" doesn't find anythi=
ng so
> I don't think the driver will build there.  I don't have a PPC toolch=
ain
> to verify that.
>=20
>   Ralf
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
